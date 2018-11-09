package com.javabrown.jsecurity.service;

import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Component
public class RandomNumberGenerator {
    public String generate() {
        List<String> names = new ArrayList<>();

        names.add("Zidan");
        names.add("RK");
        names.add("Sha");

        Random r = new Random();
        int i = r.nextInt(names.size());

        return names.get(i);
    }
}
