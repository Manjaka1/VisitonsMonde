package com.visitonsmonde.dao;


import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.model.Pays;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO pour accéder aux pays dans la base tourisme_db.
 * Basé exactement sur votre structure de table avec 4 colonnes.
 */
public class PaysDAO {

    /**
     * Récupère tous les pays de la base.
     */
    public List<Pays> getAllPays() throws SQLException {
        List<Pays> paysList = new ArrayList<>();
        String sql = "SELECT id, nom, code, continent FROM pays ORDER BY nom";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Pays pays = mapResultSetToPays(rs);
                paysList.add(pays);
            }

            System.out.println("PaysDAO: " + paysList.size() + " pays récupérés");

        } catch (SQLException e) {
            System.err.println("Erreur dans getAllPays: " + e.getMessage());
            throw e;
        }

        return paysList;
    }

    /**
     * Recherche un pays par son ID.
     */
    public Pays getPaysById(int id) throws SQLException {
        String sql = "SELECT id, nom, code, continent FROM pays WHERE id = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPays(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur dans getPaysById: " + e.getMessage());
            throw e;
        }

        return null;
    }

    /**
     * Recherche un pays par son code (ex: "FR", "USA").
     */
    public Pays getPaysByCode(String code) throws SQLException {
        String sql = "SELECT id, nom, code, continent FROM pays WHERE code = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, code.toUpperCase());

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPays(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur dans getPaysByCode: " + e.getMessage());
            throw e;
        }

        return null;
    }

    /**
     * Recherche des pays par continent.
     */
    public List<Pays> getPaysByContinent(String continent) throws SQLException {
        List<Pays> paysList = new ArrayList<>();
        String sql = "SELECT id, nom, code, continent FROM pays WHERE continent = ? ORDER BY nom";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, continent);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    paysList.add(mapResultSetToPays(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur dans getPaysByContinent: " + e.getMessage());
            throw e;
        }

        return paysList;
    }

    /**
     * Ajoute un nouveau pays.
     * Utilise seulement les 4 colonnes de votre table.
     */
    public void ajouterPays(Pays pays) throws SQLException {
        if (pays == null || !pays.isValide()) {
            throw new IllegalArgumentException("Pays invalide");
        }

        String sql = "INSERT INTO pays (nom, code, continent) VALUES (?, ?, ?)";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, pays.getNom().trim());
            stmt.setString(2, pays.getCode().trim().toUpperCase());
            stmt.setString(3, pays.getContinent() != null ? pays.getContinent().trim() : null);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Récupérer l'ID généré
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        pays.setId(generatedKeys.getInt(1));
                    }
                }
                System.out.println("PaysDAO: Pays ajouté - " + pays.getNom() + " (" + pays.getCode() + ")");
            } else {
                throw new SQLException("Échec de l'ajout du pays, aucune ligne affectée");
            }

        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate entry")) {
                throw new SQLException("Un pays avec ce code existe déjà : " + pays.getCode());
            }
            System.err.println("Erreur dans ajouterPays: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Met à jour un pays existant.
     * Utilise seulement les 4 colonnes de votre table.
     */
    public void modifierPays(Pays pays) throws SQLException {
        if (pays == null || !pays.isValide()) {
            throw new IllegalArgumentException("Pays invalide");
        }

        String sql = "UPDATE pays SET nom = ?, code = ?, continent = ? WHERE id = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, pays.getNom().trim());
            stmt.setString(2, pays.getCode().trim().toUpperCase());
            stmt.setString(3, pays.getContinent() != null ? pays.getContinent().trim() : null);
            stmt.setInt(4, pays.getId());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Aucun pays trouvé avec l'ID : " + pays.getId());
            }

            System.out.println("PaysDAO: Pays modifié - " + pays.getNom() + " (" + pays.getCode() + ")");

        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate entry")) {
                throw new SQLException("Un autre pays utilise déjà ce code : " + pays.getCode());
            }
            System.err.println("Erreur dans modifierPays: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Supprime un pays par son ID.
     */
    public void supprimerPays(int id) throws SQLException {
        // Vérifier d'abord si le pays existe
        Pays paysExistant = getPaysById(id);
        if (paysExistant == null) {
            throw new SQLException("Aucun pays trouvé avec l'ID : " + id);
        }

        String sql = "DELETE FROM pays WHERE id = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected == 0) {
                throw new SQLException("Échec de la suppression du pays ID : " + id);
            }

            System.out.println("PaysDAO: Pays supprimé - ID " + id + " (" + paysExistant.getNom() + ")");

        } catch (SQLException e) {
            System.err.println("Erreur dans supprimerPays: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Récupère tous les continents distincts.
     */
    public List<String> getAllContinents() throws SQLException {
        List<String> continents = new ArrayList<>();
        String sql = "SELECT DISTINCT continent FROM pays WHERE continent IS NOT NULL ORDER BY continent";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String continent = rs.getString("continent");
                if (continent != null && !continent.trim().isEmpty()) {
                    continents.add(continent);
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur dans getAllContinents: " + e.getMessage());
            throw e;
        }

        return continents;
    }

    /**
     * Compte le nombre de pays par continent.
     */
    public int compterPaysByContinent(String continent) throws SQLException {
        String sql = "SELECT COUNT(*) FROM pays WHERE continent = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, continent);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur dans compterPaysByContinent: " + e.getMessage());
            throw e;
        }

        return 0;
    }

    /**
     * Recherche des pays par nom (recherche partielle).
     */
    public List<Pays> rechercherPays(String motCle) throws SQLException {
        List<Pays> paysList = new ArrayList<>();
        String sql = "SELECT id, nom, code, continent FROM pays WHERE nom LIKE ? ORDER BY nom";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String pattern = "%" + motCle + "%";
            stmt.setString(1, pattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    paysList.add(mapResultSetToPays(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur dans rechercherPays: " + e.getMessage());
            throw e;
        }

        return paysList;
    }

    /**
     * Compte le nombre total de pays.
     */
    public int compterPays() throws SQLException {
        String sql = "SELECT COUNT(*) FROM pays";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Erreur dans compterPays: " + e.getMessage());
            throw e;
        }

        return 0;
    }

    /**
     * Méthode utilitaire pour mapper un ResultSet vers un objet Pays.
     * IMPORTANTE : Utilise seulement les 4 colonnes de votre table.
     */
    private Pays mapResultSetToPays(ResultSet rs) throws SQLException {
        Pays pays = new Pays();
        pays.setId(rs.getInt("id"));
        pays.setNom(rs.getString("nom"));
        pays.setCode(rs.getString("code"));
        pays.setContinent(rs.getString("continent"));

        // Les autres attributs restent null car ils ne sont pas en BDD
        // Ils peuvent être utilisés par l'application si nécessaire

        return pays;
    }

    /**
     * Méthode de test pour vérifier le bon fonctionnement du DAO.
     */
    public static void main(String[] args) {
        System.out.println("=== TEST PAYS DAO (Votre Structure) ===");

        try {
            PaysDAO dao = new PaysDAO();

            // Test 1: Lister les pays
            System.out.println("\n1. Test getAllPays:");
            List<Pays> tous = dao.getAllPays();
            System.out.println("   Nombre de pays: " + tous.size());

            for (int i = 0; i < Math.min(5, tous.size()); i++) {
                Pays p = tous.get(i);
                System.out.println("   • " + p.getNom() + " (" + p.getCode() + ") - " + p.getContinent());
            }

            // Test 2: Compter les pays
            System.out.println("\n2. Test compterPays:");
            int total = dao.compterPays();
            System.out.println("   Total: " + total + " pays");

            // Test 3: Lister les continents
            System.out.println("\n3. Test getAllContinents:");
            List<String> continents = dao.getAllContinents();
            for (String continent : continents) {
                int nb = dao.compterPaysByContinent(continent);
                System.out.println("   • " + continent + ": " + nb + " pays");
            }

            System.out.println("\n✅ Tests réussis - DAO fonctionnel");

        } catch (Exception e) {
            System.err.println("❌ Erreur durant les tests:");
            System.err.println("   " + e.getMessage());
            e.printStackTrace();
        }
    }
}