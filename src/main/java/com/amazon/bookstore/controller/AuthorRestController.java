package com.amazon.bookstore.controller;

import com.amazon.bookstore.dto.AuthorDTO;
import com.amazon.bookstore.model.Author;
import com.amazon.bookstore.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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
}
