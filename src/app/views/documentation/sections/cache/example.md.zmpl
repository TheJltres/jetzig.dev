# Cache Usage

Refer to the _Store_ documentation for full usage instructions. The interfaces for the _Cache_ and _Store_ are identical.

The example below provides a `post` _View_ function that stores a `message` param in the cache which is then accessed by the `index` _View_ function.

### View

```zig
pub fn index(request: *jetzig.Request) !jetzig.View {
    var root = try request.data(.object);
    try root.put("message", try request.cache.get("message"));

    return request.render(.ok);
}

pub fn post(request: *jetzig.Request) !jetzig.View {
    var root = try request.data(.object);

    const params = try request.params();

    if (params.get("message")) |message| {
        try request.cache.put("message", message);
        try root.put("message", message);
    } else {
        try root.put("message", "[no message param detected]");
    }

    return request.render(.ok);
}
```

### `index.zmpl`

```zmpl
<div>
  <span>Cached value: {\{.message}}</span>
</div>
```

### `post.zmpl`

```zmpl
<div>
  <span>Value "{\{.message}}" added to cache</span>
</div>
```

### Output

```console
$ curl http://localhost:8080/cache
```

```html
<div>
  <span>Cached value: </span>
</div>
```

```console
$ curl -d 'message=hello' http://localhost:8080/cache
```

```html
<div>
  <span>Value "hello" added to cache</span>
</div>
```

```console
$ curl http://localhost:8080/cache
```

```html
<div>
  <span>Cached value: hello</span>
</div>
```
