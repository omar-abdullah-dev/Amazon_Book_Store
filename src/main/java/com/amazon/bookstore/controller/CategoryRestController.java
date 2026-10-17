package com.amazon.bookstore.controller;

import com.amazon.bookstore.dto.CategoryDTO;
import com.amazon.bookstore.model.Category;
import com.amazon.bookstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/categories")
public class CategoryRestController {

    @Autowired
    private CategoryService categoryService;

    public CategoryRestController() {
    }

    public CategoryRestController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ResponseEntity<List<CategoryDTO>> getAllCategories() {
        List<Category> categories = categoryService.findAll();
        List<CategoryDTO> categoryDTOs = new ArrayList<CategoryDTO>();
        if (categories != null) {
            for (Category category : categories) {
                categoryDTOs.add(new CategoryDTO(category));
            }
        }
        return new ResponseEntity<List<CategoryDTO>>(categoryDTOs, HttpStatus.OK);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<CategoryDTO> getCategoryById(@PathVariable("id") int id) {
        Category category = categoryService.findById(id);
        if (category == null) {
            return new ResponseEntity<CategoryDTO>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<CategoryDTO>(new CategoryDTO(category), HttpStatus.OK);
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<CategoryDTO> createCategory(
            @Valid @RequestBody CategoryDTO categoryDTO,
            BindingResult bindingResult) {

        if (bindingResult.hasErrors() || categoryDTO == null || categoryDTO.getName() == null || categoryDTO.getName().trim().isEmpty()) {
            return new ResponseEntity<CategoryDTO>(HttpStatus.BAD_REQUEST);
        }

        Category category = new Category();
        category.setName(categoryDTO.getName().trim());
        categoryService.save(category);

        CategoryDTO createdDTO = new CategoryDTO(category);
        return new ResponseEntity<CategoryDTO>(createdDTO, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public ResponseEntity<CategoryDTO> updateCategory(
            @PathVariable("id") int id,
            @Valid @RequestBody CategoryDTO categoryDTO,
            BindingResult bindingResult) {

        Category existingCategory = categoryService.findById(id);
        if (existingCategory == null) {
            return new ResponseEntity<CategoryDTO>(HttpStatus.NOT_FOUND);
        }

        if (bindingResult.hasErrors() || categoryDTO == null || categoryDTO.getName() == null || categoryDTO.getName().trim().isEmpty()) {
            return new ResponseEntity<CategoryDTO>(HttpStatus.BAD_REQUEST);
        }

        existingCategory.setName(categoryDTO.getName().trim());
        categoryService.update(existingCategory);

        CategoryDTO updatedDTO = new CategoryDTO(existingCategory);
        return new ResponseEntity<CategoryDTO>(updatedDTO, HttpStatus.OK);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteCategory(@PathVariable("id") int id) {
        Category category = categoryService.findById(id);
        if (category == null) {
            return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
        }

        try {
            categoryService.delete(id);
            return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
        } catch (DataIntegrityViolationException ex) {
            return new ResponseEntity<Void>(HttpStatus.CONFLICT);
        } catch (Exception ex) {
            if (isConstraintViolation(ex)) {
                return new ResponseEntity<Void>(HttpStatus.CONFLICT);
            }
            throw new RuntimeException(ex);
        }
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<Void> handleHttpMessageNotReadable() {
        return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Void> handleMethodArgumentNotValid() {
        return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
    }

    private boolean isConstraintViolation(Throwable ex) {
        Throwable current = ex;
        while (current != null) {
            if (current instanceof org.hibernate.exception.ConstraintViolationException ||
                current instanceof java.sql.SQLIntegrityConstraintViolationException) {
                return true;
            }
            current = current.getCause();
        }
        return false;
    }
}
