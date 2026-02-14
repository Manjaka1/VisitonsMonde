package com.visitonsmonde.dao;

import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.model.Guide;
import java.sql.Types;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class GuideDAO {

    private Connection getConnection() throws SQLException {
        return DAOFactory.getConnection();
    }

    public boolean create(Guide guide) {
        String sql = """
        INSERT INTO guides
        (nom, prenom, specialite, experience_annees, langues_parlees,
         photo, description, note_moyenne, email, telephone, date_embauche, statut, utilisateur_id)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """;

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {
            stmt.setString(1, guide.getNom());
            stmt.setString(2, guide.getPrenom());
            stmt.setString(3, guide.getSpecialite());
            stmt.setInt(4, guide.getExperienceAnnees());
            stmt.setString(5, guide.getLanguesParlees());
            stmt.setString(6, guide.getPhoto());
            stmt.setString(7, guide.getDescription());
            stmt.setBigDecimal(8, guide.getNoteMoyenne());
            stmt.setString(9, guide.getEmail());
            stmt.setString(10, guide.getTelephone());
            stmt.setDate(11, guide.getDateEmbauche());
            stmt.setString(12, guide.getStatut());

            if (guide.getUtilisateurId() != null) {
                stmt.setInt(13, guide.getUtilisateurId());
            } else {
                stmt.setNull(13, Types.INTEGER);
            }

            if (stmt.executeUpdate() > 0) {
                ResultSet keys = stmt.getGeneratedKeys();
                if (keys.next()) {
                    guide.setId(keys.getInt(1));
                }
                System.out.println("Guide créé : " + guide.getNomComplet());
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR création guide : " + e.getMessage());
        }
        return false;
    }
    public Guide findById(int id) {
        String sql = "SELECT * FROM guides WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractGuide(rs);
            }
        } catch (SQLException e) {
            System.err.println("ERREUR findById guide : " + e.getMessage());
        }
        return null;
    }

    public Guide findByUtilisateurId(int utilisateurId) {
        String sql = "SELECT * FROM guides WHERE utilisateur_id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, utilisateurId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractGuide(rs);
            }
        } catch (SQLException e) {
            System.err.println("ERREUR findByUtilisateurId guide : " + e.getMessage());
        }
        return null;
    }

    public List<Guide> findAll() {
        List<Guide> guides = new ArrayList<>();
        String sql = "SELECT * FROM guides ORDER BY nom, prenom";

        try (
                Connection connection = getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)
        ) {
            while (rs.next()) {
                guides.add(extractGuide(rs));
            }
            System.out.println("Nombre de guides : " + guides.size());
        } catch (SQLException e) {
            System.err.println("ERREUR findAll guides : " + e.getMessage());
        }
        return guides;
    }

    public List<Guide> findBySpecialite(String specialite) {
        List<Guide> guides = new ArrayList<>();
        String sql = "SELECT * FROM guides WHERE LOWER(specialite) LIKE LOWER(?)";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, "%" + specialite + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                guides.add(extractGuide(rs));
            }
        } catch (SQLException e) {
            System.err.println("ERREUR recherche spécialité : " + e.getMessage());
        }
        return guides;
    }

    public boolean update(Guide guide) {
        String sql = """
        UPDATE guides SET
        nom = ?, prenom = ?, specialite = ?, experience_annees = ?,
        langues_parlees = ?, photo = ?, description = ?, note_moyenne = ?,
        email = ?, telephone = ?, date_embauche = ?, statut = ?, utilisateur_id = ?
        WHERE id = ?
    """;

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, guide.getNom());
            stmt.setString(2, guide.getPrenom());
            stmt.setString(3, guide.getSpecialite());
            stmt.setInt(4, guide.getExperienceAnnees());
            stmt.setString(5, guide.getLanguesParlees());
            stmt.setString(6, guide.getPhoto());
            stmt.setString(7, guide.getDescription());
            stmt.setBigDecimal(8, guide.getNoteMoyenne());
            stmt.setString(9, guide.getEmail());
            stmt.setString(10, guide.getTelephone());
            stmt.setDate(11, guide.getDateEmbauche());
            stmt.setString(12, guide.getStatut());

            if (guide.getUtilisateurId() != null) {
                stmt.setInt(13, guide.getUtilisateurId());
            } else {
                stmt.setNull(13, Types.INTEGER);
            }

            stmt.setInt(14, guide.getId());

            if (stmt.executeUpdate() > 0) {
                System.out.println("Guide mis à jour : #" + guide.getId());
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR update guide : " + e.getMessage());
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM guides WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);
            if (stmt.executeUpdate() > 0) {
                System.out.println("Guide supprimé : #" + id);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR suppression guide : " + e.getMessage());
        }
        return false;
    }

    private Guide extractGuide(ResultSet rs) throws SQLException {
        Guide guide = new Guide();

        guide.setId(rs.getInt("id"));
        guide.setNom(rs.getString("nom"));
        guide.setPrenom(rs.getString("prenom"));
        guide.setSpecialite(rs.getString("specialite"));
        guide.setExperienceAnnees(rs.getInt("experience_annees"));
        guide.setLanguesParlees(rs.getString("langues_parlees"));
        guide.setPhoto(rs.getString("photo"));
        guide.setDescription(rs.getString("description"));
        guide.setNoteMoyenne(rs.getBigDecimal("note_moyenne"));
        guide.setEmail(rs.getString("email"));
        guide.setTelephone(rs.getString("telephone"));
        guide.setDateEmbauche(rs.getDate("date_embauche"));

        // NOUVEAUX CHAMPS
        guide.setStatut(rs.getString("statut"));

        int utilisateurId = rs.getInt("utilisateur_id");
        if (!rs.wasNull()) {
            guide.setUtilisateurId(utilisateurId);
        }

        guide.setDateInscription(rs.getTimestamp("date_inscription"));

        return guide;
    }
}
