<%@ page import="com.visitonsmonde.model.Utilisateur" %>
<%@ page import="com.visitonsmonde.model.Destination" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur utilisateurConnecte = (Utilisateur) session.getAttribute("utilisateur");

    // Récupérer les données dynamiques
    List<Destination> destinationsPopulaires = (List<Destination>) request.getAttribute("destinationsPopulaires");
    Integer totalDestinations = (Integer) request.getAttribute("totalDestinations");
    Integer totalClients = (Integer) request.getAttribute("totalClients");
    Integer totalReservations = (Integer) request.getAttribute("totalReservations");

    // Valeurs par défaut si null
    if (destinationsPopulaires == null) destinationsPopulaires = new java.util.ArrayList<>();
    if (totalDestinations == null) totalDestinations = 0;
    if (totalClients == null) totalClients = 0;
    if (totalReservations == null) totalReservations = 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Accueil - VisitonsMonde</title>
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
        .destination-img {
            position: relative;
            overflow: hidden;
        }

        .destination-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0.4) 70%, transparent 100%);
            padding: 30px !important;
            transform: translateY(0);
            transition: all 0.3s ease;
        }

        .destination-img:hover .destination-overlay {
            background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.6) 70%, rgba(0,0,0,0.3) 100%);
        }

        .search-icon {
            position: absolute;
            top: 15px;
            right: 15px;
            z-index: 10;
        }

        .testimonial-item {
            transition: all 0.3s;
        }
        .testimonial-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15) !important;
        }
    </style>
</head>

<body>

<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Chargement...</span>
    </div>
</div>
<!-- Spinner End -->

<jsp:include page="navbar.jsp"/>

<!-- Carousel Start -->
<div class="carousel-header">
    <div id="carouselId" class="carousel slide" data-bs-ride="carousel">
        <ol class="carousel-indicators">
            <li data-bs-target="#carouselId" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#carouselId" data-bs-slide-to="1"></li>
            <li data-bs-target="#carouselId" data-bs-slide-to="2"></li>
        </ol>
        <div class="carousel-inner" role="listbox">
            <div class="carousel-item active">
                <img src="${pageContext.request.contextPath}/img/carousel-2.jpg" class="img-fluid" alt="Image">
                <div class="carousel-caption">
                    <div class="p-3" style="max-width: 900px;">
                        <h4 class="text-white text-uppercase fw-bold mb-4" style="letter-spacing: 3px;">Explorez le Monde</h4>
                        <h1 class="display-2 text-capitalize text-white mb-4">Voyageons Ensemble !</h1>
                        <p class="mb-5 fs-5">Découvrez des destinations extraordinaires avec VisitonsMonde. Votre aventure commence ici.</p>
                        <div class="d-flex align-items-center justify-content-center">
                            <a class="btn-hover-bg btn btn-primary rounded-pill text-white py-3 px-5" href="${pageContext.request.contextPath}/destinations">Découvrir Maintenant</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/img/carousel-1.jpg" class="img-fluid" alt="Image">
                <div class="carousel-caption">
                    <div class="p-3" style="max-width: 900px;">
                        <h4 class="text-white text-uppercase fw-bold mb-4" style="letter-spacing: 3px;">Explorez le Monde</h4>
                        <h1 class="display-2 text-capitalize text-white mb-4">Trouvez Votre Voyage Parfait</h1>
                        <p class="mb-5 fs-5">Des destinations uniques vous attendent. Réservez dès maintenant votre prochaine aventure.</p>
                        <div class="d-flex align-items-center justify-content-center">
                            <a class="btn-hover-bg btn btn-primary rounded-pill text-white py-3 px-5" href="${pageContext.request.contextPath}/destinations">Découvrir Maintenant</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <img src="${pageContext.request.contextPath}/img/carousel-3.jpg" class="img-fluid" alt="Image">
                <div class="carousel-caption">
                    <div class="p-3" style="max-width: 900px;">
                        <h4 class="text-white text-uppercase fw-bold mb-4" style="letter-spacing: 3px;">Explorez le Monde</h4>
                        <h1 class="display-2 text-capitalize text-white mb-4">Où Aimeriez-Vous Aller ?</h1>
                        <p class="mb-5 fs-5">Planifiez votre prochain voyage avec nos experts. Des souvenirs inoubliables vous attendent.</p>
                        <div class="d-flex align-items-center justify-content-center">
                            <a class="btn-hover-bg btn btn-primary rounded-pill text-white py-3 px-5" href="${pageContext.request.contextPath}/destinations">Découvrir Maintenant</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
            <span class="carousel-control-prev-icon btn bg-primary" aria-hidden="false"></span>
            <span class="visually-hidden">Précédent</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
            <span class="carousel-control-next-icon btn bg-primary" aria-hidden="false"></span>
            <span class="visually-hidden">Suivant</span>
        </button>
    </div>
