package com.amazon.bookstore.service.serviceImpl;

import com.amazon.bookstore.dao.BookDAO;
import com.amazon.bookstore.model.Book;
import com.amazon.bookstore.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookDAO bookDAO;
    @Override
    @Transactional
    public void save(Book book) {
        bookDAO.save(book);
    }

    @Override
    @Transactional
    public Book findById(int id) {
        return bookDAO.findById(id);
    }

    @Override
    @Transactional
    public Book findByIsbn(String isbn) {
        return bookDAO.findByIsbn(isbn);
    }

    @Override
    @Transactional
    public List<Book> findAll() {
        return bookDAO.findAll();
    }

    @Override
    @Transactional
    public void update(Book book) {
        bookDAO.update(book);
    }

    @Override
    @Transactional
    public void delete(int id) {
        bookDAO.delete(id);
    }
}