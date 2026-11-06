package com.example.demo.exception;

import java.io.Serial;

public class ResourceNotCreatedException extends RuntimeException {

    @Serial
    private static final long serialVersionUID = 2L;

    public ResourceNotCreatedException(String message) {
        super(message);
    }

}
