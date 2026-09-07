package com.amazon.bookstore.service.serviceImpl;

import com.amazon.bookstore.dao.CategoryDAO;
import com.amazon.bookstore.model.Category;
import com.amazon.bookstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryDAO categoryDAO;

    @Override
    @Transactional
    public void save(Category category) {
        categoryDAO.save(category);
    }

    @Override
    @Transactional
    public Category findById(int id) {
        return categoryDAO.findById(id);
    }

    @Override
    @Transactional
    public Category findByName(String name) {
        return categoryDAO.findByName(name);
    }

    @Override
    @Transactional
    public List<Category> findAll() {
        return categoryDAO.findAll();
    }

    @Override
    @Transactional
    public void update(Category category) {
        categoryDAO.update(category);
    }

    @Override
    @Transactional
    public void delete(int id) {
        categoryDAO.delete(id);
    }
}