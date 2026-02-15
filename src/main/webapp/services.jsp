<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Nos Services - VisitonsMonde</title>
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
        .service-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s;
            height: 100%;
            background: white;
        }
        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }
        .service-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2.5rem;
        }
        .service-title {
            color: #13357B;
            font-weight: 600;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>
<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h3 class="text-white display-3 mb-4">Nos Services</h3>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
            <li class="breadcrumb-item active text-white">Services</li>
        </ol>
    </div>
</div>
<!-- Header End -->

<!-- Services Start -->
<div class="container-fluid service py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">NOS SERVICES</h5>
            <h1 class="mb-0">Des Services d'Exception</h1>
            <p class="mt-3">
                Découvrez notre gamme complète de services conçus pour rendre votre expérience de voyage inoubliable.
            </p>
        </div>

        <!-- Services Grid -->
        <div class="row g-4">
            <!-- Service 1 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon bg-primary text-white">
                        <i class="fas fa-map-marked-alt"></i>
                    </div>
                    <h4 class="service-title">Planification Voyage sur Mesure</h4>
                    <p class="text-muted">
                        Nos experts créent des itinéraires personnalisés adaptés à vos envies, budget et style.
                    </p>
                    <ul class="text-muted small">
                        <li>Itinéraires personnalisés</li>
                        <li>Conseils d'experts</li>
                        <li>Flexibilité totale</li>
                    </ul>
                </div>
            </div>

            <!-- Service 2 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon bg-success text-white">
                        <i class="fas fa-user-tie"></i>
                    </div>
                    <h4 class="service-title">Guides Touristiques Certifiés</h4>
                    <p class="text-muted">
                        Voyagez avec des guides locaux passionnés qui connaissent les secrets de chaque destination.
                    </p>
                    <ul class="text-muted small">
                        <li>Guides multilingues</li>
                        <li>Experts locaux</li>
                        <li>Disponibles 24/7</li>
                    </ul>
                </div>
            </div>

            <!-- Service 3 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon bg-warning text-white">
                        <i class="fas fa-hotel"></i>
                    </div>
                    <h4 class="service-title">Réservation d'Hébergement</h4>
                    <p class="text-muted">
                        Profitez de notre réseau d'hôtels partenaires sélectionnés pour leur qualité.
                    </p>
                    <ul class="text-muted small">
                        <li>Hôtels de qualité</li>
                        <li>Meilleurs tarifs garantis</li>
                        <li>Assistance réservation</li>
                    </ul>
                </div>
            </div>

            <!-- Service 4 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon bg-info text-white">
                        <i class="fas fa-plane-departure"></i>
                    </div>
                    <h4 class="service-title">Billets d'Avion & Transferts</h4>
                    <p class="text-muted">
                        Réservez vos vols aux meilleurs tarifs et bénéficiez de transferts privés confortables.
                    </p>
                    <ul class="text-muted small">
                        <li>Vols aux meilleurs prix</li>
                        <li>Transferts privés</li>
                        <li>Service VIP disponible</li>
                    </ul>
                </div>
            </div>

            <!-- Service 5 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon bg-danger text-white">
                        <i class="fas fa-umbrella-beach"></i>
                    </div>
                    <h4 class="service-title">Activités & Excursions</h4>
                    <p class="text-muted">
                        Découvrez une sélection d'activités : visites culturelles, aventures sportives, gastronomie.
                    </p>
                    <ul class="text-muted small">
                        <li>Large choix d'activités</li>
                        <li>Réservation simplifiée</li>
                        <li>Expériences uniques</li>
                    </ul>
                </div>
            </div>

            <!-- Service 6 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon bg-secondary text-white">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h4 class="service-title">Assistance 24/7</h4>
                    <p class="text-muted">
                        Notre équipe est disponible jour et nuit pour répondre à vos questions et urgences.
                    </p>
                    <ul class="text-muted small">
                        <li>Support multicanal</li>
                        <li>Réponse rapide garantie</li>
                        <li>Assistance multilingue</li>
                    </ul>
                </div>
            </div>

            <!-- Service 7 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h4 class="service-title">Assurance Voyage</h4>
                    <p class="text-muted">
                        Partez en toute sérénité avec nos options d'assurance : annulation, rapatriement, bagages.
                    </p>
                    <ul class="text-muted small">
                        <li>Couverture complète</li>
                        <li>Partenaires de confiance</li>
                        <li>Tarifs compétitifs</li>
                    </ul>
                </div>
            </div>

            <!-- Service 8 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white;">
                        <i class="fas fa-camera"></i>
                    </div>
                    <h4 class="service-title">Photographie de Voyage</h4>
                    <p class="text-muted">
                        Immortalisez vos moments avec nos photographes professionnels.
                    </p>
                    <ul class="text-muted small">
                        <li>Photographes professionnels</li>
                        <li>Shooting personnalisé</li>
                        <li>Retouches incluses</li>
                    </ul>
                </div>
            </div>

            <!-- Service 9 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4">
                    <div class="service-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white;">
                        <i class="fas fa-gift"></i>
                    </div>
                    <h4 class="service-title">Événements Spéciaux</h4>
                    <p class="text-muted">
                        Organisation complète pour lunes de miel, anniversaires, voyages d'affaires ou groupes.
                    </p>
                    <ul class="text-muted small">
                        <li>Lunes de miel romantiques</li>
                        <li>Voyages de groupe</li>
                        <li>Événements d'entreprise</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Call to Action -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="bg-light rounded p-5 text-center">
                    <h3 class="mb-3">Prêt à Planifier Votre Prochain Voyage ?</h3>
                    <p class="mb-4">
                        Notre équipe est à votre disposition pour créer l'expérience de voyage de vos rêves !
                    </p>
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-primary btn-lg rounded-pill px-5 me-3">
                        <i class="fas fa-envelope me-2"></i>Nous Contacter
                    </a>
                    <a href="${pageContext.request.contextPath}/destination" class="btn btn-outline-primary btn-lg rounded-pill px-5">
                        <i class="fas fa-map-marker-alt me-2"></i>Voir Destinations
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Services End -->

<!-- Footer -->
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