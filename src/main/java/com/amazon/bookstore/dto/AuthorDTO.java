package com.amazon.bookstore.dto;

import com.amazon.bookstore.model.Author;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;

public class AuthorDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;

    @NotNull(message = "Author name is required")
    @Size(min = 1, message = "Author name is required")
    private String name;

    public AuthorDTO() {
    }

    public AuthorDTO(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public AuthorDTO(Author author) {
        if (author != null) {
            this.id = author.getId();
            this.name = author.getName();
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "AuthorDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
