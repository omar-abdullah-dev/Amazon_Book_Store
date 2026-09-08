<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - Books</title>
    
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
                <a href="${pageContext.request.contextPath}/book/showAddForm" class="btn btn-amazon shadow-sm btn-sm">
                    <i class="bi bi-plus-circle me-1"></i> Add Book
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container my-5">
    
    <!-- Top Header & Actions -->
    <div class="row align-items-center mb-4">
        <div class="col-md-6">
            <h2 class="fw-bold m-0"><i class="bi bi-collection text-primary me-2"></i>Book Inventory</h2>
            <p class="text-secondary mb-0">Manage catalog with Category, Author, and Publication details</p>
        </div>
        <div class="col-md-6 text-md-end mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/book/showAddForm" class="btn btn-amazon shadow-sm">
                <i class="bi bi-plus-lg me-1"></i> Add New Book
            </a>
        </div>
    </div>

    <!-- Live Search Bar -->
    <div class="card shadow-sm border-0 mb-4 rounded-3">
        <div class="card-body p-3">
            <div class="input-group">
                <span class="input-group-text bg-transparent border-end-0 text-muted">
                    <i class="bi bi-search"></i>
                </span>
                <input type="text" id="bookSearchInput" class="form-control border-start-0" 
                       placeholder="Search books by title, ID, author, category, or ISBN in real-time..." onkeyup="filterBooks()" />
            </div>
        </div>
    </div>

    <!-- Books Data Table -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="bookTable">
                    <thead class="table-dark">
                        <tr>
                            <th class="ps-4" style="width: 8%;">ID</th>
                            <th style="width: 28%;">Title</th>
                            <th style="width: 15%;">Category</th>
                            <th style="width: 20%;">Author(s)</th>
                            <th style="width: 12%;">ISBN</th>
                            <th class="text-end pe-4" style="width: 17%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tempBook" items="${books}">
                            <c:url var="updateLink" value="/book/showUpdateForm">
                                <c:param name="bookId" value="${tempBook.id}" />
                            </c:url>
                            <c:url var="deleteLink" value="/book/delete">
                                <c:param name="bookId" value="${tempBook.id}" />
                            </c:url>
                            <c:url var="viewMoreLink" value="/book/viewMore">
                                <c:param name="bookId" value="${tempBook.id}" />
                            </c:url>

                            <tr class="book-row">
                                <td class="ps-4 fw-semibold text-muted book-id">#${tempBook.id}</td>
                                <td>
                                    <span class="fw-bold book-title">${tempBook.title}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty tempBook.category}">
                                            <span class="badge badge-category px-2 py-1 book-category">
                                                <i class="bi bi-tag me-1"></i>${tempBook.category.name}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic small">Uncategorized</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="book-authors">
                                        <c:choose>
                                            <c:when test="${not empty tempBook.authors}">
                                                <c:forEach var="author" items="${tempBook.authors}">
                                                    <span class="badge badge-author px-2 py-1 me-1 mb-1">
                                                        <i class="bi bi-person me-1"></i>${author.name}
                                                    </span>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted fst-italic small">None</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td class="book-isbn">
                                    <code class="text-secondary">${not empty tempBook.bookDetails && not empty tempBook.bookDetails.isbn ? tempBook.bookDetails.isbn : 'N/A'}</code>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="d-inline-flex gap-1">
                                        <button type="button" class="btn btn-sm btn-outline-info py-1 px-2" 
                                                data-bs-toggle="modal" data-bs-target="#detailsModal_${tempBook.id}" title="Quick Details">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                        <a href="${viewMoreLink}" class="btn btn-sm btn-outline-primary py-1 px-2" title="Full Page Details">
                                            <i class="bi bi-box-arrow-up-right"></i>
                                        </a>
                                        <a href="${updateLink}" class="btn btn-sm btn-outline-secondary py-1 px-2" title="Update Book">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger py-1 px-2" title="Delete Book"
                                                onclick="openDeleteModal('${deleteLink}', '${tempBook.title}')">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- No results found row -->
                        <tr id="noBookMatchRow" style="display: none;">
                            <td colspan="6" class="text-center text-muted py-4">
                                <i class="bi bi-search fs-3 d-block mb-1 text-secondary"></i>
                                No matching books found.
                            </td>
                        </tr>

                        <c:if test="${empty books}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-5">
                                    <i class="bi bi-book fs-1 d-block mb-2 text-secondary"></i>
                                    No books in inventory yet.<br/>
                                    <a href="${pageContext.request.contextPath}/book/showAddForm" class="btn btn-amazon btn-sm mt-3">
                                        + Add First Book
                                    </a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Quick Details Modals -->
    <c:forEach var="tempBook" items="${books}">
        <c:url var="modalUpdateLink" value="/book/showUpdateForm">
            <c:param name="bookId" value="${tempBook.id}" />
        </c:url>
        <c:url var="modalViewMoreLink" value="/book/viewMore">
            <c:param name="bookId" value="${tempBook.id}" />
        </c:url>

        <div class="modal fade" id="detailsModal_${tempBook.id}" tabindex="-1" aria-labelledby="detailsModalLabel_${tempBook.id}" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-bold" id="detailsModalLabel_${tempBook.id}">
                            <i class="bi bi-book-half text-warning me-2"></i>${tempBook.title}
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div class="table-responsive">
                            <table class="table table-bordered mb-0">
                                <tbody>
                                    <tr>
                                        <th class="table-light text-secondary ps-3" style="width: 40%;">Category</th>
                                        <td class="ps-3">
                                            <c:choose>
                                                <c:when test="${not empty tempBook.category}">
                                                    <span class="badge badge-category px-2 py-1">${tempBook.category.name}</span>
                                                </c:when>
                                                <c:otherwise><span class="text-muted fst-italic">Uncategorized</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Author(s)</th>
                                        <td class="ps-3">
                                            <c:choose>
                                                <c:when test="${not empty tempBook.authors}">
                                                    <c:forEach var="author" items="${tempBook.authors}">
                                                        <span class="badge badge-author px-2 py-1 me-1 mb-1">${author.name}</span>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise><span class="text-muted fst-italic">None</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">ISBN</th>
                                        <td class="ps-3 fw-bold">${not empty tempBook.bookDetails && not empty tempBook.bookDetails.isbn ? tempBook.bookDetails.isbn : '<span class="text-muted fst-italic">N/A</span>'}</td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Publisher</th>
                                        <td class="ps-3">${not empty tempBook.bookDetails && not empty tempBook.bookDetails.publisher ? tempBook.bookDetails.publisher : '<span class="text-muted fst-italic">N/A</span>'}</td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Publication Date</th>
                                        <td class="ps-3">
                                            <c:choose>
                                                <c:when test="${not empty tempBook.bookDetails && not empty tempBook.bookDetails.publicationDate}">
                                                    <fmt:formatDate value="${tempBook.bookDetails.publicationDate}" pattern="yyyy-MM-dd" />
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted fst-italic">N/A</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Number of Pages</th>
                                        <td class="ps-3">${not empty tempBook.bookDetails && tempBook.bookDetails.numberOfPages > 0 ? tempBook.bookDetails.numberOfPages : '<span class="text-muted fst-italic">N/A</span>'}</td>
                                    </tr>
                                    <tr>
                                        <th class="table-light text-secondary ps-3">Language</th>
                                        <td class="ps-3">${not empty tempBook.bookDetails && not empty tempBook.bookDetails.language ? tempBook.bookDetails.language : '<span class="text-muted fst-italic">N/A</span>'}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer d-flex justify-content-between">
                        <a href="${modalViewMoreLink}" class="btn btn-outline-info btn-sm">
                            <i class="bi bi-box-arrow-up-right me-1"></i> Full Page Details
                        </a>
                        <div>
                            <a href="${modalUpdateLink}" class="btn btn-amazon btn-sm me-1">
                                <i class="bi bi-pencil me-1"></i> Edit Book
                            </a>
                            <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!-- Modern Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" style="max-width: 420px;">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title fs-5" id="deleteModalLabel">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>Confirm Deletion
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center p-4">
                    <div class="mb-3 text-danger fs-1">
                        <i class="bi bi-trash3-fill"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Are you sure?</h5>
                    <p class="text-secondary mb-1">
                        Do you really want to delete book <strong id="deleteItemName" class="text-dark"></strong>?
                    </p>
                    <small class="text-danger fst-italic">This action cannot be undone.</small>
                </div>
                <div class="modal-footer bg-light d-flex justify-content-center gap-2 border-0">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cancel</button>
                    <a href="#" id="confirmDeleteActionBtn" class="btn btn-danger px-4 shadow-sm">
                        <i class="bi bi-trash me-1"></i> Yes, Delete
                    </a>
                </div>
            </div>
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

