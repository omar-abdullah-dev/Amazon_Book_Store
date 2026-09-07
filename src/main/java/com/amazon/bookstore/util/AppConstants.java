package com.amazon.bookstore.util;

public final class AppConstants {

    private AppConstants() {
    }

    // Date & Time formats
    public static final String DATE_PATTERN = "yyyy-MM-dd";

    // Regex patterns
    public static final String ISBN_REGEX = "^(?=(?:\\D*\\d){10}(?:(?:\\D*\\d){3})?$)[\\d-]+$";

    // View names
    public static final String VIEW_HOME = "home";
    public static final String VIEW_BOOK_LIST = "list-books";
    public static final String VIEW_BOOK_FORM = "book-form";
    public static final String VIEW_BOOK_DETAILS = "viewMore";
    public static final String VIEW_CATEGORY_LIST = "list-categories";
    public static final String VIEW_CATEGORY_FORM = "category-form";
    public static final String VIEW_AUTHOR_LIST = "list-authors";
    public static final String VIEW_AUTHOR_FORM = "author-form";

    // Redirect URLs
    public static final String REDIRECT_BOOK_LIST = "redirect:/book/list";
    public static final String REDIRECT_CATEGORY_LIST = "redirect:/category/list";
    public static final String REDIRECT_AUTHOR_LIST = "redirect:/author/list";

    // Error codes
    public static final String ERROR_CODE_REQUIRED = "required";
    public static final String ERROR_CODE_DUPLICATE = "duplicate";
}
