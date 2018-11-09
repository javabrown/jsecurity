package com.javabrown.jsecurity.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
public class Runner implements CommandLineRunner {
    private static final Logger logger = LoggerFactory.getLogger(Runner.class);

    @Autowired
    RandomNumberGenerator generater;

    @Override
    public void run(String... args) {
        logger.info("Generating Random Name: {}", generater.generate());
        logger.info("Generating Random Name: {}", generater.generate());
        logger.info("Generating Random Name: {}", generater.generate());
    }
}
