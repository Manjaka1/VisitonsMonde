package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.GuideDAO;
import com.visitonsmonde.dao.UtilisateurDAO;
import com.visitonsmonde.model.Guide;
import com.visitonsmonde.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/devenir-guide")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 5,        // 5MB
        maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class DevenirGuideServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO;
    private GuideDAO guideDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        utilisateurDAO = new UtilisateurDAO();
        guideDAO = new GuideDAO();
        System.out.println("✅ DevenirGuideServlet initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== DEVENIR GUIDE SERVLET ===");

        // Récupérer les données du formulaire
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

        // Validation des champs obligatoires
        if (prenom == null || nom == null || email == null || telephone == null ||
                motDePasse == null || confirmation == null || specialite == null ||
                experienceAnneesStr == null || languesParlees == null || description == null) {
            request.setAttribute("erreur", "Tous les champs obligatoires doivent être remplis.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        // Vérifier la correspondance des mots de passe
        if (!motDePasse.equals(confirmation)) {
            request.setAttribute("erreur", "Les mots de passe ne correspondent pas.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        // Vérifier la longueur minimale du mot de passe
        if (motDePasse.length() < 6) {
            request.setAttribute("erreur", "Le mot de passe doit contenir au moins 6 caractères.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        // Convertir experienceAnnees en int
        int experienceAnnees;
        try {
            experienceAnnees = Integer.parseInt(experienceAnneesStr);
        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "Années d'expérience invalides.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        // Vérifier si l'email existe déjà
        if (utilisateurDAO.emailExists(email)) {
            request.setAttribute("erreur", "Cet email est déjà utilisé.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        // Gérer l'upload de la photo
        String photoFilename = null;
        try {
            Part photoPart = request.getPart("photo");
            if (photoPart != null && photoPart.getSize() > 0) {
                photoFilename = uploadPhoto(photoPart);
                System.out.println("📸 Photo uploadée: " + photoFilename);
            }
        } catch (Exception e) {
            System.err.println("⚠️ Erreur upload photo (continuons quand même): " + e.getMessage());
        }

        // Créer l'utilisateur
        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setPrenom(prenom);
        utilisateur.setNom(nom);
        utilisateur.setEmail(email);
        utilisateur.setMotDePasse(motDePasse);
        utilisateur.setRole("GUIDE");
        utilisateur.setEstActif(false); // Inactif jusqu'à approbation

        boolean userCreated = utilisateurDAO.create(utilisateur);

        if (!userCreated) {
            request.setAttribute("erreur", "Erreur lors de la création du compte.");
            request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
            return;
        }

        // Créer le guide
        Guide guide = new Guide();
        guide.setNom(nom);
        guide.setPrenom(prenom);
        guide.setEmail(email);
        guide.setTelephone(telephone);
        guide.setSpecialite(specialite);
        guide.setExperienceAnnees(experienceAnnees);
        guide.setLanguesParlees(languesParlees);
        guide.setDescription(description);
        guide.setStatut("EN_ATTENTE");
        guide.setUtilisateurId(utilisateur.getId());

        // Ajouter le nom de la photo si elle a été uploadée
        if (photoFilename != null) {
            guide.setPhoto(photoFilename);
        }

        boolean guideCreated = guideDAO.create(guide);

        if (guideCreated) {
            System.out.println("✅ Candidature guide créée avec succès !");
            System.out.println("   Email: " + email);
            System.out.println("   Statut: EN_ATTENTE");
            if (photoFilename != null) {
                System.out.println("   Photo: " + photoFilename);
            }

            request.setAttribute("messageSucces",
                    "Votre candidature a été envoyée avec succès ! " +
                            "Notre équipe va l'examiner et vous recevrez un email dans les prochains jours. 🎉");
        } else {
            request.setAttribute("erreur", "Erreur lors de la création de votre fiche guide.");
        }

        request.getRequestDispatcher("/devenir-guide.jsp").forward(request, response);
    }

    /**
     * Upload la photo et retourne le nom du fichier
     */
    private String uploadPhoto(Part photoPart) throws IOException {
        // Récupérer le nom original du fichier
        String originalFilename = getFileName(photoPart);

        // Générer un nom unique
        String extension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String uniqueFilename = "guide-" + System.currentTimeMillis() + extension;

        // Chemin de destination
        String uploadPath = getServletContext().getRealPath("/") + "img" + File.separator + "guides";

        // Créer le dossier s'il n'existe pas
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
            System.out.println("📁 Dossier créé: " + uploadPath);
        }

        // Sauvegarder le fichier
        Path filePath = Paths.get(uploadPath, uniqueFilename);
        Files.copy(photoPart.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        System.out.println("✅ Photo sauvegardée: " + filePath);

        return "guides/" + uniqueFilename;
    }

    /**
     * Extraire le nom du fichier de la Part
     */
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }
}