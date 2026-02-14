
Created by IntelliJ IDEA.
User: manjaka
Date: 26/12/2024
Time: 04:02
To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.visitonsmonde.model.Utilisateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession maSession = request.getSession(false);
    Utilisateur utilisateur = (maSession != null) ? (Utilisateur) maSession.getAttribute("utilisateur") : null;
    String erreur = (String) request.getAttribute("erreur");
    String succes = (String) request.getAttribute("succes");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion - TripHive</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .login-container { max-width: 400px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .auth-navbar { background: #2c3e50; padding: 15px; text-align: center; margin-bottom: 30px; }
        .auth-navbar a { color: white; text-decoration: none; margin: 0 15px; font-weight: 500; }
        .auth-navbar a:hover { color: #08f929; }
    </style>
</head>
<body>

<!-- Barre de navigation d'authentification -->
<div class="auth-navbar">
    <% if (utilisateur != null) { %>
    <span style="color: white; margin-right: 20px;">👋 Bienvenue, <%= utilisateur.getPrenom() %> !</span>
    <a href="mes-reservations">📋 Mes Réservations</a>
    <a href="mon-profil.jsp">👤 Mon Profil</a>
    <a href="logout">🚪 Déconnexion</a>
    <% } else { %>
    <a href="login.jsp">🔐 Connexion</a>
    <a href="register.jsp">📝 Inscription</a>
    <a href="mes-reservations">📋 Mes Réservations</a>
    <% } %>
    <a href="index.jsp">🏠 Accueil</a>
</div>

<div class="container">
    <div class="login-container">
        <h2 class="text-center mb-4">Connexion</h2>

        <% if (erreur != null) { %>
        <div class="alert alert-danger"><%= erreur %></div>
        <% } %>

        <% if (succes != null) { %>
        <div class="alert alert-success"><%= succes %></div>
        <% } %>

        <form action="login" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="mb-3">
                <label for="motDePasse" class="form-label">Mot de passe</label>
                <input type="password" class="form-control" id="motDePasse" name="motDePasse" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Se connecter</button>
        </form>

        <div class="text-center mt-3">
            <p>Pas encore de compte ? <a href="register.jsp">Créer un compte</a></p>
        </div>
    </div>
</div>
</body>
</html>