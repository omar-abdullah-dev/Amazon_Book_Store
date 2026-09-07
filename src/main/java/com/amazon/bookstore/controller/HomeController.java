package com.amazon.bookstore.controller;

import com.amazon.bookstore.service.AuthorService;
import com.amazon.bookstore.service.BookService;
import com.amazon.bookstore.service.CategoryService;
import com.amazon.bookstore.util.AppConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @Autowired(required = false)
    private BookService bookService;

    @Autowired(required = false)
    private CategoryService categoryService;

    @Autowired(required = false)
    private AuthorService authorService;

    @RequestMapping("/")
    public String home(Model model) {
        int totalBooks = 0;
        int totalCategories = 0;
        int totalAuthors = 0;

        try {
            if (bookService != null) {
                totalBooks = bookService.findAll().size();
            }
        } catch (Exception ignored) {
        }

        try {
            if (categoryService != null) {
                totalCategories = categoryService.findAll().size();
            }
        } catch (Exception ignored) {
        }

        try {
            if (authorService != null) {
                totalAuthors = authorService.findAll().size();
            }
        } catch (Exception ignored) {
        }

        model.addAttribute("totalBooks", totalBooks);
        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalAuthors", totalAuthors);

        return AppConstants.VIEW_HOME;
    }
}