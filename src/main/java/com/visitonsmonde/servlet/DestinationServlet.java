package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.DestinationDAO;
import com.visitonsmonde.dao.PaysDAO;
import com.visitonsmonde.model.Destination;
import com.visitonsmonde.model.Pays;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "DestinationServlet", urlPatterns = {"/destinations", "/destination"}, loadOnStartup = 1)
public class DestinationServlet extends HttpServlet {

    private DestinationDAO destinationDAO;
    private PaysDAO paysDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            destinationDAO = new DestinationDAO();
            paysDAO = new PaysDAO();
            System.out.println("✅ DestinationServlet initialisé avec succès");
        } catch (Exception e) {
            System.err.println("❌ Erreur initialisation DestinationServlet : " + e.getMessage());
            throw new ServletException("Impossible d'initialiser le servlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("🎯 DESTINATION SERVLET APPELÉ !");
        System.out.println("   URL: " + request.getRequestURL());
        System.out.println("   Action: " + request.getParameter("action"));

        String action = request.getParameter("action");

        try {
            if ("view".equals(action)) {
                afficherDestination(request, response);
            } else if ("admin".equals(action)) {
                afficherAdmin(request, response);
            } else {
                afficherDestinations(request, response);
            }
        } catch (SQLException e) {
            System.err.println("❌ Erreur base de données : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("erreur", "Erreur d'accès aux données : " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "ajouter":
                    ajouterDestination(request, response);
                    break;
                case "modifier":
                    modifierDestination(request, response);
                    break;
                case "supprimer":
                    supprimerDestination(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action non reconnue");
                    return;
            }

            response.sendRedirect(request.getContextPath() + "/destinations?success=" + action);

        } catch (SQLException e) {
            System.err.println("❌ Erreur SQL : " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de l'opération : " + e.getMessage());
            request.setAttribute("action", action);
            doGet(request, response);
        } catch (Exception e) {
            System.err.println("❌ Erreur inattendue : " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur interne du serveur");
        }
    }

    private void afficherDestinations(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        System.out.println("📋 MÉTHODE afficherDestinations APPELÉE");

        String paysFiltre = request.getParameter("pays");
        List<Destination> destinations;

        if (paysFiltre != null && !paysFiltre.trim().isEmpty()) {
            destinations = destinationDAO.getDestinationsByPays(paysFiltre);
            request.setAttribute("paysFiltre", paysFiltre);
            System.out.println("📋 Destinations filtrées : " + destinations.size());
        } else {
            System.out.println("📋 Récupération de TOUTES les destinations...");
            destinations = destinationDAO.getAllDestinations();
            System.out.println("📋 ✅ " + destinations.size() + " destinations récupérées");

            for (int i = 0; i < Math.min(3, destinations.size()); i++) {
                System.out.println("   → " + destinations.get(i).getNom());
            }
        }

        List<Pays> pays = paysDAO.getAllPays();

        request.setAttribute("destinations", destinations);
        request.setAttribute("pays", pays);
        request.setAttribute("nombreDestinations", destinations.size());

        String success = request.getParameter("success");
        if (success != null) {
            String message = getSuccessMessage(success);
            request.setAttribute("messageSucces", message);
        }

        System.out.println("📋 FORWARD vers /destination.jsp...");
        request.getRequestDispatcher("/destination.jsp").forward(request, response);
        System.out.println("📋 ✅ FORWARD TERMINÉ");
    }

    private void afficherDestination(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID requis");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Destination destination = destinationDAO.getDestinationById(id);

            if (destination == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Destination non trouvée");
                return;
            }

            request.setAttribute("destination", destination);
            request.getRequestDispatcher("/destination-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID invalide");
        }
    }

    private void afficherAdmin(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<Destination> destinations = destinationDAO.getAllDestinations();
        List<Pays> pays = paysDAO.getAllPays();

        request.setAttribute("destinations", destinations);
        request.setAttribute("pays", pays);

        request.getRequestDispatcher("/admin-destinations.jsp").forward(request, response);
    }

    private void ajouterDestination(HttpServletRequest request, HttpServletResponse response)
            throws SQLException {

        Destination destination = new Destination();

        destination.setNom(request.getParameter("nom"));
        destination.setDescription(request.getParameter("description"));
        destination.setImage(request.getParameter("image"));
        destination.setPays(request.getParameter("pays"));

        String nbPhotosStr = request.getParameter("nbPhotos");
        if (nbPhotosStr != null && !nbPhotosStr.trim().isEmpty()) {
            destination.setNbPhotos(Integer.parseInt(nbPhotosStr));
        }

        String prixStr = request.getParameter("prix");
        if (prixStr != null && !prixStr.trim().isEmpty()) {
            destination.setPrix(new BigDecimal(prixStr));
        }

        destinationDAO.insert(destination);
        System.out.println("✅ Nouvelle destination ajoutée : " + destination.getNom());
    }

    private void modifierDestination(HttpServletRequest request, HttpServletResponse response)
            throws SQLException {

        Destination destination = new Destination();

        destination.setId(Integer.parseInt(request.getParameter("id")));
        destination.setNom(request.getParameter("nom"));
        destination.setDescription(request.getParameter("description"));
        destination.setImage(request.getParameter("image"));
        destination.setPays(request.getParameter("pays"));

        String nbPhotosStr = request.getParameter("nbPhotos");
        if (nbPhotosStr != null && !nbPhotosStr.trim().isEmpty()) {
            destination.setNbPhotos(Integer.parseInt(nbPhotosStr));
        }

        String prixStr = request.getParameter("prix");
        if (prixStr != null && !prixStr.trim().isEmpty()) {
            destination.setPrix(new BigDecimal(prixStr));
        }

        destinationDAO.update(destination);
        System.out.println("✅ Destination modifiée : " + destination.getNom());
    }

    private void supprimerDestination(HttpServletRequest request, HttpServletResponse response)
            throws SQLException {

        int id = Integer.parseInt(request.getParameter("id"));
        destinationDAO.delete(id);
        System.out.println("✅ Destination supprimée ID : " + id);
    }

    private String getSuccessMessage(String action) {
        switch (action) {
            case "ajouter":
                return "Destination ajoutée avec succès !";
            case "modifier":
                return "Destination modifiée avec succès !";
            case "supprimer":
                return "Destination supprimée avec succès !";
            default:
                return "Opération réalisée avec succès !";
        }
    }

    @Override
    public void destroy() {
        System.out.println("DestinationServlet détruit");
        super.destroy();
    }
}