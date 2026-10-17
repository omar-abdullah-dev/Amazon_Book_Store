package com.amazon.bookstore.dto;

import com.amazon.bookstore.model.Category;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;

public class CategoryDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;

    @NotNull(message = "Category name is required")
    @Size(min = 1, message = "Category name is required")
    private String name;

    public CategoryDTO() {
    }

    public CategoryDTO(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public CategoryDTO(Category category) {
        if (category != null) {
            this.id = category.getId();
            this.name = category.getName();
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
        return "CategoryDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}
