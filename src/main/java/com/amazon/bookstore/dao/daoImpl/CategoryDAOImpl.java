package com.amazon.bookstore.dao.daoImpl;

import com.amazon.bookstore.dao.CategoryDAO;
import com.amazon.bookstore.model.Category;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Category category) {
        Session session = sessionFactory.getCurrentSession();
        session.saveOrUpdate(category);
    }

    @Override
    public Category findById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return (Category) session.get(Category.class, id);
    }

    @Override
    public Category findByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return null;
        }
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Category where lower(trim(name)) = lower(trim(:name))");
        query.setParameter("name", name.trim());
        List<Category> list = query.list();
        if (list != null && !list.isEmpty()) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public List<Category> findAll() {
        Session session = sessionFactory.getCurrentSession();

        return session
                .createQuery("from Category")
                .list();
    }

    @Override
    public void update(Category category) {
        Session session = sessionFactory.getCurrentSession();
        session.update(category);
    }

    @Override
    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();

        Category category = findById(id);

        if (category != null) {
            session.delete(category);
        }
    }
}