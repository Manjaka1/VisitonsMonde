<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 13/07/2025
  Time: 03:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.visitonsmonde.model.Blog" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Blog blog = (Blog) request.getAttribute("blog");
    List<Blog> recentBlogs = (List<Blog>) request.getAttribute("recentBlogs");

    if (blog == null) {
        response.sendRedirect("blog");
        return;
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="utf-8">
    <title><%= blog.getTitre() %> - VisitonsMonde</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="<%= blog.getDescriptionCourte() %>" name="description">

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

    <style>
        .blog-content-detail {
            line-height: 1.8;
            font-size: 1.1rem;
        }
        .blog-content-detail h3, .blog-content-detail h4 {
            color: #13357B;
            margin-top: 30px;
            margin-bottom: 15px;
        }
        .blog-content-detail ul, .blog-content-detail ol {
            margin-left: 20px;
            margin-bottom: 20px;
        }
        .blog-content-detail p {
            margin-bottom: 20px;
        }
        .author-box {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 40px;
        }
        .recent-post-item {
            transition: all 0.3s;
        }
        .recent-post-item:hover {
            transform: translateX(5px);
        }
    </style>
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
        <h1 class="text-white display-5 mb-4"><%= blog.getTitre() %></h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
            <li class="breadcrumb-item active text-white">Article</li>
        </ol>
    </div>
</div>
<!-- Header End -->

<!-- Blog Details Start -->
<div class="container-fluid blog py-5">
    <div class="container py-5">
        <div class="row g-5">
            <!-- Article Principal -->
            <div class="col-lg-8">
                <!-- Image principale -->
                <div class="mb-4">
                    <img class="img-fluid w-100 rounded"
                         src="${pageContext.request.contextPath}/<%= blog.getImage() != null ? blog.getImage() : "img/blog-default.jpg" %>"
                         alt="<%= blog.getTitre() %>"
                         onerror="this.src='${pageContext.request.contextPath}/img/blog-default.jpg'"
                         style="max-height: 500px; object-fit: cover;">
                </div>

                <!-- Métadonnées -->
                <div class="d-flex justify-content-between mb-4">
                    <div>
                        <i class="fa fa-user text-primary me-2"></i>
                        <strong><%= blog.getAuteur() %></strong>
                    </div>
                    <div>
                        <i class="fa fa-calendar-alt text-primary me-2"></i>
                        <%= dateFormat.format(blog.getDatePublication()) %>
                    </div>
                    <div>
                        <i class="fa fa-thumbs-up text-primary me-2"></i>
                        <%= String.format("%.1fK", blog.getLikes() / 1000.0) %> likes
                    </div>
                    <div>
                        <i class="fa fa-comments text-primary me-2"></i>
                        <%= blog.getCommentaires() %> commentaires
                    </div>
                </div>

                <!-- Description courte -->
                <div class="alert alert-info mb-4">
                    <strong><i class="fa fa-info-circle me-2"></i>En résumé :</strong>
                    <%= blog.getDescriptionCourte() %>
                </div>

                <!-- Contenu de l'article -->
                <div class="blog-content-detail">
                    <%= blog.getContenu() %>
                </div>

                <!-- Partage social -->
                <div class="mt-5 pt-4 border-top">
                    <h5 class="mb-3">Partager cet article :</h5>
                    <div class="d-flex gap-2">
                        <a href="#" class="btn btn-primary btn-sm">
                            <i class="fab fa-facebook-f me-2"></i>Facebook
                        </a>
                        <a href="#" class="btn btn-info btn-sm text-white">
                            <i class="fab fa-twitter me-2"></i>Twitter
                        </a>
                        <a href="#" class="btn btn-danger btn-sm">
                            <i class="fab fa-pinterest me-2"></i>Pinterest
                        </a>
                        <a href="#" class="btn btn-success btn-sm">
                            <i class="fab fa-whatsapp me-2"></i>WhatsApp
                        </a>
                    </div>
                </div>

                <!-- Box Auteur -->
                <div class="author-box">
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <i class="fas fa-user-circle fa-4x text-primary"></i>
                        </div>
                        <div>
                            <h5 class="mb-1"><%= blog.getAuteur() %></h5>
                            <p class="text-muted mb-0">Expert voyage et rédacteur chez VisitonsMonde</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Articles récents -->
                <div class="bg-light rounded p-4 mb-4">
                    <h5 class="mb-4">Articles Récents</h5>
                    <% if (recentBlogs != null && !recentBlogs.isEmpty()) {
                        for (Blog recent : recentBlogs) {
                            if (recent.getId() != blog.getId()) { %>
                    <div class="recent-post-item mb-3 pb-3 border-bottom">
                        <a href="blog-details?id=<%= recent.getId() %>" class="text-decoration-none">
                            <div class="d-flex">
                                <img src="${pageContext.request.contextPath}/<%= recent.getImage() != null ? recent.getImage() : "img/blog-default.jpg" %>"
                                     alt="<%= recent.getTitre() %>"
                                     class="rounded me-3"
                                     style="width: 80px; height: 80px; object-fit: cover;"
                                     onerror="this.src='${pageContext.request.contextPath}/img/blog-default.jpg'">
                                <div>
                                    <h6 class="mb-1"><%= recent.getTitre() %></h6>
                                    <small class="text-muted">
                                        <i class="fa fa-calendar-alt me-1"></i>
                                        <%= dateFormat.format(recent.getDatePublication()) %>
                                    </small>
                                </div>
                            </div>
                        </a>
                    </div>
                    <%      }
                    }
                    } %>
                </div>

                <!-- Call to Action -->
                <div class="bg-primary text-white rounded p-4 mb-4">
                    <h5 class="text-white mb-3">Prêt à Voyager ?</h5>
                    <p>Découvrez nos destinations et réservez votre prochaine aventure !</p>
                    <a href="${pageContext.request.contextPath}/destinations" class="btn btn-light w-100">
                        <i class="fa fa-plane me-2"></i>Voir les Destinations
                    </a>
                </div>

                <!-- Newsletter -->
                <div class="bg-light rounded p-4">
                    <h5 class="mb-3">Newsletter</h5>
                    <p class="small">Recevez nos derniers articles directement dans votre boîte mail !</p>
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Votre email">
                        <button class="btn btn-primary" type="button">
                            <i class="fa fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Blog Details End -->

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