package com.javabrown.jsecurity.search.controller;

import com.javabrown.jsecurity.search.model.Employee;
import com.javabrown.jsecurity.search.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Component
@ConfigurationProperties
@RestController
public class Controller {
    @Value("${application.message}")
    private String message;

    @Value("${application.appname}")
    private String appname;

    @Autowired
    private EmployeeRepository employeeRepository;

    @RequestMapping("/")
    String home(){
        return String.format("Hello World - %s %s", this.message, this.appname);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/employee")
    public Employee create(@RequestBody Employee employee) {
        return this.employeeRepository.save(employee);
    }

    @RequestMapping(method = RequestMethod.GET, value="/employee/{employeeId}")
    public Employee get(@PathVariable String employeeId) {
        return this.employeeRepository.findById(employeeId).get();
    }

//    @RequestMapping("/resource")
//    public Map<String,Object> home() {
//        Map<String,Object> model = new HashMap<>();
//        model.put("id", UUID.randomUUID().toString());
//        model.put("content", "Hello World");
//        return model;
//    }

    @RequestMapping("/greeting")
    public String greeting() {
        return "Hello Developer";
    }

    @RequestMapping("/user")
    public Principal user(Principal user) {
        return user;
    }

}
