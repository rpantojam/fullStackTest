package com.example.demo.exception;

import java.io.Serial;

public class ProductsException extends RuntimeException {

    @Serial
    private static final long serialVersionUID = 3L;

    public ProductsException(String message) {
        super(message);
    }

}
