package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.*;
import com.visitonsmonde.model.Destination;
import com.visitonsmonde.model.TypeTour;
import com.visitonsmonde.model.Utilisateur;
import com.visitonsmonde.model.Guide;
import jakarta.servlet.ServletException;
import com.visitonsmonde.model.Reservation;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    static {
        System.out.println("🔥 AdminServlet - CLASSE CHARGÉE");
    }

    public AdminServlet() {
        System.out.println("🔥 AdminServlet - CONSTRUCTEUR APPELÉ");
    }

    private PaysDAO paysDAO;
    private GuideDAO guideDAO;
    private DestinationDAO destinationDAO;
    private ReservationDAO reservationDAO;
    private TypeTourDAO typeTourDAO;
    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            paysDAO = new PaysDAO();
            guideDAO = new GuideDAO();
            destinationDAO = new DestinationDAO();
            reservationDAO = new ReservationDAO();
            typeTourDAO = new TypeTourDAO();
            utilisateurDAO = new UtilisateurDAO();

            System.out.println("✅ AdminServlet initialisé avec tous les DAOs");
        } catch (Exception e) {
            System.err.println("Erreur initialisation AdminServlet: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== AdminServlet doGet ===");

        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (session != null) ? (Utilisateur) session.getAttribute("utilisateur") : null;

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        if (!utilisateur.isAdmin() && !"ADMIN".equals(utilisateur.getRole())) {
            session.setAttribute("erreur", "Accès réservé aux administrateurs.");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String section = request.getParameter("section");
        if (section != null) {
            request.setAttribute("activeSection", section);
        }

        String messageSucces = (String) session.getAttribute("messageSucces");
        String erreur = (String) session.getAttribute("erreur");

        if (messageSucces != null) {
            request.setAttribute("messageSucces", messageSucces);
            session.removeAttribute("messageSucces");
        }

        if (erreur != null) {
            request.setAttribute("erreur", erreur);
            session.removeAttribute("erreur");
        }

        if (typeTourDAO != null) {
            request.setAttribute("typesTours", typeTourDAO.findAll());
            System.out.println("✅ Données types de tours chargées - Nombre: " + typeTourDAO.findAll().size());
        } else {
            request.setAttribute("typesTours", new ArrayList<>());
            System.out.println("⚠ TypeTourDAO null - liste types de tours vide");
        }

        try {
            if (paysDAO != null) {
                request.setAttribute("pays", paysDAO.getAllPays());
                System.out.println("✅ Données pays chargées - Nombre: " + paysDAO.getAllPays().size());
            } else {
                request.setAttribute("pays", new ArrayList<>());
                System.out.println("❌ PaysDAO null - liste pays vide");
            }

            if (guideDAO != null) {
                request.setAttribute("guides", guideDAO.findAll());
                System.out.println("✅ Données guides chargées - Nombre: " + guideDAO.findAll().size());
            } else {
                request.setAttribute("guides", new ArrayList<>());
                System.out.println("❌ GuideDAO null - liste guides vide");
            }

            if (destinationDAO != null) {
                request.setAttribute("destinations", destinationDAO.getAllDestinations());
                System.out.println("✅ Données destinations chargées - Nombre: " + destinationDAO.getAllDestinations().size());
            } else {
                request.setAttribute("destinations", new ArrayList<>());
                System.out.println("❌ DestinationDAO null - liste destinations vide");
            }

            if (reservationDAO != null) {
                request.setAttribute("reservations", reservationDAO.getAllReservations());
                System.out.println("✅ Données réservations chargées - Nombre: " + reservationDAO.getAllReservations().size());
            } else {
                request.setAttribute("reservations", new ArrayList<>());
                System.out.println("❌ ReservationDAO null - liste réservations vide");
            }

        } catch (SQLException e) {
            System.err.println("Erreur chargement données: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("destinations", new ArrayList<>());
            request.setAttribute("pays", new ArrayList<>());
            request.setAttribute("guides", new ArrayList<>());
            request.setAttribute("reservations", new ArrayList<>());

            request.setAttribute("erreur", "Erreur de chargement des données: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== AdminServlet doPost ===");

        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (session != null) ? (Utilisateur) session.getAttribute("utilisateur") : null;

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        if (!utilisateur.isAdmin() && !"ADMIN".equals(utilisateur.getRole())) {
            session.setAttribute("erreur", "Accès réservé aux administrateurs.");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String action = request.getParameter("action");
        System.out.println("Action reçue: " + action);

        if (action != null) {
            if (action.startsWith("destination-")) {
                gererDestinations(request, response, action);
            } else if (action.startsWith("reservation-")) {
                gererReservations(request, response, action);
            } else if (action.startsWith("guide-")) {
                gererGuides(request, response, action);
            } else if (action.startsWith("type-tour-")) {
                gererTypesTours(request, response, action);
            } else {
                session.setAttribute("erreur", "Action non reconnue: " + action);
            }
        } else {
            session.setAttribute("erreur", "Aucune action spécifiée.");
        }

        response.sendRedirect(request.getContextPath() + "/admin");
    }

    // ===== MÉTHODES DE GESTION DES DESTINATIONS =====

    private void gererDestinations(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "destination-ajouter":
                    ajouterDestination(request, session);
                    break;
                case "destination-modifier":
                    modifierDestination(request, session);
                    break;
                case "destination-supprimer":
                    supprimerDestination(request, session);
                    break;
                default:
                    session.setAttribute("erreur", "Action destination non reconnue: " + action);
            }
        } catch (Exception e) {
            System.err.println("Erreur gestion destinations: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("erreur", "Erreur technique lors de la gestion des destinations.");
        }
    }

    private void ajouterDestination(HttpServletRequest request, HttpSession session) {
        try {
            String nom = request.getParameter("nom");
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            String paysIdStr = request.getParameter("paysId");
            String prixStr = request.getParameter("prix");
            String nbPhotosStr = request.getParameter("nbPhotos");

            if (nom == null || nom.trim().isEmpty()) {
                session.setAttribute("erreur", "Le nom de la destination est obligatoire.");
                return;
            }

            Destination destination = new Destination();
            destination.setNom(nom.trim());
            destination.setDescription(description != null ? description.trim() : "");
            destination.setImage(image != null ? image.trim() : "");

            if (paysIdStr != null && !paysIdStr.trim().isEmpty()) {
                destination.setPaysId(Integer.parseInt(paysIdStr));
            }

            if (prixStr != null && !prixStr.trim().isEmpty()) {
                destination.setPrix(new java.math.BigDecimal(prixStr));
            }

            if (nbPhotosStr != null && !nbPhotosStr.trim().isEmpty()) {
                destination.setNbPhotos(Integer.parseInt(nbPhotosStr));
            } else {
                destination.setNbPhotos(0);
            }

            destinationDAO.insert(destination);
            session.setAttribute("messageSucces", "Destination '" + nom + "' ajoutée avec succès !");
            System.out.println("Destination ajoutée: " + nom);

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "Erreur dans les données numériques (prix, nombre de photos).");
        } catch (Exception e) {
            System.err.println("Erreur ajout destination: " + e.getMessage());
            session.setAttribute("erreur", "Erreur lors de l'ajout de la destination.");
        }
    }

    private void gererTypesTours(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "type-tour-ajouter":
                    ajouterTypeTour(request, session);
                    break;
                case "type-tour-modifier":
                    modifierTypeTour(request, session);
                    break;
                case "type-tour-supprimer":
                    supprimerTypeTour(request, session);
                    break;
                default:
                    session.setAttribute("erreur", "Action type de tour non reconnue: " + action);
            }
        } catch (Exception e) {
            System.err.println("Erreur gestion types de tours: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("erreur", "Erreur technique lors de la gestion des types de tours.");
        }
    }

    private void ajouterTypeTour(HttpServletRequest request, HttpSession session) {
        try {
            String nom = request.getParameter("nom");
            String description = request.getParameter("description");
            String image = request.getParameter("image");

            if (nom == null || nom.trim().isEmpty()) {
                session.setAttribute("erreur", "Le nom du type de tour est obligatoire.");
                return;
            }

            TypeTour typeTour = new TypeTour();
            typeTour.setNom(nom.trim());
            typeTour.setDescription(description != null ? description.trim() : "");
            typeTour.setImage(image != null ? image.trim() : "");

            boolean success = typeTourDAO.create(typeTour);

            if (success) {
                session.setAttribute("messageSucces", "Type de tour '" + nom + "' ajouté avec succès !");
                System.out.println("Type de tour ajouté: " + nom);
            } else {
                session.setAttribute("erreur", "Erreur lors de l'ajout du type de tour.");
            }

        } catch (Exception e) {
            System.err.println("Erreur ajout type de tour: " + e.getMessage());
            session.setAttribute("erreur", "Erreur lors de l'ajout du type de tour.");
        }
    }

    private void modifierTypeTour(HttpServletRequest request, HttpSession session) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("erreur", "ID de type de tour manquant.");
                return;
            }

            int id = Integer.parseInt(idStr);

            String nom = request.getParameter("nom");
            String description = request.getParameter("description");
            String image = request.getParameter("image");

            if (nom == null || nom.trim().isEmpty()) {
                session.setAttribute("erreur", "Le nom du type de tour est obligatoire.");
                return;
            }

            TypeTour typeTour = new TypeTour();
            typeTour.setId(id);
            typeTour.setNom(nom.trim());
            typeTour.setDescription(description != null ? description.trim() : "");
            typeTour.setImage(image != null ? image.trim() : "");

            boolean success = typeTourDAO.update(typeTour);

            if (success) {
                session.setAttribute("messageSucces", "Type de tour '" + nom + "' modifié avec succès !");
                System.out.println("Type de tour modifié: " + nom);
            } else {
                session.setAttribute("erreur", "Erreur lors de la modification du type de tour.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "ID de type de tour invalide.");
        } catch (Exception e) {
            System.err.println("Erreur modification type de tour: " + e.getMessage());
            session.setAttribute("erreur", "Erreur lors de la modification du type de tour.");
        }
    }

    private void supprimerTypeTour(HttpServletRequest request, HttpSession session) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("erreur", "ID de type de tour manquant.");
                return;
            }

            int id = Integer.parseInt(idStr);

            TypeTour typeTour = typeTourDAO.findById(id);
            String nomTypeTour = (typeTour != null) ? typeTour.getNom() : "ID " + id;

            boolean success = typeTourDAO.delete(id);

            if (success) {
                session.setAttribute("messageSucces", "Type de tour '" + nomTypeTour + "' supprimé avec succès !");
                System.out.println("Type de tour supprimé: " + nomTypeTour);
            } else {
                session.setAttribute("erreur", "Erreur lors de la suppression du type de tour.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "ID de type de tour invalide.");
        } catch (Exception e) {
            System.err.println("Erreur suppression type de tour: " + e.getMessage());
            session.setAttribute("erreur", "Erreur lors de la suppression du type de tour.");
        }
    }

    private void modifierDestination(HttpServletRequest request, HttpSession session) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("erreur", "ID de destination manquant.");
                return;
            }

            int id = Integer.parseInt(idStr);

            String nom = request.getParameter("nom");
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            String paysIdStr = request.getParameter("paysId");
            String prixStr = request.getParameter("prix");
            String nbPhotosStr = request.getParameter("nbPhotos");

            if (nom == null || nom.trim().isEmpty()) {
                session.setAttribute("erreur", "Le nom de la destination est obligatoire.");
                return;
            }

            Destination destination = new Destination();
            destination.setId(id);
            destination.setNom(nom.trim());
            destination.setDescription(description != null ? description.trim() : "");
            destination.setImage(image != null ? image.trim() : "");

            if (paysIdStr != null && !paysIdStr.trim().isEmpty()) {
                destination.setPaysId(Integer.parseInt(paysIdStr));
            }

            if (prixStr != null && !prixStr.trim().isEmpty()) {
                destination.setPrix(new java.math.BigDecimal(prixStr));
            }

            if (nbPhotosStr != null && !nbPhotosStr.trim().isEmpty()) {
                destination.setNbPhotos(Integer.parseInt(nbPhotosStr));
            } else {
                destination.setNbPhotos(0);
            }

            destinationDAO.update(destination);
            session.setAttribute("messageSucces", "Destination '" + nom + "' modifiée avec succès !");
            System.out.println("Destination modifiée: " + nom);

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "Erreur dans les données numériques.");
        } catch (Exception e) {
            System.err.println("Erreur modification destination: " + e.getMessage());
            session.setAttribute("erreur", "Erreur lors de la modification de la destination.");
        }
    }

    private void supprimerDestination(HttpServletRequest request, HttpSession session) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("erreur", "ID de destination manquant.");
                return;
            }

            int id = Integer.parseInt(idStr);

            Destination destination = destinationDAO.getDestinationById(id);
            String nomDestination = (destination != null) ? destination.getNom() : "ID " + id;

            destinationDAO.delete(id);
            session.setAttribute("messageSucces", "Destination '" + nomDestination + "' supprimée avec succès !");
            System.out.println("Destination supprimée: " + nomDestination);

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "ID de destination invalide.");
        } catch (Exception e) {
            System.err.println("Erreur suppression destination: " + e.getMessage());
            session.setAttribute("erreur", "Erreur lors de la suppression de la destination.");
        }
    }

    // ===== MÉTHODES DE GESTION DES RÉSERVATIONS =====

    private void gererReservations(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "reservation-confirmer":
                    changerStatutReservation(request, session, "confirmee");
                    break;
                case "reservation-annuler":
                    changerStatutReservation(request, session, "annulee");
                    break;
                case "reservation-en-attente":
                    changerStatutReservation(request, session, "en_attente");
                    break;
                default:
                    session.setAttribute("erreur", "Action réservation non reconnue: " + action);
            }
        } catch (Exception e) {
            System.err.println("Erreur gestion réservations: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("erreur", "Erreur technique lors de la gestion des réservations.");
        }
    }

    private void changerStatutReservation(HttpServletRequest request, HttpSession session, String nouveauStatut) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("erreur", "ID de réservation manquant.");
                return;
            }

            int id = Integer.parseInt(idStr);

            Reservation reservation = reservationDAO.getReservationById(id);
            String numeroReservation = (reservation != null) ? reservation.getNumeroReservation() : "ID " + id;

            boolean success = reservationDAO.updateStatut(id, nouveauStatut);

            if (success) {
                String statutTexte = getStatutTexte(nouveauStatut);
                session.setAttribute("messageSucces", "Réservation " + numeroReservation + " " + statutTexte + " avec succès !");
                System.out.println("Réservation " + numeroReservation + " -> " + nouveauStatut);
            } else {
                session.setAttribute("erreur", "Erreur lors de la mise à jour du statut.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "ID de réservation invalide.");
        } catch (Exception e) {
            System.err.println("Erreur changement statut réservation: " + e.getMessage());
            session.setAttribute("erreur", "Erreur lors du changement de statut.");
        }
    }

    private String getStatutTexte(String statut) {
        switch (statut) {
            case "confirmee": return "confirmée";
            case "annulee": return "annulée";
            case "en_attente": return "remise en attente";
            default: return "mise à jour";
        }
    }

    // ===== MÉTHODES DE GESTION DES GUIDES =====

    private void gererGuides(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "guide-approuver":
                    approuverGuide(request, session);
                    break;
                case "guide-refuser":
                    refuserGuide(request, session);
                    break;
                case "guide-suspendre":
                    suspendreGuide(request, session);
                    break;
                default:
                    session.setAttribute("erreur", "Action guide non reconnue: " + action);
            }
        } catch (Exception e) {
            System.err.println("Erreur gestion guides: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("erreur", "Erreur technique lors de la gestion des guides.");
        }
    }

    private void approuverGuide(HttpServletRequest request, HttpSession session) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("erreur", "ID de guide manquant.");
                return;
            }

            int guideId = Integer.parseInt(idStr);

            Guide guide = guideDAO.findById(guideId);
            if (guide == null) {
                session.setAttribute("erreur", "Guide introuvable.");
                return;
            }

            guide.setStatut("ACTIF");
            boolean guideUpdated = guideDAO.update(guide);

            if (!guideUpdated) {
                session.setAttribute("erreur", "Erreur lors de la mise à jour du statut du guide.");
                return;
            }

            if (guide.getUtilisateurId() != null) {
                Utilisateur utilisateur = utilisateurDAO.findById(guide.getUtilisateurId());
                if (utilisateur != null) {
                    utilisateur.setEstActif(true);
                    utilisateurDAO.update(utilisateur);
                }
            }

            session.setAttribute("messageSucces",
                    "Guide " + guide.getNomComplet() + " approuvé avec succès ! Le compte est maintenant actif.");
            System.out.println("✅ Guide approuvé: " + guide.getNomComplet());

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "ID de guide invalide.");
        } catch (Exception e) {
            System.err.println("❌ Erreur approbation guide: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("erreur", "Erreur lors de l'approbation du guide.");
        }
    }

    private void refuserGuide(HttpServletRequest request, HttpSession session) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("erreur", "ID de guide manquant.");
                return;
            }

            int guideId = Integer.parseInt(idStr);

            Guide guide = guideDAO.findById(guideId);
            if (guide == null) {
                session.setAttribute("erreur", "Guide introuvable.");
                return;
            }

            guide.setStatut("INACTIF");
            boolean success = guideDAO.update(guide);

            if (success) {
                session.setAttribute("messageSucces",
                        "Candidature de " + guide.getNomComplet() + " refusée.");
                System.out.println("❌ Guide refusé: " + guide.getNomComplet());
            } else {
                session.setAttribute("erreur", "Erreur lors du refus du guide.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "ID de guide invalide.");
        } catch (Exception e) {
            System.err.println("❌ Erreur refus guide: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("erreur", "Erreur lors du refus du guide.");
        }
    }

    private void suspendreGuide(HttpServletRequest request, HttpSession session) {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                session.setAttribute("erreur", "ID de guide manquant.");
                return;
            }

            int guideId = Integer.parseInt(idStr);

            Guide guide = guideDAO.findById(guideId);
            if (guide == null) {
                session.setAttribute("erreur", "Guide introuvable.");
                return;
            }

            guide.setStatut("SUSPENDU");
            boolean guideUpdated = guideDAO.update(guide);

            if (!guideUpdated) {
                session.setAttribute("erreur", "Erreur lors de la suspension du guide.");
                return;
            }

            if (guide.getUtilisateurId() != null) {
                Utilisateur utilisateur = utilisateurDAO.findById(guide.getUtilisateurId());
                if (utilisateur != null) {
                    utilisateur.setEstActif(false);
                    utilisateurDAO.update(utilisateur);
                }
            }

            session.setAttribute("messageSucces",
                    "Guide " + guide.getNomComplet() + " suspendu. Le compte est désactivé.");
            System.out.println("⏸ Guide suspendu: " + guide.getNomComplet());

        } catch (NumberFormatException e) {
            session.setAttribute("erreur", "ID de guide invalide.");
        } catch (Exception e) {
            System.err.println("❌ Erreur suspension guide: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("erreur", "Erreur lors de la suspension du guide.");
        }
    }
}