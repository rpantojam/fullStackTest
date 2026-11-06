package com.example.demo.service.impl;

import com.example.demo.dto.ProductDTO;
import com.example.demo.dto.SaleDTO;
import com.example.demo.entity.Product;
import com.example.demo.exception.ProductsException;
import com.example.demo.exception.ResourceNotCreatedException;
import com.example.demo.exception.ResourceNotFoundException;
import com.example.demo.repository.ProductRepository;
import com.example.demo.service.ProductService;
import com.example.demo.service.SalesService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    private final ProductRepository repository;
    private final SalesService salesService;

    public ProductServiceImpl(ProductRepository repository, SalesServiceImpl salesService) {
        this.repository = repository;
        this.salesService = salesService;
    }

    @Override
    @Transactional(readOnly = true)
    public List<ProductDTO> findAll() {
        return repository.findAll()
                .stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public ProductDTO findById(Long id) {
        Product product = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Producto no encontrado con id: " + id));
        return toDTO(product);
    }

    @Override
    public ProductDTO create(ProductDTO dto) {
        Product product = toEntity(dto);
        return toDTO(repository.save(product));
    }

    @Override
    public ProductDTO update(Long id, ProductDTO dto) {
        Product existing = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Producto no encontrado con id: " + id));
        existing.setNombre(dto.getNombre());
        existing.setPrecio(dto.getPrecio());
        existing.setStock(dto.getStock());
        return toDTO(repository.save(existing));
    }

    @Override
    public void delete(Long id) {
        if (!repository.existsById(id)) {
            throw new ResourceNotFoundException("Producto no encontrado con id: " + id);
        }
        repository.deleteById(id);
    }

    @Override
    public SaleDTO saleProduct(SaleDTO sale, String username) throws ProductsException {
        Product existing = repository.findById(sale.getProductId())
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Producto no encontrado con id: " + sale.getProductId()));

        if (existing.getPrecio().compareTo(sale.getUnitaryPrice()) != 0) {
            throw new ProductsException("Precio unitario no coincide con el registrado en base de datos. Verifique antes de continuar");
        }

        if (existing.getStock() < sale.getAmount()) {
            throw new ProductsException("La cantidad excede las existencias en stock.");
        }

        try {
            salesService.registerSale(sale, username);
            existing.setStock(existing.getStock() - sale.getAmount().intValue());
            repository.save(existing);
        } catch (Exception ex) {
            log.error(ex.getMessage());
            throw new ResourceNotCreatedException("Error creating sale");
        }

        return sale;
    }

    // ── Mappers privados ──────────────────────────────────────────────────────

    private ProductDTO toDTO(Product p) {
        return ProductDTO.builder()
                .id(p.getId())
                .nombre(p.getNombre())
                .precio(p.getPrecio())
                .stock(p.getStock())
                .build();
    }

    private Product toEntity(ProductDTO dto) {
        return Product.builder()
                .nombre(dto.getNombre())
                .precio(dto.getPrecio())
                .stock(dto.getStock())
                .build();
    }
}
