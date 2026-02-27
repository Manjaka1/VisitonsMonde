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

<jsp:include page="navbar.jsp" />

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
                         src="${pageContext.request.contextPath}/img/<%= dest.getImage() != null && !dest.getImage().isEmpty() ? dest.getImage() : "default-destination.jpg" %>"
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
                        <a href="${pageContext.request.contextPath}/img/<%= dest.getImage() != null && !dest.getImage().isEmpty() ? dest.getImage() : "default-destination.jpg" %>"
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