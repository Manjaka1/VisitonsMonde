<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 17/05/2025
  Time: 00:23
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.Utilisateur" %>
<%
    Utilisateur navbarUser = (Utilisateur) session.getAttribute("utilisateur");
    boolean isConnected = (navbarUser != null);
    boolean isAdmin = isConnected && (navbarUser.isAdmin() || "ADMIN".equals(navbarUser.getRole()));
    boolean isGuide = isConnected && "GUIDE".equals(navbarUser.getRole());
%>

<!-- Navbar & Hero Start -->
<div class="container-fluid position-relative p-0">
    <nav class="navbar navbar-expand-lg navbar-light px-4 px-lg-5 py-3 py-lg-0">
        <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand p-0">
            <h1 class="text-primary m-0">
                <i class="fa fa-map-marker-alt me-3"></i>VisitonsMonde
            </h1>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="fa fa-bars"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <div class="navbar-nav ms-auto py-0">
                <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link">
                    <i class="fas fa-home me-1"></i>Accueil
                </a>
                <a href="${pageContext.request.contextPath}/destinations" class="nav-item nav-link">
                    <i class="fas fa-map-marked-alt me-1"></i>Destinations
                </a>
                <a href="${pageContext.request.contextPath}/guides" class="nav-item nav-link">
                    <i class="fas fa-user-tie me-1"></i>Guides
                </a>
                <a href="${pageContext.request.contextPath}/about.jsp" class="nav-item nav-link">
                    <i class="fas fa-info-circle me-1"></i>À Propos
                </a>
                <a href="${pageContext.request.contextPath}/contact.jsp" class="nav-item nav-link">
                    <i class="fas fa-envelope me-1"></i>Contact
                </a>

                <% if (!isConnected) { %>
                <!-- Lien "Devenir Guide" pour les visiteurs -->
                <a href="${pageContext.request.contextPath}/devenir-guide" class="nav-item nav-link text-warning">
                    <i class="fas fa-star me-1"></i>Devenir Guide
                </a>
                <% } %>
            </div>

            <!-- BOUTONS DROITE -->
            <% if (isConnected) { %>
            <!-- UTILISATEUR CONNECTÉ -->
            <div class="dropdown ms-3">
                <button class="btn btn-primary dropdown-toggle" type="button"
                        id="userMenu" data-bs-toggle="dropdown">
                    <i class="fas fa-user me-2"></i><%= navbarUser.getPrenom() %>
                </button>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <h6 class="dropdown-header">
                            <i class="fas fa-user-circle me-2"></i><%= navbarUser.getNomComplet() %>
                        </h6>
                    </li>
                    <li><hr class="dropdown-divider"></li>

                    <% if (isAdmin) { %>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin">
                            <i class="fas fa-user-shield me-2 text-danger"></i>Admin
                        </a>
                    </li>
                    <% } %>

                    <% if (isGuide) { %>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/espace-guide">
                            <i class="fas fa-user-tie me-2 text-success"></i>Mon Espace Guide
                        </a>
                    </li>
                    <% } %>

                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/mon-profil.jsp">
                            <i class="fas fa-user me-2"></i>Mon Profil
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/mes-reservations">
                            <i class="fas fa-calendar-check me-2"></i>Mes Réservations
                        </a>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
                        </a>
                    </li>
                </ul>
            </div>
            <% } else { %>
            <!-- VISITEUR NON CONNECTÉ -->
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary rounded-pill py-2 px-4 ms-3">
                <i class="fas fa-sign-in-alt me-2"></i>Connexion
            </a>
            <% } %>
        </div>
    </nav>
</div>