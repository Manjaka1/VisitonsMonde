<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.Destination" %>
<%@ page import="java.util.List" %>
<%
    List<Destination> destinations = (List<Destination>) request.getAttribute("destinations");
    if (destinations == null) {
        destinations = new java.util.ArrayList<>();
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <title>Destinations - VisitonsMonde</title>
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
        .search-box {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 30px;
        }
        .search-input {
            border-radius: 50px;
            border: 2px solid #e0e0e0;
            padding: 12px 25px;
            font-size: 16px;
            transition: all 0.3s;
        }
        .search-input:focus {
            border-color: #13357B;
            box-shadow: 0 0 0 0.2rem rgba(19, 53, 123, 0.25);
        }
        .destination-card {
            transition: all 0.3s ease;
        }
        .destination-card.hidden {
            display: none;
        }
        .badge-results {
            font-size: 1rem;
            padding: 10px 20px;
            border-radius: 50px;
        }
    </style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<!-- Header Start -->
<div class="container-fluid bg-breadcrumb">
    <div class="container text-center py-5" style="max-width: 900px;">
        <h3 class="text-white display-3 mb-4">Nos Destinations</h3>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="index.jsp">Accueil</a></li>
            <li class="breadcrumb-item active text-white">Destinations</li>
        </ol>
    </div>
</div>
<!-- Header End -->

<!-- Destination Start -->
<div class="container-fluid py-5">
    <div class="container py-5">
        <div class="mx-auto text-center mb-5" style="max-width: 900px;">
            <h5 class="section-title px-3">Destinations</h5>
            <h1 class="mb-0">Découvrez nos destinations</h1>
        </div>

        <!-- BARRE DE RECHERCHE -->
        <div class="search-box">
            <div class="row g-3">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="fas fa-search text-primary"></i>
                        </span>
                        <input type="text"
                               id="searchInput"
                               class="form-control search-input border-start-0"
                               placeholder="Rechercher une destination..."
                               onkeyup="rechercherDestinations()">
                    </div>
                </div>
                <div class="col-md-4">
                    <select id="paysFilter" class="form-select search-input" onchange="rechercherDestinations()">
                        <option value="">Tous les pays</option>
                        <%
                            // Extraire la liste unique des pays
                            java.util.Set<String> paysUniques = new java.util.TreeSet<>();
                            for (Destination d : destinations) {
                                if (d.getPays() != null && !d.getPays().isEmpty()) {
                                    paysUniques.add(d.getPays());
                                }
                            }
                            for (String pays : paysUniques) {
                        %>
                        <option value="<%= pays %>"><%= pays %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-3">
                    <select id="prixFilter" class="form-select search-input" onchange="rechercherDestinations()">
                        <option value="">Tous les prix</option>
                        <option value="0-500">Moins de 500€</option>
                        <option value="500-1000">500€ - 1000€</option>
                        <option value="1000-2000">1000€ - 2000€</option>
                        <option value="2000-99999">Plus de 2000€</option>
                    </select>
                </div>
            </div>
            <div class="text-center mt-3">
                <span class="badge bg-success badge-results" id="resultsCount">
                    <%= destinations.size() %> destinations disponibles
                </span>
            </div>
        </div>

        <!-- LISTE DES DESTINATIONS -->
        <div class="row g-4" id="destinationsContainer">
            <%
                if (destinations != null && !destinations.isEmpty()) {
                    for (Destination dest : destinations) {
            %>
            <div class="col-lg-4 col-md-6 destination-card"
                 data-nom="<%= dest.getNom().toLowerCase() %>"
                 data-pays="<%= dest.getPays() != null ? dest.getPays() : "" %>"
                 data-prix="<%= dest.getPrix() != null ? dest.getPrix() : 0 %>">
                <div class="card h-100 shadow-sm">
                    <img class="card-img-top"
                         src="${pageContext.request.contextPath}/img/<%= dest.getImage() != null && !dest.getImage().isEmpty() ? dest.getImage() : "default-destination.jpg" %>"
                         alt="<%= dest.getNom() %>"
                         onerror="this.src='${pageContext.request.contextPath}/img/default-destination.jpg'"
                         style="height: 250px; object-fit: cover;">

                    <div class="card-body">
                        <h5 class="card-title"><%= dest.getNom() %></h5>
                        <p class="card-text text-muted">
                            <i class="fa fa-map-marker-alt me-2"></i>
                            <%= dest.getPays() != null ? dest.getPays() : "International" %>
                        </p>
                        <% if (dest.getPrix() != null) { %>
                        <p class="text-primary fw-bold fs-5">
                            À partir de <%= String.format("%.0f", dest.getPrix()) %> €
                        </p>
                        <% } %>
                        <a href="destination-details?id=<%= dest.getId() %>"
                           class="btn btn-primary w-100">
                            <i class="fa fa-eye me-2"></i>Voir les détails
                        </a>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="col-12">
                <div class="alert alert-info text-center py-5">
                    <i class="fas fa-info-circle fa-3x mb-3"></i>
                    <h4>Aucune destination disponible</h4>
                    <p>Revenez bientôt pour découvrir nos merveilleuses destinations !</p>
                </div>
            </div>
            <% } %>
        </div>

        <!-- MESSAGE SI AUCUN RÉSULTAT -->
        <div id="noResults" class="col-12" style="display: none;">
            <div class="alert alert-warning text-center py-5">
                <i class="fas fa-search fa-3x mb-3"></i>
                <h4>Aucune destination trouvée</h4>
                <p>Essayez d'autres critères de recherche.</p>
                <button class="btn btn-primary" onclick="resetRecherche()">
                    <i class="fas fa-redo me-2"></i>Réinitialiser la recherche
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Destination End -->

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
    // ========================================
    // FONCTION DE RECHERCHE DYNAMIQUE
    // ========================================
    function rechercherDestinations() {
        const searchText = document.getElementById('searchInput').value.toLowerCase();
        const paysFilter = document.getElementById('paysFilter').value;
        const prixFilter = document.getElementById('prixFilter').value;

        const cards = document.querySelectorAll('.destination-card');
        let visibleCount = 0;

        cards.forEach(card => {
            const nom = card.getAttribute('data-nom');
            const pays = card.getAttribute('data-pays');
            const prix = parseFloat(card.getAttribute('data-prix'));

            let showCard = true;

            // Filtre par texte (nom)
            if (searchText && !nom.includes(searchText)) {
                showCard = false;
            }

            // Filtre par pays
            if (paysFilter && pays !== paysFilter) {
                showCard = false;
            }

            // Filtre par prix
            if (prixFilter) {
                const [min, max] = prixFilter.split('-').map(Number);
                if (prix < min || prix > max) {
                    showCard = false;
                }
            }

            // Afficher ou cacher la carte
            if (showCard) {
                card.classList.remove('hidden');
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.classList.add('hidden');
                card.style.display = 'none';
            }
        });

        // Mettre à jour le compteur
        const resultsCount = document.getElementById('resultsCount');
        resultsCount.textContent = visibleCount + ' destination' + (visibleCount > 1 ? 's' : '') + ' trouvée' + (visibleCount > 1 ? 's' : '');

        // Afficher message "Aucun résultat"
        const noResults = document.getElementById('noResults');
        if (visibleCount === 0) {
            noResults.style.display = 'block';
        } else {
            noResults.style.display = 'none';
        }
    }

    // ========================================
    // RÉINITIALISER LA RECHERCHE
    // ========================================
    function resetRecherche() {
        document.getElementById('searchInput').value = '';
        document.getElementById('paysFilter').value = '';
        document.getElementById('prixFilter').value = '';
        rechercherDestinations();
    }

    // ========================================
    // INITIALISATION AU CHARGEMENT
    // ========================================
    document.addEventListener('DOMContentLoaded', function() {
        console.log('✅ Recherche de destinations initialisée');
    });
</script>
</body>
</html>