<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - ${category.id == 0 ? 'Add Category' : 'Update Category'}</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark amazon-navbar sticky-top">
    <div class="container">
        <a class="navbar-brand amazon-brand" href="${pageContext.request.contextPath}/">
            <i class="bi bi-book-half"></i> Amazon Book Store
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#amazonNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="amazonNav">
            <ul class="navbar-nav me-auto ms-lg-3">
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/"><i class="bi bi-house me-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/book/list"><i class="bi bi-collection me-1"></i> Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link active" href="${pageContext.request.contextPath}/category/list"><i class="bi bi-tags me-1"></i> Categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/author/list"><i class="bi bi-people me-1"></i> Authors</a>
                </li>
            </ul>
            <div class="d-flex align-items-center gap-2 mt-2 mt-lg-0">
                <button type="button" class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
                    <i class="bi bi-moon-stars" id="themeIcon"></i> <span id="themeText">Dark</span>
                </button>
            </div>
        </div>
    </div>
</nav>

<div class="container my-5" style="max-width: 580px;">
    
    <!-- Header -->
    <div class="header text-center mb-4">
        <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-3 py-2 rounded-pill mb-2 fw-semibold">
            <i class="bi bi-tags me-1"></i> Category Management
        </span>
        <h2 class="fw-bold mt-2">
            <i class="bi ${category.id == 0 ? 'bi-plus-circle-fill text-primary' : 'bi-pencil-square text-primary'} me-2"></i>
            ${category.id == 0 ? 'Add New Category' : 'Update Category'}
        </h2>
        <p class="text-secondary">Provide a descriptive category or genre name for organizing books</p>
    </div>

    <!-- Server-Side Error Alert Box (Spring Validation / Flash Error) -->
    <spring:hasBindErrors name="category">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 d-flex align-items-center mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-4 me-3 flex-shrink-0"></i>
            <div>
                <strong>Validation Error:</strong>
                <form:errors path="*" element="div" cssClass="small mt-1" />
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </spring:hasBindErrors>

    <c:if test="${not empty nameError}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 d-flex align-items-center mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-4 me-3 flex-shrink-0"></i>
            <div>
                <strong>Validation Error:</strong>
                <div class="small mt-1">${nameError}</div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Card Form -->
    <div class="card shadow-sm border-0 rounded-4" id="categoryFormCard">
        <div class="card-body p-4 p-md-5">
            <form:form id="categoryForm" action="${pageContext.request.contextPath}/category/saveCategory" 
                       modelAttribute="category" method="POST" novalidate="novalidate">
                
                <form:hidden path="id" />

                <!-- Category Name Input Group -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <label for="categoryName" class="form-label fw-semibold mb-0">
                            Category Name <span class="text-danger">*</span>
                        </label>
                        <span class="input-character-counter text-muted" id="charCounter">0 / 50</span>
                    </div>

                    <div class="position-relative">
                        <form:input path="name" id="categoryName" 
                                    cssClass="form-control form-control-lg pe-5" 
                                    placeholder="e.g. Science Fiction, Computer Science" 
                                    maxlength="50"
                                    autocomplete="off"
                                    required="required" />
                        
                        <!-- Real-time Status Icon -->
                        <span id="validationIcon" class="position-absolute top-50 end-0 translate-middle-y me-3 d-none"></span>
                    </div>

                    <!-- Guidance Help Text -->
                    <div class="form-text text-muted small mt-1" id="categoryHelpText">
                        <i class="bi bi-info-circle me-1"></i> Must be between 1 and 50 characters.
                    </div>

                    <!-- Client-Side Feedback Message -->
                    <div id="clientErrorFeedback" class="invalid-feedback d-none">
                        <i class="bi bi-exclamation-circle-fill me-1"></i>
                        <span id="clientErrorText">Category name is required.</span>
                    </div>

                    <!-- Spring JSR-303 Backend Error Feedback -->
                    <form:errors path="name" cssClass="invalid-feedback d-block" />
                </div>

                <!-- Form Action Buttons -->
                <div class="d-flex gap-2 pt-2">
                    <button type="submit" id="saveCategoryBtn" class="btn btn-amazon btn-lg shadow-sm px-4 flex-grow-1">
                        <i class="bi bi-check2-circle me-1" id="btnIcon"></i>
                        <span id="btnText">${category.id == 0 ? 'Save Category' : 'Update Category'}</span>
                    </button>
                    <a href="${pageContext.request.contextPath}/category/list" class="btn btn-outline-secondary btn-lg px-4">
                        Cancel
                    </a>
                </div>

            </form:form>
        </div>
    </div>
