<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 02/03/2025
  Time: 01:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.Utilisateur" %>
<%
  Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

  // Récupérer les paramètres de confirmation
  String numero = request.getParameter("numero");
  String destination = request.getParameter("destination");
  String dateDepart = request.getParameter("dateDepart");
  String nbPersonnes = request.getParameter("nbPersonnes");
  String prixTotal = request.getParameter("prixTotal");
  String dateReservation = request.getParameter("dateReservation");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Confirmation de réservation - VisitonsMonde</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
  <style>
    .confirmation-card {
      max-width: 700px;
      margin: 50px auto;
      box-shadow: 0 0 30px rgba(1, 61, 66, 0.1);
      border-radius: 15px;
      overflow: hidden;
    }
    .confirmation-header {
      background: linear-gradient(135deg, #013D42 0%, #016a71 100%);
      color: white;
      padding: 40px 30px;
      text-align: center;
    }
    .check-icon {
      width: 80px;
      height: 80px;
      background: white;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px;
    }
    .check-icon i {
      font-size: 40px;
      color: #28a745;
    }
    .confirmation-body {
      padding: 40px 30px;
      background: white;
    }
    .info-row {
      display: flex;
      justify-content: space-between;
      padding: 15px 0;
      border-bottom: 1px solid #eee;
    }
    .info-label {
      font-weight: 600;
      color: #013D42;
    }
    .info-value {
      color: #555;
      text-align: right;
    }
    .total-row {
      background: #f8f9fa;
      padding: 20px;
      margin: 20px -30px -40px;
      border-top: 2px solid #013D42;
    }
    .btn-actions {
      display: flex;
      gap: 10px;
      margin-top: 30px;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="confirmation-card">
    <div class="confirmation-header">
      <div class="check-icon">
        <i class="fas fa-check"></i>
      </div>
      <h2 class="mb-3">Réservation Confirmée !</h2>
      <p class="mb-0">Votre voyage commence ici</p>
    </div>

    <div class="confirmation-body">
      <% if (numero != null) { %>

      <div class="alert alert-success mb-4">
        <strong>Numéro de réservation :</strong> <span class="fs-5"><%= numero %></span>
      </div>

      <h5 class="mb-3">Détails de votre réservation</h5>

      <div class="info-row">
        <span class="info-label"><i class="fas fa-user me-2"></i>Client</span>
        <span class="info-value"><%= utilisateur != null ? utilisateur.getNomComplet() : "Client" %></span>
      </div>

      <div class="info-row">
        <span class="info-label"><i class="fas fa-map-marker-alt me-2"></i>Destination</span>
        <span class="info-value"><%= destination %></span>
      </div>

      <div class="info-row">
        <span class="info-label"><i class="fas fa-calendar-alt me-2"></i>Date de départ</span>
        <span class="info-value"><%= dateDepart %></span>
      </div>

      <div class="info-row">
        <span class="info-label"><i class="fas fa-users me-2"></i>Nombre de personnes</span>
        <span class="info-value"><%= nbPersonnes %> personne(s)</span>
      </div>

      <div class="total-row">
        <div class="d-flex justify-content-between align-items-center">
          <h4 class="mb-0">Prix Total</h4>
          <h3 class="mb-0 text-primary"><%= String.format("%.2f", Double.parseDouble(prixTotal)) %> €</h3>
        </div>
      </div>

      <div class="btn-actions">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-primary flex-fill">
          <i class="fas fa-home me-2"></i>Retour à l'accueil
        </a>
        <a href="#" onclick="window.print(); return false;" class="btn btn-primary flex-fill">
          <i class="fas fa-print me-2"></i>Imprimer
        </a>
      </div>

      <div class="alert alert-info mt-4 mb-0">
        <i class="fas fa-info-circle me-2"></i>
        Un email de confirmation a été envoyé à <strong><%= utilisateur != null ? utilisateur.getEmail() : "votre adresse" %></strong>
      </div>

      <% } else { %>
      <div class="alert alert-danger">
        <h5>Erreur</h5>
        <p>Aucune information de réservation trouvée. Veuillez réessayer.</p>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary mt-3">Retour à l'accueil</a>
      </div>
      <% } %>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>