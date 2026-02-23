<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.visitonsmonde.model.*" %>
<%@ page import="java.util.List" %>
<%
  // Vérifier que l'utilisateur est admin
  Utilisateur admin = (Utilisateur) session.getAttribute("utilisateur");
  if (admin == null || !admin.isAdmin()) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
    return;
  }

  // Récupérer les données
  List<Destination> destinations = (List<Destination>) request.getAttribute("destinations");
  List<Pays> paysList = (List<Pays>) request.getAttribute("pays");
  List<Guide> guides = (List<Guide>) request.getAttribute("guides");
  List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
  List<TypeTour> typesTours = (List<TypeTour>) request.getAttribute("typesTours");

  String messageSucces = (String) request.getAttribute("messageSucces");
  String erreur = (String) request.getAttribute("erreur");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>Admin - VisitonsMonde</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <!-- Bootstrap CSS -->
  <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>

  <style>
    .admin-sidebar {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      color: white;
    }
    .admin-card {
      border-radius: 10px;
      box-shadow: 0 3px 10px rgba(0,0,0,0.1);
      transition: transform 0.3s;
    }
    .admin-card:hover {
      transform: translateY(-5px);
    }
    .stats-box {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border-radius: 10px;
      padding: 20px;
    }
  </style>
</head>
<body>

