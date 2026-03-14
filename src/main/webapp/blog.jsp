<%@ page import="com.visitonsmonde.model.Utilisateur" %>
<%@ page import="com.visitonsmonde.model.Blog" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Blog> blogs = (List<Blog>) request.getAttribute("blogs");
    Integer totalBlogs = (Integer) request.getAttribute("totalBlogs");

    if (blogs == null) blogs = new java.util.ArrayList<>();
    if (totalBlogs == null) totalBlogs = 0;

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <title>Blog Voyage - VisitonsMonde</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="blog voyage, conseils voyage, destinations" name="keywords">
    <meta content="Découvrez nos conseils d'experts et inspirations voyage sur le blog VisitonsMonde" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600&family=Roboto&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/lightbox/css/lightbox.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>

<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Chargement...</span>
    </div>
</div>
<!-- Spinner End -->

<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h1 class="text-white display-3 mb-4">Blog Voyage</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
            <li class="breadcrumb-item active text-white">Blog</li>
        </ol>
    </div>
</div>
<!-- Header End -->

<!-- Blog Start -->
<div class="container-fluid blog py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">Notre Blog</h5>
            <h1 class="mb-4">Conseils & Inspirations Voyage</h1>
            <p class="mb-0">Nos experts partagent leurs secrets et découvertes pour vous aider à vivre des aventures extraordinaires. Guides pratiques, destinations secrètes et conseils d'initiés vous attendent.
            </p>
            <p class="mt-3 text-primary fw-bold"><%= totalBlogs %> articles disponibles</p>
        </div>

        <% if (blogs != null && !blogs.isEmpty()) { %>
        <div class="row g-4 justify-content-center">
            <% for (Blog blog : blogs) { %>
            <div class="col-lg-4 col-md-6">
                <div class="blog-item">
                    <div class="blog-img">
                        <div class="blog-img-inner">
                            <img class="img-fluid w-100 rounded-top"
                                 src="${pageContext.request.contextPath}/<%= blog.getImage() != null ? blog.getImage() : "img/blog-default.jpg" %>"
                                 alt="<%= blog.getTitre() %>"
                                 onerror="this.src='${pageContext.request.contextPath}/img/blog-default.jpg'"
                                 style="height: 250px; object-fit: cover;">
                            <div class="blog-icon">
                                <a href="blog-details?id=<%= blog.getId() %>" class="my-auto">
                                    <i class="fas fa-link fa-2x text-white"></i>
                                </a>
                            </div>
                        </div>
                        <div class="blog-info d-flex align-items-center border border-start-0 border-end-0">
                            <small class="flex-fill text-center border-end py-2">
                                <i class="fa fa-calendar-alt text-primary me-2"></i>
                                <%= blog.getDatePublication() != null ? dateFormat.format(blog.getDatePublication()) : "N/A" %>
                            </small>
                            <a href="#" class="btn-hover flex-fill text-center text-white border-end py-2">
                                <i class="fa fa-thumbs-up text-primary me-2"></i>
                                <%= String.format("%.1fK", blog.getLikes() / 1000.0) %>
                            </a>
                            <a href="#" class="btn-hover flex-fill text-center text-white py-2">
                                <i class="fa fa-comments text-primary me-2"></i>
                                <%= blog.getCommentaires() %>
                            </a>
                        </div>
                    </div>
                    <div class="blog-content border border-top-0 rounded-bottom p-4">
                        <p class="mb-3">Par: <strong><%= blog.getAuteur() != null ? blog.getAuteur() : "Anonyme" %></strong></p>
                        <a href="blog-details?id=<%= blog.getId() %>" class="h4"><%= blog.getTitre() %></a>
                        <p class="my-3"><%= blog.getDescriptionCourte() != null ? blog.getDescriptionCourte() : "" %></p>
                        <a href="blog-details?id=<%= blog.getId() %>" class="btn btn-primary rounded-pill py-2 px-4">
                            Lire Plus
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="row">
            <div class="col-12">
                <div class="alert alert-info text-center py-5">
                    <i class="fas fa-info-circle fa-3x mb-3"></i>
                    <h4>Aucun article disponible pour le moment</h4>
                    <p>Revenez bientôt pour découvrir nos derniers articles voyage !</p>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
<!-- Blog End -->

<!-- Subscribe Start -->
<div class="container-fluid subscribe py-5">
    <div class="container text-center py-5">
        <div class="mx-auto text-center" style="max-width: 900px;">
            <h5 class="subscribe-title px-3">Newsletter</h5>
            <h1 class="text-white mb-4">Ne Ratez Rien</h1>
            <p class="text-white mb-5">Abonnez-vous à notre newsletter voyage pour recevoir chaque semaine nos derniers articles, conseils d'experts et offres exclusives. Plus de 30,000 voyageurs nous font déjà confiance.
            </p>
            <div class="position-relative mx-auto">
                <input class="form-control border-primary rounded-pill w-100 py-3 ps-4 pe-5" type="email" placeholder="Votre adresse email">
                <button type="button" class="btn btn-primary rounded-pill position-absolute top-0 end-0 py-2 px-4 mt-2 me-2">S'abonner</button>
            </div>
        </div>
    </div>
</div>
<!-- Subscribe End -->

<!-- Footer -->
<jsp:include page="footer.jsp" />

<!-- Back to Top -->
<a href="#" class="btn btn-primary btn-primary-outline-0 btn-md-square back-to-top"><i class="fa fa-arrow-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>