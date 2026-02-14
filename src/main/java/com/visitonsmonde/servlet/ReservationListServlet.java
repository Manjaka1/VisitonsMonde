package com.visitonsmonde.servlet;


import com.visitonsmonde.dao.ReservationDAO;
import com.visitonsmonde.model.Reservation;
import com.visitonsmonde.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/mes-reservations", "/admin-reservations"})
public class ReservationListServlet extends HttpServlet {

    private ReservationDAO reservationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        reservationDAO = new ReservationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/mes-reservations".equals(path)) {
            afficherReservationsUtilisateur(request, response);
        } else if ("/admin-reservations".equals(path)) {
            afficherAdminReservations(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String numeroReservation = request.getParameter("numero");

        try {
            switch (action) {
                case "confirmer":
                    reservationDAO.updateStatut(numeroReservation, "confirmee");
                    request.setAttribute("messageSucces", "Réservation confirmée avec succès !");
                    break;
                case "annuler":
                    reservationDAO.updateStatut(numeroReservation, "annulee");
                    request.setAttribute("messageSucces", "Réservation annulée avec succès !");
                    break;
                case "export":
                    exporterCSV(request, response);
                    return;
            }
        } catch (Exception e) {
            request.setAttribute("erreur", "Erreur lors de l'opération : " + e.getMessage());
        }

        // Rediriger vers la page appropriée
        doGet(request, response);
    }

    /**
     * Afficher les réservations d'un utilisateur
     */
    private void afficherReservationsUtilisateur(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupérer l'utilisateur de la session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        int utilisateurId = utilisateur.getId();

        String statutFiltre = request.getParameter("statut");
        List<Reservation> reservations;

        if (statutFiltre != null && !statutFiltre.trim().isEmpty()) {
            // Utilisez la nouvelle méthode du DAO
            reservations = reservationDAO.findByUtilisateurAndStatut(utilisateurId, statutFiltre);
        } else {
            reservations = reservationDAO.findByUtilisateur(utilisateurId);
        }

        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/mes-reservations.jsp").forward(request, response);
    }

    /**
     * Afficher la page d'administration des réservations
     */
    private void afficherAdminReservations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String numeroFiltre = request.getParameter("numero");
        String statutFiltre = request.getParameter("statut");
        String dateDebut = request.getParameter("dateDebut");
        String dateFin = request.getParameter("dateFin");

        List<Reservation> reservations;

        if (numeroFiltre != null && !numeroFiltre.trim().isEmpty()) {
            // Recherche par numéro spécifique
            Reservation reservation = reservationDAO.findByNumero(numeroFiltre);
            reservations = reservation != null ? List.of(reservation) : List.of();
        } else if (statutFiltre != null && !statutFiltre.trim().isEmpty()) {
            // Filtrer par statut
            reservations = reservationDAO.findByStatut(statutFiltre);
        } else {
            // Toutes les réservations
            reservations = reservationDAO.findAll();
        }

        // Calculer les statistiques
        ReservationStats stats = calculerStatistiques(reservations);

        request.setAttribute("reservations", reservations);
        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/admin-reservations.jsp").forward(request, response);
    }

    /**
     * Calculer les statistiques des réservations
     */
    private ReservationStats calculerStatistiques(List<Reservation> reservations) {
        int total = reservations.size();
        int enAttente = 0, confirmees = 0, annulees = 0;

        for (Reservation r : reservations) {
            switch (r.getStatut()) {
                case "en_attente": enAttente++; break;
                case "confirmee": confirmees++; break;
                case "annulee": annulees++; break;
            }
        }

        return new ReservationStats(total, enAttente, confirmees, annulees);
    }

    /**
     * Exporter les réservations en CSV
     */
    private void exporterCSV(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"reservations.csv\"");

        List<Reservation> reservations = reservationDAO.findAll();

        StringBuilder csv = new StringBuilder();
        csv.append("Numéro,Utilisateur ID,Destination ID,Date Départ,Nb Personnes,Prix Total,Statut,Date Réservation\n");

        for (Reservation r : reservations) {
            csv.append(r.getNumeroReservation()).append(",")
                    .append(r.getUtilisateurId()).append(",")
                    .append(r.getDestinationId()).append(",")
                    .append(r.getDateDepart()).append(",")
                    .append(r.getNbPersonnes()).append(",")
                    .append(r.getPrixTotal()).append(",")
                    .append(r.getStatut()).append(",")
                    .append(r.getDateReservation()).append("\n");
        }

        response.getWriter().write(csv.toString());
    }


    /**
     * Classe interne pour les statistiques
     */
    public static class ReservationStats {
        private int totalReservations;
        private int enAttente;
        private int confirmees;
        private int annulees;

        public ReservationStats(int totalReservations, int enAttente, int confirmees, int annulees) {
            this.totalReservations = totalReservations;
            this.enAttente = enAttente;
            this.confirmees = confirmees;
            this.annulees = annulees;
        }

        // Getters
        public int getTotalReservations() { return totalReservations; }
        public int getEnAttente() { return enAttente; }
        public int getConfirmees() { return confirmees; }
        public int getAnnulees() { return annulees; }
    }
}