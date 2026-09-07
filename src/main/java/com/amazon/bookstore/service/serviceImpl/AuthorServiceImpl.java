package com.amazon.bookstore.service.serviceImpl;

import com.amazon.bookstore.dao.AuthorDAO;
import com.amazon.bookstore.model.Author;
import com.amazon.bookstore.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class AuthorServiceImpl implements AuthorService {


    @Autowired
    private AuthorDAO authorDAO;

    @Override
    @Transactional
    public void save(Author author) {
        authorDAO.save(author);
    }

    @Override
    @Transactional
    public Author findById(int id) {
        return authorDAO.findById(id);
    }

    @Override
    @Transactional
    public Author findByName(String name) {
        return authorDAO.findByName(name);
    }

    @Override
    @Transactional
    public List<Author> findAll() {
        return authorDAO.findAll();
    }

    @Override
    @Transactional
    public void update(Author author) {
        authorDAO.update(author);
    }

    @Override
    @Transactional
    public void delete(int id) {
        authorDAO.delete(id);
    }
}