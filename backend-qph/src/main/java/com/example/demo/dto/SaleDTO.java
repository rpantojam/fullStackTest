package com.example.demo.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class SaleDTO {

    @NotNull(message = "El producto es obligatorio")
    private Long productId;

    @NotNull(message = "El precio es obligatorio")
    private BigDecimal unitaryPrice;

    @NotNull(message = "La cantidad es obligatoria")
    private Long amount;

}
