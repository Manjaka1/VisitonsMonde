<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>À Propos - VisitonsMonde</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600&family=Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>
<jsp:include page="navbar.jsp" />

<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h3 class="text-white display-3 mb-4">À Propos</h3>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Accueil</a></li>
            <li class="breadcrumb-item active text-white">À Propos</li>
        </ol>
    </div>
</div>

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
                <p class="mb-4">Depuis 2015, VisitonsMonde s'est imposée comme référence dans l'organisation de voyages sur mesure. Notre mission est simple : transformer vos rêves d'évasion en expériences inoubliables.</p>
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
                        <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>150+ Tours Premium</p>
                    </div>
                    <div class="col-sm-6">
                        <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>Service 24/7</p>
                    </div>
                </div>
                <a class="btn btn-primary rounded-pill py-3 px-5 mt-2" href="${pageContext.request.contextPath}/services.jsp">Nos Services</a>
            </div>
        </div>
    </div>
</div>

<!-- Stats -->
<div class="container-fluid bg-light py-5">
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-md-3 text-center">
                <i class="fas fa-users fa-3x text-primary mb-3"></i>
                <h2 class="text-primary">15,000+</h2>
                <p>Voyageurs Satisfaits</p>
            </div>
            <div class="col-md-3 text-center">
                <i class="fas fa-map-marked-alt fa-3x text-success mb-3"></i>
                <h2 class="text-success">150+</h2>
                <p>Destinations</p>
            </div>
            <div class="col-md-3 text-center">
                <i class="fas fa-award fa-3x text-warning mb-3"></i>
                <h2 class="text-warning">50+</h2>
                <p>Prix Remportés</p>
            </div>
            <div class="col-md-3 text-center">
                <i class="fas fa-user-tie fa-3x text-info mb-3"></i>
                <h2 class="text-info">100+</h2>
                <p>Guides Experts</p>
            </div>
        </div>
    </div>
</div>

<!-- Mission & Vision -->
<div class="container py-5">
    <div class="row g-5">
        <div class="col-lg-6">
            <div class="bg-light rounded p-5 h-100">
                <div class="text-center mb-4">
                    <i class="fas fa-bullseye fa-4x text-primary"></i>
                </div>
                <h3 class="text-center mb-4">Notre Mission</h3>
                <p class="text-center">Créer des expériences de voyage exceptionnelles qui enrichissent la vie de nos clients, tout en respectant les cultures locales et l'environnement. Nous nous engageons à offrir un service personnalisé, authentique et de qualité supérieure.</p>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="bg-light rounded p-5 h-100">
                <div class="text-center mb-4">
                    <i class="fas fa-eye fa-4x text-success"></i>
                </div>
                <h3 class="text-center mb-4">Notre Vision</h3>
                <p class="text-center">Devenir la référence mondiale du voyage sur mesure, reconnue pour notre excellence, notre innovation et notre engagement envers un tourisme responsable et durable. Nous aspirons à connecter les cultures et créer des souvenirs qui durent toute une vie.</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<a href="#" class="btn btn-primary btn-primary-outline-0 btn-md-square back-to-top"><i class="fa fa-arrow-up"></i></a>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/lightbox/js/lightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>