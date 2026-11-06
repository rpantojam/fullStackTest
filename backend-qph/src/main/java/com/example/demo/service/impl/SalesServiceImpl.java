package com.example.demo.service.impl;

import com.example.demo.dto.SaleDTO;
import com.example.demo.entity.Sales;
import com.example.demo.repository.SalesRepository;
import com.example.demo.service.SalesService;
import com.example.demo.service.UserService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Service
public class SalesServiceImpl implements SalesService {

    private final SalesRepository repository;
    private final UserService userService;

    public SalesServiceImpl(SalesRepository repository, UserService userService) {
        this.repository = repository;
        this.userService = userService;
    }

    @Override
    public Sales registerSale(SaleDTO saleDTO, String username) {

        var user = userService.findByUserName(username);
        var sale = Sales.builder()
                .productId(saleDTO.getProductId())
                .amount(saleDTO.getAmount())
                .unitaryPrice(saleDTO.getUnitaryPrice())
                .amount(saleDTO.getAmount())
                .total(saleDTO.getUnitaryPrice()
                        .multiply(BigDecimal.valueOf(saleDTO.getAmount()))
                        .setScale(2, RoundingMode.HALF_UP))
                .sellerUserId(user.getId())
                .build();

        return repository.save(sale);
    }

}
