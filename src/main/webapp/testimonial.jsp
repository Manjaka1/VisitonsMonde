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
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5">
        <h3 class="text-white display-3">Témoignages</h3>
    </div>
</div>

<div class="container-fluid testimonial py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">TÉMOIGNAGES</h5>
            <h1 class="mb-0">Ce Que Nos Clients Disent</h1>
        </div>

        <div class="testimonial-carousel owl-carousel">
            <% for (Testimonial t : testimonials) { %>
            <div class="testimonial-item text-center rounded pb-4">
                <div class="testimonial-comment bg-light rounded p-4">
                    <p class="text-center mb-5"><%= t.getCommentaire() %></p>
                </div>
                <div class="testimonial-img p-1">
                    <img src="${pageContext.request.contextPath}/img/<%= t.getPhoto() %>" class="img-fluid rounded-circle" alt="<%= t.getNom() %>">
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
    </div>
</div>

<jsp:include page="footer.jsp" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>