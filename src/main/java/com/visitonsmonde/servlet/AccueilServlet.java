package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.DestinationDAO;
import com.visitonsmonde.dao.ReservationDAO;
import com.visitonsmonde.dao.UtilisateurDAO;
import com.visitonsmonde.model.Destination;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet({"/accueil", "/home"})
public class AccueilServlet extends HttpServlet {

    private DestinationDAO destinationDAO;
    private ReservationDAO reservationDAO;
    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() throws ServletException {
        destinationDAO = new DestinationDAO();
        reservationDAO = new ReservationDAO();
        utilisateurDAO = new UtilisateurDAO();
        System.out.println("✅ AccueilServlet initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1️⃣ TOP 6 DESTINATIONS POPULAIRES
            List<Destination> destinationsPopulaires = destinationDAO.getTopDestinations(6);
            request.setAttribute("destinationsPopulaires", destinationsPopulaires);

            // 2️⃣ STATISTIQUES
            int totalDestinations = destinationDAO.count();
            int totalClients = utilisateurDAO.countByRole("CLIENT");
            int totalReservations = reservationDAO.count();

            request.setAttribute("totalDestinations", totalDestinations);
            request.setAttribute("totalClients", totalClients);
            request.setAttribute("totalReservations", totalReservations);

            System.out.println("📊 Stats chargées: " + totalDestinations + " destinations, " + totalClients + " clients");

            // 3️⃣ FORWARD VERS INDEX.JSP
            request.getRequestDispatcher("/index.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erreur lors du chargement de la page d'accueil", e);
        }
    }
}