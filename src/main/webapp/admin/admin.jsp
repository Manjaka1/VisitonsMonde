<%--
  Created by IntelliJ IDEA.
  User: manjaka
  Date: 18/07/2025
  Time: 22:42
  To change this template use File | Settings | File Templates.
--%>
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

  if (destinations == null) destinations = new java.util.ArrayList<>();
  if (paysList == null) paysList = new java.util.ArrayList<>();
  if (guides == null) guides = new java.util.ArrayList<>();
  if (reservations == null) reservations = new java.util.ArrayList<>();
  if (typesTours == null) typesTours = new java.util.ArrayList<>();
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
      </ul>

      <hr class="my-4 bg-white">
      <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-light btn-sm">
        <i class="fas fa-home me-2"></i>Retour au site
      </a>
    </div>

    <!-- CONTENU PRINCIPAL -->
    <div class="col-md-10 p-4">
      <h1 class="mb-4">🎯 Tableau de Bord Administrateur</h1>

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
      <!-- STATISTIQUES AMÉLIORÉES -->
      <div class="row g-4 mb-5">
        <div class="col-md-3">
          <div class="stats-box" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
            <i class="fas fa-map-marked-alt fa-3x mb-3"></i>
            <h2><%= destinations.size() %></h2>
            <p class="mb-0">Destinations</p>
            <small class="text-white-50">+<%= destinations.size() > 0 ? "2" : "0" %> ce mois</small>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stats-box" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
            <i class="fas fa-calendar-check fa-3x mb-3"></i>
            <h2><%= reservations.size() %></h2>
            <p class="mb-0">Réservations</p>
            <%
              int reservationsConfirmees = 0;
              for (Reservation r : reservations) {
                if ("confirmee".equals(r.getStatut())) reservationsConfirmees++;
              }
            %>
            <small class="text-white-50"><%= reservationsConfirmees %> confirmées</small>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stats-box" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
            <i class="fas fa-user-tie fa-3x mb-3"></i>
            <h2><%= guides.size() %></h2>
            <p class="mb-0">Guides</p>
            <%
              int guidesActifs = 0;
              for (Guide g : guides) {
                if ("ACTIF".equals(g.getStatut())) guidesActifs++;
              }
            %>
            <small class="text-white-50"><%= guidesActifs %> actifs</small>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stats-box" style="background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);">
            <i class="fas fa-euro-sign fa-3x mb-3"></i>
            <%
              double revenuTotal = 0;
              for (Reservation r : reservations) {
                if ("confirmee".equals(r.getStatut())) {
                  revenuTotal += r.getPrixTotal().doubleValue();
                }
              }
            %>
            <h2><%= String.format("%.0f", revenuTotal) %>€</h2>
            <p class="mb-0">Revenus</p>
            <small class="text-white-50">Réservations confirmées</small>
          </div>
        </div>
      </div>

      <!-- GRAPHIQUES -->
      <div class="row g-4 mb-5">
        <!-- Graphique Guides -->
        <div class="col-lg-6">
          <div class="admin-card p-4">
            <h4 class="mb-4"><i class="fas fa-chart-pie text-primary me-2"></i>Répartition des Guides</h4>
            <canvas id="guidesChart" style="max-height: 300px;"></canvas>
          </div>
        </div>

        <!-- Graphique Réservations -->
        <div class="col-lg-6">
          <div class="admin-card p-4">
            <h4 class="mb-4"><i class="fas fa-chart-bar text-success me-2"></i>Statut des Réservations</h4>
            <canvas id="reservationsChart" style="max-height: 300px;"></canvas>
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
              <% if (!destinations.isEmpty()) {
                for (Destination dest : destinations) { %>
              <tr>
                <td><%= dest.getId() %></td>
                <td><%= dest.getNom() %></td>
                <td><%= dest.getPays() != null ? dest.getPays() : "-" %></td>
                <td><%= dest.getPrix() != null ? String.format("%.2f €", dest.getPrix()) : "-" %></td>
                <td><%= dest.getNbPhotos() %></td>
                <td>
                  <button class="btn btn-sm btn-warning" title="Modifier">
                    <i class="fas fa-edit"></i>
                  </button>
                  <button class="btn btn-sm btn-danger" onclick="supprimerDestination(<%= dest.getId() %>, '<%= dest.getNom() %>')" title="Supprimer">
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

      <!-- GESTION GUIDES -->
      <div class="collapse" id="guides">
        <div class="admin-card p-4 mb-5">
          <h3 class="mb-4"><i class="fas fa-user-tie me-2"></i>Gestion des Guides</h3>

          <!-- Filtres -->
          <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
              <a class="nav-link active" data-bs-toggle="tab" href="#guides-attente">
                En Attente <span class="badge bg-warning ms-2">
                    <%
                      int countAttente = 0;
                      for (Guide g : guides) {
                        if ("EN_ATTENTE".equals(g.getStatut())) countAttente++;
                      }
                    %>
                    <%= countAttente %>
                    </span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" data-bs-toggle="tab" href="#guides-actifs">
                Actifs <span class="badge bg-success ms-2">
                    <%
                      int countActifs = 0;
                      for (Guide g : guides) {
                        if ("ACTIF".equals(g.getStatut())) countActifs++;
                      }
                    %>
                    <%= countActifs %>
                    </span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" data-bs-toggle="tab" href="#guides-tous">
                Tous <span class="badge bg-secondary ms-2"><%= guides.size() %></span>
              </a>
            </li>
          </ul>

          <div class="tab-content">
            <!-- GUIDES EN ATTENTE -->
            <div class="tab-pane fade show active" id="guides-attente">
              <div class="table-responsive">
                <table class="table table-hover">
                  <thead class="table-warning">
                  <tr>
                    <th>Nom Complet</th>
                    <th>Email</th>
                    <th>Spécialité</th>
                    <th>Expérience</th>
                    <th>Langues</th>
                    <th>Date Inscription</th>
                    <th>Actions</th>
                  </tr>
                  </thead>
                  <tbody>
                  <%
                    boolean hasAttente = false;
                    for (Guide guide : guides) {
                      if ("EN_ATTENTE".equals(guide.getStatut())) {
                        hasAttente = true;
                  %>
                  <tr>
                    <td><strong><%= guide.getNomComplet() %></strong></td>
                    <td><%= guide.getEmail() %></td>
                    <td><%= guide.getSpecialite() != null ? guide.getSpecialite() : "-" %></td>
                    <td><%= guide.getExperienceAnnees() %> ans</td>
                    <td><%= guide.getLanguesParlees() != null ? guide.getLanguesParlees() : "-" %></td>
                    <td><%= guide.getDateInscription() != null ? guide.getDateInscription() : "-" %></td>
                    <td>
                      <form method="post" action="admin" style="display:inline;">
                        <input type="hidden" name="action" value="guide-approuver">
                        <input type="hidden" name="id" value="<%= guide.getId() %>">
                        <button type="submit" class="btn btn-sm btn-success" title="Approuver">
                          <i class="fas fa-check"></i> Approuver
                        </button>
                      </form>
                      <form method="post" action="admin" style="display:inline;">
                        <input type="hidden" name="action" value="guide-refuser">
                        <input type="hidden" name="id" value="<%= guide.getId() %>">
                        <button type="submit" class="btn btn-sm btn-danger" title="Refuser">
                          <i class="fas fa-times"></i> Refuser
                        </button>
                      </form>
                    </td>
                  </tr>
                  <%
                      }
                    }
                    if (!hasAttente) {
                  %>
                  <tr>
                    <td colspan="7" class="text-center">Aucun guide en attente</td>
                  </tr>
                  <% } %>
                  </tbody>
                </table>
              </div>
            </div>

            <!-- GUIDES ACTIFS -->
            <div class="tab-pane fade" id="guides-actifs">
              <div class="table-responsive">
                <table class="table table-hover">
                  <thead class="table-success">
                  <tr>
                    <th>Nom Complet</th>
                    <th>Email</th>
                    <th>Spécialité</th>
                    <th>Note</th>
                    <th>Actions</th>
                  </tr>
                  </thead>
                  <tbody>
                  <%
                    boolean hasActifs = false;
                    for (Guide guide : guides) {
                      if ("ACTIF".equals(guide.getStatut())) {
                        hasActifs = true;
                  %>
                  <tr>
                    <td><strong><%= guide.getNomComplet() %></strong></td>
                    <td><%= guide.getEmail() %></td>
                    <td><%= guide.getSpecialite() != null ? guide.getSpecialite() : "-" %></td>
                    <td>
                      <% if (guide.getNoteMoyenne() != null) { %>
                      <span class="badge bg-primary"><%= guide.getNoteMoyenne() %> ⭐</span>
                      <% } else { %>
                      <span class="text-muted">Pas encore noté</span>
                      <% } %>
                    </td>
                    <td>
                      <form method="post" action="admin" style="display:inline;">
                        <input type="hidden" name="action" value="guide-suspendre">
                        <input type="hidden" name="id" value="<%= guide.getId() %>">
                        <button type="submit" class="btn btn-sm btn-warning" title="Suspendre">
                          <i class="fas fa-pause"></i> Suspendre
                        </button>
                      </form>
                    </td>
                  </tr>
                  <%
                      }
                    }
                    if (!hasActifs) {
                  %>
                  <tr>
                    <td colspan="5" class="text-center">Aucun guide actif</td>
                  </tr>
                  <% } %>
                  </tbody>
                </table>
              </div>
            </div>

            <!-- TOUS LES GUIDES -->
            <div class="tab-pane fade" id="guides-tous">
              <div class="table-responsive">
                <table class="table table-hover">
                  <thead class="table-dark">
                  <tr>
                    <th>ID</th>
                    <th>Nom Complet</th>
                    <th>Email</th>
                    <th>Spécialité</th>
                    <th>Statut</th>
                  </tr>
                  </thead>
                  <tbody>
                  <% if (!guides.isEmpty()) {
                    for (Guide guide : guides) { %>
                  <tr>
                    <td><%= guide.getId() %></td>
                    <td><%= guide.getNomComplet() %></td>
                    <td><%= guide.getEmail() %></td>
                    <td><%= guide.getSpecialite() != null ? guide.getSpecialite() : "-" %></td>
                    <td>
                      <% if ("EN_ATTENTE".equals(guide.getStatut())) { %>
                      <span class="badge bg-warning">En attente</span>
                      <% } else if ("ACTIF".equals(guide.getStatut())) { %>
                      <span class="badge bg-success">Actif</span>
                      <% } else if ("SUSPENDU".equals(guide.getStatut())) { %>
                      <span class="badge bg-danger">Suspendu</span>
                      <% } else if ("INACTIF".equals(guide.getStatut())) { %>
                      <span class="badge bg-secondary">Inactif</span>
                      <% } else { %>
                      <span class="badge bg-secondary"><%= guide.getStatut() %></span>
                      <% } %>
                    </td>
                  </tr>
                  <% }
                  } else { %>
                  <tr>
                    <td colspan="5" class="text-center">Aucun guide</td>
                  </tr>
                  <% } %>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>

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
              <% if (!reservations.isEmpty()) {
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
              <% for (Pays p : paysList) { %>
              <option value="<%= p.getId() %>"><%= p.getNom() %></option>
              <% } %>
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
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<script>
  // Données pour le graphique des guides
  <%
      int countEnAttente = 0, countActif = 0, countSuspendu = 0, countInactif = 0;
      for (Guide g : guides) {
          String statut = g.getStatut();
          if ("EN_ATTENTE".equals(statut)) countEnAttente++;
          else if ("ACTIF".equals(statut)) countActif++;
          else if ("SUSPENDU".equals(statut)) countSuspendu++;
          else if ("INACTIF".equals(statut)) countInactif++;
      }
  %>

  const guidesData = {
    labels: ['En Attente', 'Actifs', 'Suspendus', 'Inactifs'],
    datasets: [{
      data: [<%= countEnAttente %>, <%= countActif %>, <%= countSuspendu %>, <%= countInactif %>],
      backgroundColor: [
        'rgba(255, 193, 7, 0.8)',
        'rgba(40, 167, 69, 0.8)',
        'rgba(220, 53, 69, 0.8)',
        'rgba(108, 117, 125, 0.8)'
      ],
      borderColor: [
        'rgba(255, 193, 7, 1)',
        'rgba(40, 167, 69, 1)',
        'rgba(220, 53, 69, 1)',
        'rgba(108, 117, 125, 1)'
      ],
      borderWidth: 2
    }]
  };

  const guidesChart = new Chart(
          document.getElementById('guidesChart'),
          {
            type: 'doughnut',
            data: guidesData,
            options: {
              responsive: true,
              plugins: {
                legend: {
                  position: 'bottom',
                }
              }
            }
          }
  );

  // Données pour le graphique des réservations
  <%
      int countEnAttente2 = 0, countConfirmee = 0, countAnnulee = 0;
      for (Reservation r : reservations) {
          String statut = r.getStatut();
          if ("en_attente".equals(statut)) countEnAttente2++;
          else if ("confirmee".equals(statut)) countConfirmee++;
          else if ("annulee".equals(statut)) countAnnulee++;
      }
  %>

  const reservationsData = {
    labels: ['En Attente', 'Confirmées', 'Annulées'],
    datasets: [{
      label: 'Réservations',
      data: [<%= countEnAttente2 %>, <%= countConfirmee %>, <%= countAnnulee %>],
      backgroundColor: [
        'rgba(255, 193, 7, 0.8)',
        'rgba(40, 167, 69, 0.8)',
        'rgba(220, 53, 69, 0.8)'
      ],
      borderColor: [
        'rgba(255, 193, 7, 1)',
        'rgba(40, 167, 69, 1)',
        'rgba(220, 53, 69, 1)'
      ],
      borderWidth: 2
    }]
  };

  const reservationsChart = new Chart(
          document.getElementById('reservationsChart'),
          {
            type: 'bar',
            data: reservationsData,
            options: {
              responsive: true,
              scales: {
                y: {
                  beginAtZero: true,
                  ticks: {
                    stepSize: 1
                  }
                }
              },
              plugins: {
                legend: {
                  display: false
                }
              }
            }
          }
  );
</script>
</body>
</html>