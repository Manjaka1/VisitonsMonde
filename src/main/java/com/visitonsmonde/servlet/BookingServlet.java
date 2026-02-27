package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.DestinationDAO;
import com.visitonsmonde.dao.ReservationDAO;
import com.visitonsmonde.model.Destination;
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
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private ReservationDAO reservationDAO;
    private DestinationDAO destinationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.reservationDAO = new ReservationDAO();
        this.destinationDAO = new DestinationDAO();
        System.out.println("✅ BookingServlet initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Récupérer toutes les destinations pour le formulaire
            List<Destination> destinations = destinationDAO.selectAll();
            request.setAttribute("destinations", destinations);

            System.out.println("🔗 Connexion établie à la base de données");
            System.out.println("📋 " + destinations.size() + " destinations chargées pour booking.jsp");

            // Récupérer la destination pré-sélectionnée (si venant de packages)
            String destinationParam = request.getParameter("destination");
            if (destinationParam != null) {
                request.setAttribute("selectedDestination", destinationParam);
            }

            // Afficher la page de réservation
            request.getRequestDispatcher("booking.jsp").forward(request, response);

        } catch (SQLException e) {
            System.err.println("❌ Erreur SQL dans BookingServlet GET : " + e.getMessage());
            e.printStackTrace();

            // ✅ CORRECTION : On forward quand même vers booking.jsp avec une liste vide
            request.setAttribute("destinations", new java.util.ArrayList<>());
            request.setAttribute("erreur", "Erreur de chargement des destinations");
            request.getRequestDispatcher("booking.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("❌ Erreur dans BookingServlet GET : " + e.getMessage());
            e.printStackTrace();

            // ✅ CORRECTION : On forward quand même vers booking.jsp
            request.setAttribute("destinations", new java.util.ArrayList<>());
            request.setAttribute("erreur", "Erreur technique");
            request.getRequestDispatcher("booking.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        try {
            // Vérifier si l'utilisateur est connecté
            Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
            if (utilisateur == null) {
                session.setAttribute("erreur", "Vous devez être connecté pour faire une réservation");
                response.sendRedirect("login.jsp");
                return;
            }

            // Récupérer les données du formulaire
            String nom = request.getParameter("name");
            String email = request.getParameter("email");
            String dateDepart = request.getParameter("dateDepart");
            String destinationIdStr = request.getParameter("destinationId");
            String nbPersonnesStr = request.getParameter("nbPersonnes");
            String commentaires = request.getParameter("commentaires");

            // Validation des champs obligatoires
            if (nom == null || nom.trim().isEmpty()) {
                throw new Exception("Le nom est obligatoire");
            }
            if (email == null || email.trim().isEmpty()) {
                throw new Exception("L'email est obligatoire");
            }
            if (dateDepart == null || dateDepart.trim().isEmpty()) {
                throw new Exception("La date de départ est obligatoire");
            }
            if (destinationIdStr == null || destinationIdStr.trim().isEmpty()) {
                throw new Exception("Veuillez choisir une destination");
            }
            if (nbPersonnesStr == null || nbPersonnesStr.trim().isEmpty()) {
                throw new Exception("Le nombre de personnes est obligatoire");
            }

            // Conversion et validation des données
            int destinationId = Integer.parseInt(destinationIdStr);
            int nbPersonnes = Integer.parseInt(nbPersonnesStr);
            Date sqlDateDepart = Date.valueOf(dateDepart);

            // Vérifier que la destination existe
            Destination destination = destinationDAO.getDestinationById(destinationId);
            if (destination == null) {
                throw new Exception("Destination introuvable");
            }

            // Calculer le prix total (prix destination * nombre de personnes)
            BigDecimal prixTotal = destination.getPrix().multiply(new BigDecimal(nbPersonnes));

            // Créer la réservation
            Reservation reservation = new Reservation();
            reservation.setUtilisateurId(utilisateur.getId());
            reservation.setDestinationId(destinationId);
            reservation.setDateDepart(sqlDateDepart);
            reservation.setNbPersonnes(nbPersonnes);
            reservation.setPrixTotal(prixTotal);

            // Sauvegarder la réservation
            boolean success = reservationDAO.create(reservation);

            if (success) {
                // Succès - rediriger avec message de confirmation
                session.setAttribute("messageSucces",
                        "Votre réservation a été enregistrée avec succès ! " +
                                "Numéro de réservation : " + reservation.getNumeroReservation() +
                                ". Vous recevrez une confirmation par email.");

                session.setAttribute("derniereReservation", reservation);
                session.setAttribute("destinationReservee", destination);

                response.sendRedirect("booking");  // ✅ Redirige vers doGet pour recharger les destinations
            } else {
                throw new Exception("Erreur lors de l'enregistrement de la réservation");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "Données numériques invalides");
            response.sendRedirect("booking");
        } catch (IllegalArgumentException e) {
            session.setAttribute("erreur", "Date invalide");
            response.sendRedirect("booking");
        } catch (Exception e) {
            System.err.println("❌ Erreur dans BookingServlet POST : " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("erreur", "Erreur : " + e.getMessage());
            response.sendRedirect("booking");
        }
    }
}