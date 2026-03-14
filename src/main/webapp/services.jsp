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
            cursor: pointer;
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
                <div class="service-card p-4" onclick="openServiceModal('planification')">
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
                    <div class="text-center mt-3">
                        <span class="badge bg-primary">Cliquez pour en savoir plus</span>
                    </div>
                </div>
            </div>

            <!-- Service 2 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4" onclick="openServiceModal('guides')">
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
                    <div class="text-center mt-3">
                        <span class="badge bg-success">Cliquez pour en savoir plus</span>
                    </div>
                </div>
            </div>

            <!-- Service 3 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4" onclick="openServiceModal('hebergement')">
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
                    <div class="text-center mt-3">
                        <span class="badge bg-warning">Cliquez pour en savoir plus</span>
                    </div>
                </div>
            </div>

            <!-- Service 4 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4" onclick="openServiceModal('billets')">
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
                    <div class="text-center mt-3">
                        <span class="badge bg-info">Cliquez pour en savoir plus</span>
                    </div>
                </div>
            </div>

            <!-- Service 5 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4" onclick="openServiceModal('activites')">
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
                    <div class="text-center mt-3">
                        <span class="badge bg-danger">Cliquez pour en savoir plus</span>
                    </div>
                </div>
            </div>

            <!-- Service 6 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4" onclick="openServiceModal('assistance')">
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
                    <div class="text-center mt-3">
                        <span class="badge bg-secondary">Cliquez pour en savoir plus</span>
                    </div>
                </div>
            </div>

            <!-- Service 7 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4" onclick="openServiceModal('assurance')">
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
                    <div class="text-center mt-3">
                        <span class="badge" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">Cliquez pour en savoir plus</span>
                    </div>
                </div>
            </div>

            <!-- Service 8 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4" onclick="openServiceModal('photo')">
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
                    <div class="text-center mt-3">
                        <span class="badge" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">Cliquez pour en savoir plus</span>
                    </div>
                </div>
            </div>

            <!-- Service 9 -->
            <div class="col-lg-4 col-md-6">
                <div class="service-card p-4" onclick="openServiceModal('evenements')">
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
                    <div class="text-center mt-3">
                        <span class="badge" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">Cliquez pour en savoir plus</span>
                    </div>
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
                    <a href="${pageContext.request.contextPath}/destinations" class="btn btn-outline-primary btn-lg rounded-pill px-5">
                        <i class="fas fa-map-marker-alt me-2"></i>Voir Destinations
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Services End -->

<!-- MODALE DÉTAILS SERVICE -->
<div class="modal fade" id="serviceModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" id="modalHeader">
                <h5 class="modal-title text-white" id="modalTitle"></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="modalIcon" class="text-center mb-4"></div>
                <div id="modalDescription"></div>
                <hr>
                <h6 class="text-primary mb-3">Avantages de ce service :</h6>
                <div id="modalAvantages"></div>
                <hr>
                <div id="modalTarifs"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
                <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-primary">
                    <i class="fas fa-envelope me-2"></i>Nous Contacter
                </a>
            </div>
        </div>
    </div>
</div>

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

