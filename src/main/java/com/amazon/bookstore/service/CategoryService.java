package com.amazon.bookstore.service;

import com.bootcamp.bookstore.model.Category;

import java.util.List;

public interface CategoryService {

    void save(Category category);

    Category findById(int id);

    Category findByName(String name);

    List<Category> findAll();

    void update(Category category);

    void delete(int id);
}