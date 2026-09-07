package com.amazon.bookstore.controller;

import com.amazon.bookstore.model.Author;
import com.amazon.bookstore.service.AuthorService;
import com.amazon.bookstore.util.AppConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;

@Controller
@RequestMapping("/author")
public class AuthorController {

    @Autowired
    private AuthorService authorService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listAuthors(Model model) {
        model.addAttribute(
                "authors",
                authorService.findAll());
        return AppConstants.VIEW_AUTHOR_LIST;
    }

    @RequestMapping(value = "/showAddForm", method = RequestMethod.GET)
    public String showAddForm(Model model) {
        Author author = new Author();
        model.addAttribute("author", author);
        return AppConstants.VIEW_AUTHOR_FORM;
    }

    @RequestMapping(value = "/saveAuthor", method = RequestMethod.POST)
    public String saveAuthor(
            @Valid @ModelAttribute("author") Author author,
            BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            return AppConstants.VIEW_AUTHOR_FORM;
        }

        // Check if duplicate author name
        Author existing = authorService.findByName(author.getName());
        if (existing != null && existing.getId() != author.getId()) {
            bindingResult.rejectValue(
                    "name",
                    "duplicate",
                    "Author with name '" + author.getName() + "' already exists."
            );
            return AppConstants.VIEW_AUTHOR_FORM;
        }

        try {
            if (author.getId() == 0) {
                authorService.save(author);
            } else {
                authorService.update(author);
            }
        } catch (Exception e) {
            bindingResult.rejectValue(
                    "name",
                    "duplicate",
                    "Author with name '" + author.getName() + "' already exists."
            );
            return AppConstants.VIEW_AUTHOR_FORM;
        }

        return AppConstants.REDIRECT_AUTHOR_LIST;
    }

    @RequestMapping(value = "/showUpdateForm", method = RequestMethod.GET)
    public String showUpdateForm(
            @RequestParam("authorId") int id,
            Model model) {

        Author author = authorService.findById(id);
        model.addAttribute("author", author);
        return AppConstants.VIEW_AUTHOR_FORM;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(@RequestParam("authorId") int id) {
        authorService.delete(id);
        return AppConstants.REDIRECT_AUTHOR_LIST;
    }
}