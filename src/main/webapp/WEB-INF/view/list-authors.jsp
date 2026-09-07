<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - Authors</title>
    
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
                    <a class="nav-link amazon-nav-link" href="${pageContext.request.contextPath}/category/list"><i class="bi bi-tags me-1"></i> Categories</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link amazon-nav-link active" href="${pageContext.request.contextPath}/author/list"><i class="bi bi-people me-1"></i> Authors</a>
                </li>
            </ul>
            <div class="d-flex align-items-center gap-2 mt-2 mt-lg-0">
                <button type="button" class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()" title="Toggle Dark/Light Mode">
                    <i class="bi bi-moon-stars" id="themeIcon"></i> <span id="themeText">Dark</span>
                </button>
                <a href="${pageContext.request.contextPath}/author/showAddForm" class="btn btn-amazon shadow-sm btn-sm">
                    <i class="bi bi-plus-circle me-1"></i> Add Author
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container my-5">
    
    <!-- Top Header & Actions -->
    <div class="row align-items-center mb-4">
        <div class="col-md-6">
            <h2 class="fw-bold m-0"><i class="bi bi-people text-primary me-2"></i>Author Directory</h2>
            <p class="text-secondary mb-0">Manage and browse book authors</p>
        </div>
        <div class="col-md-6 text-md-end mt-3 mt-md-0">
            <a href="${pageContext.request.contextPath}/author/showAddForm" class="btn btn-amazon shadow-sm">
                <i class="bi bi-plus-lg me-1"></i> Add New Author
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
                <input type="text" id="authorSearchInput" class="form-control border-start-0" 
                       placeholder="Search author by name or ID in real-time..." onkeyup="filterAuthors()" />
            </div>
        </div>
    </div>

    <!-- Authors Data Table -->
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="authorTable">
                    <thead class="table-dark">
                        <tr>
                            <th class="ps-4" style="width: 15%;">ID</th>
                            <th style="width: 60%;">Author Name</th>
                            <th class="text-end pe-4" style="width: 25%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="tempAuthor" items="${authors}">
                            <c:url var="updateLink" value="/author/showUpdateForm">
                                <c:param name="authorId" value="${tempAuthor.id}" />
                            </c:url>
                            <c:url var="deleteLink" value="/author/delete">
                                <c:param name="authorId" value="${tempAuthor.id}" />
                            </c:url>

                            <tr class="author-row">
                                <td class="ps-4 fw-semibold text-muted author-id">#${tempAuthor.id}</td>
                                <td>
                                    <span class="badge badge-author px-3 py-2 fs-6 author-name">
                                        <i class="bi bi-person me-1"></i>${tempAuthor.name}
                                    </span>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="d-inline-flex gap-2">
                                        <a href="${updateLink}" class="btn btn-sm btn-outline-secondary py-1 px-3">
                                            <i class="bi bi-pencil me-1"></i>Update
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger py-1 px-3"
                                                onclick="openDeleteModal('${deleteLink}', '${tempAuthor.name}')">
                                            <i class="bi bi-trash me-1"></i>Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- No results found row -->
                        <tr id="noAuthorMatchRow" style="display: none;">
                            <td colspan="3" class="text-center text-muted py-4">
                                <i class="bi bi-search fs-3 d-block mb-1 text-secondary"></i>
                                No matching authors found.
                            </td>
                        </tr>

                        <c:if test="${empty authors}">
                            <tr>
                                <td colspan="3" class="text-center text-muted py-5">
                                    <i class="bi bi-people fs-1 d-block mb-2 text-secondary"></i>
                                    No authors available yet.<br/>
                                    <a href="${pageContext.request.contextPath}/author/showAddForm" class="btn btn-amazon btn-sm mt-3">
                                        + Add First Author
                                    </a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

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
                    Do you really want to delete author <strong id="deleteItemName" class="text-dark"></strong>?
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

<!-- Footer -->
<footer class="py-4 border-top text-center text-muted small mt-auto">
    <div class="container">
        &bull; Amazon Book Store Application
    </div>
</footer>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Theme Switcher & Search Script -->
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

    // Author Live Search Function
    function filterAuthors() {
        const input = document.getElementById("authorSearchInput").value.toLowerCase().trim();
        const rows = document.querySelectorAll(".author-row");
        const noMatch = document.getElementById("noAuthorMatchRow");
        let visibleCount = 0;

        rows.forEach(row => {
            const name = row.querySelector(".author-name").textContent.toLowerCase();
            const id = row.querySelector(".author-id").textContent.toLowerCase();

            if (name.includes(input) || id.includes(input)) {
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
