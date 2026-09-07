package com.amazon.bookstore.service;

import java.util.List;

public interface AuthorService {

    void save(Author author);

    Author findById(int id);

    Author findByName(String name);

    List<Author> findAll();

    void update(Author author);

    void delete(int id);
}