</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Interactive Real-time Validation & Theme Script -->
<script>
    // Theme Management
    (function() {
        const savedTheme = localStorage.getItem('theme') || 'light';
        document.documentElement.setAttribute('data-bs-theme', savedTheme);
    })();

    function updateThemeUI(theme) {
        const themeIcon = document.getElementById('themeIcon');
        const themeText = document.getElementById('themeText');
        if (themeIcon && themeText) {
            if (theme === 'dark') {
                themeIcon.className = 'bi bi-sun-fill text-warning';
                themeText.textContent = 'Light';
            } else {
                themeIcon.className = 'bi bi-moon-stars';
                themeText.textContent = 'Dark';
            }
        }
    }

    function toggleTheme() {
        const currentTheme = document.documentElement.getAttribute('data-bs-theme') || 'light';
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        document.documentElement.setAttribute('data-bs-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateThemeUI(newTheme);
    }

    // Real-Time Form Validation
    document.addEventListener("DOMContentLoaded", function() {
        const currentTheme = document.documentElement.getAttribute('data-bs-theme') || 'light';
        updateThemeUI(currentTheme);

        const form = document.getElementById("categoryForm");
        const input = document.getElementById("categoryName");
        const charCounter = document.getElementById("charCounter");
        const valIcon = document.getElementById("validationIcon");
        const clientError = document.getElementById("clientErrorFeedback");
        const clientErrorText = document.getElementById("clientErrorText");
        const formCard = document.getElementById("categoryFormCard");
        const saveBtn = document.getElementById("saveCategoryBtn");
        const btnIcon = document.getElementById("btnIcon");
        const btnText = document.getElementById("btnText");

        // Focus on category input on page load
        if (input) {
            input.focus();
            updateValidationState();
        }

        function updateValidationState(isSubmitted = false) {
            const val = input.value;
            const trimmed = val.trim();
            const len = val.length;

            // Update Character Counter
            charCounter.textContent = len + " / 50";
            if (len >= 45) {
                charCounter.classList.add("text-warning");
                charCounter.classList.remove("text-muted", "text-danger");
            } else if (len > 50) {
                charCounter.classList.add("text-danger");
                charCounter.classList.remove("text-muted", "text-warning");
            } else {
                charCounter.classList.add("text-muted");
                charCounter.classList.remove("text-warning", "text-danger");
            }

            // Only show validation styling if user has typed or submitted
            if (len === 0 && !isSubmitted) {
                input.classList.remove("is-valid", "is-invalid");
                valIcon.classList.add("d-none");
                clientError.classList.add("d-none");
                return false;
            }

            if (trimmed.length === 0) {
                input.classList.remove("is-valid");
                input.classList.add("is-invalid");
                valIcon.className = "position-absolute top-50 end-0 translate-middle-y me-3 bi bi-exclamation-circle-fill text-danger";
                valIcon.classList.remove("d-none");
                clientErrorText.textContent = "Category name cannot be empty or only spaces.";
                clientError.classList.remove("d-none");
                return false;
            } else if (trimmed.length < 2) {
                input.classList.remove("is-valid");
                input.classList.add("is-invalid");
                valIcon.className = "position-absolute top-50 end-0 translate-middle-y me-3 bi bi-exclamation-circle-fill text-danger";
                valIcon.classList.remove("d-none");
                clientErrorText.textContent = "Category name must be at least 2 characters long.";
                clientError.classList.remove("d-none");
                return false;
            } else {
                input.classList.remove("is-invalid");
                input.classList.add("is-valid");
                valIcon.className = "position-absolute top-50 end-0 translate-middle-y me-3 bi bi-check-circle-fill text-success";
                valIcon.classList.remove("d-none");
                clientError.classList.add("d-none");
                return true;
            }
        }

        // Real-time input listener
        input.addEventListener("input", function() {
            updateValidationState(false);
        });

        input.addEventListener("blur", function() {
            if (input.value.length > 0) {
                updateValidationState(true);
            }
        });

        // Form Submit Handler
        form.addEventListener("submit", function(e) {
            const isValid = updateValidationState(true);
            if (!isValid) {
                e.preventDefault();
                input.focus();
                
                // Shake animation on error
                formCard.classList.remove("shake-input");
                void formCard.offsetWidth; // Trigger reflow
                formCard.classList.add("shake-input");
            } else {
                // Submit loading state
                saveBtn.disabled = true;
                btnIcon.className = "spinner-border spinner-border-sm me-1";
                btnText.textContent = "Saving...";
                form.submit();
            }
        });
    });
</script>

</body>
</html>
