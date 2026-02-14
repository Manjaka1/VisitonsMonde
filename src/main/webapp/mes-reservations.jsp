<%@ page import="com.visitonsmonde.model.Utilisateur, java.util.List, com.visitonsmonde.model.Reservation, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String basePath = request.getContextPath();
  HttpSession maSession = request.getSession(false);
  Utilisateur utilisateur = (maSession != null) ? (Utilisateur) maSession.getAttribute("utilisateur") : null;
  List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
  String messageSucces = (String) request.getAttribute("messageSucces");
  String erreur = (String) request.getAttribute("erreur");
  String statutFiltre = request.getParameter("statut");

  SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
  SimpleDateFormat numberFormat = new SimpleDateFormat("#,##0.00");
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <title>Mes Réservations - TripHive</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
  <style>
    .reservation-card { border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: transform 0.3s ease; }
    .reservation-card:hover { transform: translateY(-5px); }
    .status-badge { padding: 8px 16px; border-radius: 20px; font-weight: bold; }
    .status-en_attente { background-color: #fff3cd; color: #856404; }
    .status-confirmee { background-color: #d1edff; color: #004085; }
    .status-annulee { background-color: #f8d7da; color: #721c24; }
    .numero-reservation { font-family: 'Courier New', monospace; background: #f8f9fa; padding: 8px 12px; border-radius: 8px; border-left: 4px solid #28a745; }
    .auth-navbar { background: #2c3e50; padding: 15px; text-align: center; }
    .auth-navbar a { color: white; text-decoration: none; margin: 0 15px; font-weight: 500; }
    .auth-navbar a:hover { color: #08f929; }
  </style>
</head>

<body>

<!-- Barre de navigation d'authentification -->
<div class="auth-navbar">
  <% if (utilisateur != null) { %>
  <span style="color: white; margin-right: 20px;">👋 Bienvenue, <%= utilisateur.getPrenom() %> !</span>
  <a href="mes-reservations">📋 Mes Réservations</a>
  <a href="mon-profil.jsp">👤 Mon Profil</a>
  <a href="logout">🚪 Déconnexion</a>
  <% } else { %>
  <a href="login.jsp">🔐 Connexion</a>
  <a href="register.jsp">📝 Inscription</a>
  <a href="mes-reservations">📋 Mes Réservations</a>
  <% } %>
  <a href="index.jsp">🏠 Accueil</a>
</div>

<div class="container-fluid bg-light py-5">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <h1 class="display-5 text-center mb-5">
          <i class="fas fa-calendar-check text-success me-3"></i>Mes Réservations
        </h1>
      </div>
    </div>

    <!-- Messages -->
    <% if (messageSucces != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <i class="fas fa-check-circle me-2"></i><%= messageSucces %>
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <% if (erreur != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <i class="fas fa-exclamation-triangle me-2"></i><%= erreur %>
      <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <!-- Filtres -->
    <div class="row mb-4">
      <div class="col-md-6">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">Filtrer mes réservations</h5>
            <form method="get" action="mes-reservations">
              <div class="row g-2">
                <div class="col-md-6">
                  <select name="statut" class="form-select">
                    <option value="">Tous les statuts</option>
                    <option value="en_attente" <%= "en_attente".equals(statutFiltre) ? "selected" : "" %>>En attente</option>
                    <option value="confirmee" <%= "confirmee".equals(statutFiltre) ? "selected" : "" %>>Confirmées</option>
                    <option value="annulee" <%= "annulee".equals(statutFiltre) ? "selected" : "" %>>Annulées</option>
                  </select>
                </div>
                <div class="col-md-6">
                  <button type="submit" class="btn btn-outline-success">
                    <i class="fas fa-filter me-1"></i>Filtrer
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card bg-success text-white">
          <div class="card-body text-center">
            <h5 class="card-title">Total de mes réservations</h5>
            <h2 class="display-6"><%= reservations != null ? reservations.size() : 0 %></h2>
          </div>
        </div>
      </div>
    </div>

    <!-- Liste des réservations -->
    <div class="row">
      <% if (reservations == null || reservations.isEmpty()) { %>
      <div class="col-12">
        <div class="card reservation-card text-center">
          <div class="card-body py-5">
            <i class="fas fa-calendar-times fa-4x text-muted mb-4"></i>
            <h4>Aucune réservation trouvée</h4>
            <p class="text-muted">Vous n'avez pas encore effectué de réservation.</p>
            <a href="destinations" class="btn btn-success btn-lg">
              <i class="fas fa-plus me-2"></i>Découvrir nos destinations
            </a>
          </div>
        </div>
      </div>
      <% } else {
        for (Reservation reservation : reservations) { %>
      <div class="col-lg-6 mb-4">
        <div class="card reservation-card h-100">
          <div class="card-header bg-transparent">
            <div class="row align-items-center">
              <div class="col-8">
                <div class="numero-reservation">
                  <small class="text-muted d-block">Numéro de réservation</small>
                  <strong><%= reservation.getNumeroReservation() %></strong>
                </div>
              </div>
              <div class="col-4 text-end">
                      <span class="status-badge status-<%= reservation.getStatut() %>">
                        <%
                          String statutText = "";
                          switch(reservation.getStatut()) {
                            case "en_attente": statutText = "En attente"; break;
                            case "confirmee": statutText = "Confirmée"; break;
                            case "annulee": statutText = "Annulée"; break;
                            default: statutText = reservation.getStatut();
                          }
                        %>
                        <%= statutText %>
                      </span>
              </div>
            </div>
          </div>

          <div class="card-body">
            <h5 class="card-title text-success">
              <i class="fas fa-map-marker-alt me-2"></i>
              <%= reservation.getDestinationNom() != null ? reservation.getDestinationNom() : "Destination" %>
            </h5>

            <div class="row g-3">
              <div class="col-6">
                <small class="text-muted">Date de départ</small>
                <div class="fw-bold">
                  <i class="fas fa-calendar me-1"></i>
                  <%= dateFormat.format(reservation.getDateDepart()) %>
                </div>
              </div>
              <div class="col-6">
                <small class="text-muted">Personnes</small>
                <div class="fw-bold">
                  <i class="fas fa-users me-1"></i>
                  <%= reservation.getNbPersonnes() %>
                </div>
              </div>
              <div class="col-6">
                <small class="text-muted">Prix total</small>
                <div class="fw-bold text-success">
                  <i class="fas fa-euro-sign me-1"></i>
                  <%= String.format("%.2f", reservation.getPrixTotal()) %> €
                </div>
              </div>
              <div class="col-6">
                <small class="text-muted">Réservé le</small>
                <div class="fw-bold">
                  <%= dateFormat.format(reservation.getDateReservation()) %>
                </div>
              </div>
            </div>

            <% if (reservation.getGuideNom() != null && !reservation.getGuideNom().isEmpty()) { %>
            <div class="mt-3 p-2 bg-light rounded">
              <small class="text-muted">Guide accompagnateur</small>
              <div class="fw-bold">
                <i class="fas fa-user-tie me-1"></i><%= reservation.getGuideNom() %>
              </div>
            </div>
            <% } %>
          </div>

          <div class="card-footer bg-transparent">
            <div class="btn-group w-100" role="group">
              <button type="button" class="btn btn-outline-info" onclick="voirDetails('<%= reservation.getNumeroReservation() %>')">
                <i class="fas fa-eye me-1"></i>Détails
              </button>

              <% if ("en_attente".equals(reservation.getStatut())) { %>
              <button type="button" class="btn btn-outline-danger" onclick="annulerReservation('<%= reservation.getNumeroReservation() %>')">
                <i class="fas fa-times me-1"></i>Annuler
              </button>
              <% } %>
            </div>
          </div>
        </div>
      </div>
      <%   }
      } %>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function voirDetails(numeroReservation) {
    window.location.href = 'reservation-details?numero=' + numeroReservation;
  }

  function annulerReservation(numeroReservation) {
    if (confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')) {
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'mes-reservations';  // ✅ CORRECT - utiliser ReservationListServlet

      const actionInput = document.createElement('input');
      actionInput.type = 'hidden';
      actionInput.name = 'action';
      actionInput.value = 'annuler';

      const numeroInput = document.createElement('input');
      numeroInput.type = 'hidden';
      numeroInput.name = 'numero';
      numeroInput.value = numeroReservation;

      form.appendChild(actionInput);
      form.appendChild(numeroInput);
      document.body.appendChild(form);
      form.submit();
    }
  }
</script>
<!-- AJOUTER CETTE MODAL AVANT LA FERMETURE DU BODY dans mes-reservations.jsp -->

<!-- Modal Détails Réservation -->
<div class="modal fade" id="detailsModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title">
          <i class="fas fa-info-circle me-2"></i>Détails de la réservation
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-6">
            <h6 class="text-success">Informations générales</h6>
            <table class="table table-sm">
              <tr>
                <td><strong>Numéro :</strong></td>
                <td id="modalNumero"></td>
              </tr>
              <tr>
                <td><strong>Statut :</strong></td>
                <td id="modalStatut"></td>
              </tr>
              <tr>
                <td><strong>Date de réservation :</strong></td>
                <td id="modalDateReservation"></td>
              </tr>
            </table>
          </div>
          <div class="col-md-6">
            <h6 class="text-success">Détails du voyage</h6>
            <table class="table table-sm">
              <tr>
                <td><strong>Destination :</strong></td>
                <td id="modalDestination"></td>
              </tr>
              <tr>
                <td><strong>Date de départ :</strong></td>
                <td id="modalDateDepart"></td>
              </tr>
              <tr>
                <td><strong>Nombre de personnes :</strong></td>
                <td id="modalPersonnes"></td>
              </tr>
              <tr>
                <td><strong>Prix total :</strong></td>
                <td id="modalPrix"></td>
              </tr>
              <tr>
                <td><strong>Guide :</strong></td>
                <td id="modalGuide"></td>
              </tr>
            </table>
          </div>
        </div>

        <div class="row mt-3" id="modalActions">
          <div class="col-12">
            <h6 class="text-success">Actions disponibles</h6>
            <div class="btn-group" role="group">
              <button type="button" class="btn btn-outline-danger" id="modalAnnulerBtn" style="display: none;">
                <i class="fas fa-times me-1"></i>Annuler cette réservation
              </button>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fermer</button>
      </div>
    </div>
  </div>
</div>

<!-- MODIFIER LE JAVASCRIPT -->
<script>
  function voirDetails(numeroReservation) {
    // Trouver la réservation dans la page
    const cards = document.querySelectorAll('.card.reservation-card');
    let reservationData = null;

    cards.forEach(card => {
      const cardNumero = card.querySelector('.numero-reservation strong').textContent;
      if (cardNumero === numeroReservation) {
        // Extraire les données de la carte
        const statut = card.querySelector('.status-badge').textContent.trim();
        const destination = card.querySelector('.card-title').textContent.replace(/^\s*\S+\s*/, '').trim();
        const dateDepart = card.querySelector('.fa-calendar').parentElement.textContent.trim();
        const personnes = card.querySelector('.fa-users').parentElement.textContent.trim();
        const prix = card.querySelector('.fa-euro-sign').parentElement.textContent.trim();
        const guide = card.querySelector('.fa-user-tie') ?
                card.querySelector('.fa-user-tie').parentElement.textContent.trim() :
                'Aucun guide assigné';

        reservationData = {
          numero: numeroReservation,
          statut: statut,
          destination: destination,
          dateDepart: dateDepart,
          personnes: personnes,
          prix: prix,
          guide: guide
        };
      }
    });

    if (reservationData) {
      // Remplir la modal
      document.getElementById('modalNumero').textContent = reservationData.numero;
      document.getElementById('modalStatut').innerHTML = `<span class="badge bg-secondary">${reservationData.statut}</span>`;
      document.getElementById('modalDestination').textContent = reservationData.destination;
      document.getElementById('modalDateDepart').textContent = reservationData.dateDepart;
      document.getElementById('modalPersonnes').textContent = reservationData.personnes;
      document.getElementById('modalPrix').textContent = reservationData.prix;
      document.getElementById('modalGuide').textContent = reservationData.guide;
      document.getElementById('modalDateReservation').textContent = new Date().toLocaleDateString('fr-FR');

      // Gérer le bouton d'annulation
      const annulerBtn = document.getElementById('modalAnnulerBtn');
      if (reservationData.statut === 'En attente') {
        annulerBtn.style.display = 'block';
        annulerBtn.onclick = () => {
          const modal = bootstrap.Modal.getInstance(document.getElementById('detailsModal'));
          modal.hide();
          annulerReservation(numeroReservation);
        };
      } else {
        annulerBtn.style.display = 'none';
      }

      // Afficher la modal
      const modal = new bootstrap.Modal(document.getElementById('detailsModal'));
      modal.show();
    }
  }

  function annulerReservation(numeroReservation) {
    if (confirm('Êtes-vous sûr de vouloir annuler cette réservation ?')) {
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = 'mes-reservations';

      const actionInput = document.createElement('input');
      actionInput.type = 'hidden';
      actionInput.name = 'action';
      actionInput.value = 'annuler';

      const numeroInput = document.createElement('input');
      numeroInput.type = 'hidden';
      numeroInput.name = 'numero';
      numeroInput.value = numeroReservation;

      form.appendChild(actionInput);
      form.appendChild(numeroInput);
      document.body.appendChild(form);
      form.submit();
    }
  }
</script>
</body>
</html>