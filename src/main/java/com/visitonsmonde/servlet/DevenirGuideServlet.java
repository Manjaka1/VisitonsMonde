package com.visitonsmonde.servlet;


import com.visitonsmonde.dao.GuideDAO;
import com.visitonsmonde.dao.UtilisateurDAO;
import com.visitonsmonde.model.Guide;
import com.visitonsmonde.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/devenir-guide")
public class DevenirGuideServlet extends HttpServlet {

    private GuideDAO guideDAO;
    private UtilisateurDAO utilisateurDAO;

    @Override
    public void init() {
        guideDAO = new GuideDAO();
        utilisateurDAO = new UtilisateurDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Afficher le formulaire
        request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== DEVENIR GUIDE SERVLET ===");

        // Récupérer les paramètres
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String motDePasse = request.getParameter("motDePasse");
        String confirmation = request.getParameter("confirmation");
        String specialite = request.getParameter("specialite");
        String experienceAnneesStr = request.getParameter("experienceAnnees");
        String languesParlees = request.getParameter("languesParlees");
        String description = request.getParameter("description");

        System.out.println("Candidature guide:");
        System.out.println("Nom: " + nom + " " + prenom);
        System.out.println("Email: " + email);
        System.out.println("Spécialité: " + specialite);

        // Validation
        if (prenom == null || prenom.trim().isEmpty() ||
                nom == null || nom.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                motDePasse == null || motDePasse.isEmpty() ||
                confirmation == null || confirmation.isEmpty()) {

            request.setAttribute("erreur", "Tous les champs obligatoires doivent être remplis.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        // Vérifier que les mots de passe correspondent
        if (!motDePasse.equals(confirmation)) {
            request.setAttribute("erreur", "Les mots de passe ne correspondent pas.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        // Vérifier la longueur du mot de passe
        if (motDePasse.length() < 6) {
            request.setAttribute("erreur", "Le mot de passe doit contenir au moins 6 caractères.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        try {
            // Vérifier si l'email existe déjà
            if (utilisateurDAO.emailExists(email)) {
                request.setAttribute("erreur", "Un compte existe déjà avec cet email.");
                request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
                return;
            }

            // 1. CRÉER LE COMPTE UTILISATEUR avec rôle GUIDE
            Utilisateur utilisateur = new Utilisateur();
            utilisateur.setPrenom(prenom.trim());
            utilisateur.setNom(nom.trim());
            utilisateur.setEmail(email.trim());
            utilisateur.setMotDePasse(motDePasse);
            utilisateur.setRole("GUIDE");
            utilisateur.setEstActif(false); // Inactif tant que non validé par admin

            boolean userCreated = utilisateurDAO.create(utilisateur);

            if (!userCreated) {
                request.setAttribute("erreur", "Erreur lors de la création du compte.");
                request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
                return;
            }

            // Récupérer l'utilisateur créé pour avoir son ID
            Utilisateur utilisateurCree = utilisateurDAO.findByEmail(email);

            if (utilisateurCree == null) {
                request.setAttribute("erreur", "Erreur lors de la récupération du compte.");
                request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
                return;
            }

            // 2. CRÉER LA FICHE GUIDE
            Guide guide = new Guide();
            guide.setNom(nom.trim());
            guide.setPrenom(prenom.trim());
            guide.setEmail(email.trim());
            guide.setTelephone(telephone != null ? telephone.trim() : "");
            guide.setSpecialite(specialite);
            guide.setLanguesParlees(languesParlees != null ? languesParlees.trim() : "");
            guide.setDescription(description != null ? description.trim() : "");
            guide.setUtilisateurId(utilisateurCree.getId());
            guide.setStatut("EN_ATTENTE"); // Statut en attente de validation
            guide.setUtilisateurId(utilisateur.getId());
            // Gérer l'expérience
            if (experienceAnneesStr != null && !experienceAnneesStr.trim().isEmpty()) {
                guide.setExperienceAnnees(Integer.parseInt(experienceAnneesStr));
            }

            boolean guideCreated = guideDAO.create(guide);

            if (guideCreated) {
                System.out.println("✅ Candidature guide créée avec succès !");
                System.out.println("   Email: " + email);
                System.out.println("   Statut: EN_ATTENTE");

                request.setAttribute("messageSucces",
                        "Votre candidature a été envoyée avec succès ! " +
                                "Notre équipe va l'examiner et vous recevrez un email dans les prochains jours. 🎉");
                request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            } else {
                request.setAttribute("erreur", "Erreur lors de l'enregistrement de votre candidature.");
                request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "Erreur dans les données numériques.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("❌ Erreur candidature guide: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("erreur", "Erreur technique. Veuillez réessayer.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
        }
    }
}