<script>
    // Données des services
    const servicesData = {
        planification: {
            title: 'Planification Voyage sur Mesure',
            icon: '<i class="fas fa-map-marked-alt fa-4x text-primary"></i>',
            headerColor: 'bg-primary',
            description: 'Notre équipe d\'experts en voyage crée pour vous des itinéraires 100% personnalisés qui correspondent parfaitement à vos envies, votre budget et votre style de voyage. Nous prenons en compte chaque détail pour vous offrir une expérience unique et inoubliable.',
            avantages: [
                'Consultation gratuite avec nos experts voyage',
                'Itinéraire détaillé jour par jour',
                'Recommandations personnalisées (restaurants, activités, lieux secrets)',
                'Modifications illimitées jusqu\'à satisfaction',
                'Carnet de voyage digital inclus',
                'Support avant, pendant et après le voyage'
            ],
            tarifs: 'À partir de 150€ pour un itinéraire complet de 7 jours'
        },
        guides: {
            title: 'Guides Touristiques Certifiés',
            icon: '<i class="fas fa-user-tie fa-4x text-success"></i>',
            headerColor: 'bg-success',
            description: 'Nos guides touristiques sont des professionnels certifiés, passionnés par leur région et formés pour vous offrir une expérience enrichissante. Ils parlent plusieurs langues et connaissent tous les secrets de chaque destination.',
            avantages: [
                'Guides diplômés et certifiés',
                'Maîtrise de 3 langues minimum',
                'Connaissance approfondie de l\'histoire et de la culture locale',
                'Accès à des lieux non touristiques',
                'Flexibilité dans le programme',
                'Petits groupes pour une expérience personnalisée'
            ],
            tarifs: 'À partir de 80€/jour pour un guide privé'
        },
        hebergement: {
            title: 'Réservation d\'Hébergement',
            icon: '<i class="fas fa-hotel fa-4x text-warning"></i>',
            headerColor: 'bg-warning',
            description: 'Accédez à notre réseau exclusif d\'hôtels, resorts et hébergements de charme soigneusement sélectionnés pour leur qualité exceptionnelle. Nous négocions pour vous les meilleurs tarifs et garantissons votre satisfaction.',
            avantages: [
                'Plus de 10,000 établissements partenaires',
                'Meilleurs prix garantis',
                'Surclassement gratuit selon disponibilité',
                'Annulation flexible sur la plupart des réservations',
                'Service conciergerie 24/7',
                'Programme de fidélité avec avantages exclusifs'
            ],
            tarifs: 'Pas de frais de réservation - Vous payez le même prix qu\'en direct'
        },
        billets: {
            title: 'Billets d\'Avion & Transferts',
            icon: '<i class="fas fa-plane-departure fa-4x text-info"></i>',
            headerColor: 'bg-info',
            description: 'Profitez de nos partenariats avec les compagnies aériennes pour obtenir les meilleurs tarifs et services. Nous organisons également tous vos transferts pour une expérience sans stress du départ à l\'arrivée.',
            avantages: [
                'Accès aux tarifs négociés avec les compagnies',
                'Comparaison automatique de toutes les options',
                'Assistance pour visa et formalités',
                'Transferts privés aéroport-hôtel inclus',
                'Service Fast Track dans certains aéroports',
                'Assurance annulation disponible'
            ],
            tarifs: 'Tarifs variables selon destination - Devis gratuit'
        },
        activites: {
            title: 'Activités & Excursions',
            icon: '<i class="fas fa-umbrella-beach fa-4x text-danger"></i>',
            headerColor: 'bg-danger',
            description: 'Découvrez notre sélection exclusive d\'activités et d\'excursions : visites culturelles, aventures sportives, expériences gastronomiques, et bien plus. Chaque activité est testée et approuvée par notre équipe.',
            avantages: [
                'Plus de 5,000 activités dans le monde',
                'Réservation instantanée',
                'Guides experts pour chaque activité',
                'Petits groupes (max 12 personnes)',
                'Équipement fourni',
                'Garantie satisfait ou remboursé'
            ],
            tarifs: 'À partir de 30€/personne selon l\'activité'
        },
        assistance: {
            title: 'Assistance 24/7',
            icon: '<i class="fas fa-headset fa-4x text-secondary"></i>',
            headerColor: 'bg-secondary',
            description: 'Voyagez l\'esprit tranquille avec notre service d\'assistance disponible 24h/24 et 7j/7. Notre équipe multilingue est à votre écoute pour répondre à toutes vos questions et gérer les imprévus.',
            avantages: [
                'Disponible dans 15 langues',
                'Temps de réponse moyen < 5 minutes',
                'Assistance médicale d\'urgence',
                'Aide pour documents perdus',
                'Modification de réservation en temps réel',
                'Support technique et logistique'
            ],
            tarifs: 'Service inclus gratuitement dans tous nos forfaits'
        },
        assurance: {
            title: 'Assurance Voyage',
            icon: '<i class="fas fa-shield-alt fa-4x" style="color: #667eea;"></i>',
            headerColor: 'bg-primary',
            description: 'Protégez votre voyage avec nos formules d\'assurance complètes. En partenariat avec les leaders du secteur, nous vous proposons des couvertures adaptées à chaque type de voyage.',
            avantages: [
                'Annulation pour toute raison',
                'Rapatriement médical',
                'Frais médicaux à l\'étranger',
                'Perte et vol de bagages',
                'Responsabilité civile',
                'Assistance juridique'
            ],
            tarifs: 'À partir de 4% du montant total du voyage'
        },
        photo: {
            title: 'Photographie de Voyage',
            icon: '<i class="fas fa-camera fa-4x" style="color: #f5576c;"></i>',
            headerColor: 'bg-danger',
            description: 'Immortalisez vos plus beaux moments avec nos photographes professionnels. Spécialisés en photographie de voyage, ils capturent l\'essence de votre aventure avec un regard artistique unique.',
            avantages: [
                'Photographes professionnels locaux',
                'Shooting de 2h minimum',
                'Minimum 50 photos retouchées',
                'Livraison en haute définition',
                'Album photo digital inclus',
                'Option album papier premium'
            ],
            tarifs: 'À partir de 200€ pour une session de 2 heures'
        },
        evenements: {
            title: 'Événements Spéciaux',
            icon: '<i class="fas fa-gift fa-4x" style="color: #00f2fe;"></i>',
            headerColor: 'bg-info',
            description: 'Célébrez vos moments importants avec nos forfaits sur mesure : lunes de miel romantiques, anniversaires inoubliables, voyages d\'affaires réussis ou aventures en groupe. Nous nous occupons de chaque détail.',
            avantages: [
                'Planification complète de A à Z',
                'Décoration et ambiance personnalisée',
                'Surprises et attention particulières',
                'Coordination avec prestataires locaux',
                'Tarifs de groupe avantageux',
                'Coordinateur dédié à votre événement'
            ],
            tarifs: 'Sur devis personnalisé selon vos besoins'
        }
    };

    function openServiceModal(serviceKey) {
        const service = servicesData[serviceKey];
        if (!service) return;

        // Remplir la modale
        document.getElementById('modalTitle').textContent = service.title;
        document.getElementById('modalHeader').className = 'modal-header ' + service.headerColor;
        document.getElementById('modalIcon').innerHTML = service.icon;
        document.getElementById('modalDescription').innerHTML = '<p class="lead">' + service.description + '</p>';

        // Avantages
        let avantagesHTML = '<ul class="list-unstyled">';
        service.avantages.forEach(avantage => {
            avantagesHTML += '<li class="mb-2"><i class="fas fa-check-circle text-success me-2"></i>' + avantage + '</li>';
        });
        avantagesHTML += '</ul>';
        document.getElementById('modalAvantages').innerHTML = avantagesHTML;

        // Tarifs
        document.getElementById('modalTarifs').innerHTML = '<h6 class="text-primary mb-2">Tarifs :</h6><p class="text-muted">' + service.tarifs + '</p>';

        // Ouvrir la modale
        const modal = new bootstrap.Modal(document.getElementById('serviceModal'));
        modal.show();
    }
</script>
</body>
</html>