<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.Guide" %>
<%@ page import="java.util.List" %>
<%
    List<Guide> guides = (List<Guide>) request.getAttribute("guides");
    if (guides == null) guides = new java.util.ArrayList<>();

    String erreur = (String) request.getAttribute("erreur");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Nos Guides - VisitonsMonde</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

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
        .guide-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .guide-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .guide-img {
            width: 100%;
            height: 350px;
            object-fit: cover;
        }
        .guide-info {
            padding: 25px;
            background: #f8f9fa;
        }
        .guide-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: #13357B;
            margin-bottom: 5px;
        }
        .guide-specialty {
            color: #86B817;
            font-weight: 500;
            margin-bottom: 15px;
        }
        .guide-details {
            font-size: 0.9rem;
            color: #666;
        }
        .guide-details i {
            color: #13357B;
            margin-right: 8px;
            width: 20px;
        }
        .rating {
            color: #ffc107;
        }
        .social-links a {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #13357B;
            color: white;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin: 0 5px;
            transition: all 0.3s;
        }
        .social-links a:hover {
            background: #86B817;
            transform: scale(1.1);
        }
    </style>
</head>

<body>
<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h3 class="text-white display-3 mb-4">Nos Guides Professionnels</h3>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
            <li class="breadcrumb-item active text-white">Guides</li>
        </ol>
    </div>
</div>
<!-- Header End -->

<!-- Guides Start -->
<div class="container-fluid guide py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">NOS GUIDES</h5>
            <h1 class="mb-0">Rencontrez Nos Experts</h1>
            <p class="mb-0 mt-3">
                Nos guides professionnels sont passionnés, expérimentés et dévoués à rendre votre voyage inoubliable.
                Découvrez nos experts qui vous accompagneront dans vos aventures.
            </p>
        </div>

        <% if (erreur != null) { %>
        <div class="alert alert-danger text-center">
            <i class="fas fa-exclamation-circle me-2"></i><%= erreur %>
        </div>
        <% } %>

        <% if (guides.isEmpty()) { %>
        <div class="text-center py-5">
            <i class="fas fa-users fa-5x text-muted mb-4"></i>
            <h3 class="text-muted">Aucun guide disponible pour le moment</h3>
            <p class="text-muted">Nos guides sont en cours de validation. Revenez bientôt !</p>
        </div>
        <% } else { %>

        <!-- Statistiques -->
        <div class="row g-4 mb-5">
            <div class="col-md-4 text-center">
                <div class="bg-light p-4 rounded">
                    <i class="fas fa-user-tie fa-3x text-primary mb-3"></i>
                    <h2 class="text-primary"><%= guides.size() %></h2>
                    <p class="mb-0">Guides Professionnels</p>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="bg-light p-4 rounded">
                    <i class="fas fa-language fa-3x text-success mb-3"></i>
                    <%
                        // Compter le nombre total de langues
                        java.util.Set<String> langues = new java.util.HashSet<>();
                        for (Guide g : guides) {
                            if (g.getLanguesParlees() != null) {
                                String[] langs = g.getLanguesParlees().split(",");
                                for (String l : langs) {
                                    langues.add(l.trim());
                                }
                            }
                        }
                    %>
                    <h2 class="text-success"><%= langues.size() %></h2>
                    <p class="mb-0">Langues Parlées</p>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="bg-light p-4 rounded">
                    <i class="fas fa-award fa-3x text-warning mb-3"></i>
                    <%
                        int experienceTotal = 0;
                        for (Guide g : guides) {
                            experienceTotal += g.getExperienceAnnees();
                        }
                    %>
                    <h2 class="text-warning"><%= experienceTotal %></h2>
                    <p class="mb-0">Années d'Expérience</p>
                </div>
            </div>
        </div>

        <!-- Grille des guides -->
        <div class="row g-4">
            <% for (Guide guide : guides) { %>
            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="guide-card">
                    <!-- Photo -->
                    <div class="guide-img-wrapper">
                        <% if (guide.getPhoto() != null && !guide.getPhoto().isEmpty()) { %>
                        <img src="${pageContext.request.contextPath}/img/<%= guide.getPhoto() %>"
                             class="guide-img"
                             alt="<%= guide.getNomComplet() %>">
                        <% } else { %>
                        <div class="guide-img bg-secondary d-flex align-items-center justify-content-center">
                            <i class="fas fa-user fa-5x text-white"></i>
                        </div>
                        <% } %>
                    </div>

                    <!-- Infos -->
                    <div class="guide-info">
                        <h5 class="guide-name"><%= guide.getNomComplet() %></h5>
                        <p class="guide-specialty mb-3">
                            <i class="fas fa-tag"></i>
                            <%= guide.getSpecialite() != null ? guide.getSpecialite() : "Guide professionnel" %>
                        </p>

                        <div class="guide-details mb-3">
                            <!-- Expérience -->
                            <div class="mb-2">
                                <i class="fas fa-briefcase"></i>
                                <strong><%= guide.getExperienceAnnees() %> ans</strong> d'expérience
                            </div>

                            <!-- Langues -->
                            <% if (guide.getLanguesParlees() != null && !guide.getLanguesParlees().isEmpty()) { %>
                            <div class="mb-2">
                                <i class="fas fa-language"></i>
                                <%= guide.getLanguesParlees() %>
                            </div>
                            <% } %>

                            <!-- Note -->
                            <% if (guide.getNoteMoyenne() != null) { %>
                            <div class="rating mb-2">
                                <i class="fas fa-star"></i>
                                <strong><%= guide.getNoteMoyenne() %></strong> / 5
                            </div>
                            <% } %>
                        </div>

                        <!-- Description courte -->
                        <% if (guide.getDescription() != null && !guide.getDescription().isEmpty()) { %>
                        <p class="text-muted small mb-3">
                            <%= guide.getDescription().length() > 100 ?
                                    guide.getDescription().substring(0, 100) + "..." :
                                    guide.getDescription() %>
                        </p>
                        <% } %>

                        <!-- Réseaux sociaux -->
                        <div class="social-links text-center mt-3">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
</div>
<!-- Guides End -->

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

<!-- Template Javascript -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>