package com.amazon.bookstore.controller;

import com.amazon.bookstore.model.Category;
import com.amazon.bookstore.service.CategoryService;
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
import java.util.List;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listCategories(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            Model model) {
        if (page < 1) {
            page = 1;
        }
        if (size < 1) {
            size = 5;
        }

        long totalItems = categoryService.count();
        int totalPages = (int) Math.ceil((double) totalItems / size);

        if (totalPages > 0 && page > totalPages) {
            page = totalPages;
        }

        List<Category> categories = categoryService.findPaginated(page, size);

        model.addAttribute("categories", categories);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalItems", totalItems);

        return AppConstants.VIEW_CATEGORY_LIST;
    }
    @RequestMapping(value = {"/showFormForAdd", "/showAddForm"}, method = RequestMethod.GET)
    public String showAddForm(Model model) {
        Category category = new Category();
        model.addAttribute("category", category);
        return AppConstants.VIEW_CATEGORY_FORM;

    }

    @RequestMapping(value = "/saveCategory", method = RequestMethod.POST)
    public String saveCategory(@Valid @ModelAttribute("category") Category category, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return AppConstants.VIEW_CATEGORY_FORM;
        }

        // Check for duplicate category name (case-insensitive)
        Category existing = categoryService.findByName(category.getName());
        if (existing != null && existing.getId() != category.getId()) {
            bindingResult.rejectValue("name", "duplicate", "Category with name '" + category.getName() + "' already exists.");
            return AppConstants.VIEW_CATEGORY_FORM;
        }
        try {
            categoryService.save(category);
        } catch (Exception e) {
            bindingResult.rejectValue("name", "duplicate", "Category with name '" + category.getName() + "' already exists.");
            return AppConstants.VIEW_CATEGORY_FORM;
        }

        return AppConstants.REDIRECT_CATEGORY_LIST;

    }

    @RequestMapping(value = {"/showFormForUpdate", "/showUpdateForm"}, method = RequestMethod.GET)
    public String showUpdateForm(@RequestParam("categoryId") int categoryId, Model model) {
        Category category = categoryService.findById(categoryId);
        model.addAttribute("category", category);
        return AppConstants.VIEW_CATEGORY_FORM;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String deleteCategory(@RequestParam("categoryId") int id) {
        categoryService.delete(id);
        return AppConstants.REDIRECT_CATEGORY_LIST;
    }



}