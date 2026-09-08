<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Amazon Book Store - ${book.title}</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    
    <style>
        .book-detail-hero {
            background: linear-gradient(135deg, #131921 0%, #1e293b 100%);
            border-bottom: 3px solid var(--amazon-yellow);
            color: #ffffff;
            border-radius: 16px 16px 0 0;
        }
        .book-cover-mock {
            width: 130px;
            height: 180px;
            background: linear-gradient(145deg, #232f3e, #131921);
            border: 2px solid rgba(255, 153, 0, 0.4);
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.4);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 12px;
            text-align: center;
            flex-shrink: 0;
        }
        .detail-meta-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.25rem;
            height: 100%;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .detail-meta-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }
        .meta-icon-wrapper {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            flex-shrink: 0;
        }
        .badge-category-detail {
            background-color: var(--badge-category-bg) !important;
            color: var(--badge-category-text) !important;
            font-size: 0.95rem;
            padding: 0.45rem 0.85rem;
            border-radius: 8px;
            border: 1px solid rgba(2, 132, 199, 0.25);
            display: inline-flex;
            align-items: center;
            max-width: 100%;
            white-space: normal;
            word-break: break-word;
            text-align: left;
        }
        .badge-author-detail {
            background-color: var(--badge-author-bg) !important;
            color: var(--badge-author-text) !important;
            font-size: 0.95rem;
            padding: 0.45rem 0.85rem;
            border-radius: 8px;
            border: 1px solid rgba(147, 51, 234, 0.25);
            display: inline-flex;
            align-items: center;
            margin-right: 6px;
            margin-bottom: 6px;
        }
    </style>
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

