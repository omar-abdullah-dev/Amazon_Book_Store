package com.amazon.bookstore.dao.daoImpl;

import com.amazon.bookstore.dao.CategoryDAO;
import com.amazon.bookstore.model.Category;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Category category) {
        Session session = sessionFactory.getCurrentSession();
        session.save(category);
        
    }

    @Override
    public Category findById(int id) {
        return null;
    }

    @Override
    public Category findByName(String name) {
        return null;
    }

    @Override
    public List<Category> findAll() {
        return Collections.emptyList();
    }

    @Override
    public void update(Category category) {

    }

    @Override
    public void delete(int id) {

    }
}