<!-- Theme Switcher Script -->
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

    // Book Live Search Function
    function filterBooks() {
        const input = document.getElementById("bookSearchInput").value.toLowerCase().trim();
        const rows = document.querySelectorAll(".book-row");
        const noMatch = document.getElementById("noBookMatchRow");
        let visibleCount = 0;

        rows.forEach(row => {
            const title = row.querySelector(".book-title") ? row.querySelector(".book-title").textContent.toLowerCase() : "";
            const id = row.querySelector(".book-id") ? row.querySelector(".book-id").textContent.toLowerCase() : "";
            const category = row.querySelector(".book-category") ? row.querySelector(".book-category").textContent.toLowerCase() : "";
            const authors = row.querySelector(".book-authors") ? row.querySelector(".book-authors").textContent.toLowerCase() : "";
            const isbn = row.querySelector(".book-isbn") ? row.querySelector(".book-isbn").textContent.toLowerCase() : "";

            if (title.includes(input) || id.includes(input) || category.includes(input) || authors.includes(input) || isbn.includes(input)) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }
        });

        if (noMatch) {
            noMatch.style.display = (visibleCount === 0 && rows.length > 0) ? "" : "none";
        }
    }

    // Open Custom Delete Confirmation Modal
    function openDeleteModal(deleteUrl, itemName) {
        document.getElementById("deleteItemName").textContent = itemName;
        document.getElementById("confirmDeleteActionBtn").setAttribute("href", deleteUrl);
        const modal = new bootstrap.Modal(document.getElementById("deleteConfirmModal"));
        modal.show();
    }

    document.addEventListener("DOMContentLoaded", function() {
        const currentTheme = document.documentElement.getAttribute('data-bs-theme') || 'light';
        updateThemeUI(currentTheme);
    });
</script>

</body>
</html>
