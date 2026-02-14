<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 17/05/2025
  Time: 00:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Footer Start -->
<div class="container-fluid footer py-5">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">VisitonsMonde</h4>
                    <p class="text-white">Votre agence de voyage pour découvrir le monde avec des guides professionnels.</p>
                    <div class="d-flex align-items-center">
                        <i class="fas fa-share fa-2x text-white me-2"></i>
                        <a class="btn-square btn btn-primary rounded-circle mx-1" href="#">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a class="btn-square btn btn-primary rounded-circle mx-1" href="#">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a class="btn-square btn btn-primary rounded-circle mx-1" href="#">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a class="btn-square btn btn-primary rounded-circle mx-1" href="#">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">Entreprise</h4>
                    <a href="${pageContext.request.contextPath}/about.jsp">
                        <i class="fas fa-angle-right me-2"></i> À Propos
                    </a>
                    <a href="${pageContext.request.contextPath}/destinations">
                        <i class="fas fa-angle-right me-2"></i> Destinations
                    </a>
                    <a href="${pageContext.request.contextPath}/guides.jsp">
                        <i class="fas fa-angle-right me-2"></i> Nos Guides
                    </a>
                    <a href="${pageContext.request.contextPath}/contact.jsp">
                        <i class="fas fa-angle-right me-2"></i> Contact
                    </a>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">Support</h4>
                    <a href="${pageContext.request.contextPath}/contact.jsp">
                        <i class="fas fa-angle-right me-2"></i> Support Client
                    </a>
                    <a href="#">
                        <i class="fas fa-angle-right me-2"></i> Conditions d'utilisation
                    </a>
                    <a href="#">
                        <i class="fas fa-angle-right me-2"></i> Politique de confidentialité
                    </a>
                    <a href="${pageContext.request.contextPath}/devenir-guide">
                        <i class="fas fa-angle-right me-2"></i> Devenir Guide
                    </a>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-xl-3">
                <div class="footer-item d-flex flex-column">
                    <h4 class="mb-4 text-white">Contact</h4>
                    <a href="#">
                        <i class="fa fa-map-marker-alt me-2"></i> Paris, France
                    </a>
                    <a href="mailto:contact@visitonsmonde.com">
                        <i class="fas fa-envelope me-2"></i> contact@visitonsmonde.com
                    </a>
                    <a href="tel:+33123456789">
                        <i class="fas fa-phone me-2"></i> +33 1 23 45 67 89
                    </a>
                    <a href="#" class="mb-3">
                        <i class="fas fa-print me-2"></i> +33 1 23 45 67 90
                    </a>
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
            <div class="col-md-6 text-center text-md-start mb-md-0">
                <span class="text-white">
                    <a href="#"><i class="fas fa-copyright text-light me-2"></i>VisitonsMonde</a>,
                    Tous droits réservés <%= java.time.Year.now().getValue() %>.
                </span>
            </div>
            <div class="col-md-6 text-center text-md-end text-white">
                Conçu avec <i class="fas fa-heart text-danger"></i> par VisitonsMonde
            </div>
        </div>
    </div>
</div>
<!-- Copyright End -->

<!-- Back to Top -->
<a href="#" class="btn btn-primary btn-primary-outline-0 btn-md-square back-to-top">
    <i class="fa fa-arrow-up"></i>
</a>