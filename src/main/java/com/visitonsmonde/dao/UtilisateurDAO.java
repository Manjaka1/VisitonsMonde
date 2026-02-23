package com.visitonsmonde.dao;

import com.visitonsmonde.model.Utilisateur;
import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtilisateurDAO {

    private Connection getConnection() throws SQLException {
        return DAOFactory.getConnection();
    }

    public boolean create(Utilisateur utilisateur) {
        String sql = "INSERT INTO utilisateurs (nom, prenom, email, mot_de_passe, role, est_actif) VALUES (?, ?, ?, ?, ?, ?)";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getPrenom());
            stmt.setString(3, utilisateur.getEmail());
            // ✅ HACHAGE DU MOT DE PASSE AVEC BCRYPT
            String hashedPassword = PasswordUtil.hashPassword(utilisateur.getMotDePasse());
            stmt.setString(4, hashedPassword);
            stmt.setString(5, utilisateur.getRole());
            stmt.setBoolean(6, utilisateur.isEstActif());

            int lignesAffectees = stmt.executeUpdate();

            if (lignesAffectees > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    utilisateur.setId(generatedKeys.getInt(1));
                }

                Utilisateur created = findById(utilisateur.getId());
                if (created != null) {
                    utilisateur.setDateInscription(created.getDateInscription());
                }

                System.out.println("✅ Utilisateur créé avec mot de passe haché : " + utilisateur.getEmail());
                return true;
            }
        } catch (SQLException e) {
            System.err.println("❌ ERREUR lors de la création de l'utilisateur : " + e.getMessage());
        }

        return false;
    }

    public Utilisateur authenticate(String email, String motDePasse) {
        // ✅ On ne compare PLUS directement le mot de passe dans le SQL !
        String sql = "SELECT * FROM utilisateurs WHERE email = ? AND est_actif = TRUE";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hashedPasswordFromDB = rs.getString("mot_de_passe");

                // ✅ VÉRIFICATION AVEC BCRYPT !
                if (PasswordUtil.checkPassword(motDePasse, hashedPasswordFromDB)) {
                    Utilisateur user = extractUtilisateurFromResultSet(rs);
                    System.out.println("✅ Authentification réussie pour : " + email);
                    updateLastConnection(user.getId());
                    return user;
                } else {
                    System.out.println("❌ Mot de passe incorrect pour : " + email);
                }
            } else {
                System.out.println("❌ Email non trouvé : " + email);
            }
        } catch (SQLException e) {
            System.err.println("❌ ERREUR lors de l'authentification : " + e.getMessage());
        }

        return null;
    }

    private void updateLastConnection(int userId) {
        String sql = "UPDATE utilisateurs SET date_derniere_connexion = CURRENT_TIMESTAMP WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("ERREUR lors de la mise à jour de la dernière connexion : " + e.getMessage());
        }
    }

    public Utilisateur findById(int id) {
        String sql = "SELECT * FROM utilisateurs WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractUtilisateurFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors de la recherche de l'utilisateur #" + id + " : " + e.getMessage());
        }

        return null;
    }

    public Utilisateur findByEmail(String email) {
        String sql = "SELECT * FROM utilisateurs WHERE email = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractUtilisateurFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors de la recherche par email : " + e.getMessage());
        }

        return null;
    }

    public List<Utilisateur> findAll() {
        List<Utilisateur> utilisateurs = new ArrayList<>();
        String sql = "SELECT * FROM utilisateurs ORDER BY date_inscription DESC";

        try (
                Connection connection = getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)
        ) {
            while (rs.next()) {
                utilisateurs.add(extractUtilisateurFromResultSet(rs));
            }

            System.out.println("Nombre d'utilisateurs trouvés : " + utilisateurs.size());

        } catch (SQLException e) {
            System.err.println("ERREUR lors de la récupération des utilisateurs : " + e.getMessage());
        }

        return utilisateurs;
    }

    public List<Utilisateur> searchByName(String keyword) {
        List<Utilisateur> resultats = new ArrayList<>();
        String sql = "SELECT * FROM utilisateurs WHERE " +
                "LOWER(nom) LIKE LOWER(?) OR LOWER(prenom) LIKE LOWER(?) " +
                "ORDER BY nom, prenom";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            String pattern = "%" + keyword + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                resultats.add(extractUtilisateurFromResultSet(rs));
            }

            System.out.println("Recherche '" + keyword + "' : " + resultats.size() + " résultats");

        } catch (SQLException e) {
            System.err.println("ERREUR lors de la recherche : " + e.getMessage());
        }

        return resultats;
    }

    public List<Utilisateur> findRecentUsers(int joursMax) {
        List<Utilisateur> recents = new ArrayList<>();
        String sql = "SELECT * FROM utilisateurs WHERE " +
                "date_inscription >= DATE_SUB(NOW(), INTERVAL ? DAY) " +
                "ORDER BY date_inscription DESC";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, joursMax);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                recents.add(extractUtilisateurFromResultSet(rs));
            }

            System.out.println("Utilisateurs des " + joursMax + " derniers jours : " + recents.size());

        } catch (SQLException e) {
            System.err.println("ERREUR lors de la recherche des utilisateurs récents : " + e.getMessage());
        }

        return recents;
    }

    public boolean update(Utilisateur utilisateur) {
        String sql = "UPDATE utilisateurs SET nom = ?, prenom = ?, email = ?, role = ?, est_actif = ? WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getPrenom());
            stmt.setString(3, utilisateur.getEmail());
            stmt.setString(4, utilisateur.getRole());
            stmt.setBoolean(5, utilisateur.isEstActif());
            stmt.setInt(6, utilisateur.getId());

            int lignesModifiees = stmt.executeUpdate();

            if (lignesModifiees > 0) {
                System.out.println("Utilisateur #" + utilisateur.getId() + " mis à jour");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors de la mise à jour : " + e.getMessage());
        }

        return false;
    }

    public boolean updatePassword(int id, String nouveauMotDePasse) {
        String sql = "UPDATE utilisateurs SET mot_de_passe = ? WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            // ✅ HACHAGE DU NOUVEAU MOT DE PASSE !
            String hashedPassword = PasswordUtil.hashPassword(nouveauMotDePasse);
            stmt.setString(1, hashedPassword);
            stmt.setInt(2, id);

            if (stmt.executeUpdate() > 0) {
                System.out.println("✅ Mot de passe haché mis à jour pour l'utilisateur #" + id);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors du changement de mot de passe : " + e.getMessage());
        }

        return false;
    }

    public boolean desactiverCompte(int id) {
        String sql = "UPDATE utilisateurs SET est_actif = FALSE WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);

            if (stmt.executeUpdate() > 0) {
                System.out.println("Compte #" + id + " désactivé");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors de la désactivation : " + e.getMessage());
        }

        return false;
    }

    public boolean reactiverCompte(int id) {
        String sql = "UPDATE utilisateurs SET est_actif = TRUE WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);

            if (stmt.executeUpdate() > 0) {
                System.out.println("Compte #" + id + " réactivé");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors de la réactivation : " + e.getMessage());
        }

        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM utilisateurs WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);

            int lignesSupprimees = stmt.executeUpdate();

            if (lignesSupprimees > 0) {
                System.out.println("Utilisateur #" + id + " supprimé");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors de la suppression : " + e.getMessage());
        }

        return false;
    }

    public int count() {
        String sql = "SELECT COUNT(*) FROM utilisateurs";

        try (
                Connection connection = getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)
        ) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors du comptage : " + e.getMessage());
        }

        return 0;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM utilisateurs WHERE email = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR lors de la vérification de l'email : " + e.getMessage());
        }

        return true;
    }

    private Utilisateur extractUtilisateurFromResultSet(ResultSet rs) throws SQLException {
        Utilisateur utilisateur = new Utilisateur();

        utilisateur.setId(rs.getInt("id"));
        utilisateur.setNom(rs.getString("nom"));
        utilisateur.setPrenom(rs.getString("prenom"));
        utilisateur.setEmail(rs.getString("email"));
        utilisateur.setMotDePasse(rs.getString("mot_de_passe"));
        utilisateur.setRole(rs.getString("role"));
        utilisateur.setEstActif(rs.getBoolean("est_actif"));
        utilisateur.setDateInscription(rs.getTimestamp("date_inscription"));
        utilisateur.setDateDerniereConnexion(rs.getTimestamp("date_derniere_connexion"));
        utilisateur.setTokenReinitialisation(rs.getString("token_reinitialisation"));
        utilisateur.setExpirationToken(rs.getTimestamp("expiration_token"));

        return utilisateur;
    }

    public static void main(String[] args) {
        System.out.println("╔══════════════════════════════════════════╗");
        System.out.println("║     TEST COMPLET DE UtilisateurDAO      ║");
        System.out.println("╚══════════════════════════════════════════╝\n");

        UtilisateurDAO dao = new UtilisateurDAO();

        System.out.println("┌─── Test 1: Statistiques ───┐");
        int nombre = dao.count();
        System.out.println("│ Nombre total d'utilisateurs : " + nombre);
        System.out.println("└─────────────────────────────┘\n");

        System.out.println("┌─── Test 2: Liste des utilisateurs ───┐");
        List<Utilisateur> tous = dao.findAll();

        if (tous.isEmpty()) {
            System.out.println("│ Aucun utilisateur dans la base");
        } else {
            for (Utilisateur u : tous) {
                System.out.println("│ • " + u.getNomComplet());
                System.out.println("│   Email : " + u.getEmail());
                System.out.println("│   Rôle : " + u.getRole());
                System.out.println("│   Statut : " + (u.isEstActif() ? "Actif" : "Inactif"));
                System.out.println("│   Inscrit le : " + u.getDateInscription());
                System.out.println("│");
            }
        }
        System.out.println("└───────────────────────────────────────┘\n");

        System.out.println("┌─── Test 3: Authentification ───┐");
        Utilisateur auth = dao.authenticate("test@example.com", "password123");
        if (auth != null) {
            System.out.println("│ ✓ Authentification réussie");
            System.out.println("│   Utilisateur : " + auth.getNomComplet());
            System.out.println("│   Rôle : " + auth.getRole());
        } else {
            System.out.println("│ ✗ Authentification échouée");
        }
        System.out.println("└─────────────────────────────────┘\n");

        System.out.println("╔══════════════════════════════════════════╗");
        System.out.println("║    TOUS LES TESTS SONT TERMINÉS !       ║");
        System.out.println("╚══════════════════════════════════════════╝");
    }
}