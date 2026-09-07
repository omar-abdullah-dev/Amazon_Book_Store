package com.amazon.bookstore.dao;

import com.bootcamp.bookstore.model.Author;

import java.util.List;

public interface AuthorDAO {

    void save(Author author);

    Author findById(int id);

    Author findByName(String name);

    List<Author> findAll();

    void update(Author author);

    void delete(int id);
}