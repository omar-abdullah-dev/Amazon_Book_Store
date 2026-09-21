package com.amazon.bookstore.dao;

import com.amazon.bookstore.model.Book;

import java.util.List;

public interface BookDAO {

    void save(Book book);

    Book findById(int id);

    Book findByIsbn(String isbn);

    List<Book> findAll();

    List<Book> findPaginated(int page, int pageSize);

    long count();

    void update(Book book);

    void delete(int id);
}

