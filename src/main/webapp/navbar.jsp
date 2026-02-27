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

<!-- Topbar Start -->
<div class="container-fluid bg-primary px-5 d-none d-lg-block">
    <div class="row gx-0">
        <div class="col-lg-8 text-center text-lg-start mb-2 mb-lg-0">
            <div class="d-inline-flex align-items-center" style="height: 45px;">
                <% if (isConnected) { %>
                <!-- SI CONNECTÉ -->
                <span class="text-light me-3">
                    <i class="fa fa-user me-2"></i>Bonjour, <%= navbarUser.getPrenom() %> !
                </span>
                <% } else { %>
                <!-- SI NON CONNECTÉ - Réseaux sociaux -->
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-twitter fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-facebook-f fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-linkedin-in fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-instagram fw-normal"></i></a>
                <% } %>
            </div>
        </div>
        <div class="col-lg-4 text-center text-lg-end">
            <div class="d-inline-flex align-items-center" style="height: 45px;">
                <% if (isConnected) { %>
                <!-- SI CONNECTÉ -->
                <div class="dropdown">
                    <a href="#" class="dropdown-toggle text-light" data-bs-toggle="dropdown">
                        <small><i class="fa fa-home me-2"></i>Mon Espace</small>
                    </a>
                    <div class="dropdown-menu rounded">
                        <% if (isAdmin) { %>
                        <a href="${pageContext.request.contextPath}/admin" class="dropdown-item">
                            <i class="fas fa-user-shield me-2"></i>Admin
                        </a>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/mon-profil.jsp" class="dropdown-item">
                            <i class="fas fa-user-alt me-2"></i>Mon Profil
                        </a>
                        <a href="${pageContext.request.contextPath}/mes-reservations" class="dropdown-item">
                            <i class="fas fa-suitcase me-2"></i>Mes Réservations
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">
                            <i class="fas fa-power-off me-2"></i>Déconnexion
                        </a>
                    </div>
                </div>
                <% } else { %>
                <!-- SI NON CONNECTÉ -->
                <a href="${pageContext.request.contextPath}/login.jsp" class="text-light me-3">
                    <small><i class="fa fa-sign-in-alt me-2"></i>Connexion</small>
                </a>
                <a href="${pageContext.request.contextPath}/register.jsp" class="text-light">
                    <small><i class="fa fa-user-plus me-2"></i>S'inscrire</small>
                </a>
                <% } %>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->

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

                <% if (isConnected) { %>
                <!-- Menu pour utilisateurs connectés -->
                <a href="${pageContext.request.contextPath}/guides" class="nav-item nav-link">
                    <i class="fas fa-user-tie me-1"></i>Guides
                </a>
                <% } %>

                <a href="${pageContext.request.contextPath}/packages.jsp" class="nav-item nav-link">
                    <i class="fas fa-box me-1"></i>Forfaits
                </a>
                <a href="${pageContext.request.contextPath}/services.jsp" class="nav-item nav-link">
                    <i class="fas fa-concierge-bell me-1"></i>Services
                </a>
                <a href="${pageContext.request.contextPath}/blog.jsp" class="nav-item nav-link">
                    <i class="fas fa-blog me-1"></i>Blog
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
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-primary rounded-pill py-2 px-4 ms-3">
                <i class="fas fa-sign-in-alt me-2"></i>Connexion
            </a>
            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary rounded-pill py-2 px-4 ms-2">
                <i class="fas fa-user-plus me-2"></i>S'inscrire
            </a>
            <% } %>
        </div>
    </nav>
</div>