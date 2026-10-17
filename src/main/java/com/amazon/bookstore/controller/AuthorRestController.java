package com.amazon.bookstore.controller;

import com.amazon.bookstore.dto.AuthorDTO;
import com.amazon.bookstore.model.Author;
import com.amazon.bookstore.service.AuthorService;
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
@RequestMapping("/api/authors")
public class AuthorRestController {

    @Autowired
    private AuthorService authorService;

    public AuthorRestController() {
    }

    public AuthorRestController(AuthorService authorService) {
        this.authorService = authorService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ResponseEntity<List<AuthorDTO>> getAllAuthors() {
        List<Author> authors = authorService.findAll();
        List<AuthorDTO> authorDTOs = new ArrayList<AuthorDTO>();
        if (authors != null) {
            for (Author author : authors) {
                authorDTOs.add(new AuthorDTO(author));
            }
        }
        return new ResponseEntity<List<AuthorDTO>>(authorDTOs, HttpStatus.OK);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<AuthorDTO> getAuthorById(@PathVariable("id") int id) {
        Author author = authorService.findById(id);
        if (author == null) {
            return new ResponseEntity<AuthorDTO>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<AuthorDTO>(new AuthorDTO(author), HttpStatus.OK);
    }

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<AuthorDTO> createAuthor(
            @Valid @RequestBody AuthorDTO authorDTO,
            BindingResult bindingResult) {

        if (bindingResult.hasErrors() || authorDTO == null || authorDTO.getName() == null || authorDTO.getName().trim().isEmpty()) {
            return new ResponseEntity<AuthorDTO>(HttpStatus.BAD_REQUEST);
        }

        Author author = new Author();
        author.setName(authorDTO.getName().trim());
        authorService.save(author);

        AuthorDTO createdDTO = new AuthorDTO(author);
        return new ResponseEntity<AuthorDTO>(createdDTO, HttpStatus.CREATED);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    public ResponseEntity<AuthorDTO> updateAuthor(
            @PathVariable("id") int id,
            @Valid @RequestBody AuthorDTO authorDTO,
            BindingResult bindingResult) {

        Author existingAuthor = authorService.findById(id);
        if (existingAuthor == null) {
            return new ResponseEntity<AuthorDTO>(HttpStatus.NOT_FOUND);
        }

        if (bindingResult.hasErrors() || authorDTO == null || authorDTO.getName() == null || authorDTO.getName().trim().isEmpty()) {
            return new ResponseEntity<AuthorDTO>(HttpStatus.BAD_REQUEST);
        }

        existingAuthor.setName(authorDTO.getName().trim());
        authorService.update(existingAuthor);

        AuthorDTO updatedDTO = new AuthorDTO(existingAuthor);
        return new ResponseEntity<AuthorDTO>(updatedDTO, HttpStatus.OK);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Void> deleteAuthor(@PathVariable("id") int id) {
        Author author = authorService.findById(id);
        if (author == null) {
            return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
        }

        try {
            authorService.delete(id);
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
