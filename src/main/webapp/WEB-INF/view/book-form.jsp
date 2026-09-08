<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - ${book.id == 0 ? 'Add Book' : 'Update Book'}</title>
    
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
                    <a class="nav-link amazon-nav-link active" href="${pageContext.request.contextPath}/book/list"><i class="bi bi-collection me-1"></i> Books</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/category/list"><i class="bi bi-tags me-1"></i> Categories</a>
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

<div class="container my-5" style="max-width: 760px;">
    
    <!-- Header -->
    <div class="header text-center mb-4">
        <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-3 py-2 rounded-pill mb-2 fw-semibold">
            <i class="bi bi-book-half me-1"></i> Book Catalog
        </span>
        <h2 class="fw-bold mt-2">
            <i class="bi ${book.id == 0 ? 'bi-plus-circle-fill text-warning' : 'bi-pencil-square text-warning'} me-2"></i>
            ${book.id == 0 ? 'Add New Book' : 'Update Book Details'}
        </h2>
        <p class="text-secondary">Provide book details, relationships, and publication metadata</p>
    </div>

    <!-- Server-Side Error Alert Box -->
    <spring:hasBindErrors name="book">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0 d-flex align-items-center mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill fs-4 me-3 flex-shrink-0"></i>
            <div>
                <strong>Validation Error:</strong>
                <form:errors path="*" element="div" cssClass="small mt-1" />
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </spring:hasBindErrors>

    <c:if test="${not empty errors}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-0" role="alert">
            <div class="d-flex align-items-center mb-2">
                <i class="bi bi-exclamation-triangle-fill fs-5 me-2"></i>
                <h6 class="alert-heading m-0 fw-bold">Please correct the following errors:</h6>
            </div>
            <ul class="mb-0 ps-3 small">
                <c:forEach var="err" items="${errors}">
                    <li>${err}</li>
                </c:forEach>
            </ul>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Main Form Card -->
    <div class="card shadow-sm border-0 rounded-4" id="bookFormCard">
        <div class="card-body p-4 p-md-5">
            <form:form id="bookForm" action="${pageContext.request.contextPath}/book/saveBook" 
                       modelAttribute="book" method="POST" novalidate="novalidate">
                
                <!-- Hidden fields -->
                <form:hidden path="id" />
                <form:hidden path="bookDetails.id" />

                <!-- Section: Basic Information -->
                <div class="d-flex align-items-center mb-3">
                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 28px; height: 28px;">
                        <i class="bi bi-info fs-6"></i>
                    </div>
                    <h5 class="fw-bold mb-0">Basic Information</h5>
                </div>

                <!-- Title Field -->
                <div class="mb-3">
                    <label for="title" class="form-label fw-semibold">Book Title <span class="text-danger">*</span></label>
                    <form:input path="title" id="title" cssClass="form-control form-control-lg" 
                                placeholder="e.g. Clean Code, Domain-Driven Design" required="required"/>
                    <div id="titleClientError" class="invalid-feedback d-none">
                        <i class="bi bi-exclamation-circle-fill me-1"></i> Book title is required.
                    </div>
                    <form:errors path="title" cssClass="invalid-feedback d-block" />
                </div>

                <!-- Category Field -->
                <div class="mb-3">
                    <label for="category" class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                    <form:select path="category.id" id="category" cssClass="form-select form-select-lg">
                        <form:option value="0" label="-- Select Category --" />
                        <form:options items="${categories}" itemValue="id" itemLabel="name" />
                    </form:select>
                    <div id="categoryClientError" class="invalid-feedback d-none">
                        <i class="bi bi-exclamation-circle-fill me-1"></i> Please select a category.
                    </div>
                    <form:errors path="category" cssClass="invalid-feedback d-block" />
                </div>

                <!-- Authors Multi-Select Field -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <label class="form-label fw-semibold mb-0">Author(s) <span class="text-danger">*</span></label>
                        <small class="text-muted fst-italic">(Select at least 1 author)</small>
                    </div>

                    <div id="authorsContainer" class="p-3 bg-light rounded-3 border">
                        <c:choose>
                            <c:when test="${not empty authors}">
                                <div class="row g-2">
                                    <c:forEach var="tempAuthor" items="${authors}">
                                        <c:set var="isAuthorSelected" value="false" />
                                        <c:if test="${not empty book.authors}">
                                            <c:forEach var="bookAuthor" items="${book.authors}">
                                                <c:if test="${bookAuthor.id == tempAuthor.id}">
                                                    <c:set var="isAuthorSelected" value="true" />
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                        <div class="col-sm-6">
                                            <div class="form-check p-2 rounded hover-bg-light">
                                                <input class="form-check-input author-checkbox" type="checkbox" name="authorIds" 
                                                       id="author_${tempAuthor.id}" value="${tempAuthor.id}"
                                                       ${isAuthorSelected ? 'checked="checked"' : ''} />
                                                <label class="form-check-label fw-medium ms-1" for="author_${tempAuthor.id}">
                                                    <i class="bi bi-person me-1 text-secondary"></i>${tempAuthor.name}
                                                </label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted text-center py-2">
                                    <i class="bi bi-exclamation-circle me-1"></i> No authors found. 
                                    <a href="${pageContext.request.contextPath}/author/showAddForm" target="_blank" class="fw-semibold text-primary">Add an author first</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div id="authorClientError" class="text-danger small mt-1 d-none">
                        <i class="bi bi-exclamation-circle-fill me-1"></i> Please select at least one author for this book.
                    </div>
                    <form:errors path="authors" cssClass="invalid-feedback d-block" />
                </div>

                <hr class="my-4"/>

                <!-- Section: Publication Details (OneToOne) -->
                <div class="d-flex align-items-center mb-3">
                    <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 28px; height: 28px;">
                        <i class="bi bi-card-checklist fs-6"></i>
                    </div>
                    <h5 class="fw-bold mb-0">Publication Details <span class="text-muted fs-6 fw-normal">(One-to-One)</span></h5>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label for="isbn" class="form-label fw-semibold">
                            ISBN <span class="text-danger">*</span>
                        </label>
                        <form:input path="bookDetails.isbn" id="isbn" 
                                    cssClass="form-control" 
                                    placeholder="e.g. 978-0-13-235088-4 or 978-0132350884" required="required" />
                        <div class="form-text text-muted small">
                            <i class="bi bi-info-circle me-1"></i> Unique 10 or 13 digits ISBN (e.g. 978-0-13-235088-4)
                        </div>
                        <div id="isbnClientError" class="invalid-feedback d-none">
                            <i class="bi bi-exclamation-circle-fill me-1"></i> <span id="isbnErrorMsg">Please enter a valid ISBN.</span>
                        </div>
                        <form:errors path="bookDetails.isbn" cssClass="invalid-feedback d-block" />
                    </div>
                    <div class="col-md-6">
                        <label for="publisher" class="form-label fw-semibold">Publisher</label>
                        <form:input path="bookDetails.publisher" id="publisher" cssClass="form-control" placeholder="e.g. Prentice Hall, O'Reilly" />
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label for="publicationDate" class="form-label fw-semibold">Publication Date</label>
                        <fmt:formatDate value="${book.bookDetails.publicationDate}" pattern="yyyy-MM-dd" var="formattedDate" />
                        <form:input path="bookDetails.publicationDate" id="publicationDate" type="date" cssClass="form-control" value="${formattedDate}" />
                    </div>
                    <div class="col-md-6">
                        <label for="numberOfPages" class="form-label fw-semibold">Number of Pages</label>
                        <form:input path="bookDetails.numberOfPages" id="numberOfPages" type="number" min="1" cssClass="form-control" placeholder="e.g. 464" />
                    </div>
                </div>

                <!-- Language Field -->
                <div class="mb-4">
                    <label for="language" class="form-label fw-semibold">
                        Language <span class="text-danger">*</span> <i class="bi bi-translate text-primary ms-1"></i>
                    </label>
                    <form:select path="bookDetails.language" id="language" cssClass="form-select form-select-lg">
                        <form:option value="" label="-- Select or Pick Language Below --" />
                        <form:option value="English" label="🇺🇸 English" />
                        <form:option value="Arabic" label="🇸🇦 Arabic (العربية)" />
                        <form:option value="French" label="🇫🇷 French (Français)" />
                        <form:option value="German" label="🇩🇪 German (Deutsch)" />
                        <form:option value="Spanish" label="🇪🇸 Spanish (Español)" />
                        <form:option value="Italian" label="🇮🇹 Italian (Italiano)" />
                        <form:option value="Russian" label="🇷🇺 Russian" />
                    </form:select>
                    <div id="languageClientError" class="invalid-feedback d-none">
                        <i class="bi bi-exclamation-circle-fill me-1"></i> Please select a language for this book.
                    </div>
                    <form:errors path="bookDetails.language" cssClass="invalid-feedback d-block" />

                    <!-- Quick Select / Drag & Drop Language Selector -->
                    <div class="mt-3 p-3 bg-light rounded-3 border">
                        <small class="text-muted fw-bold d-block mb-2">
                            <i class="bi bi-hand-index-thumb me-1"></i> Quick Click or Drag Language Chip to Box:
                        </small>
                        <div class="d-flex flex-wrap gap-2" id="languageChipsContainer">
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="English" style="cursor: grab;">🇺🇸 English</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Arabic" style="cursor: grab;">🇸🇦 Arabic</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="French" style="cursor: grab;">🇫🇷 French</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="German" style="cursor: grab;">🇩🇪 German</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Spanish" style="cursor: grab;">🇪🇸 Spanish</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Italian" style="cursor: grab;">🇮🇹 Italian</span>
                            <span class="badge bg-white text-dark border p-2 shadow-sm lang-chip" draggable="true" data-lang="Russian" style="cursor: grab;">🇷🇺 Russian</span>
                        </div>
                    </div>
                </div>

                <!-- Form Action Buttons -->
                <div class="d-flex gap-2 pt-2">
                    <button type="submit" id="saveBookBtn" class="btn btn-amazon btn-lg shadow-sm px-4 flex-grow-1">
                        <i class="bi bi-check2-circle me-1" id="btnIcon"></i>
                        <span id="btnText">${book.id == 0 ? 'Save Book' : 'Update Book'}</span>
                    </button>
                    <a href="${pageContext.request.contextPath}/book/list" class="btn btn-outline-secondary btn-lg px-4">
                        Cancel
                    </a>
                </div>

            </form:form>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="py-4 border-top text-center text-muted small mt-auto">
    <div class="container">
        &bull; Amazon Book Store Application
    </div>
