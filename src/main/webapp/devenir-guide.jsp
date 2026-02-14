<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 11/08/2025
  Time: 23:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>Devenir Guide - VisitonsMonde</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <!-- Bootstrap CSS -->
  <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>

  <style>
    .hero-section {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 80px 0;
    }
    .form-card {
      background: white;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      padding: 40px;
      margin-top: -50px;
    }
    .benefit-card {
      border: none;
      border-radius: 10px;
      padding: 30px;
      text-align: center;
      transition: transform 0.3s;
    }
    .benefit-card:hover {
      transform: translateY(-5px);
    }
  </style>
</head>
<body>

<!-- Hero Section -->
<div class="hero-section">
  <div class="container text-center">
    <h1 class="display-4 mb-3">Devenez Guide Touristique</h1>
    <p class="lead">Partagez votre passion, guidez des voyageurs, vivez des aventures uniques</p>
  </div>
</div>

<div class="container mb-5">
  <!-- Formulaire d'inscription -->
  <div class="form-card">
    <h2 class="text-center mb-4">
      <i class="fas fa-user-tie text-primary me-2"></i>
      Postuler pour devenir guide
    </h2>

    <%
      String messageSucces = (String) request.getAttribute("messageSucces");
      String erreur = (String) request.getAttribute("erreur");
    %>

    <% if (messageSucces != null) { %>
    <div class="alert alert-success alert-dismissible fade show">
      <i class="fas fa-check-circle me-2"></i><%= messageSucces %>
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <% if (erreur != null) { %>
    <div class="alert alert-danger alert-dismissible fade show">
      <i class="fas fa-exclamation-circle me-2"></i><%= erreur %>
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <form method="post" action="devenir-guide">
      <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label">Prénom *</label>
          <input type="text" class="form-control" name="prenom" required>
        </div>

        <div class="col-md-6">
          <label class="form-label">Nom *</label>
          <input type="text" class="form-control" name="nom" required>
        </div>

        <div class="col-md-6">
          <label class="form-label">Email *</label>
          <input type="email" class="form-control" name="email" required>
        </div>

        <div class="col-md-6">
          <label class="form-label">Téléphone *</label>
          <input type="tel" class="form-control" name="telephone" required>
        </div>

        <div class="col-md-6">
          <label class="form-label">Mot de passe *</label>
          <input type="password" class="form-control" name="motDePasse" required>
          <small class="text-muted">Minimum 6 caractères</small>
        </div>

        <div class="col-md-6">
          <label class="form-label">Confirmation *</label>
          <input type="password" class="form-control" name="confirmation" required>
        </div>

        <div class="col-md-6">
          <label class="form-label">Spécialité *</label>
          <select class="form-select" name="specialite" required>
            <option value="">-- Choisir --</option>
            <option value="Culturel">Culturel</option>
            <option value="Nature">Nature</option>
            <option value="Aventure">Aventure</option>
            <option value="Gastronomie">Gastronomie</option>
            <option value="Histoire">Histoire</option>
            <option value="Sport">Sport</option>
          </select>
        </div>

        <div class="col-md-6">
          <label class="form-label">Années d'expérience *</label>
          <input type="number" class="form-control" name="experienceAnnees" min="0" required>
        </div>

        <div class="col-12">
          <label class="form-label">Langues parlées *</label>
          <input type="text" class="form-control" name="languesParlees"
                 placeholder="Ex: Français, Anglais, Espagnol" required>
          <small class="text-muted">Séparez les langues par des virgules</small>
        </div>

        <div class="col-12">
          <label class="form-label">Présentez-vous *</label>
          <textarea class="form-control" name="description" rows="4" required
                    placeholder="Parlez de votre expérience, votre passion, ce qui vous rend unique..."></textarea>
        </div>

        <div class="col-12">
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="acceptConditions" required>
            <label class="form-check-label" for="acceptConditions">
              J'accepte les conditions d'utilisation et la politique de confidentialité
            </label>
          </div>
        </div>

        <div class="col-12 text-center mt-4">
          <button type="submit" class="btn btn-primary btn-lg px-5">
            <i class="fas fa-paper-plane me-2"></i>Envoyer ma candidature
          </button>
        </div>
      </div>
    </form>
  </div>

  <!-- Avantages -->
  <div class="row g-4 mt-5">
    <div class="col-md-4">
      <div class="benefit-card bg-light">
        <i class="fas fa-coins fa-3x text-success mb-3"></i>
        <h4>Revenus attractifs</h4>
        <p>Gagnez en partageant votre passion</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="benefit-card bg-light">
        <i class="fas fa-calendar-check fa-3x text-primary mb-3"></i>
        <h4>Flexibilité</h4>
        <p>Gérez votre planning comme vous le souhaitez</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="benefit-card bg-light">
        <i class="fas fa-users fa-3x text-warning mb-3"></i>
        <h4>Rencontres</h4>
        <p>Faites découvrir votre région à des voyageurs</p>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>