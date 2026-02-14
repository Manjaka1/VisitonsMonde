<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 17/05/2025
  Time: 00:23
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Styles CSS intégrés -->
<style>
    /* Topbar Style */
    .topbar-minimaliste {
        background: linear-gradient(135deg, #2c3e50, #34495e);
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    .btn-social-mini {
        color: rgba(255,255,255,0.7);
        text-decoration: none;
        transition: all 0.3s ease;
        width: 30px;
        height: 30px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
    }

    .btn-social-mini:hover {
        color: white;
        background: rgba(255,255,255,0.1);
        transform: translateY(-2px);
    }

    .btn-topbar-mini {
        color: rgba(255,255,255,0.8);
        text-decoration: none;
        font-size: 0.9rem;
        transition: all 0.3s ease;
    }

    .btn-topbar-mini:hover {
        color: white;
    }

    /* Navigation Bar Style */
    .navbar-professionnelle {
        background: #ffffff;
        box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        padding: 15px 0;
        transition: all 0.3s ease;
    }

    .nav-link {
        color: #2c3e50 !important;
        font-weight: 500;
        padding: 0.5rem 1rem !important;
        margin: 0 0.2rem;
        transition: all 0.3s ease;
        border-radius: 6px;
    }

    .nav-link:hover,
    .nav-link.active {
        color: #28a745 !important;
        background: rgba(40, 167, 69, 0.1);
    }

    .dropdown-menu {
        border: none;
        box-shadow: 0 5px 25px rgba(0,0,0,0.15);
        border-radius: 12px;
        padding: 10px;
        margin-top: 10px;
    }

    .dropdown-item {
        border-radius: 8px;
        padding: 10px 15px;
        margin: 3px 0;
        transition: all 0.3s ease;
    }

    .dropdown-item:hover,
    .dropdown-item.active {
        background: #28a745;
        color: white !important;
    }

    /* Responsive Design */
    @media (max-width: 991.98px) {
        .navbar-collapse {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.15);
            margin-top: 15px;
        }

        .nav-link {
            margin: 0.3rem 0;
            text-align: center;
        }
    }
</style>

<!-- Header Topbar Minimaliste -->
<div class="container-fluid topbar-minimaliste px-4 px-lg-5 py-2">
    <div class="row align-items-center">
        <!-- Social Media -->
        <div class="col-md-6 d-none d-md-block">
            <div class="d-inline-flex align-items-center">
                <span class="text-white-50 me-3">Follow us:</span>
                <a class="btn-social-mini facebook me-2" href="#"><i class="fab fa-facebook-f"></i></a>
                <a class="btn-social-mini instagram me-2" href="#"><i class="fab fa-instagram"></i></a>
                <a class="btn-social-mini twitter me-2" href="#"><i class="fab fa-twitter"></i></a>
                <a class="btn-social-mini youtube" href="#"><i class="fab fa-youtube"></i></a>
            </div>
        </div>

        <!-- User Actions -->
        <div class="col-md-6 text-end">
            <div class="d-inline-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.utilisateur}">
                        <!-- Utilisateur CONNECTÉ -->
                        <span class="text-white-50 me-3">Bienvenue, ${sessionScope.utilisateur.prenom}!</span>
                        <a href="${pageContext.request.contextPath}/mes-reservations" class="btn-topbar-mini me-3">
                            <i class="fas fa-suitcase me-1"></i>Mes réservations
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-topbar-mini">
                            <i class="fas fa-sign-out-alt me-1"></i>Déconnexion
                        </a>
                    </c:when>
                    <c:otherwise>
                        <!-- Utilisateur DÉCONNECTÉ -->
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn-topbar-mini me-3">
                            <i class="fas fa-sign-in-alt me-1"></i>Connexion
                        </a>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn-topbar-mini">
                            <i class="fas fa-user-plus me-1"></i>Inscription
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<!-- Navigation Bar Professionnelle -->
<nav class="navbar navbar-expand-lg navbar-professionnelle">
    <div class="container">
        <!-- Brand Logo -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <div class="d-flex align-items-center">
                <i class="fas fa-globe-americas me-2 fa-2x" style="color: #28a745;"></i>
                <span class="h4 mb-0 fw-bold" style="color: #28a745;">Trip<span style="color: #2c3e50;">Hive</span></span>
            </div>
        </a>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarMain" aria-controls="navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Main Navigation -->
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/services.jsp">Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/packages.jsp">Packages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/blog.jsp">Blog</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        Pages
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/destinations">Destination</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/tour.jsp">Explore Tour</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/booking.jsp">Travel Booking</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/gallery.jsp">Our Gallery</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/guides.jsp">Travel Guides</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/testimonial.jsp">Testimonial</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/404.jsp">404 Page</a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
                </li>

                <!-- ONGLET MES RÉSERVATIONS VISIBLE - pour utilisateur connecté -->
                <c:if test="${not empty sessionScope.utilisateur}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/mes-reservations">
                            <i class="fas fa-suitcase me-1"></i>Mes Réservations
                        </a>
                    </li>
                </c:if>

                <!-- Menu utilisateur connecté -->
                <c:if test="${not empty sessionScope.utilisateur}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-circle me-1"></i>Mon compte
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mon-profil.jsp">
                                <i class="fas fa-user me-2"></i>Mon profil
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/mes-reservations">
                                <i class="fas fa-suitcase me-2"></i>Mes réservations
                            </a></li>
                            <c:if test="${sessionScope.utilisateur.admin}">
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                                    <i class="fas fa-cog me-2"></i>Administration
                                </a></li>
                            </c:if>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:if>
            </ul>

            <!-- Book Now Button -->
            <div class="ms-lg-3">
                <a href="${pageContext.request.contextPath}/booking.jsp" class="btn btn-success rounded-pill px-4">
                    <i class="fas fa-calendar-check me-2"></i>Book Now
                </a>
            </div>
        </div>
    </div>
</nav>