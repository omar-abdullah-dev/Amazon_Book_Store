package com.amazon.bookstore.dao;

import com.amazon.bookstore.model.Category;

import java.util.List;

public interface CategoryDAO {

    void save(Category category);

    Category findById(int id);

    Category findByName(String name);

    List<Category> findAll();

    List<Category> findPaginated(int page, int pageSize);

    long count();

    void update(Category category);

    void delete(int id);
}