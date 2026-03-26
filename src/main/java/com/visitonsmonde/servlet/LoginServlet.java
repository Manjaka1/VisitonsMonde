package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.UtilisateurDAO;
import com.visitonsmonde.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() {
        utilisateurDAO = new UtilisateurDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");

        System.out.println("Tentative de connexion:");
        System.out.println("Email: " + email);

        try {
            // Authentification normale via la base de données
            Utilisateur utilisateur = utilisateurDAO.authenticate(email, motDePasse);

            if (utilisateur != null) {
                // Connexion réussie
                HttpSession session = request.getSession();
                session.setAttribute("utilisateur", utilisateur);

                System.out.println("✅ Utilisateur connecté: " + utilisateur.getEmail());
                System.out.println("   Rôle: " + utilisateur.getRole());
                System.out.println("   Est admin: " + utilisateur.isAdmin());

                // REDIRECTION SELON LE RÔLE
                if (utilisateur.isAdmin() || "ADMIN".equals(utilisateur.getRole())) {
                    System.out.println("🔐 Admin connecté - redirection vers /admin");
                    response.sendRedirect(request.getContextPath() + "/admin");
                } else {
                    System.out.println("👤 Utilisateur normal - redirection vers /accueil");
                    response.sendRedirect(request.getContextPath() + "/accueil");
                }
                return;
            } else {
                // Échec de connexion
                System.out.println(" Échec de connexion pour: " + email);
                request.setAttribute("erreur", " Email ou mot de passe incorrect. Veuillez réessayer.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println(" Erreur de connexion: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("erreur", " Erreur de connexion. Veuillez réessayer.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}