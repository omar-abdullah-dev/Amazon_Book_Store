package com.amazon.bookstore.dao.daoImpl;

import com.amazon.bookstore.dao.BookDAO;
import com.amazon.bookstore.model.Book;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;

@Repository
public class BookDAOImpl implements BookDAO {
    @Autowired
    SessionFactory sessionFactory;

    @Override
    public void save(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.save(book);
    }

    @Override
    public Book findById(int id) {
        Session session = sessionFactory.getCurrentSession();
        String hql =
                "select distinct b from Book b " +
                        "left join fetch b.category " +
                        "left join fetch b.authors " +
                        "left join fetch b.bookDetails " +
                        "where b.id = :id";
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        List<Book> list = query.list();
        if (list != null && !list.isEmpty()) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public Book findByIsbn(String isbn) {
        Session session = sessionFactory.getCurrentSession();
        if (isbn == null || isbn.trim().isEmpty()) {
            return null;
        }
        String hql =
                "select distinct b from Book b " +
                        "left join fetch b.category " +
                        "left join fetch b.authors " +
                        "left join fetch b.bookDetails " +
                        "where lower(trim(b.bookDetails.isbn)) = lower(trim(:isbn))";
        Query query = session.createQuery(hql);
        query.setParameter("isbn", isbn.trim());
        List<Book> bookList = query.list();
        if (bookList != null && !bookList.isEmpty()) {
            return bookList.get(0);
        }
        return null;
    }

    @Override
    public List<Book> findAll() {
        Session session = sessionFactory.getCurrentSession();
        String hql =
                "select distinct b from Book b " +
                        "left join fetch b.category " +
                        "left join fetch b.authors " +
                        "left join fetch b.bookDetails";
        Query query = session.createQuery(hql);
        return query.list();
    }

    @Override
    public List<Book> findPaginated(int page, int pageSize) {
        Session session = sessionFactory.getCurrentSession();
        Query idQuery = session.createQuery("select b.id from Book b order by b.id asc");
        idQuery.setFirstResult((page - 1) * pageSize);
        idQuery.setMaxResults(pageSize);
        List<Integer> ids = idQuery.list();

        if (ids == null || ids.isEmpty()) {
            return Collections.emptyList();
        }

        String hql = "select distinct b from Book b " +
                "left join fetch b.category " +
                "left join fetch b.authors " +
                "left join fetch b.bookDetails " +
                "where b.id in (:ids) " +
                "order by b.id asc";
        Query bookQuery = session.createQuery(hql);
        bookQuery.setParameterList("ids", ids);
        return bookQuery.list();
    }

    @Override
    public long count() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count(b.id) from Book b");
        Long count = (Long) query.uniqueResult();
        return count != null ? count : 0L;
    }

    @Override
    public void update(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.update(book);
    }

    @Override
    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        Book book = findById(id);
        if (book != null) {
            session.delete(book);
        }
    }
}