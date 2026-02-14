package com.visitonsmonde.dao;

import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.model.Destination;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO (Data Access Object) pour gérer les destinations dans la base de données.
 * Version corrigée pour utiliser pays_id au lieu de pays.
 */
public class DestinationDAO {

    /**
     * Récupère toutes les destinations avec jointure sur la table pays
     */
    public List<Destination> selectAll() throws SQLException {
        List<Destination> destinations = new ArrayList<>();

        String sql = "SELECT d.id, d.nom, d.description, d.image, d.nb_photos, d.prix, " +
                "d.pays_id, p.nom as pays_nom, d.type_tour_id, tt.nom as type_tour_nom " +
                "FROM destinations d " +
                "LEFT JOIN pays p ON d.pays_id = p.id " +
                "LEFT JOIN types_tours tt ON d.type_tour_id = tt.id " +
                "ORDER BY d.nom";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Destination destination = mapResultSetToDestination(rs);
                destinations.add(destination);
            }

        } catch (SQLException e) {
            System.err.println("Erreur récupération destinations : " + e.getMessage());
            throw e;
        }

        return destinations;
    }

    /**
     * Alias pour selectAll()
     */
    public List<Destination> getAllDestinations() throws SQLException {
        return selectAll();
    }

    /**
     * Recherche une destination par ID
     */
    public Destination getDestinationById(int id) throws SQLException {
        String sql = "SELECT d.id, d.nom, d.description, d.image, d.nb_photos, d.prix, " +
                "d.pays_id, p.nom as pays_nom, d.type_tour_id, tt.nom as type_tour_nom " +
                "FROM destinations d " +
                "LEFT JOIN pays p ON d.pays_id = p.id " +
                "LEFT JOIN types_tours tt ON d.type_tour_id = tt.id " +
                "WHERE d.id = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToDestination(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur recherche destination : " + e.getMessage());
            throw e;
        }

        return null;
    }

    /**
     * Ajoute une nouvelle destination
     */
    public void insert(Destination destination) throws SQLException {
        String sql = "INSERT INTO destinations (nom, description, image, pays_id, nb_photos, prix, type_tour_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, destination.getNom());
            stmt.setString(2, destination.getDescription());
            stmt.setString(3, destination.getImage());

            if (destination.getPaysId() != null) {
                stmt.setInt(4, destination.getPaysId());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }

            stmt.setInt(5, destination.getNbPhotos() != null ? destination.getNbPhotos() : 0);
            stmt.setBigDecimal(6, destination.getPrix());

            if (destination.getTypeTourId() != null) {
                stmt.setInt(7, destination.getTypeTourId());
            } else {
                stmt.setNull(7, Types.INTEGER);
            }

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        destination.setId(generatedKeys.getInt(1));
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur ajout destination : " + e.getMessage());
            throw e;
        }
    }

    /**
     * Met à jour une destination existante
     */
    public void update(Destination destination) throws SQLException {
        String sql = "UPDATE destinations SET nom = ?, description = ?, image = ?, " +
                "pays_id = ?, nb_photos = ?, prix = ?, type_tour_id = ? WHERE id = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, destination.getNom());
            stmt.setString(2, destination.getDescription());
            stmt.setString(3, destination.getImage());

            if (destination.getPaysId() != null) {
                stmt.setInt(4, destination.getPaysId());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }

            stmt.setInt(5, destination.getNbPhotos() != null ? destination.getNbPhotos() : 0);
            stmt.setBigDecimal(6, destination.getPrix());

            if (destination.getTypeTourId() != null) {
                stmt.setInt(7, destination.getTypeTourId());
            } else {
                stmt.setNull(7, Types.INTEGER);
            }

            stmt.setInt(8, destination.getId());

            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Erreur modification destination : " + e.getMessage());
            throw e;
        }
    }

    /**
     * Supprime une destination
     */
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM destinations WHERE id = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Erreur suppression destination : " + e.getMessage());
            throw e;
        }
    }

    /**
     * Recherche destinations par nom de pays
     */
    public List<Destination> getDestinationsByPays(String nomPays) throws SQLException {
        List<Destination> destinations = new ArrayList<>();

        String sql = "SELECT d.id, d.nom, d.description, d.image, d.nb_photos, d.prix, " +
                "d.pays_id, p.nom as pays_nom, d.type_tour_id, tt.nom as type_tour_nom " +
                "FROM destinations d " +
                "LEFT JOIN pays p ON d.pays_id = p.id " +
                "LEFT JOIN types_tours tt ON d.type_tour_id = tt.id " +
                "WHERE p.nom = ? ORDER BY d.nom";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nomPays);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    destinations.add(mapResultSetToDestination(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur recherche par pays : " + e.getMessage());
            throw e;
        }

        return destinations;
    }

    /**
     * Recherche destinations par ID de pays
     */
    public List<Destination> getDestinationsByPaysId(int paysId) throws SQLException {
        List<Destination> destinations = new ArrayList<>();

        String sql = "SELECT d.id, d.nom, d.description, d.image, d.nb_photos, d.prix, " +
                "d.pays_id, p.nom as pays_nom, d.type_tour_id, tt.nom as type_tour_nom " +
                "FROM destinations d " +
                "LEFT JOIN pays p ON d.pays_id = p.id " +
                "LEFT JOIN types_tours tt ON d.type_tour_id = tt.id " +
                "WHERE d.pays_id = ? ORDER BY d.nom";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, paysId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    destinations.add(mapResultSetToDestination(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur recherche par pays ID : " + e.getMessage());
            throw e;
        }

        return destinations;
    }

    /**
     * NOUVEAU : Recherche destinations par type de tour
     */
    public List<Destination> getDestinationsByTourType(String tourTypeName) throws SQLException {
        List<Destination> destinations = new ArrayList<>();

        String sql = "SELECT d.id, d.nom, d.description, d.image, d.nb_photos, d.prix, " +
                "d.pays_id, p.nom as pays_nom, d.type_tour_id, tt.nom as type_tour_nom " +
                "FROM destinations d " +
                "LEFT JOIN pays p ON d.pays_id = p.id " +
                "JOIN types_tours tt ON d.type_tour_id = tt.id " +
                "WHERE tt.nom = ? ORDER BY d.nom";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, tourTypeName);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    destinations.add(mapResultSetToDestination(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur recherche par type de tour : " + e.getMessage());
            throw e;
        }

        return destinations;
    }

    /**
     * NOUVEAU : Recherche destinations par ID de type de tour
     */
    public List<Destination> getDestinationsByTourTypeId(int tourTypeId) throws SQLException {
        List<Destination> destinations = new ArrayList<>();

        String sql = "SELECT d.id, d.nom, d.description, d.image, d.nb_photos, d.prix, " +
                "d.pays_id, p.nom as pays_nom, d.type_tour_id, tt.nom as type_tour_nom " +
                "FROM destinations d " +
                "LEFT JOIN pays p ON d.pays_id = p.id " +
                "LEFT JOIN types_tours tt ON d.type_tour_id = tt.id " +
                "WHERE d.type_tour_id = ? ORDER BY d.nom";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, tourTypeId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    destinations.add(mapResultSetToDestination(rs));
                }
            }

        } catch (SQLException e) {
            System.err.println("Erreur recherche par type de tour ID : " + e.getMessage());
            throw e;
        }

        return destinations;
    }

    /**
     * Convertit ResultSet en objet Destination
     */
    private Destination mapResultSetToDestination(ResultSet rs) throws SQLException {
        Destination destination = new Destination();

        destination.setId(rs.getInt("id"));
        destination.setNom(rs.getString("nom"));
        destination.setDescription(rs.getString("description"));
        destination.setImage(rs.getString("image"));
        destination.setNbPhotos(rs.getInt("nb_photos"));
        destination.setPrix(rs.getBigDecimal("prix"));

        // Récupère pays_id
        int paysId = rs.getInt("pays_id");
        if (!rs.wasNull()) {
            destination.setPaysId(paysId);
        }

        // Récupère le nom du pays
        String paysNom = rs.getString("pays_nom");
        if (paysNom != null) {
            destination.setPays(paysNom);
        }

        // Récupère type_tour_id
        int typeTourId = rs.getInt("type_tour_id");
        if (!rs.wasNull()) {
            destination.setTypeTourId(typeTourId);
        }

        // Récupère le nom du type de tour
        String typeTourNom = rs.getString("type_tour_nom");
        if (typeTourNom != null) {
            destination.setTypeTour(typeTourNom);
        }

        return destination;
    }

    /**
     * Méthode de test
     */
    public static void main(String[] args) {
        System.out.println("=== TEST DESTINATION DAO ===");

        DestinationDAO dao = new DestinationDAO();

        try {
            System.out.println("\n1. Toutes les destinations :");
            List<Destination> toutes = dao.selectAll();
            System.out.println("Destinations trouvées : " + toutes.size());
            for (Destination dest : toutes) {
                System.out.println("   • " + dest.getNom() + " - " + dest.getPays() +
                        " (" + dest.getTypeTour() + ") - " + dest.getPrix() + "€");
            }

            System.out.println("\n2. Recherche destination ID = 1 :");
            Destination dest1 = dao.getDestinationById(1);
            if (dest1 != null) {
                System.out.println("   → " + dest1.getNom() + " - " + dest1.getPays() + " - " + dest1.getTypeTour());
            } else {
                System.out.println("   → Destination non trouvée");
            }

            System.out.println("\n3. Destinations en France :");
            List<Destination> destFrance = dao.getDestinationsByPays("France");
            for (Destination dest : destFrance) {
                System.out.println("   • " + dest.getNom());
            }

            System.out.println("\n4. NOUVEAU : Destinations de type 'Beach Tour' :");
            List<Destination> destBeach = dao.getDestinationsByTourType("Beach Tour");
            for (Destination dest : destBeach) {
                System.out.println("   • " + dest.getNom() + " - " + dest.getPays());
            }

            System.out.println("\nTests terminés avec succès !");

        } catch (SQLException e) {
            System.err.println("Erreur lors des tests : " + e.getMessage());
            e.printStackTrace();
        }
    }
}