</div>
<!-- Carousel End -->

<!-- About Start -->
<div class="container-fluid about py-5">
    <div class="container py-5">
        <div class="row g-5 align-items-center">
            <div class="col-lg-5">
                <div class="h-100" style="border: 50px solid; border-color: transparent #13357B transparent #13357B;">
                    <img src="${pageContext.request.contextPath}/img/about-img.jpg" class="img-fluid w-100 h-100" alt="">
                </div>
            </div>
            <div class="col-lg-7">
                <h5 class="section-about-title pe-3">À Propos</h5>
                <h1 class="mb-4">Bienvenue chez <span class="text-primary">VisitonsMonde</span></h1>
                <p class="mb-4">Depuis notre création, VisitonsMonde s'est imposée comme référence dans l'organisation de voyages sur mesure. Notre mission est simple : transformer vos rêves d'évasion en expériences inoubliables.</p>
                <p class="mb-4">Avec une équipe de passionnés et un réseau de guides locaux experts, nous vous garantissons des voyages authentiques, sûrs et mémorables aux quatre coins du monde.</p>

                <div class="row gy-2 gx-4 mb-4">
                    <div class="col-sm-6">
                        <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>Vols Premium</p>
                    </div>
                    <div class="col-sm-6">
                        <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>Hôtels Sélectionnés</p>
                    </div>
                    <div class="col-sm-6">
                        <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>Hébergements 5 Étoiles</p>
                    </div>
                    <div class="col-sm-6">
                        <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>Véhicules Récents</p>
                    </div>
                    <div class="col-sm-6">
                        <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i><%= totalDestinations %>+ Destinations</p>
                    </div>
                    <div class="col-sm-6">
                        <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i><%= totalClients %>+ Clients Satisfaits</p>
                    </div>
                </div>
                <a class="btn btn-primary rounded-pill py-3 px-5 mt-2" href="${pageContext.request.contextPath}/about.jsp">En savoir plus</a>
            </div>
        </div>
    </div>
</div>
<!-- About End -->

<!-- Services Start -->
<jsp:include page="services.jsp"/>

