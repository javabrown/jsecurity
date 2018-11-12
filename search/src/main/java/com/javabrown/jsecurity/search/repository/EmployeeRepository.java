package com.javabrown.jsecurity.search.repository;

import com.javabrown.jsecurity.search.model.Employee;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface EmployeeRepository extends MongoRepository<Employee, String> {
}