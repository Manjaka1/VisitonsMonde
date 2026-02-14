<%@ page import="com.visitonsmonde.model.Utilisateur" %>
<%@ page import="com.visitonsmonde.model.Destination" %>
<%@ page import="java.util.List" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    List<Destination> destinations = (List<Destination>) request.getAttribute("destinations");

    // DEBUG
    System.out.println("=== BOOKING.JSP DEBUG ===");
    System.out.println("Utilisateur: " + (utilisateur != null ? utilisateur.getNomComplet() : "null"));
    System.out.println("Destinations: " + destinations);
    System.out.println("Nombre destinations: " + (destinations != null ? destinations.size() : "null"));
    if (destinations != null && !destinations.isEmpty()) {
        for (Destination d : destinations) {
            System.out.println("  - " + d.getNom() + " (" + d.getPays() + ") - " + d.getPrix() + "€");
        }
    }
    System.out.println("==========================");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Récupérer l'utilisateur connecté pour pré-remplir le formulaire
    Utilisateur utilisateurConnecte = (Utilisateur) session.getAttribute("utilisateur");
    String nomPreRempl = "";
    String emailPreRempl = "";

    if (utilisateurConnecte != null) {
        nomPreRempl = utilisateurConnecte.getNom() + " " + utilisateurConnecte.getPrenom();
        emailPreRempl = utilisateurConnecte.getEmail();
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Réservation - TripHive</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500;600&family=Roboto&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>

<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border text-success" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Loading...</span>
    </div>
</div>
<!-- Spinner End -->

<%--<!-- Topbar Start -->--%>
<%--<!-- <%@ include file="navbar.jsp" %> -->--%>
<!-- Topbar Start -->
<div class="container-fluid bg-primary px-5 d-none d-lg-block">
    <div class="row gx-0">
        <div class="col-lg-8 text-center text-lg-start mb-2 mb-lg-0">
            <div class="d-inline-flex align-items-center" style="height: 45px;">
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-twitter fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-facebook-f fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-linkedin-in fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle me-2" href=""><i class="fab fa-instagram fw-normal"></i></a>
                <a class="btn btn-sm btn-outline-light btn-sm-square rounded-circle" href=""><i class="fab fa-youtube fw-normal"></i></a>
            </div>
        </div>
        <div class="col-lg-4 text-center text-lg-end">
            <div class="d-inline-flex align-items-center" style="height: 45px;">
                <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">Se connecter</a>
                <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#registerModal">S'inscrire</a>
                <div class="dropdown">
                    <a href="#" class="dropdown-toggle text-light" data-bs-toggle="dropdown"><small><i class="fa fa-home me-2"></i> My Dashboard</small></a>
                    <div class="dropdown-menu rounded">
                        <a href="#" class="dropdown-item"><i class="fas fa-user-alt me-2"></i> My Profile</a>
                        <a href="#" class="dropdown-item"><i class="fas fa-comment-alt me-2"></i> Inbox</a>
                        <a href="#" class="dropdown-item"><i class="fas fa-bell me-2"></i> Notifications</a>
                        <a href="#" class="dropdown-item"><i class="fas fa-cog me-2"></i> Account Settings</a>
                        <a href="#" class="dropdown-item"><i class="fas fa-power-off me-2"></i> Log Out</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->
<%--<!-- Topbar End -->--%>

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">

    <div class="container text-center py-5" style="max-width: 900px;">
        <h1 class="text-white display-3 mb-4">Réservation en Ligne</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="index.jsp">Accueil</a></li>
            <li class="breadcrumb-item"><a href="#">Pages</a></li>
            <li class="breadcrumb-item active text-white">Réservation</li>
        </ol>
    </div>

</div>
<!-- Header End -->

<!-- Messages de notification -->

<!-- Tour Booking Start -->
<div class="container-fluid booking py-5">
    <div class="container py-5">
        <div class="row g-5 align-items-center">
            <div class="col-lg-6">
                <h5 class="section-booking-title pe-3">Réservation</h5>
                <h1 class="text-white mb-4">Réservation en Ligne</h1>
                <p class="text-white mb-4">Réservez votre voyage en toute simplicité ! Notre système de réservation sécurisé vous permet de choisir votre destination, vos dates et de personnaliser votre séjour selon vos envies.
                </p>
                <p class="text-white mb-4">Bénéficiez de tarifs préférentiels, d'un support client 24h/7j et de la garantie d'un voyage inoubliable. Nos experts voyages vous accompagnent dans chaque étape de votre aventure.
                </p>

                <!--  -->


                <a href="contact.jsp" class="btn btn-light text-success rounded-pill py-3 px-5 mt-2">Nous contacter</a>
            </div>
            <div class="col-lg-6">
                <h1 class="text-white mb-3">Réservez votre Voyage</h1>
                <p class="text-white mb-4">Profitez de <span class="text-warning">prix exceptionnels</span> sur votre première aventure avec TripHive. Réservez maintenant !</p>



                    <% if (utilisateur != null) { %>
                    <!-- Formulaire pour utilisateur connecté -->
                    <form action="booking" method="POST">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="text" class="form-control bg-white border-0" id="name" name="name"
                                           value="<%= utilisateur.getNom() + " " + utilisateur.getPrenom() %>" required readonly>
                                    <label for="name">Votre nom</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="email" class="form-control bg-white border-0" id="email" name="email"
                                           value="<%= utilisateur.getEmail() %>" required readonly>
                                    <label for="email">Votre email</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <input type="date" class="form-control bg-white border-0" id="dateDepart" name="dateDepart" required
                                           min="<%= java.time.LocalDate.now().plusDays(1) %>">
                                    <label for="dateDepart">Date de départ</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <select class="form-select bg-white border-0" id="destinationId" name="destinationId" required>
                                        <option value="">Choisir une destination</option>
                                        <% if (destinations != null) {
                                            for (Destination dest : destinations) { %>
                                        <option value="<%= dest.getId() %>">
                                            <%= dest.getNom() %> - <%= dest.getPays() %>
                                            (<%= String.format("%.2f", dest.getPrix()) %> €)
                                        </option>
                                        <%  }
                                        } %>
                                    </select>
                                    <label for="destinationId">Destination</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <select class="form-select bg-white border-0" id="nbPersonnes" name="nbPersonnes" required>
                                        <option value="">Nombre de personnes</option>
                                        <option value="1">1 personne</option>
                                        <option value="2">2 personnes</option>
                                        <option value="3">3 personnes</option>
                                        <option value="4">4 personnes</option>
                                        <option value="5">5 personnes</option>
                                        <option value="6">6+ personnes</option>
                                    </select>
                                    <label for="nbPersonnes">Personnes</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <select class="form-select bg-white border-0" id="typeTour" name="typeTour">
                                        <option value="">Type de voyage</option>
                                        <option value="famille">Famille</option>
                                        <option value="couple">Couple</option>
                                        <option value="aventure">Aventure</option>
                                        <option value="detente">Détente</option>
                                        <option value="culture">Culture</option>
                                        <option value="nature">Nature</option>
                                    </select>
                                    <label for="typeTour">Catégorie</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-floating">
                    <textarea class="form-control bg-white border-0" placeholder="Demandes spéciales"
                              id="commentaires" name="commentaires" style="height: 100px"></textarea>
                                    <label for="commentaires">Demandes spéciales</label>
                                </div>
                            </div>
                            <div class="col-12">
                                <button class="btn btn-success text-white w-100 py-3" type="submit">
                                    <i class="fas fa-calendar-check me-2"></i>Confirmer la réservation
                                </button>
                            </div>
                        </div>
                    </form>
                    <% } else { %>
                    <!-- Message pour utilisateur non connecté -->
                    <div class="alert alert-warning">
                        <h5 class="text-dark"><i class="fas fa-user-lock me-2"></i>Connexion requise</h5>
                        <p class="text-dark mb-3">Vous devez être connecté pour effectuer une réservation.</p>
                        <a href="#" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">Se connecter</a>
                        <a href="#" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#registerModal">S'inscrire</a>
                    </div>
                    <% } %>
            </div>
        </div>
    </div>
</div>
<!-- Tour Booking End -->

<!-- Subscribe Start -->
<div class="container-fluid subscribe py-5">
    <div class="container text-center py-5">
        <div class="mx-auto text-center" style="max-width: 900px;">
            <h5 class="subscribe-title px-3">Newsletter</h5>
            <h1 class="text-white mb-4">Restez Informés</h1>
            <p class="text-white mb-5">Inscrivez-vous à notre newsletter pour recevoir nos dernières offres de voyage et conseils exclusifs directement dans votre boîte mail.
            </p>
            <div class="position-relative mx-auto">
                <input class="form-control border-success rounded-pill w-100 py-3 ps-4 pe-5" type="email" placeholder="Votre email">
                <button type="button" class="btn btn-success rounded-pill position-absolute top-0 end-0 py-2 px-4 mt-2 me-2">S'inscrire</button>
            </div>
        </div>
    </div>
</div>
<!-- Subscribe End -->

<!-- Footer Start -->
<div class="container-fluid footer py-5">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">Contact</h4>
                    <a href=""><i class="fas fa-home me-2"></i> 123 Rue de la Paix, Paris</a>
                    <a href="mailto:info@triphive.fr"><i class="fas fa-envelope me-2"></i> info@triphive.fr</a>
                    <a href="tel:+33123456789"><i class="fas fa-phone me-2"></i> +33 1 23 45 67 89</a>
                    <a href="" class="mb-3"><i class="fas fa-print me-2"></i> +33 1 23 45 67 90</a>
                    <div class="d-flex align-items-center">
                        <i class="fas fa-share fa-2x text-white me-2"></i>
                        <a class="btn-square btn btn-success rounded-circle mx-1" href=""><i class="fab fa-facebook-f"></i></a>
                        <a class="btn-square btn btn-success rounded-circle mx-1" href=""><i class="fab fa-twitter"></i></a>
                        <a class="btn-square btn btn-success rounded-circle mx-1" href=""><i class="fab fa-instagram"></i></a>
                        <a class="btn-square btn btn-success rounded-circle mx-1" href=""><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">Entreprise</h4>
                    <a href="about.jsp"><i class="fas fa-angle-right me-2"></i> À Propos</a>
                    <a href="#"><i class="fas fa-angle-right me-2"></i> Carrières</a>
                    <a href="blog.jsp"><i class="fas fa-angle-right me-2"></i> Blog</a>
                    <a href="#"><i class="fas fa-angle-right me-2"></i> Presse</a>
                    <a href="#"><i class="fas fa-angle-right me-2"></i> Partenaires</a>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">Support</h4>
                    <a href="contact.jsp"><i class="fas fa-angle-right me-2"></i> Contact</a>
                    <a href="#"><i class="fas fa-angle-right me-2"></i> Mentions Légales</a>
                    <a href="#"><i class="fas fa-angle-right me-2"></i> Politique de Confidentialité</a>
                    <a href="#"><i class="fas fa-angle-right me-2"></i> CGV</a>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item">
                    <h4 class="text-white mb-3">Moyens de Paiement</h4>
                    <div class="footer-bank-card">
                        <a href="#" class="text-white me-2"><i class="fab fa-cc-visa fa-2x"></i></a>
                        <a href="#" class="text-white me-2"><i class="fab fa-cc-mastercard fa-2x"></i></a>
                        <a href="#" class="text-white me-2"><i class="fab fa-cc-paypal fa-2x"></i></a>
                        <a href="#" class="text-white me-2"><i class="fab fa-cc-amex fa-2x"></i></a>
                        <a href="#" class="text-white"><i class="fas fa-credit-card fa-2x"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->

<!-- Copyright Start -->
<div class="container-fluid copyright text-body py-4">
    <div class="container">
        <div class="row g-4 align-items-center">
            <div class="col-md-6 text-center text-md-end mb-md-0">
                <i class="fas fa-copyright me-2"></i><a class="text-white" href="#">TripHive</a>, Tous droits réservés.
            </div>
            <div class="col-md-6 text-center text-md-start">
                Votre partenaire voyage de confiance
            </div>
        </div>
    </div>
</div>
<!-- Copyright End -->

<!-- Back to Top -->
<a href="#" class="btn btn-success btn-success-outline-0 btn-md-square back-to-top"><i class="fa fa-arrow-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script src="lib/lightbox/js/lightbox.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>
<!-- Modal Login -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Connexion</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="login" method="post">
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mot de passe</label>
                        <input type="password" class="form-control" name="motDePasse" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Se connecter</button>
                </form>
                <div class="text-center mt-3">
                    <small>Pas de compte ? <a href="#" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#registerModal">Créer un compte</a></small>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Register -->
<div class="modal fade" id="registerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Créer un compte</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="register" method="post">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Prénom</label>
                            <input type="text" class="form-control" name="prenom" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Nom</label>
                            <input type="text" class="form-control" name="nom" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mot de passe</label>
                        <input type="password" class="form-control" name="motDePasse" required>
                        <small class="text-muted">Minimum 6 caractères</small>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Confirmation</label>
                        <input type="password" class="form-control" name="confirmation" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Créer mon compte</button>
                </form>
                <div class="text-center mt-3">
                    <small>Déjà un compte ? <a href="#" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#loginModal">Se connecter</a></small>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

</html>