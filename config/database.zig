pub const database = .{
    .development = .{
        .adapter = .postgresql,
        .hostname = "localhost",
        .port = 5432,
        .username = "postgres",
        .password = "password",
        .database = "jetzig_website_development",
        .pool_size = 16,
    },

    .testing = .{
        .adapter = .postgresql,
        .hostname = "localhost",
        .port = 5432,
        .username = "postgres",
        .password = "password",
        .database = "jetzig_website_testing",
    },

    .production = .{
        .adapter = .postgresql,
        .database = "jetzig_website",
        .hostname = "localhost",
        .port = 5432,
        .pool_size = 32,
    },
};