</footer>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Theme Switcher & Validation Script -->
<script>
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

    document.addEventListener("DOMContentLoaded", function() {
        const currentTheme = document.documentElement.getAttribute('data-bs-theme') || 'light';
        updateThemeUI(currentTheme);

        const bookForm = document.getElementById("bookForm");
        const formCard = document.getElementById("bookFormCard");
        const titleInput = document.getElementById("title");
        const titleClientError = document.getElementById("titleClientError");
        const categorySelect = document.getElementById("category");
        const categoryClientError = document.getElementById("categoryClientError");
        const authorsContainer = document.getElementById("authorsContainer");
        const authorClientError = document.getElementById("authorClientError");
        const authorCheckboxes = document.querySelectorAll(".author-checkbox");
        const isbnInput = document.getElementById("isbn");
        const isbnClientError = document.getElementById("isbnClientError");
        const langSelect = document.getElementById("language");
        const languageClientError = document.getElementById("languageClientError");
        const chips = document.querySelectorAll(".lang-chip");
        const saveBtn = document.getElementById("saveBookBtn");
        const btnIcon = document.getElementById("btnIcon");
        const btnText = document.getElementById("btnText");

        // Real-time Title validation
        if (titleInput) {
            titleInput.addEventListener("input", function() {
                if (this.value.trim() !== "") {
                    this.classList.remove("is-invalid");
                    if (titleClientError) titleClientError.classList.add("d-none");
                }
            });
        }

        // Real-time Category validation
        if (categorySelect) {
            categorySelect.addEventListener("change", function() {
                if (this.value && this.value !== "0") {
                    this.classList.remove("is-invalid");
                    if (categoryClientError) categoryClientError.classList.add("d-none");
                }
            });
        }

        // Real-time Author validation
        authorCheckboxes.forEach(cb => {
            cb.addEventListener("change", function () {
                const checkedCount = document.querySelectorAll(".author-checkbox:checked").length;
                if (checkedCount > 0) {
                    authorsContainer.classList.remove("border-danger", "bg-danger-subtle");
                    if (authorClientError) authorClientError.classList.add("d-none");
                }
            });
        });

        // ISBN Regex Validator (10 or 13 digits with optional hyphens)
        const isbnRegex = /^(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+$/;
        const isbnErrorMsg = document.getElementById("isbnErrorMsg");

        function validateIsbnField() {
            if (!isbnInput) return true;
            const val = isbnInput.value.trim();
            if (val === "") {
                isbnInput.classList.remove("is-valid");
                isbnInput.classList.add("is-invalid");
                if (isbnErrorMsg) isbnErrorMsg.textContent = "ISBN is required.";
                if (isbnClientError) isbnClientError.classList.remove("d-none");
                return false;
            } else if (!isbnRegex.test(val)) {
                isbnInput.classList.remove("is-valid");
                isbnInput.classList.add("is-invalid");
                if (isbnErrorMsg) isbnErrorMsg.textContent = "Invalid ISBN format. Must contain 10 or 13 digits (e.g. 978-0-13-235088-4 or 978-0132350884).";
                if (isbnClientError) isbnClientError.classList.remove("d-none");
                return false;
            } else {
                isbnInput.classList.remove("is-invalid");
                isbnInput.classList.add("is-valid");
                if (isbnClientError) isbnClientError.classList.add("d-none");
                return true;
            }
        }

        // Real-time ISBN validation
        if (isbnInput) {
            isbnInput.addEventListener("input", validateIsbnField);
            isbnInput.addEventListener("blur", validateIsbnField);
        }

        // Real-time Language validation
        if (langSelect) {
            langSelect.addEventListener("change", function () {
                if (this.value && this.value.trim() !== "") {
                    this.classList.remove("is-invalid");
                    if (languageClientError) languageClientError.classList.add("d-none");
                }
            });
        }

        // Draggable & Clickable Language Chips
        chips.forEach(chip => {
            chip.addEventListener("dragstart", function (e) {
                e.dataTransfer.setData("text/plain", this.getAttribute("data-lang"));
                this.classList.add("opacity-50");
            });

            chip.addEventListener("dragend", function () {
                this.classList.remove("opacity-50");
            });

            chip.addEventListener("click", function () {
                const langValue = this.getAttribute("data-lang");
                if (langSelect) {
                    langSelect.value = langValue;
                    langSelect.classList.remove("is-invalid");
                    if (languageClientError) languageClientError.classList.add("d-none");
                    highlightSelect();
                }
            });
        });

        if (langSelect) {
            langSelect.addEventListener("dragover", function (e) {
                e.preventDefault();
                this.classList.add("border-warning", "bg-warning-subtle");
            });

            langSelect.addEventListener("dragleave", function () {
                this.classList.remove("border-warning", "bg-warning-subtle");
            });

            langSelect.addEventListener("drop", function (e) {
                e.preventDefault();
                this.classList.remove("border-warning", "bg-warning-subtle");
                const langValue = e.dataTransfer.getData("text/plain");
                if (langValue) {
                    this.value = langValue;
                    this.classList.remove("is-invalid");
                    if (languageClientError) languageClientError.classList.add("d-none");
                    highlightSelect();
                }
            });
        }

        function highlightSelect() {
            if (langSelect) {
                langSelect.classList.add("border-success");
                setTimeout(() => {
                    langSelect.classList.remove("border-success");
                }, 600);
            }
        }

        // Form Submit Validation
        if (bookForm) {
            bookForm.addEventListener("submit", function (e) {
                let isValid = true;
                let firstInvalidEl = null;

                // 1. Title
                if (titleInput && (!titleInput.value || titleInput.value.trim() === "")) {
                    titleInput.classList.add("is-invalid");
                    if (titleClientError) titleClientError.classList.remove("d-none");
                    isValid = false;
                    if (!firstInvalidEl) firstInvalidEl = titleInput;
                }

                // 2. Category
                if (categorySelect && (!categorySelect.value || categorySelect.value === "0")) {
                    categorySelect.classList.add("is-invalid");
                    if (categoryClientError) categoryClientError.classList.remove("d-none");
                    isValid = false;
                    if (!firstInvalidEl) firstInvalidEl = categorySelect;
                }

                // 3. Authors
                const checkedAuthors = document.querySelectorAll(".author-checkbox:checked");
                if (checkedAuthors.length === 0) {
                    if (authorsContainer) authorsContainer.classList.add("border-danger", "bg-danger-subtle");
                    if (authorClientError) authorClientError.classList.remove("d-none");
                    isValid = false;
                    if (!firstInvalidEl) firstInvalidEl = authorsContainer;
                }

                // 4. ISBN
                if (!validateIsbnField()) {
                    isValid = false;
                    if (!firstInvalidEl) firstInvalidEl = isbnInput;
                }

                // 5. Language
                if (langSelect && (!langSelect.value || langSelect.value.trim() === "")) {
                    langSelect.classList.add("is-invalid");
                    if (languageClientError) languageClientError.classList.remove("d-none");
                    isValid = false;
                    if (!firstInvalidEl) firstInvalidEl = langSelect;
                }

                if (!isValid) {
                    e.preventDefault();
                    if (firstInvalidEl) {
                        firstInvalidEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
                        if (typeof firstInvalidEl.focus === 'function') firstInvalidEl.focus();
                    }
                    if (formCard) {
                        formCard.classList.remove("shake-input");
                        void formCard.offsetWidth;
                        formCard.classList.add("shake-input");
                    }
                } else {
                    if (saveBtn) saveBtn.disabled = true;
                    if (btnIcon) btnIcon.className = "spinner-border spinner-border-sm me-1";
                    if (btnText) btnText.textContent = "Saving...";
                    bookForm.submit();
                }
            });
        }
    });
</script>

</body>
</html>
