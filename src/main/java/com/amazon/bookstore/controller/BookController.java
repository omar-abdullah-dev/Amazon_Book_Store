package com.amazon.bookstore.controller;

import com.amazon.bookstore.model.Author;
import com.amazon.bookstore.model.Book;
import com.amazon.bookstore.model.BookDetails;
import com.amazon.bookstore.model.Category;
import com.amazon.bookstore.service.AuthorService;
import com.amazon.bookstore.service.BookService;
import com.amazon.bookstore.service.CategoryService;
import com.amazon.bookstore.util.AppConstants;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/book")
public class BookController {

    @Autowired
    private BookService bookService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private AuthorService authorService;

    public BookController() {
    }

    public BookController(BookService bookService, CategoryService categoryService, AuthorService authorService) {
        this.bookService = bookService;
        this.categoryService = categoryService;
        this.authorService = authorService;
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(AppConstants.DATE_PATTERN);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));

        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        binder.registerCustomEditor(String.class, stringTrimmerEditor);
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listBooks(Model model) {
        model.addAttribute("books", bookService.findAll());
        return AppConstants.VIEW_BOOK_LIST;
    }

    @RequestMapping(value = {"/showAddForm", "/showFormForAdd"}, method = RequestMethod.GET)
    public String showAddForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("authors", authorService.findAll());
        return AppConstants.VIEW_BOOK_FORM;
    }

    @RequestMapping(value = "/saveBook", method = RequestMethod.POST)
    public String saveBook(
            @Valid @ModelAttribute("book") Book book,
            BindingResult bindingResult,
            @RequestParam(value = "authorIds", required = false) List<Integer> authorIds,
            Model model
        ) {

        // Validate Category
        if (book.getCategory() == null || book.getCategory().getId() == 0) {
            bindingResult.rejectValue("category.id", "required", "Please select a category.");
        }

        // Validate Author
        if (authorIds == null || authorIds.isEmpty()) {
            bindingResult.rejectValue("authors", "required", "Please select at least one author.");
        }

        // Validate Duplicate ISBN
        if (book.getBookDetails() != null && book.getBookDetails().getIsbn() != null && !book.getBookDetails().getIsbn().trim().isEmpty()) {
            Book existingBook = bookService.findByIsbn(book.getBookDetails().getIsbn());
            if (existingBook != null && existingBook.getId() != book.getId()) {
                bindingResult.rejectValue("bookDetails.isbn", AppConstants.ERROR_CODE_DUPLICATE,
                        "Book with ISBN '" + book.getBookDetails().getIsbn() + "' already exists.");
            }
        }

        if (bindingResult.hasErrors()) {
            model.addAttribute("book", book);
            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("authors", authorService.findAll());
            return AppConstants.VIEW_BOOK_FORM;
        }

        // set Category
        if (book.getCategory() != null && book.getCategory().getId() > 0) {
            Category category = categoryService.findById(book.getCategory().getId());
            book.setCategory(category);
        } else {
            book.setCategory(null);
        }

        // set Authors
        if (authorIds != null && !authorIds.isEmpty()) {
            List<Author> authorList = new ArrayList<>();
            for (Integer authorId : authorIds) {
                Author author = authorService.findById(authorId);
                if (author != null) {
                    authorList.add(author);
                }
            }
            book.setAuthors(authorList);
        } else {
            book.setAuthors(new ArrayList<>());
        }

        // Bi-directional link between Book and BookDetails
        if (book.getBookDetails() != null) {
            book.getBookDetails().setBook(book);
        }

        try {
            if (book.getId() == 0) {
                bookService.save(book);
            } else {
                bookService.update(book);
            }
        } catch (Exception e) {
            bindingResult.rejectValue("bookDetails.isbn", AppConstants.ERROR_CODE_DUPLICATE,
                    "Book with ISBN '" + (book.getBookDetails() != null ? book.getBookDetails().getIsbn() : "") + "' already exists.");
            model.addAttribute("book", book);
            model.addAttribute("categories", categoryService.findAll());
            model.addAttribute("authors", authorService.findAll());
            return AppConstants.VIEW_BOOK_FORM;
        }

        return AppConstants.REDIRECT_BOOK_LIST;
    }

    @RequestMapping(value = {"/showUpdateForm", "/showFormForUpdate"}, method = RequestMethod.GET)
    public String showUpdateForm(@RequestParam("bookId") int id, Model model) {
        Book book = bookService.findById(id);
        if (book != null && book.getBookDetails() == null) {
            book.setBookDetails(new BookDetails());
        }
        model.addAttribute("book", book);
        model.addAttribute("categories", categoryService.findAll());
        model.addAttribute("authors", authorService.findAll());
        return AppConstants.VIEW_BOOK_FORM;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(@RequestParam("bookId") int id) {
        bookService.delete(id);
        return AppConstants.REDIRECT_BOOK_LIST;
    }

    @RequestMapping(value = "/viewMore", method = RequestMethod.GET)
    public String viewMore(@RequestParam("bookId") int id, Model model) {
        Book book = bookService.findById(id);
        model.addAttribute("book", book);
        return AppConstants.VIEW_BOOK_DETAILS;
    }

    

}