<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.Destination" %>
<%@ page import="java.util.List" %>
<%
    List<Destination> destinations = (List<Destination>) request.getAttribute("destinations");
    if (destinations == null) {
        destinations = new java.util.ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Destinations - VisitonsMonde</title>
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
</head>

<body>

<!-- Topbar Start -->
<div class="container-fluid bg-primary px-5 d-none d-lg-block">
    <div class="row gx-0">
        <div class="col-lg-8 text-center text-lg-start mb-2 mb-lg-0">
            <div class="d-inline-flex align-items-center" style="height: 45px;">
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-twitter fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-facebook-f fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-linkedin-in fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-instagram fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle" href=""><i class="fab fa-youtube fw-normal"></i></a>
            </div>
        </div>
        <div class="col-lg-4 text-center text-lg-end">
            <div class="d-inline-flex align-items-center" style="height: 45px;">
                <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">Se connecter</a>
                <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registerModal">S'inscrire</a>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->

<!-- Navbar Start -->
<div class="container-fluid position-relative p-0">
    <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0">
        <a href="index.jsp" class="navbar-brand p-0">
            <h1 class="m-0"><i class="fa fa-map-marker-alt me-3"></i>VisitonsMonde</h1>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="fa fa-bars"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-0">
                <a href="index.jsp" class="nav-item nav-link">Accueil</a>
                <a href="destinations" class="nav-item nav-link active">Destinations</a>
                <a href="booking" class="nav-item nav-link">Réserver</a>
                <a href="contact.jsp" class="nav-item nav-link">Contact</a>
            </div>
            <a href="booking" class="btn btn-primary rounded-pill py-2 px-4 ms-lg-4">Réserver Maintenant</a>
        </div>
    </nav>
</div>
<!-- Navbar End -->

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h3 class="text-white display-3 mb-4">Nos Destinations</h3>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="index.jsp">Accueil</a></li>
            <li class="breadcrumb-item active text-white">Destinations</li>
        </ol>
    </div>
</div>
<!-- Header End -->

<!-- Destination Start -->
<div class="container-fluid destination py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">Destinations</h5>
            <h1 class="mb-0">Découvrez nos destinations</h1>
            <p class="mb-4"><%= destinations.size() %> destinations disponibles</p>
        </div>

        <div class="row g-4">
            <%
                if (destinations != null && !destinations.isEmpty()) {
                    for (Destination dest : destinations) {
            %>
            <div class="col-lg-4 col-md-6">
                <div class="destination-img">
                    <img class="img-fluid rounded w-100"
                         src="https://source.unsplash.com/400x300/?<%= dest.getNom().replace(" ", ",") %>,travel,destination"
                         alt="<%= dest.getNom() %>"
                         style="height: 300px; object-fit: cover;">
                    <div class="destination-overlay p-4">
                        <h4 class="text-white mb-2 mt-3"><%= dest.getNom() %></h4>
                        <p class="text-white mb-3">
                            <i class="fa fa-map-marker-alt me-2"></i>
                            <%= dest.getPays() != null ? dest.getPays() : "International" %>
                        </p>
                        <% if (dest.getPrix() != null) { %>
                        <h5 class="text-white mb-3">
                            À partir de <%= String.format("%.0f", dest.getPrix()) %> €
                        </h5>
                        <% } %>
                        <a href="destinations?action=view&id=<%= dest.getId() %>"
                           class="btn btn-primary text-white rounded-pill border py-2 px-4">
                            <i class="fa fa-eye me-2"></i>Voir les détails
                        </a>
                    </div>
                    <div class="search-icon">
                        <a href="https://source.unsplash.com/800x600/?<%= dest.getNom().replace(" ", ",") %>,travel"
                           data-lightbox="destination-<%= dest.getId() %>">
                            <i class="fa fa-plus-square fa-1x btn btn-light btn-lg-square text-primary"></i>
                        </a>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="col-12">
                <div class="alert alert-info text-center py-5">
                    <i class="fas fa-info-circle fa-3x mb-3"></i>
                    <h4>Aucune destination disponible</h4>
                    <p>Revenez bientôt pour découvrir nos merveilleuses destinations !</p>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>
<!-- Destination End -->

<!-- Footer Start -->
<div class="container-fluid footer py-5">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">VisitonsMonde</h4>
                    <a href=""><i class="fas fa-home me-2"></i> Madagascar</a>
                    <a href=""><i class="fas fa-envelope me-2"></i> contact@visitonsmonde.com</a>
                    <a href=""><i class="fas fa-phone me-2"></i> +261 34 00 000 00</a>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">Navigation</h4>
                    <a href="index.jsp"><i class="fas fa-angle-right me-2"></i> Accueil</a>
                    <a href="destinations"><i class="fas fa-angle-right me-2"></i> Destinations</a>
                    <a href="booking"><i class="fas fa-angle-right me-2"></i> Réserver</a>
                    <a href="contact.jsp"><i class="fas fa-angle-right me-2"></i> Contact</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->

<!-- Copyright Start -->
<div class="container-fluid copyright text-body py-4">
    <div class="container">
        <div class="row g-4 align-items-center">
            <div class="col-md-6 text-center text-md-end mb-md-0">
                <i class="fas fa-copyright me-2"></i><a class="text-white" href="#">VisitonsMonde</a>, Tous droits réservés.
            </div>
            <div class="col-md-6 text-center text-md-start">
                Designed By <a class="text-white" href="https://htmlcodex.com">HTML Codex</a>
            </div>
        </div>
    </div>
</div>
<!-- Copyright End -->

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
<!-- Modal Register -->
<div class="modal fade" id="registerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Créer un compte</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="register" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Prénom</label>
                            <input type="text" class="form-control" name="prenom" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Nom</label>
                            <input type="text" class="form-control" name="nom" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mot de passe</label>
                        <input type="password" class="form-control" name="motDePasse" required>
                        <small class="text-muted">Minimum 6 caractères</small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Confirmation</label>
                        <input type="password" class="form-control" name="confirmation" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Créer mon compte</button>
                </form>
                <div class="text-center mt-3">
                    <small>Déjà un compte ? <a href="#" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#loginModal">Se connecter</a></small>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>