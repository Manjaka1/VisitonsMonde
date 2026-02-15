<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.BlogPost" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    List<BlogPost> posts = (List<BlogPost>) request.getAttribute("posts");
    if (posts == null) posts = new java.util.ArrayList<>();
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Blog - VisitonsMonde</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5">
        <h3 class="text-white display-3">Blog</h3>
    </div>
</div>

<div class="container py-5">
    <div class="mx-auto text-center mb-5" style="max-width: 900px;">
        <h5 class="section-title px-3">BLOG</h5>
        <h1 class="mb-0">Actualités & Conseils Voyage</h1>
    </div>

    <div class="row g-4">
        <% for (BlogPost post : posts) { %>
        <div class="col-lg-4 col-md-6">
            <div class="blog-item rounded overflow-hidden h-100">
                <img src="${pageContext.request.contextPath}/img/<%= post.getImage() %>" class="img-fluid w-100" alt="<%= post.getTitre() %>">
                <div class="p-4 bg-light">
                    <div class="d-flex justify-content-between mb-3">
                        <small><i class="fas fa-user me-2 text-primary"></i><%= post.getAuteur() %></small>
                        <small><i class="fas fa-calendar me-2 text-primary"></i><%= sdf.format(post.getDatePublication()) %></small>
                    </div>
                    <% if (post.getCategorie() != null) { %>
                    <span class="badge bg-primary mb-2"><%= post.getCategorie() %></span>
                    <% } %>
                    <h5 class="mb-3"><%= post.getTitre() %></h5>
                    <p class="text-muted"><%= post.getExtrait() %></p>
                    <a href="#" class="btn btn-primary rounded-pill">Lire Plus <i class="fas fa-arrow-right ms-2"></i></a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>