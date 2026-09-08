package com.amazon.bookstore.model;

import javax.persistence.*;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

@Entity
@Table(name = "book")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @NotNull(message = "Book title is required")
    @Size(min = 1, message = "Book title is required")
    private String title;

    @ManyToOne
    @JoinColumn(name="category_id")
    private Category category;

    @Valid
    @OneToOne(mappedBy = "book", cascade = CascadeType.ALL)
    private BookDetails bookDetails;

    @ManyToMany
    @JoinTable(
            name = "book_author",
            joinColumns = @JoinColumn(name = "book_id"),
            inverseJoinColumns = @JoinColumn(name = "author_id")
    )
    private List<Author> authors;
    
    public Book(String title, Category category, BookDetails bookDetails, List<Author> authors) {
        this.title = title;
        this.category = category;
        this.bookDetails = bookDetails;
        this.authors = authors;
    }
    public Book() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }

    public BookDetails getBookDetails() { return bookDetails; }
    public void setBookDetails(BookDetails bookDetails) { this.bookDetails = bookDetails; }

    public List<Author> getAuthors() { return authors; }
    public void setAuthors(List<Author> authors) { this.authors = authors; }

}