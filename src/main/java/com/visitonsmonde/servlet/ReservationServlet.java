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
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/reservations")
class ReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        reservationDAO = new ReservationDAO();
        System.out.println("✅ ReservationServlet initialisé");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🎯🎯🎯 RESERVATION SERVLET APPELÉ ! 🎯🎯🎯");
        System.out.println("Méthode: " + request.getMethod());
        System.out.println("URL: " + request.getRequestURL());
        System.out.println("Action parameter: " + request.getParameter("action"));

        // Afficher tous les paramètres reçus
        System.out.println("Tous les paramètres:");
        java.util.Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String paramName = params.nextElement();
            String paramValue = request.getParameter(paramName);
            System.out.println("  " + paramName + " = " + paramValue);
        }

        if ("creer".equals(request.getParameter("action"))) {
            System.out.println("🟢 Action 'creer' détectée");
            creerReservation(request, response);
        } else {
            System.out.println("🔴 Action non reconnue: " + request.getParameter("action"));
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non reconnue");
        }
    }

    private void creerReservation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            System.out.println("=== DÉBUT CRÉATION RÉSERVATION ===");

            // 1. Récupérer les paramètres
            String destinationIdStr = request.getParameter("destination_id");
            String nbPersonnesStr = request.getParameter("nb_personnes");
            String dateDepartStr = request.getParameter("date_depart");
            String guideIdStr = request.getParameter("guide_id");
            String prixDestinationStr = request.getParameter("prix_destination");
            String nomDestination = request.getParameter("nom_destination");

            System.out.println("Paramètres reçus:");
            System.out.println("destination_id: " + destinationIdStr);
            System.out.println("nb_personnes: " + nbPersonnesStr);
            System.out.println("date_depart: " + dateDepartStr);
            System.out.println("guide_id: " + guideIdStr);
            System.out.println("prix_destination: " + prixDestinationStr);
            System.out.println("nom_destination: " + nomDestination);

            // Validation des paramètres obligatoires
            if (destinationIdStr == null || nbPersonnesStr == null || dateDepartStr == null || prixDestinationStr == null) {
                System.err.println("❌ Paramètres manquants");
                response.sendRedirect("erreur-reservation.jsp");
                return;
            }

            int destinationId = Integer.parseInt(destinationIdStr);
            int nbPersonnes = Integer.parseInt(nbPersonnesStr);
            LocalDate dateDepart = LocalDate.parse(dateDepartStr);
            BigDecimal prixDestination = new BigDecimal(prixDestinationStr);

            // 2. Préparer la réservation
            Reservation reservation = new Reservation();
            reservation.setDestinationId(destinationId);
            reservation.setNbPersonnes(nbPersonnes);
            reservation.setDateDepart(Date.valueOf(dateDepart));

            // Gestion du guide (peut être vide/null)
            if (guideIdStr != null && !guideIdStr.trim().isEmpty() && !"".equals(guideIdStr)) {
                try {
                    reservation.setGuideId(Integer.parseInt(guideIdStr));
                    System.out.println("✅ Guide sélectionné: " + guideIdStr);
                } catch (NumberFormatException e) {
                    reservation.setGuideId(null);
                    System.out.println("⚠️ Guide non valide, mis à null");
                }
            } else {
                reservation.setGuideId(null);
                System.out.println("ℹ️ Aucun guide sélectionné");
            }

            // Calcul du prix total
            BigDecimal prixTotal = prixDestination.multiply(new BigDecimal(nbPersonnes));
            reservation.setPrixTotal(prixTotal);
            reservation.setStatut("en_attente");
            // Récupérer l'utilisateur connecté
            HttpSession session = request.getSession();
            Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

            if (utilisateur != null) {
                reservation.setUtilisateurId(utilisateur.getId()); // VRAI ID utilisateur
            } else {
                // Rediriger vers login si pas connecté
                response.sendRedirect("login.jsp");
                return;
            } // ID temporaire

            System.out.println("📋 Réservation préparée: " + reservation);

            // 3. Sauvegarder avec génération automatique du numéro
            boolean success = reservationDAO.create(reservation);

            // 4. Redirection avec TOUS les paramètres
            if (success) {
                System.out.println("✅ Réservation créée avec succès!");
                System.out.println("🆔 ID: " + reservation.getId());
                System.out.println("🔢 Numéro: " + reservation.getNumeroReservation());

                // REDIRECTION AVEC TOUS LES PARAMÈTRES
                String redirectUrl = String.format(
                        "confirmation-reservation.jsp?numero=%s&destination=%s&dateDepart=%s&nbPersonnes=%d&prixTotal=%s&dateReservation=%s",
                        URLEncoder.encode(reservation.getNumeroReservation(), "UTF-8"),
                        URLEncoder.encode(nomDestination != null ? nomDestination : "Destination", "UTF-8"),
                        URLEncoder.encode(dateDepart.toString(), "UTF-8"),
                        nbPersonnes,
                        URLEncoder.encode(prixTotal.toString(), "UTF-8"),
                        URLEncoder.encode(new java.util.Date().toString(), "UTF-8") // Date actuelle
                );

                System.out.println("🔗 Redirection vers: " + redirectUrl);
                response.sendRedirect(redirectUrl);

            } else {
                System.err.println("❌ Échec de la création de réservation");
                response.sendRedirect("erreur-reservation.jsp");
            }

        } catch (NumberFormatException e) {
            System.err.println("❌ Erreur de format des paramètres: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("erreur-reservation.jsp");
        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la création de réservation: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("erreur-reservation.jsp");
        }

        System.out.println("=== FIN CRÉATION RÉSERVATION ===");
    }
}