<div class="container-fluid">
  <div class="row">
    <!-- SIDEBAR -->
    <div class="col-md-2 admin-sidebar p-4">
      <h3 class="mb-4"><i class="fas fa-user-shield me-2"></i>Admin</h3>
      <p class="mb-4">Bonjour, <%= admin.getPrenom() %> !</p>

      <ul class="nav flex-column">
        <li class="nav-item mb-2">
          <a href="#destinations" class="nav-link text-white" data-bs-toggle="collapse">
            <i class="fas fa-map-marked-alt me-2"></i>Destinations
          </a>
        </li>
        <li class="nav-item mb-2">
          <a href="#reservations" class="nav-link text-white" data-bs-toggle="collapse">
            <i class="fas fa-calendar-check me-2"></i>Réservations
          </a>
        </li>
        <li class="nav-item mb-2">
          <a href="#guides" class="nav-link text-white" data-bs-toggle="collapse">
            <i class="fas fa-user-tie me-2"></i>Guides
          </a>
        </li>
        <li class="nav-item mb-2">
          <a href="#types-tours" class="nav-link text-white" data-bs-toggle="collapse">
            <i class="fas fa-tags me-2"></i>Types de Tours
          </a>
        </li>
      </ul>

      <hr class="my-4 bg-white">
      <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-light btn-sm mb-2 w-100">
        <i class="fas fa-home me-2"></i>Retour au site
      </a>
      <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm w-100">
        <i class="fas fa-sign-out-alt me-2"></i>Déconnexion
      </a>
    </div>

    <!-- CONTENU PRINCIPAL -->
    <div class="col-md-10 p-4">
      <h1 class="mb-4">Tableau de Bord Administrateur</h1>

      <!-- MESSAGES -->
      <% if (messageSucces != null) { %>
      <div class="alert alert-success alert-dismissible fade show">
        <i class="fas fa-check-circle me-2"></i><%= messageSucces %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
      <% } %>

      <% if (erreur != null) { %>
      <div class="alert alert-danger alert-dismissible fade show">
        <i class="fas fa-exclamation-circle me-2"></i><%= erreur %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
      <% } %>

      <!-- STATISTIQUES -->
      <div class="row g-4 mb-5">
        <div class="col-md-3">
          <div class="stats-box">
            <h3><%= destinations != null ? destinations.size() : 0 %></h3>
            <p class="mb-0"><i class="fas fa-map-marked-alt me-2"></i>Destinations</p>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stats-box">
            <h3><%= reservations != null ? reservations.size() : 0 %></h3>
            <p class="mb-0"><i class="fas fa-calendar-check me-2"></i>Réservations</p>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stats-box">
            <h3><%= guides != null ? guides.size() : 0 %></h3>
            <p class="mb-0"><i class="fas fa-user-tie me-2"></i>Guides</p>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stats-box">
            <h3><%= typesTours != null ? typesTours.size() : 0 %></h3>
            <p class="mb-0"><i class="fas fa-tags me-2"></i>Types Tours</p>
          </div>
        </div>
      </div>

      <!-- GESTION DESTINATIONS -->
      <div class="collapse show" id="destinations">
        <div class="admin-card p-4 mb-5">
          <h3 class="mb-4"><i class="fas fa-map-marked-alt me-2"></i>Gestion des Destinations</h3>

          <!-- Bouton Ajouter -->
          <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#ajouterDestinationModal">
            <i class="fas fa-plus me-2"></i>Ajouter une destination
          </button>

          <!-- Tableau -->
          <div class="table-responsive">
            <table class="table table-hover">
              <thead class="table-dark">
              <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Pays</th>
                <th>Prix</th>
                <th>Photos</th>
                <th>Actions</th>
              </tr>
              </thead>
              <tbody>
              <% if (destinations != null && !destinations.isEmpty()) {
                for (Destination dest : destinations) { %>
              <tr>
                <td><%= dest.getId() %></td>
                <td><%= dest.getNom() %></td>
                <td><%= dest.getPays() != null ? dest.getPays() : "-" %></td>
                <td><%= dest.getPrix() != null ? String.format("%.2f €", dest.getPrix()) : "-" %></td>
                <td><%= dest.getNbPhotos() %></td>
                <td>
                  <button class="btn btn-sm btn-warning" onclick="modifierDestination(<%= dest.getId() %>)">
                    <i class="fas fa-edit"></i>
                  </button>
                  <button class="btn btn-sm btn-danger" onclick="supprimerDestination(<%= dest.getId() %>, '<%= dest.getNom() %>')">
                    <i class="fas fa-trash"></i>
                  </button>
                </td>
              </tr>
              <% }
              } else { %>
              <tr>
                <td colspan="6" class="text-center">Aucune destination</td>
              </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- GESTION RÉSERVATIONS -->
      <!-- GESTION RÉSERVATIONS -->
      <div class="collapse" id="reservations">
        <div class="admin-card p-4 mb-5">
          <h3 class="mb-4"><i class="fas fa-calendar-check me-2"></i>Gestion des Réservations</h3>

          <div class="table-responsive">
            <table class="table table-hover">
              <thead class="table-dark">
              <tr>
                <th>Numéro</th>
                <th>Client ID</th>
                <th>Destination ID</th>
                <th>Date Départ</th>
                <th>Prix Total</th>
                <th>Statut</th>
                <th>Actions</th>
              </tr>
              </thead>
              <tbody>
              <% if (reservations != null && !reservations.isEmpty()) {
                for (Reservation res : reservations) { %>
              <tr>
                <td><code><%= res.getNumeroReservation() %></code></td>
                <td>Client #<%= res.getUtilisateurId() %></td>
                <td>Dest. #<%= res.getDestinationId() %></td>
                <td><%= res.getDateDepart() %></td>
                <td><%= String.format("%.2f €", res.getPrixTotal()) %></td>
                <td>
                  <% if ("en_attente".equals(res.getStatut())) { %>
                  <span class="badge bg-warning">En attente</span>
                  <% } else if ("confirmee".equals(res.getStatut())) { %>
                  <span class="badge bg-success">Confirmée</span>
                  <% } else if ("annulee".equals(res.getStatut())) { %>
                  <span class="badge bg-danger">Annulée</span>
                  <% } else { %>
                  <span class="badge bg-secondary"><%= res.getStatut() %></span>
                  <% } %>
                </td>
                <td>
                  <% if (!"confirmee".equals(res.getStatut())) { %>
                  <form method="post" action="admin" style="display:inline;">
                    <input type="hidden" name="action" value="reservation-confirmer">
                    <input type="hidden" name="id" value="<%= res.getId() %>">
                    <button type="submit" class="btn btn-sm btn-success" title="Confirmer">
                      <i class="fas fa-check"></i>
                    </button>
                  </form>
                  <% } %>

                  <% if (!"annulee".equals(res.getStatut())) { %>
                  <form method="post" action="admin" style="display:inline;">
                    <input type="hidden" name="action" value="reservation-annuler">
                    <input type="hidden" name="id" value="<%= res.getId() %>">
                    <button type="submit" class="btn btn-sm btn-danger" title="Annuler">
                      <i class="fas fa-times"></i>
                    </button>
                  </form>
                  <% } %>
                </td>
              </tr>
              <% }
              } else { %>
              <tr>
                <td colspan="7" class="text-center">Aucune réservation</td>
              </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- MODAL AJOUTER DESTINATION -->
<div class="modal fade" id="ajouterDestinationModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title">Ajouter une Destination</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <form method="post" action="admin">
        <div class="modal-body">
          <input type="hidden" name="action" value="destination-ajouter">

          <div class="mb-3">
            <label class="form-label">Nom *</label>
            <input type="text" class="form-control" name="nom" required>
          </div>

          <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea class="form-control" name="description" rows="3"></textarea>
          </div>

          <div class="mb-3">
            <label class="form-label">Image (nom fichier)</label>
            <input type="text" class="form-control" name="image" placeholder="destination-1.jpg">
          </div>

          <div class="mb-3">
            <label class="form-label">Pays</label>
            <select class="form-select" name="paysId">
              <option value="">-- Choisir --</option>
              <% if (paysList != null) {
                for (Pays p : paysList) { %>
              <option value="<%= p.getId() %>"><%= p.getNom() %></option>
              <% }
              } %>
            </select>
          </div>

          <div class="mb-3">
            <label class="form-label">Prix (€)</label>
            <input type="number" step="0.01" class="form-control" name="prix">
          </div>

          <div class="mb-3">
            <label class="form-label">Nombre de photos</label>
            <input type="number" class="form-control" name="nbPhotos" value="0">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
          <button type="submit" class="btn btn-primary">Ajouter</button>
        </div>
      </form>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function supprimerDestination(id, nom) {
    if (confirm('Supprimer la destination "' + nom + '" ?')) {
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'admin';
      form.innerHTML = '<input type="hidden" name="action" value="destination-supprimer">' +
              '<input type="hidden" name="id" value="' + id + '">';
      document.body.appendChild(form);
      form.submit();
    }
  }
</script>
</body>
</html>