<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.Guide" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
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
    <meta content="guides touristiques, experts voyage" name="keywords">
    <meta content="Rencontrez nos guides professionnels passionnés" name="description">

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

<jsp:include page="navbar.jsp" />

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h3 class="text-white display-3 mb-4">Nos Guides Professionnels</h3>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
            <li class="breadcrumb-item"><a href="#">Pages</a></li>
            <li class="breadcrumb-item active text-white">Guides</li>
        </ol>
    </div>
</div>
<!-- Header End -->

<!-- Travel Guide Start -->
<div class="container-fluid guide py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">Nos Guides</h5>
            <h1 class="mb-0">Rencontrez Nos Experts du Voyage</h1>
            <p class="mt-3">Nos guides professionnels sont passionnés, expérimentés et dévoués à rendre votre voyage inoubliable. Ils parlent plusieurs langues et connaissent parfaitement leurs destinations.</p>
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

        <!-- Grille des guides -->
        <div class="row g-4">
            <% for (Guide guide : guides) { %>
            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="guide-item">
                    <div class="guide-img">
                        <div class="guide-img-efects">
                            <% if (guide.getPhoto() != null && !guide.getPhoto().isEmpty()) { %>
                            <img src="${pageContext.request.contextPath}/img/<%= guide.getPhoto() %>"
                                 class="img-fluid w-100 rounded-top"
                                 alt="<%= guide.getNomComplet() %>">
                            <% } else { %>
                            <div class="bg-secondary d-flex align-items-center justify-content-center" style="height: 350px;">
                                <i class="fas fa-user fa-5x text-white"></i>
                            </div>
                            <% } %>
                        </div>
                        <div class="guide-icon rounded-pill p-2">
                            <% if (guide.getEmail() != null && !guide.getEmail().isEmpty()) { %>
                            <a class="btn btn-square btn-primary rounded-circle mx-1"
                               href="mailto:<%= guide.getEmail() %>" title="Email">
                                <i class="fas fa-envelope"></i>
                            </a>
                            <% } %>
                            <% if (guide.getTelephone() != null && !guide.getTelephone().isEmpty()) { %>
                            <a class="btn btn-square btn-primary rounded-circle mx-1"
                               href="tel:<%= guide.getTelephone() %>" title="Téléphone">
                                <i class="fas fa-phone"></i>
                            </a>
                            <% } %>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href="#" title="Facebook">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href="#" title="Instagram">
                                <i class="fab fa-instagram"></i>
                            </a>
                        </div>
                    </div>
                    <div class="guide-title text-center rounded-bottom p-4">
                        <div class="guide-title-inner">
                            <h4 class="mt-3"><%= guide.getNomComplet() %></h4>
                            <p class="text-primary mb-2"><%= guide.getSpecialite() != null ? guide.getSpecialite() : "Guide Professionnel" %></p>

                            <div class="text-muted small mb-2">
                                <i class="fas fa-briefcase text-primary me-2"></i>
                                <strong><%= guide.getExperienceAnnees() %> ans</strong> d'expérience
                            </div>

                            <% if (guide.getLanguesParlees() != null && !guide.getLanguesParlees().isEmpty()) { %>
                            <div class="text-muted small mb-2">
                                <i class="fas fa-language text-primary me-2"></i>
                                <%= guide.getLanguesParlees() %>
                            </div>
                            <% } %>

                            <% if (guide.getNoteMoyenne() != null) {
                                int noteInt = guide.getNoteMoyenne().intValue();
                            %>
                            <div class="text-warning mt-2">
                                <% for(int i = 1; i <= 5; i++) { %>
                                <i class="fas fa-star <%= (i <= noteInt) ? "" : "text-muted" %>"></i>
                                <% } %>
                                <span class="text-dark ms-2">(<%= guide.getNoteMoyenne() %>/5)</span>
                            </div>
                            <% } %>

                            <% if (guide.getDescription() != null && !guide.getDescription().isEmpty()) { %>
                            <div class="mt-3">
                                <p class="text-muted small mb-0">
                                    <%= guide.getDescription().length() > 100 ?
                                            guide.getDescription().substring(0, 100) + "..." :
                                            guide.getDescription() %>
                                </p>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
</div>
<!-- Travel Guide End -->

<!-- Subscribe Start -->
<div class="container-fluid subscribe py-5">
    <div class="container text-center py-5">
        <div class="mx-auto text-center" style="max-width: 900px;">
            <h5 class="subscribe-title px-3">Newsletter</h5>
            <h1 class="text-white mb-4">Restez Informés</h1>
            <p class="text-white mb-5">Recevez nos dernières offres et conseils de voyage directement dans votre boîte mail.</p>
            <div class="position-relative mx-auto">
                <input class="form-control border-primary rounded-pill w-100 py-3 ps-4 pe-5" type="email" placeholder="Votre email">
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