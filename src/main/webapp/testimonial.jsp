<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.Testimonial" %>
<%@ page import="java.util.List" %>
<%
    List<Testimonial> testimonials = (List<Testimonial>) request.getAttribute("testimonials");
    if (testimonials == null) testimonials = new java.util.ArrayList<>();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Témoignages - VisitonsMonde</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="témoignages clients, avis voyages" name="keywords">
    <meta content="Découvrez ce que nos clients disent de leurs expériences avec VisitonsMonde" name="description">

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
</head>
<body>

<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Chargement...</span>
    </div>
</div>
<!-- Spinner End -->

<jsp:include page="navbar.jsp" />

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h3 class="text-white display-3 mb-4">Témoignages Clients</h3>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="index.jsp">Accueil</a></li>
            <li class="breadcrumb-item"><a href="#">Pages</a></li>
            <li class="breadcrumb-item active text-white">Témoignages</li>
        </ol>
    </div>
</div>
<!-- Header End -->

<!-- Testimonial Start -->
<div class="container-fluid testimonial py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">Témoignages</h5>
            <h1 class="mb-0">Ce Que Nos Clients Disent !!!</h1>
        </div>

        <% if (testimonials.isEmpty()) { %>
        <!-- Témoignages par défaut si BDD vide -->
        <div class="testimonial-carousel owl-carousel">
            <div class="testimonial-item text-center rounded pb-4">
                <div class="testimonial-comment bg-light rounded p-4">
                    <p class="text-center mb-5">Un voyage extraordinaire organisé de A à Z avec une attention aux détails impressionnante. L'équipe de VisitonsMonde a su transformer notre lune de miel en un moment magique et inoubliable. Merci infiniment !</p>
                </div>
                <div class="testimonial-img p-1">
                    <img src="${pageContext.request.contextPath}/img/testimonial-1.jpg" class="img-fluid rounded-circle" alt="Jean Martin">
                </div>
                <div style="margin-top: -35px;">
                    <h5 class="mb-0">Jean Martin</h5>
                    <p class="mb-0">Paris, France</p>
                    <div class="d-flex justify-content-center">
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                    </div>
                </div>
            </div>
            <div class="testimonial-item text-center rounded pb-4">
                <div class="testimonial-comment bg-light rounded p-4">
                    <p class="text-center mb-5">Service impeccable du début à la fin ! Les guides étaient excellents, les hôtels soigneusement sélectionnés et l'itinéraire parfaitement adapté à nos envies. Une expérience 5 étoiles que je recommande vivement.</p>
                </div>
                <div class="testimonial-img p-1">
                    <img src="${pageContext.request.contextPath}/img/testimonial-2.jpg" class="img-fluid rounded-circle" alt="Sarah Johnson">
                </div>
                <div style="margin-top: -35px;">
                    <h5 class="mb-0">Sarah Johnson</h5>
                    <p class="mb-0">New York, USA</p>
                    <div class="d-flex justify-content-center">
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                    </div>
                </div>
            </div>
            <div class="testimonial-item text-center rounded pb-4">
                <div class="testimonial-comment bg-light rounded p-4">
                    <p class="text-center mb-5">Après avoir visité 15 pays avec VisitonsMonde, je peux affirmer que c'est la meilleure agence de voyage avec qui j'ai eu la chance de travailler. Professionnalisme, disponibilité et passion du voyage sont leurs maîtres-mots.</p>
                </div>
                <div class="testimonial-img p-1">
                    <img src="${pageContext.request.contextPath}/img/testimonial-3.jpg" class="img-fluid rounded-circle" alt="Carlos Lopez">
                </div>
                <div style="margin-top: -35px;">
                    <h5 class="mb-0">Carlos Lopez</h5>
                    <p class="mb-0">Madrid, Espagne</p>
                    <div class="d-flex justify-content-center">
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                    </div>
                </div>
            </div>
            <div class="testimonial-item text-center rounded pb-4">
                <div class="testimonial-comment bg-light rounded p-4">
                    <p class="text-center mb-5">En tant que voyageuse solo, j'appréciais particulièrement la sécurité et le confort qu'offre VisitonsMonde. Chaque détail était pensé pour rendre mon expérience unique. Je recommande à 200% pour tous types de voyageurs !</p>
                </div>
                <div class="testimonial-img p-1">
                    <img src="${pageContext.request.contextPath}/img/testimonial-4.jpg" class="img-fluid rounded-circle" alt="Emma Wilson">
                </div>
                <div style="margin-top: -35px;">
                    <h5 class="mb-0">Emma Wilson</h5>
                    <p class="mb-0">Londres, UK</p>
                    <div class="d-flex justify-content-center">
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                        <i class="fas fa-star text-primary"></i>
                    </div>
                </div>
            </div>
        </div>
        <% } else { %>
        <!-- Témoignages depuis BDD -->
        <div class="testimonial-carousel owl-carousel">
            <% for (Testimonial t : testimonials) { %>
            <div class="testimonial-item text-center rounded pb-4">
                <div class="testimonial-comment bg-light rounded p-4">
                    <p class="text-center mb-5"><%= t.getCommentaire() %></p>
                </div>
                <div class="testimonial-img p-1">
                    <img src="${pageContext.request.contextPath}/img/<%= t.getPhoto() %>"
                         class="img-fluid rounded-circle"
                         alt="<%= t.getNom() %>">
                </div>
                <div style="margin-top: -35px;">
                    <h5 class="mb-0"><%= t.getNom() %></h5>
                    <p class="mb-0"><%= t.getLocation() %></p>
                    <div class="d-flex justify-content-center">
                        <% for(int i = 0; i < t.getNote(); i++) { %>
                        <i class="fas fa-star text-primary"></i>
                        <% } %>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
</div>
<!-- Testimonial End -->

<!-- Subscribe Start -->
<div class="container-fluid subscribe py-5">
    <div class="container text-center py-5">
        <div class="mx-auto text-center" style="max-width: 900px;">
            <h5 class="subscribe-title px-3">Newsletter</h5>
            <h1 class="text-white mb-4">Rejoignez Notre Communauté</h1>
            <p class="text-white mb-5">Abonnez-vous pour recevoir nos offres exclusives, conseils de voyage et inspirations. Plus de 50,000 voyageurs satisfaits nous font confiance.</p>
            <div class="position-relative mx-auto">
                <input class="form-control border-primary rounded-pill w-100 py-3 ps-4 pe-5" type="email" placeholder="Votre adresse email">
                <button type="button" class="btn btn-primary rounded-pill position-absolute top-0 end-0 py-2 px-4 mt-2 me-2">S'abonner</button>
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