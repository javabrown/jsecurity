package com.javabrown.jsecurity.products.controller;

import com.javabrown.jsecurity.products.repository.ProductRepository;
import com.javabrown.jsecurity.products.repository.modal.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;

@RestController
public class WebController {
    @Autowired
    ProductRepository repository;

    @RequestMapping(name = "/")
    public String home(){
        return "Product Application Root";
    }

    @RequestMapping("/save")
    public String progress(){
        this.repository.save(new Product("Macbook", "Macbook Pro 2018"));
        this.repository.saveAll(Arrays.asList(
                new Product("Macbook", "Macbook Pro 2017"),
                new Product("Macbook", "Macbook Pro 2017")));
        return "Done";
    }

    @RequestMapping("/findall")
    public String findAll() {
        String result = "";
        for(Product p : repository.findAll()) {
            result += p.toString() + "<br/>";
        }

        return result;
    }

    @RequestMapping("/findbyid")
    public String findById(@RequestParam long id) {
        return repository.findById(id).toString();
    }
}
