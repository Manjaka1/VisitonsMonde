<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 04/01/2025
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.Destination" %>
<%@ page import="java.util.List" %>
<%
  Destination destination = (Destination) request.getAttribute("destination");
  List<Destination> similarDestinations = (List<Destination>) request.getAttribute("similarDestinations");

  if (destination == null) {
    response.sendRedirect(request.getContextPath() + "/destinations");
    return;
  }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title><%= destination.getNom() %> - VisitonsMonde</title>
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
    .hero-section {
      background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
      url('${pageContext.request.contextPath}/img/destination-<%= destination.getId() %>.jpg');
      background-size: cover;
      background-position: center;
      padding: 150px 0;
      color: white;
    }
    .booking-card {
      background: white;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      padding: 30px;
      position: sticky;
      top: 100px;
    }
    .info-box {
      background: #f8f9fa;
      border-left: 4px solid #13357B;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 20px;
    }
  </style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<!-- Hero Section -->
<div class="container-fluid hero-section">
  <div class="container text-center">
    <h1 class="display-3 text-white mb-4"><%= destination.getNom() %></h1>
    <p class="text-white h4">
      <i class="fa fa-map-marker-alt me-2"></i><%= destination.getPays() %>
    </p>
  </div>
</div>

<!-- Content -->
<div class="container-fluid py-5">
  <div class="container py-5">
    <div class="row g-5">
      <!-- Left Column - Destination Details -->
      <div class="col-lg-8">
        <!-- Image principale -->
        <div class="mb-5">
          <img src="${pageContext.request.contextPath}/img/destination-<%= destination.getId() %>.jpg"
               class="img-fluid rounded w-100 mb-4"
               alt="<%= destination.getNom() %>"
               onerror="this.src='${pageContext.request.contextPath}/img/default-destination.jpg'"
               style="height: 500px; object-fit: cover; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
        </div>

        <!-- Description -->
        <div class="mb-5">
          <h2 class="mb-4">
            <i class="fas fa-info-circle text-primary me-3"></i>À propos de <%= destination.getNom() %>
          </h2>
          <p class="mb-4 fs-5" style="line-height: 1.8;">
            <%= destination.getDescription() != null ? destination.getDescription() : "Découvrez cette destination magnifique qui vous promet des souvenirs inoubliables. Une expérience unique vous attend dans ce lieu d'exception." %>
          </p>
        </div>

        <!-- Informations détaillées -->
        <div class="row g-4 mb-5">
          <div class="col-md-6">
            <div class="info-box">
              <div class="d-flex align-items-center">
                <i class="fas fa-map-marker-alt fa-3x text-primary me-3"></i>
                <div>
                  <h5 class="mb-1">Localisation</h5>
                  <p class="mb-0 text-muted"><%= destination.getPays() %></p>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="info-box">
              <div class="d-flex align-items-center">
                <i class="fas fa-camera fa-3x text-primary me-3"></i>
                <div>
                  <h5 class="mb-1">Galerie photos</h5>
                  <p class="mb-0 text-muted">Photos disponibles</p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Ce qui est inclus -->
        <div class="mb-5">
          <h3 class="mb-4">
            <i class="fas fa-check-circle text-success me-3"></i>Inclus dans le forfait
          </h3>
          <div class="row g-3">
            <div class="col-md-6">
              <p><i class="fas fa-check text-success me-2"></i>Vol aller-retour</p>
            </div>
            <div class="col-md-6">
              <p><i class="fas fa-check text-success me-2"></i>Hébergement 4★</p>
            </div>
            <div class="col-md-6">
              <p><i class="fas fa-check text-success me-2"></i>Petit-déjeuner inclus</p>
            </div>
            <div class="col-md-6">
              <p><i class="fas fa-check text-success me-2"></i>Visites guidées</p>
            </div>
            <div class="col-md-6">
              <p><i class="fas fa-check text-success me-2"></i>Assurance voyage</p>
            </div>
            <div class="col-md-6">
              <p><i class="fas fa-check text-success me-2"></i>Transferts aéroport</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Right Column - Booking Card -->
      <div class="col-lg-4">
        <div class="booking-card">
          <div class="text-center mb-4">
            <h3 class="text-primary mb-3">Réservez maintenant</h3>
            <h2 class="text-success mb-0">
              <%= String.format("%.0f", destination.getPrix()) %> €
            </h2>
            <small class="text-muted">par personne</small>
          </div>

          <hr class="my-4">

          <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary w-100 py-3 mb-3">
            <i class="fas fa-calendar-check me-2"></i>Réserver maintenant
          </a>

          <div class="alert alert-info">
            <i class="fas fa-info-circle me-2"></i>
            <small>Réservation flexible - Annulation gratuite jusqu'à 24h avant le départ</small>
          </div>

          <hr class="my-4">

          <h6 class="mb-3">
            <i class="fas fa-phone text-success me-2"></i>Besoin d'aide ?
          </h6>
          <p class="mb-2"><small>Appelez-nous :</small></p>
          <p class="text-primary fw-bold">+33 1 23 45 67 89</p>
          <p class="mb-0"><small>Lundi - Vendredi : 9h - 18h</small></p>
        </div>
      </div>
    </div>

    <!-- Destinations similaires -->
    <% if (similarDestinations != null && !similarDestinations.isEmpty()) { %>
    <div class="row mt-5">
      <div class="col-12">
        <h3 class="mb-4">
          <i class="fas fa-compass text-primary me-3"></i>Destinations similaires
        </h3>
      </div>
      <% for (Destination similar : similarDestinations) { %>
      <div class="col-lg-4 col-md-6 mb-4">
        <div class="card h-100 shadow-sm">
          <img class="card-img-top"
               src="${pageContext.request.contextPath}/img/destination-<%= similar.getId() %>.jpg"
               alt="<%= similar.getNom() %>"
               onerror="this.src='${pageContext.request.contextPath}/img/default-destination.jpg'"
               style="height: 200px; object-fit: cover;">

          <div class="card-body">
            <h5 class="card-title"><%= similar.getNom() %></h5>
            <p class="card-text text-muted">
              <i class="fa fa-map-marker-alt me-2"></i><%= similar.getPays() %>
            </p>
            <p class="text-primary fw-bold">
              À partir de <%= String.format("%.0f", similar.getPrix()) %> €
            </p>
            <a href="destination-details?id=<%= similar.getId() %>"
               class="btn btn-primary w-100">
              Voir les détails
            </a>
          </div>
        </div>
      </div>
      <% } %>
    </div>
    <% } %>
  </div>
</div>

<jsp:include page="footer.jsp" />

<!-- Back to Top -->
<a href="#" class="btn btn-primary btn-primary-outline-0 btn-md-square back-to-top"><i class="fa fa-arrow-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/lightbox/js/lightbox.min.js"></script>

<!-- Template Javascript -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>