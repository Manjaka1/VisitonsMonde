package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.DestinationDAO;
import com.visitonsmonde.model.Destination;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/destination-details")
public class DestinationDetailsServlet extends HttpServlet {
    private DestinationDAO destinationDAO;

    @Override
    public void init() {
        destinationDAO = new DestinationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/destinations");
            return;
        }

        try {
            int destinationId = Integer.parseInt(idParam);
            Destination destination = destinationDAO.getDestinationById(destinationId);

            if (destination == null) {
                response.sendRedirect(request.getContextPath() + "/destinations");
                return;
            }

            // Récupérer les destinations similaires
            List<Destination> similarDestinations = getSimilarDestinations(destination);

            request.setAttribute("destination", destination);
            request.setAttribute("similarDestinations", similarDestinations);

            request.getRequestDispatcher("/destination-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/destinations");
        } catch (SQLException e) {
            throw new ServletException("Erreur lors de la récupération de la destination", e);
        }
    }

    private List<Destination> getSimilarDestinations(Destination currentDestination) throws SQLException {
        List<Destination> allDestinations = destinationDAO.getAllDestinations();
        List<Destination> similar = new ArrayList<>();

        for (Destination dest : allDestinations) {
            // Ne pas inclure la destination actuelle
            if (dest.getId().equals(currentDestination.getId())) {
                continue;
            }

            // Critères de similarité : même pays OU prix proche (±500€)
            boolean samePays = dest.getPays() != null &&
                    dest.getPays().equals(currentDestination.getPays());

            boolean similarPrice = false;
            if (dest.getPrix() != null && currentDestination.getPrix() != null) {
                // Convertir BigDecimal en double pour calculer la différence
                double currentPrice = currentDestination.getPrix().doubleValue();
                double destPrice = dest.getPrix().doubleValue();
                double priceDiff = Math.abs(destPrice - currentPrice);
                similarPrice = priceDiff <= 500;
            }

            if (samePays || similarPrice) {
                similar.add(dest);
                if (similar.size() >= 3) {
                    break;
                }
            }
        }

        return similar;
    }
}