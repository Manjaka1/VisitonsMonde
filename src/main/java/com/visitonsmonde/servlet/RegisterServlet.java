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
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== REGISTER SERVLET ===");

        // Récupérer les paramètres du formulaire
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        String confirmation = request.getParameter("confirmation");

        System.out.println("Tentative d'inscription:");
        System.out.println("Prénom: " + prenom);
        System.out.println("Nom: " + nom);
        System.out.println("Email: " + email);

        // Validation des champs
        if (prenom == null || prenom.trim().isEmpty() ||
                nom == null || nom.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                motDePasse == null || motDePasse.isEmpty() ||
                confirmation == null || confirmation.isEmpty()) {

            request.setAttribute("erreur", "Tous les champs sont obligatoires.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // Vérifier que les mots de passe correspondent
        if (!motDePasse.equals(confirmation)) {
            request.setAttribute("erreur", "Les mots de passe ne correspondent pas.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        // Vérifier la longueur du mot de passe
        if (motDePasse.length() < 6) {
            request.setAttribute("erreur", "Le mot de passe doit contenir au moins 6 caractères.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        try {
            UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

            // Vérifier si l'email existe déjà
            if (utilisateurDAO.emailExists(email)) {
                request.setAttribute("erreur", "Un compte existe déjà avec cet email.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                return;
            }

            // ===== DÉTERMINER SI L'UTILISATEUR EST ADMIN =====
            boolean isAdmin = false;

            // 1️⃣ Le PREMIER utilisateur est automatiquement ADMIN
            if (utilisateurDAO.findAll().isEmpty()) {
                isAdmin = true;
                System.out.println("🔥 PREMIER UTILISATEUR = ADMIN AUTOMATIQUE");
            }
            // 2️⃣ Les emails spécifiques sont ADMIN
            else if (email.endsWith("@visitonsmonde.com") ||
                    email.endsWith("@admin.com") ||
                    email.equals("admin@gmail.com")) {
                isAdmin = true;
                System.out.println("✅ EMAIL ADMIN RECONNU = ADMIN");
            }
            // 3️⃣ Tous les autres sont utilisateurs normaux
            else {
                isAdmin = false;
                System.out.println("👤 UTILISATEUR NORMAL");
            }

            // Créer le nouvel utilisateur
            Utilisateur nouvelUtilisateur = new Utilisateur();
            nouvelUtilisateur.setPrenom(prenom.trim());
            nouvelUtilisateur.setNom(nom.trim());
            nouvelUtilisateur.setEmail(email.trim());
            nouvelUtilisateur.setMotDePasse(motDePasse); // En production, il faut hasher le mot de passe !
            if (isAdmin) {
                nouvelUtilisateur.setRole("ADMIN");
            } else {
                nouvelUtilisateur.setRole("USER");
            }

            // Insérer en base de données
            boolean success = utilisateurDAO.create(nouvelUtilisateur);

            if (success) {
                System.out.println("✅ Utilisateur créé avec succès !");
                System.out.println("   Admin: " + isAdmin);

                // Récupérer l'utilisateur complet depuis la BDD
                Utilisateur utilisateurComplet = utilisateurDAO.findByEmail(email);

                if (utilisateurComplet != null) {
                    // Créer la session
                    HttpSession session = request.getSession();
                    session.setAttribute("utilisateur", utilisateurComplet);

                    System.out.println("✅ Session créée pour: " + utilisateurComplet.getEmail());
                    System.out.println("   ID: " + utilisateurComplet.getId());
                    System.out.println("   Admin: " + utilisateurComplet.isAdmin());

                    // Message de bienvenue personnalisé
                    if (isAdmin) {
                        session.setAttribute("messageSucces", "Bienvenue " + prenom + " ! Vous êtes administrateur. 🔐");
                        // Rediriger vers la page admin
                        response.sendRedirect(request.getContextPath() + "/admin");
                    } else {
                        session.setAttribute("messageSucces", "Bienvenue " + prenom + " ! Votre compte a été créé avec succès. 🎉");
                        // Rediriger vers la page d'accueil
                        response.sendRedirect(request.getContextPath() + "/index.jsp");
                    }
                } else {
                    request.setAttribute("erreur", "Erreur lors de la récupération du compte.");
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("erreur", "Erreur lors de la création du compte.");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.err.println("❌ Erreur inattendue:");
            e.printStackTrace();
            request.setAttribute("erreur", "Erreur inattendue. Veuillez réessayer.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}