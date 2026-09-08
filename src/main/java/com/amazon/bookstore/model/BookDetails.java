package com.amazon.bookstore.model;

import com.amazon.bookstore.util.AppConstants;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Entity
@Table(name = "book_details")
public class BookDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @OneToOne
    @JoinColumn(name = "book_id")
    private Book book;

    @NotNull(message = "ISBN ID is required")
    @Pattern(regexp = AppConstants.ISBN_REGEX, message = "Invalid ISBN format. Must be 10 or 13 digits (e.g. 978-0132350884)")
    @Column(name = "isbn", unique = true)
    private String isbn;

    @NotNull(message = "Language is required")
    @Column(name = "language")
    private String language;

    @Column(name = "publisher")
    private String publisher;


    @Temporal(TemporalType.DATE)
    @Column(name = "publication_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date publicationDate;

    @Column(name = "number_of_pages")
    private Integer numberOfPages;

    public BookDetails() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public Date getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(Date publicationDate) {
        this.publicationDate = publicationDate;
    }

    public Integer getNumberOfPages() {
        return numberOfPages;
    }

    public void setNumberOfPages(Integer numberOfPages) {
        this.numberOfPages = numberOfPages;
    }
}