<!-- DESTINATIONS POPULAIRES -->
<div class="container-fluid destination py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">Destinations</h5>
            <h1 class="mb-0">Destinations Populaires</h1>
            <p class="mt-3">Découvrez nos <%= totalDestinations %> destinations à travers le monde</p>
        </div>

        <% if (destinationsPopulaires != null && !destinationsPopulaires.isEmpty()) { %>

        <!-- 2 premières destinations -->
        <div class="row g-3">
            <% for (int i = 0; i < Math.min(2, destinationsPopulaires.size()); i++) {
                Destination dest = destinationsPopulaires.get(i); %>
            <div class="col-lg-6">
                <div class="destination-img">
                    <img class="img-fluid rounded w-100"
                         src="${pageContext.request.contextPath}/img/<%= dest.getImage() != null ? dest.getImage() : "default-destination.jpg" %>"
                         alt="<%= dest.getNom() %>"
                         onerror="this.src='${pageContext.request.contextPath}/img/default-destination.jpg'">
                    <div class="destination-overlay p-4">
                        <h4 class="text-white mb-2 mt-3"><%= dest.getNom() %></h4>
                        <% if (dest.getPays() != null) { %>
                        <p class="text-white mb-3"><i class="fa fa-map-marker-alt me-2"></i><%= dest.getPays() %></p>
                        <% } %>
                        <% if (dest.getPrix() != null) { %>
                        <p class="text-white mb-3">À partir de <%= String.format("%.0f", dest.getPrix()) %> €</p>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/destination-details?id=<%= dest.getId() %>"
                           class="btn-hover text-white">
                            Voir les détails <i class="fa fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                    <div class="search-icon">
                        <a href="${pageContext.request.contextPath}/img/<%= dest.getImage() %>" data-lightbox="destination-<%= dest.getId() %>">
                            <i class="fa fa-plus-square fa-1x btn btn-light btn-lg-square text-primary"></i>
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <!-- 3ème destination pleine largeur -->
        <% if (destinationsPopulaires.size() > 2) {
            Destination dest = destinationsPopulaires.get(2); %>
        <div class="row g-3">
            <div class="col-12">
                <div class="destination-img h-100">
                    <img class="img-fluid rounded w-100 h-100"
                         src="${pageContext.request.contextPath}/img/<%= dest.getImage() != null ? dest.getImage() : "default-destination.jpg" %>"
                         alt="<%= dest.getNom() %>"
                         onerror="this.src='${pageContext.request.contextPath}/img/default-destination.jpg'"
                         style="object-fit: cover; min-height: 400px;">
                    <div class="destination-overlay p-4">
                        <h4 class="text-white mb-2 mt-3"><%= dest.getNom() %></h4>
                        <% if (dest.getPays() != null) { %>
                        <p class="text-white mb-3"><i class="fa fa-map-marker-alt me-2"></i><%= dest.getPays() %></p>
                        <% } %>
                        <% if (dest.getPrix() != null) { %>
                        <p class="text-white mb-3">À partir de <%= String.format("%.0f", dest.getPrix()) %> €</p>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/destination-details?id=<%= dest.getId() %>"
                           class="btn-hover text-white">
                            Voir les détails <i class="fa fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                    <div class="search-icon">
                        <a href="${pageContext.request.contextPath}/img/<%= dest.getImage() %>" data-lightbox="destination-<%= dest.getId() %>">
                            <i class="fa fa-plus-square fa-1x btn btn-light btn-lg-square text-primary"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <% } %>

        <!-- 3 dernières destinations -->
        <% if (destinationsPopulaires.size() > 3) { %>
        <div class="row g-3 mt-3">
            <% for (int i = 3; i < Math.min(6, destinationsPopulaires.size()); i++) {
                Destination dest = destinationsPopulaires.get(i); %>
            <div class="col-lg-4">
                <div class="destination-img">
                    <img class="img-fluid rounded w-100"
                         src="${pageContext.request.contextPath}/img/<%= dest.getImage() != null ? dest.getImage() : "default-destination.jpg" %>"
                         alt="<%= dest.getNom() %>"
                         onerror="this.src='${pageContext.request.contextPath}/img/default-destination.jpg'">
                    <div class="destination-overlay p-4">
                        <h4 class="text-white mb-2 mt-3"><%= dest.getNom() %></h4>
                        <% if (dest.getPays() != null) { %>
                        <p class="text-white mb-3"><i class="fa fa-map-marker-alt me-2"></i><%= dest.getPays() %></p>
                        <% } %>
                        <% if (dest.getPrix() != null) { %>
                        <p class="text-white mb-3">À partir de <%= String.format("%.0f", dest.getPrix()) %> €</p>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/destination-details?id=<%= dest.getId() %>"
                           class="btn-hover text-white">
                            Voir les détails <i class="fa fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                    <div class="search-icon">
                        <a href="${pageContext.request.contextPath}/img/<%= dest.getImage() %>" data-lightbox="destination-<%= dest.getId() %>">
                            <i class="fa fa-plus-square fa-1x btn btn-light btn-lg-square text-primary"></i>
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>

        <% } else { %>
        <div class="alert alert-info text-center">
            <p>Aucune destination disponible pour le moment.</p>
        </div>
        <% } %>

        <div class="text-center mt-5">
            <a class="btn btn-primary rounded-pill py-3 px-5" href="${pageContext.request.contextPath}/destinations">
                Voir Toutes Les Destinations
            </a>
        </div>
    </div>
</div>
<!-- Destination End -->

<!-- Travel Guide Start -->
<div class="container-fluid guide py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">Guides Touristiques</h5>
            <h1 class="mb-0">Rencontrez Nos Guides</h1>
        </div>
        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="guide-item">
                    <div class="guide-img">
                        <div class="guide-img-efects">
                            <img src="${pageContext.request.contextPath}/img/guide-1.jpg" class="img-fluid w-100 rounded-top" alt="Image">
                        </div>
                        <div class="guide-icon rounded-pill p-2">
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="guide-title text-center rounded-bottom p-4">
                        <div class="guide-title-inner">
                            <h4 class="mt-3">Guide Expert</h4>
                            <p class="mb-0">Spécialiste Europe</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="guide-item">
                    <div class="guide-img">
                        <div class="guide-img-efects">
                            <img src="${pageContext.request.contextPath}/img/guide-2.jpg" class="img-fluid w-100 rounded-top" alt="Image">
                        </div>
                        <div class="guide-icon rounded-pill p-2">
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="guide-title text-center rounded-bottom p-4">
                        <div class="guide-title-inner">
                            <h4 class="mt-3">Guide Expert</h4>
                            <p class="mb-0">Spécialiste Asie</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="guide-item">
                    <div class="guide-img">
                        <div class="guide-img-efects">
                            <img src="${pageContext.request.contextPath}/img/guide-3.jpg" class="img-fluid w-100 rounded-top" alt="Image">
                        </div>
                        <div class="guide-icon rounded-pill p-2">
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="guide-title text-center rounded-bottom p-4">
                        <div class="guide-title-inner">
                            <h4 class="mt-3">Guide Expert</h4>
                            <p class="mb-0">Spécialiste Afrique</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="guide-item">
                    <div class="guide-img">
                        <div class="guide-img-efects">
                            <img src="${pageContext.request.contextPath}/img/guide-4.jpg" class="img-fluid w-100 rounded-top" alt="Image">
                        </div>
                        <div class="guide-icon rounded-pill p-2">
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                            <a class="btn btn-square btn-primary rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="guide-title text-center rounded-bottom p-4">
                        <div class="guide-title-inner">
                            <h4 class="mt-3">Guide Expert</h4>
                            <p class="mb-0">Spécialiste Amériques</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Travel Guide End -->
<!-- Testimonials Start -->
<div class="container-fluid testimonial py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">Témoignages</h5>
            <h1 class="mb-0">Ils Ont Voyagé Avec Nous</h1>
            <p class="mt-3">Découvrez les expériences de nos clients satisfaits</p>
        </div>

        <div class="row g-4">
            <!-- Témoignage 1 -->
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-item bg-white rounded p-4 h-100 shadow-sm">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/img/testimonial-1.jpg"
                             class="rounded-circle me-3"
                             style="width: 60px; height: 60px; object-fit: cover;"
                             onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.jpg'">
                        <div>
                            <h5 class="mb-0">Sophie Martin</h5>
                            <small class="text-muted">Paris, France</small>
                        </div>
                    </div>
                    <div class="text-warning mb-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="mb-3">
                        <i class="fas fa-quote-left text-primary me-2"></i>
                        Un voyage absolument magnifique à Madagascar ! L'organisation était parfaite,
                        notre guide Rakoto était exceptionnel. Les paysages de l'allée des baobabs
                        nous ont laissés sans voix. Merci VisitonsMonde !
                    </p>
                    <div class="text-muted small">
                        <i class="fas fa-map-marker-alt me-1"></i>
                        Voyage à Madagascar - Octobre 2025
                    </div>
                </div>
            </div>

            <!-- Témoignage 2 -->
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-item bg-white rounded p-4 h-100 shadow-sm">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/img/testimonial-2.jpg"
                             class="rounded-circle me-3"
                             style="width: 60px; height: 60px; object-fit: cover;"
                             onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.jpg'">
                        <div>
                            <h5 class="mb-0">Marc Dubois</h5>
                            <small class="text-muted">Lyon, France</small>
                        </div>
                    </div>
                    <div class="text-warning mb-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="mb-3">
                        <i class="fas fa-quote-left text-primary me-2"></i>
                        Safari au Kenya inoubliable ! Nous avons vu les Big Five, l'équipe était
                        professionnelle et aux petits soins. L'hébergement était top et les repas
                        délicieux. Une expérience à vivre absolument !
                    </p>
                    <div class="text-muted small">
                        <i class="fas fa-map-marker-alt me-1"></i>
                        Safari au Kenya - Septembre 2025
                    </div>
                </div>
            </div>

            <!-- Témoignage 3 -->
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-item bg-white rounded p-4 h-100 shadow-sm">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/img/testimonial-3.jpg"
                             class="rounded-circle me-3"
                             style="width: 60px; height: 60px; object-fit: cover;"
                             onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.jpg'">
                        <div>
                            <h5 class="mb-0">Julie & Thomas</h5>
                            <small class="text-muted">Marseille, France</small>
                        </div>
                    </div>
                    <div class="text-warning mb-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="mb-3">
                        <i class="fas fa-quote-left text-primary me-2"></i>
                        Notre lune de miel aux Seychelles était un rêve devenu réalité !
                        Tout était parfaitement organisé, de l'accueil à l'aéroport aux activités.
                        Le personnel était adorable. Nous recommandons à 200% !
                    </p>
                    <div class="text-muted small">
                        <i class="fas fa-map-marker-alt me-1"></i>
                        Lune de miel aux Seychelles - Août 2025
                    </div>
                </div>
            </div>

            <!-- Témoignage 4 -->
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-item bg-white rounded p-4 h-100 shadow-sm">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/img/testimonial-4.jpg"
                             class="rounded-circle me-3"
                             style="width: 60px; height: 60px; object-fit: cover;"
                             onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.jpg'">
                        <div>
                            <h5 class="mb-0">Pierre Leroux</h5>
                            <small class="text-muted">Toulouse, France</small>
                        </div>
                    </div>
                    <div class="text-warning mb-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="far fa-star"></i>
                    </div>
                    <p class="mb-3">
                        <i class="fas fa-quote-left text-primary me-2"></i>
                        Excellent voyage en Thaïlande ! Les plages étaient paradisiaques,
                        la nourriture délicieuse. Une petite amélioration sur la ponctualité
                        serait appréciée, mais globalement très satisfait !
                    </p>
                    <div class="text-muted small">
                        <i class="fas fa-map-marker-alt me-1"></i>
                        Circuit en Thaïlande - Juillet 2025
                    </div>
                </div>
            </div>

            <!-- Témoignage 5 -->
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-item bg-white rounded p-4 h-100 shadow-sm">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/img/testimonial-5.jpg"
                             class="rounded-circle me-3"
                             style="width: 60px; height: 60px; object-fit: cover;"
                             onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.jpg'">
                        <div>
                            <h5 class="mb-0">Famille Rousseau</h5>
                            <small class="text-muted">Nantes, France</small>
                        </div>
                    </div>
                    <div class="text-warning mb-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="mb-3">
                        <i class="fas fa-quote-left text-primary me-2"></i>
                        Voyage en famille à l'île Maurice réussi ! Les enfants ont adoré les
                        activités nautiques. L'hôtel était adapté aux familles et le personnel
                        très attentionné. Merci pour ces souvenirs inoubliables !
                    </p>
                    <div class="text-muted small">
                        <i class="fas fa-map-marker-alt me-1"></i>
                        Vacances à l'île Maurice - Décembre 2025
                    </div>
                </div>
            </div>

            <!-- Témoignage 6 -->
            <div class="col-lg-4 col-md-6">
                <div class="testimonial-item bg-white rounded p-4 h-100 shadow-sm">
                    <div class="d-flex align-items-center mb-3">
                        <img src="${pageContext.request.contextPath}/img/testimonial-6.jpg"
                             class="rounded-circle me-3"
                             style="width: 60px; height: 60px; object-fit: cover;"
                             onerror="this.src='${pageContext.request.contextPath}/img/default-avatar.jpg'">
                        <div>
                            <h5 class="mb-0">Claire Benoit</h5>
                            <small class="text-muted">Bordeaux, France</small>
                        </div>
                    </div>
                    <div class="text-warning mb-2">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                    <p class="mb-3">
                        <i class="fas fa-quote-left text-primary me-2"></i>
                        Road trip en Afrique du Sud fantastique ! De Cape Town au parc Kruger,
                        chaque étape était magique. Guide très compétent et itinéraire bien pensé.
                        Je recommande vivement VisitonsMonde !
                    </p>
                    <div class="text-muted small">
                        <i class="fas fa-map-marker-alt me-1"></i>
                        Road Trip Afrique du Sud - Novembre 2025
                    </div>
                </div>
            </div>
        </div>

        <!-- Statistiques -->
        <div class="row mt-5">
            <div class="col-md-3 col-6 text-center mb-3">
                <div class="bg-light rounded p-4">
                    <h2 class="text-primary mb-0"><%= totalClients != null ? totalClients : 5 %>+</h2>
                    <p class="mb-0">Clients Satisfaits</p>
                </div>
            </div>
            <div class="col-md-3 col-6 text-center mb-3">
                <div class="bg-light rounded p-4">
                    <h2 class="text-primary mb-0">4.9/5</h2>
                    <p class="mb-0">Note Moyenne</p>
                </div>
            </div>
            <div class="col-md-3 col-6 text-center mb-3">
                <div class="bg-light rounded p-4">
                    <h2 class="text-primary mb-0">98%</h2>
                    <p class="mb-0">Taux de Satisfaction</p>
                </div>
            </div>
            <div class="col-md-3 col-6 text-center mb-3">
                <div class="bg-light rounded p-4">
                    <h2 class="text-primary mb-0"><%= totalDestinations != null ? totalDestinations : 25 %>+</h2>
                    <p class="mb-0">Destinations</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Testimonials End -->
<!-- Subscribe Start -->
<div class="container-fluid subscribe py-5">
    <div class="container text-center py-5">
        <div class="mx-auto text-center" style="max-width: 900px;">
            <h5 class="subscribe-title px-3">Newsletter</h5>
            <h1 class="text-white mb-4">Notre Newsletter</h1>
            <p class="text-white mb-5">Inscrivez-vous à notre newsletter pour recevoir nos dernières offres et actualités directement dans votre boîte mail.</p>
            <div class="position-relative mx-auto">
                <input class="form-control border-primary rounded-pill w-100 py-3 ps-4 pe-5" type="text" placeholder="Votre email">
                <button type="button" class="btn btn-primary rounded-pill position-absolute top-0 end-0 py-2 px-4 mt-2 me-2">S'inscrire</button>
            </div>
        </div>
    </div>
</div>
<!-- Subscribe End -->

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
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>