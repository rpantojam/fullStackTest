package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import java.math.BigDecimal;
import java.time.Instant;

@Data
@Entity
@Builder
@Table(name = "sales")
@NoArgsConstructor
@AllArgsConstructor
public class Sales {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "product_id", nullable = false)
    private Long productId;

    @Column(name = "unitary_price", nullable = false)
    private BigDecimal unitaryPrice;

    @Column(nullable = false)
    private Long amount;

    @Column(nullable = false)
    private BigDecimal total;

    @CreationTimestamp
    @Column(name = "sale_dt", nullable = false, updatable = false)
    private Instant saleDt;

    @Column(name = "seller_user_id", nullable = false)
    private Long sellerUserId;

}