<div class="container my-5" style="max-width: 960px;">
    
    <!-- Top Navigation Bar -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <a href="${pageContext.request.contextPath}/book/list" class="btn btn-outline-secondary d-inline-flex align-items-center shadow-sm">
            <i class="bi bi-arrow-left me-2"></i> Back to Book Inventory
        </a>
        <div class="d-flex gap-2">
            <c:url var="editLink" value="/book/showUpdateForm">
                <c:param name="bookId" value="${book.id}" />
            </c:url>
            <a href="${editLink}" class="btn btn-amazon shadow-sm d-inline-flex align-items-center">
                <i class="bi bi-pencil me-2"></i> Edit Book
            </a>
        </div>
    </div>

    <!-- Main Presentation Card -->
    <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
        
        <!-- Hero Header -->
        <div class="book-detail-hero p-4 p-md-5">
            <div class="d-flex flex-column flex-md-row align-items-md-center gap-4">
                
                <!-- Book 3D-Like Preview Cover -->
                <div class="book-cover-mock">
                    <i class="bi bi-journal-bookmark-fill fs-1 text-warning mb-2"></i>
                    <span class="text-white-50 small fw-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 1px;">Amazon Book</span>
                    <span class="badge bg-warning text-dark mt-2 fw-semibold">#${book.id}</span>
                </div>

                <!-- Book Titles & Main Meta -->
                <div class="flex-grow-1">
                    <div class="d-flex align-items-center gap-2 mb-2 flex-wrap">
                        <span class="badge bg-warning text-dark fw-bold px-3 py-1 rounded-pill">
                            <i class="bi bi-bookmark-check-fill me-1"></i> Book Catalog
                        </span>
                        <span class="text-white-50 small">&bull; Record ID: #${book.id}</span>
                    </div>

                    <h1 class="fw-bold text-white mb-3" style="font-size: 2rem; line-height: 1.3;">
                        ${book.title}
                    </h1>

                    <!-- Category & Authors inline summary -->
                    <div class="d-flex flex-wrap gap-2 align-items-center mt-2">
                        <c:choose>
                            <c:when test="${not empty book.category}">
                                <span class="badge badge-category-detail">
                                    <i class="bi bi-tag-fill me-2"></i> ${book.category.name}
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary px-3 py-2">Uncategorized</span>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${not empty book.authors}">
                            <c:forEach var="author" items="${book.authors}">
                                <span class="badge badge-author-detail">
                                    <i class="bi bi-person-fill me-1"></i> ${author.name}
                                </span>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>

            </div>
        </div>

        <!-- Details Body -->
        <div class="card-body p-4 p-md-5">
            
            <div class="d-flex align-items-center mb-4">
                <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 36px; height: 36px;">
                    <i class="bi bi-card-checklist fs-5"></i>
                </div>
            </div>

            <!-- Grid of Metadata Cards -->
            <div class="row g-3 g-md-4">
                
                <!-- ISBN -->
                <div class="col-md-6 col-lg-4">
                    <div class="detail-meta-card d-flex align-items-center gap-3">
                        <div class="meta-icon-wrapper bg-primary-subtle text-primary">
                            <i class="bi bi-upc-scan"></i>
                        </div>
                        <div>
                            <small class="text-muted text-uppercase fw-semibold d-block">ISBN Code</small>
                            <span class="fw-bold fs-6">
                                ${not empty book.bookDetails && not empty book.bookDetails.isbn ? book.bookDetails.isbn : '<span class="text-muted fst-italic">N/A</span>'}
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Publisher -->
                <div class="col-md-6 col-lg-4">
                    <div class="detail-meta-card d-flex align-items-center gap-3">
                        <div class="meta-icon-wrapper bg-success-subtle text-success">
                            <i class="bi bi-building"></i>
                        </div>
                        <div>
                            <small class="text-muted text-uppercase fw-semibold d-block">Publisher</small>
                            <span class="fw-bold fs-6">
                                ${not empty book.bookDetails && not empty book.bookDetails.publisher ? book.bookDetails.publisher : '<span class="text-muted fst-italic">N/A</span>'}
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Publication Date -->
                <div class="col-md-6 col-lg-4">
                    <div class="detail-meta-card d-flex align-items-center gap-3">
                        <div class="meta-icon-wrapper bg-warning-subtle text-warning">
                            <i class="bi bi-calendar-event"></i>
                        </div>
                        <div>
                            <small class="text-muted text-uppercase fw-semibold d-block">Publication Date</small>
                            <span class="fw-bold fs-6">
                                <c:choose>
                                    <c:when test="${not empty book.bookDetails && not empty book.bookDetails.publicationDate}">
                                        <fmt:formatDate value="${book.bookDetails.publicationDate}" pattern="yyyy-MM-dd" />
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted fst-italic">N/A</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Number of Pages -->
                <div class="col-md-6 col-lg-4">
                    <div class="detail-meta-card d-flex align-items-center gap-3">
                        <div class="meta-icon-wrapper bg-info-subtle text-info">
                            <i class="bi bi-book"></i>
                        </div>
                        <div>
                            <small class="text-muted text-uppercase fw-semibold d-block">Page Count</small>
                            <span class="fw-bold fs-6">
                                ${not empty book.bookDetails && book.bookDetails.numberOfPages > 0 ? book.bookDetails.numberOfPages : '<span class="text-muted fst-italic">N/A</span>'} 
                                <c:if test="${not empty book.bookDetails && book.bookDetails.numberOfPages > 0}">Pages</c:if>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Language -->
                <div class="col-md-6 col-lg-4">
                    <div class="detail-meta-card d-flex align-items-center gap-3">
                        <div class="meta-icon-wrapper bg-danger-subtle text-danger">
                            <i class="bi bi-translate"></i>
                        </div>
                        <div>
                            <small class="text-muted text-uppercase fw-semibold d-block">Language</small>
                            <span class="fw-bold fs-6">
                                <c:choose>
                                    <c:when test="${not empty book.bookDetails && not empty book.bookDetails.language}">
                                        <c:choose>
                                            <c:when test="${book.bookDetails.language == 'English'}">🇺🇸 English</c:when>
                                            <c:when test="${book.bookDetails.language == 'Arabic'}">🇸🇦 Arabic (العربية)</c:when>
                                            <c:when test="${book.bookDetails.language == 'French'}">🇫🇷 French (Français)</c:when>
                                            <c:when test="${book.bookDetails.language == 'German'}">🇩🇪 German (Deutsch)</c:when>
                                            <c:when test="${book.bookDetails.language == 'Spanish'}">🇪🇸 Spanish (Español)</c:when>
                                            <c:when test="${book.bookDetails.language == 'Italian'}">🇮🇹 Italian (Italiano)</c:when>
                                            <c:when test="${book.bookDetails.language == 'Russian'}">🇷🇺 Russian</c:when>
                                            <c:otherwise>${book.bookDetails.language}</c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted fst-italic">N/A</span>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Category Direct Info -->
                <div class="col-md-6 col-lg-4">
                    <div class="detail-meta-card d-flex align-items-center gap-3">
                        <div class="meta-icon-wrapper bg-secondary-subtle text-secondary">
                            <i class="bi bi-tags"></i>
                        </div>
                        <div class="overflow-hidden">
                            <small class="text-muted text-uppercase fw-semibold d-block">Category Name</small>
                            <span class="fw-bold fs-6 text-truncate d-block">
                                ${not empty book.category ? book.category.name : '<span class="text-muted fst-italic">None</span>'}
                            </span>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <!-- Footer Actions -->
        <div class="card-footer bg-light p-4 d-flex flex-column flex-sm-row justify-content-between align-items-center gap-3">
            <div class="d-flex gap-2">
                <c:url var="editLink" value="/book/showUpdateForm">
                    <c:param name="bookId" value="${book.id}" />
                </c:url>
                <a href="${editLink}" class="btn btn-amazon btn-sm px-3 shadow-sm">
                    <i class="bi bi-pencil me-1"></i> Edit Book
                </a>
                <a href="${pageContext.request.contextPath}/book/list" class="btn btn-secondary btn-sm px-3">
                    <i class="bi bi-collection me-1"></i> Back to List
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

    document.addEventListener("DOMContentLoaded", function() {
        const currentTheme = document.documentElement.getAttribute('data-bs-theme') || 'light';
        updateThemeUI(currentTheme);
    });
</script>

</body>
</html>
