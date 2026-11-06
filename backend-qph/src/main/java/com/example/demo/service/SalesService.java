package com.example.demo.service;

import com.example.demo.dto.SaleDTO;
import com.example.demo.entity.Sales;

public interface SalesService {

    Sales registerSale(SaleDTO saleDTO, String username);

}
