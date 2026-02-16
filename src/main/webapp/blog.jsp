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
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600&family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Loading...</span>
    </div>
</div>
<!-- Spinner End -->

<jsp:include page="navbar.jsp" />

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h3 class="text-white display-3 mb-4">Notre Blog</h3>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="index.jsp">Accueil</a></li>
            <li class="breadcrumb-item"><a href="#">Pages</a></li>
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
            <h1 class="mb-4">Actualités & Conseils Voyage</h1>
            <p class="mb-0">Découvrez nos derniers articles, guides de voyage et conseils d'experts pour préparer vos prochaines aventures.</p>
        </div>
        <div class="row g-4 justify-content-center">
            <% if (posts.isEmpty()) { %>
            <div class="col-12 text-center">
                <p class="text-muted">Aucun article disponible pour le moment.</p>
            </div>
            <% } else {
                for (BlogPost post : posts) { %>
            <div class="col-lg-4 col-md-6">
                <div class="blog-item">
                    <div class="blog-img">
                        <div class="blog-img-inner">
                            <img class="img-fluid w-100 rounded-top" src="${pageContext.request.contextPath}/img/<%= post.getImage() %>" alt="<%= post.getTitre() %>">
                            <div class="blog-icon">
                                <a href="#" class="my-auto"><i class="fas fa-link fa-2x text-white"></i></a>
                            </div>
                        </div>
                        <div class="blog-info d-flex align-items-center border border-start-0 border-end-0">
                            <small class="flex-fill text-center border-end py-2">
                                <i class="fa fa-calendar-alt text-primary me-2"></i><%= sdf.format(post.getDatePublication()) %>
                            </small>
                            <a href="#" class="btn-hover flex-fill text-center text-white border-end py-2">
                                <i class="fa fa-thumbs-up text-primary me-2"></i>1.7K
                            </a>
                            <a href="#" class="btn-hover flex-fill text-center text-white py-2">
                                <i class="fa fa-comments text-primary me-2"></i>1K
                            </a>
                        </div>
                    </div>
                    <div class="blog-content border border-top-0 rounded-bottom p-4">
                        <% if (post.getAuteur() != null && !post.getAuteur().isEmpty()) { %>
                        <p class="mb-3">Publié par: <%= post.getAuteur() %></p>
                        <% } %>
                        <a href="#" class="h4"><%= post.getTitre() %></a>
                        <p class="my-3"><%= post.getExtrait() %></p>
                        <a href="#" class="btn btn-primary rounded-pill py-2 px-4">Lire Plus</a>
                    </div>
                </div>
            </div>
            <% } } %>
        </div>
    </div>
</div>
<!-- Blog End -->

<!-- Subscribe Start -->
<div class="container-fluid subscribe py-5">
    <div class="container text-center py-5">
        <div class="mx-auto text-center" style="max-width: 900px;">
            <h5 class="subscribe-title px-3">Abonnez-vous</h5>
            <h1 class="text-white mb-4">Notre Newsletter</h1>
            <p class="text-white mb-5">Recevez nos derniers conseils de voyage, offres exclusives et inspirations directement dans votre boîte mail.</p>
            <div class="position-relative mx-auto">
                <input class="form-control border-primary rounded-pill w-100 py-3 ps-4 pe-5" type="text" placeholder="Votre email">
                <button type="button" class="btn btn-primary rounded-pill position-absolute top-0 end-0 py-2 px-4 mt-2 me-2">S'abonner</button>
            </div>
        </div>
    </div>
</div>
<!-- Subscribe End -->

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