<%@ page import="com.visitonsmonde.model.Utilisateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

    if (utilisateur == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Mon Profil - VisitonsMonde</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

<div class="container py-5">
    <div class="row">
        <div class="col-lg-8 mx-auto">

            <!-- En-tête du profil -->
            <div class="card shadow-sm mb-4">
                <div class="card-body text-center py-5" style="background: linear-gradient(135deg, #013D42 0%, #016a71 100%);">
                    <div class="avatar mb-3">
                        <i class="fas fa-user-circle fa-5x text-white"></i>
                    </div>
                    <h2 class="text-white mb-1"><%= utilisateur.getPrenom() %> <%= utilisateur.getNom() %></h2>
                    <p class="text-white-50 mb-0"><i class="fas fa-envelope me-2"></i><%= utilisateur.getEmail() %></p>
                </div>
            </div>

            <!-- Informations personnelles -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-user me-2"></i>Informations Personnelles</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-4"><strong>Prénom :</strong></div>
                        <div class="col-md-8"><%= utilisateur.getPrenom() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><strong>Nom :</strong></div>
                        <div class="col-md-8"><%= utilisateur.getNom() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><strong>Email :</strong></div>
                        <div class="col-md-8"><%= utilisateur.getEmail() %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-4"><strong>Identifiant :</strong></div>
                        <div class="col-md-8">#<%= utilisateur.getId() %></div>
                    </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4"><strong>Statut :</strong></div>
                        <div class="col-md-8">
                            <% if (utilisateur.isAdmin()) { %>
                            <span class="badge bg-danger">Administrateur</span>
                            <% } else { %>
                            <span class="badge bg-success">Membre</span>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Actions rapides -->
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-cog me-2"></i>Actions Rapides</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="mes-reservations" class="btn btn-outline-primary">
                            <i class="fas fa-calendar-check me-2"></i>Mes Réservations
                        </a>
                        <a href="booking" class="btn btn-outline-success">
                            <i class="fas fa-plus-circle me-2"></i>Nouvelle Réservation
                        </a>
                        <a href="index.jsp" class="btn btn-outline-secondary">
                            <i class="fas fa-home me-2"></i>Retour à l'accueil
                        </a>
                        <a href="logout" class="btn btn-outline-danger">
                            <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>