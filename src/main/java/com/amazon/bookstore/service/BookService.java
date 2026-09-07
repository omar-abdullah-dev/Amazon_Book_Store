package com.amazon.bookstore.service;

import com.bootcamp.bookstore.model.Book;

import java.util.List;

public interface BookService {

    void save(Book book);

    Book findById(int id);

    Book findByIsbn(String isbn);

    List<Book> findAll();

    void update(Book book);

    void delete(int id);
}