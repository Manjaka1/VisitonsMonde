package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.GuideDAO;
import com.visitonsmonde.model.Guide;
import com.visitonsmonde.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/espace-guide")
public class EspaceGuideServlet extends HttpServlet {

    private GuideDAO guideDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        guideDAO = new GuideDAO();
        System.out.println("✅ EspaceGuideServlet initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== ESPACE GUIDE ===");

        // Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (session != null) ? (Utilisateur) session.getAttribute("utilisateur") : null;

        if (utilisateur == null) {
            System.out.println("❌ Utilisateur non connecté - redirection vers login");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Vérifier que c'est un guide
        if (!"GUIDE".equals(utilisateur.getRole())) {
            System.out.println("❌ Utilisateur n'est pas un guide - redirection vers index");
            session.setAttribute("erreur", "Accès réservé aux guides.");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Récupérer les infos du guide via l'ID utilisateur
        Guide guide = guideDAO.findByUtilisateurId(utilisateur.getId());

        if (guide == null) {
            System.out.println("❌ Fiche guide non trouvée pour utilisateur #" + utilisateur.getId());
            session.setAttribute("erreur", "Votre fiche guide n'a pas été trouvée. Contactez l'administrateur.");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Vérifier que le guide est actif
        if (!"ACTIF".equals(guide.getStatut())) {
            System.out.println("⏳ Guide non actif - statut: " + guide.getStatut());
            session.setAttribute("erreur", "Votre compte guide est en attente de validation.");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        System.out.println("✅ Guide trouvé: " + guide.getNomComplet() + " (ID: " + guide.getId() + ")");

        // Passer les données à la JSP
        request.setAttribute("guide", guide);
        request.setAttribute("utilisateur", utilisateur);

        // Afficher la page
        request.getRequestDispatcher("/espace-guide.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Pour l'instant, rediriger vers doGet
        // Plus tard on ajoutera la modification de profil
        doGet(request, response);
    }
}