package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.GuideDAO;
import com.visitonsmonde.model.Guide;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GuidesServlet", urlPatterns = {"/guides"}, loadOnStartup = 1)
public class GuidesServlet extends HttpServlet {

    private GuideDAO guideDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        guideDAO = new GuideDAO();
        System.out.println("✅ GuidesServlet initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== GuidesServlet - Affichage des guides ===");

        try {
            // Récupérer TOUS les guides
            List<Guide> tousLesGuides = guideDAO.findAll();
            System.out.println("📊 Total guides en BDD : " + tousLesGuides.size());

            // DEBUG - Afficher le statut de chaque guide
            for (Guide g : tousLesGuides) {
                System.out.println("  - Guide #" + g.getId() + " : " + g.getNomComplet() + " → Statut: [" + g.getStatut() + "]");
            }

            // Filtrer pour ne garder que les guides ACTIFS
            List<Guide> guidesActifs = new ArrayList<>();
            for (Guide guide : tousLesGuides) {
                if ("ACTIF".equals(guide.getStatut())) {
                    guidesActifs.add(guide);
                    System.out.println("  ✅ Guide ACTIF ajouté : " + guide.getNomComplet());
                } else {
                    System.out.println("  ❌ Guide IGNORÉ (statut: " + guide.getStatut() + ") : " + guide.getNomComplet());
                }
            }

            System.out.println("📊 Guides actifs trouvés : " + guidesActifs.size() + " / " + tousLesGuides.size());

            // Passer les guides à la JSP
            request.setAttribute("guides", guidesActifs);

        } catch (Exception e) {
            System.err.println("❌ Erreur récupération guides : " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("guides", new ArrayList<>());
            request.setAttribute("erreur", "Erreur lors du chargement des guides.");
        }

        // Afficher la page
        request.getRequestDispatcher("/guides.jsp").forward(request, response);
    }
}