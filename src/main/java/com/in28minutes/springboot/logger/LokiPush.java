package com.in28minutes.springboot.logger;

import pl.mjaron.tinyloki.ILogStream;
import pl.mjaron.tinyloki.TinyLoki;

public class LokiPush {
    private static LokiPush instance;
    private final ILogStream logger;

    public static LokiPush getInstance() {
        String endpoint = System.getenv("LOKI_ENDPOINT");
        if (endpoint == null) {
            endpoint = "http://localhost:3100";
        }

        if (instance == null) {
            instance = new LokiPush(endpoint);
        }
        return instance;
    }
    LokiPush(String endpoint) {
        logger = TinyLoki
            .withUrl(endpoint + "/loki/api/v1/push")
            .start().stream().l("app", "spring")
                .build();
    }

    public ILogStream getLogger() {
        return logger;
    }
}