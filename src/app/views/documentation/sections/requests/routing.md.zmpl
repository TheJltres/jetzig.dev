# Routing

A route in _Jetzig_ is defined by creating a `.zig` file in `src/app/views/`.

Request paths map to routes using the following two simple rules:

1. The root path `/` maps to `src/app/views/root.zig`
1. Any other path maps to a path inside `src/app/views/`

For example, the path `/iguanas` maps to `src/app/views/iguanas.zig`.

Inside each `.zig` file you can define the following functions:

`index`, `get`, `post` , `put`, `patch`, `delete`

## Routing Logic

When _Jetzig_ receives a request with a path that matches a route, one of the above functions is invoked based on the following (we'll use `src/app/views/iguanas.zig` as our example):

* A `GET` request to `/iguanas` calls the `index` function.
* A `GET` request to `/iguanas/new` calls the `new` function.
* A `GET` request to `/iguanas/example-resource-id` calls the `get` function.
* A `POST` request to `/iguanas` calls the `post` function.
* A `PUT` request to `/iguanas/example-resource-id` calls the `PUT` function.
* A `PATCH` request to `/iguanas/example-resource-id` calls the `PATCH` function.
* A `DELETE` request to `/iguanas/example-resource-id` calls the `DELETE` function.

Apart from `index` and `post`, all functions receive the final component of the path (`example-resource-id`) as their first argument (`[]const u8`).

All functions always receive a `*jetzig.Request` argument and return `!jetzig.View` (see _Rendering_ for more information).

## Public Content

If the **root** directory of your project has a `public/` directory, _Jetzig_ will serve any files in this location directly. The appropriate _MIME_ type is selected from the file extension and added to a `Content-Type` header.

Although serving content from this directory is fully supported, it is highly recommended to serve this content via a separate web server such as [Nginx](https://www.nginx.com/) or via a [Content Delivery Network](https://en.wikipedia.org/wiki/Content_delivery_network), allowing your _Jetzig_ server to focus exclusively on serving dynamic content.

## Function Signatures

```zig
pub fn index(request: *jetzig.Request) !jetzig.View
pub fn get(id: []const u8, request: *jetzig.Request) !jetzig.View
pub fn new(request: *jetzig.Request) !jetzig.View
pub fn post(request: *jetzig.Request) !jetzig.View
pub fn put(id: []const u8, request: *jetzig.Request) !jetzig.View
pub fn patch(id: []const u8, request: *jetzig.Request) !jetzig.View
pub fn delete(id: []const u8, request: *jetzig.Request) !jetzig.View
```

If you do not define one of these functions, requests that would otherwise map to that function will return `404 Not Found`.

## View Generator

The easiest way to create a view module is to use the _Jetzig_ command line tool:

```console
jetzig generate view iguanas
```
