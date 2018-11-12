package com.javabrown.jsecurity.products.repository;

import com.javabrown.jsecurity.products.repository.modal.Product;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProductRepository extends CrudRepository<Product, Long> {
    List<Product> findByName(String lastName);
}
