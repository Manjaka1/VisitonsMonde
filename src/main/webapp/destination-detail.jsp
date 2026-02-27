<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 04/01/2025
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <title>TripHive - ${destination.nom}</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <%
    String basePath = request.getContextPath();
  %>

  <!-- Google Web Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600&family=Roboto&display=swap" rel="stylesheet">

  <!-- Icon Font Stylesheet -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

  <!-- Libraries Stylesheet -->
  <link href="<%= basePath %>/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
  <link href="<%= basePath %>/lib/lightbox/css/lightbox.min.css" rel="stylesheet">

  <!-- Customized Bootstrap Stylesheet -->
  <link href="<%= basePath %>/css/bootstrap.min.css" rel="stylesheet">

  <!-- Template Stylesheet -->
  <link href="<%= basePath %>/css/style.css" rel="stylesheet">

  <style>
    .hero-section {
      background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
      url('<%= basePath %>/img/${not empty destination.image ? destination.image : 'default-destination.jpg'}');
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
    }
  </style>
</head>

<body>

<!-- Spinner -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
  <div class="spinner-border text-success" style="width: 3rem; height: 3rem;" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>

<!-- Navigation (la même que destination.jsp) -->
<%@ include file="/navbar.jsp" %>

<!-- Hero Section -->
<div class="container-fluid hero-section">
  <div class="container text-center">
    <h1 class="display-3 text-white mb-4">${destination.nom}</h1>
    <p class="text-white mb-0">${destination.pays}</p>
  </div>
</div>

<!-- Content -->
<div class="container-fluid py-5">
  <div class="container py-5">
    <div class="row g-5">
      <!-- Left Column - Destination Details -->
      <div class="col-lg-8">
        <div class="mb-5">
          <img src="<%= basePath %>/img/${not empty destination.image ? destination.image : 'default-destination.jpg'}"
               class="img-fluid rounded w-100 mb-4" alt="${destination.nom}" style="height: 400px; object-fit: cover;">

          <h2 class="mb-4">À propos de ${destination.nom}</h2>
          <p class="mb-4">${destination.description}</p>

          <div class="row g-4 mb-4">
            <div class="col-md-6">
              <div class="d-flex align-items-center">
                <i class="fas fa-map-marker-alt fa-2x text-success me-3"></i>
                <div>
                  <h5 class="mb-0">Pays</h5>
                  <p class="mb-0">${destination.pays}</p>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="d-flex align-items-center">
                <i class="fas fa-camera fa-2x text-success me-3"></i>
                <div>
                  <h5 class="mb-0">Photos disponibles</h5>
                  <p class="mb-0">${destination.nbPhotos} photos</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Right Column - Booking Form -->
      <!-- Right Column - Booking Form -->
      <div class="col-lg-4">
        <div class="booking-card">
          <h3 class="text-success mb-4">Réserver maintenant</h3>
          <p class="h2 text-success mb-4">${destination.prix} €</p>

          <form action="reservations" method="post">
            <input type="hidden" name="action" value="creer">
            <input type="hidden" name="destination_id" value="${destination.id}">
            <input type="hidden" name="nom_destination" value="${destination.nom}">
            <input type="hidden" name="prix_destination" value="${destination.prix}">

            <div class="mb-3">
              <label class="form-label">Date de départ</label>
              <input type="date" class="form-control" name="date_depart" required>
            </div>

            <div class="mb-3">
              <label class="form-label">Nombre de personnes</label>
              <select class="form-select" name="nb_personnes" required>
                <option value="1">1 personne</option>
                <option value="2">2 personnes</option>
                <option value="3">3 personnes</option>
                <option value="4">4 personnes</option>
                <option value="5">5+ personnes</option>
              </select>
            </div>

            <div class="mb-4">
              <label class="form-label">Guide accompagnateur</label>
              <select class="form-select" name="guide_id">
                <option value="">Sans guide</option>
                <!-- Les guides seront ajoutés dynamiquement plus tard -->
                <option value="1">Jean Martin (Expert Europe)</option>
                <option value="2">Sarah Smith (Spécialiste Asie)</option>
              </select>
            </div>

            <button type="submit" class="btn btn-success w-100 py-3">
              <i class="fas fa-calendar-check me-2"></i>Réserver maintenant
            </button>
          </form>

          <div class="mt-4 p-3 bg-light rounded">
            <h6 class="text-success"><i class="fas fa-info-circle me-2"></i>Inclus dans le prix:</h6>
            <ul class="list-unstyled mb-0">
              <li><i class="fas fa-check text-success me-2"></i>Vol aller-retour</li>
              <li><i class="fas fa-check text-success me-2"></i>Hébergement 4★</li>
              <li><i class="fas fa-check text-success me-2"></i>Petit-déjeuner</li>
              <li><i class="fas fa-check text-success me-2"></i>Visites guidées</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Footer & Scripts (identique à destination.jsp) -->
<%@ include file="footer.jsp" %>

</body>
</html>