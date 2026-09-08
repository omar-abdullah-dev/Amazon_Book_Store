package com.amazon.bookstore.dao.daoImpl;

import com.amazon.bookstore.dao.AuthorDAO;
import com.amazon.bookstore.model.Author;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.*;

@Repository
public class AuthorDAOImpl implements AuthorDAO {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Author author) {
        Session  session = sessionFactory.getCurrentSession();
        session.save(author);
    }

    @Override
    public Author findById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return (Author) session.get(Author.class, id);
    }

    @Override
    public Author findByName(String name) {
        Session session = sessionFactory.getCurrentSession();

        if (name == null || name.trim().isEmpty()) {
            return null;
        }

        Query query = session.createQuery("from Author where lower(trim(name)) = lower(trim(:name))");
        query.setParameter("name", name.trim());
        List<Author> list = query.list();

        if (list != null && !list.isEmpty()) {
            return (Author)list.get(0);
        }
        return null;
    }

    @Override
    public List<Author> findAll() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Author");
        List<Author> list = query.list();
        if (list != null && !list.isEmpty()) {
            return list;
        }
        return new ArrayList<Author>();
    }

    @Override
    public void update(Author author) {
        Session session = sessionFactory.getCurrentSession();
        session.update(author);
    }

    @Override
    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        Author author = findById(id);
        if (author != null) {
            session.delete(author);
        }
    }
}