package com.amazon.bookstore.dao;

import com.amazon.bookstore.model.Category;

import java.util.List;

public interface CategoryDAO {

    void save(Category category);

    Category findById(int id);

    Category findByName(String name);

    List<Category> findAll();

    void update(Category category);

    void delete(int id);
}