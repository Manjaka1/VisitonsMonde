package com.visitonsmonde.dao;

import com.visitonsmonde.model.Reservation;
import com.visitonsmonde.config.DAOFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO pour gérer les réservations dans la base de données
 */
public class ReservationDAO {

    /**
     * Obtenir une connexion via DAOFactory
     */
    private Connection getConnection() throws SQLException {
        try {
            return DAOFactory.getConnection();
        } catch (SQLException e) {
            System.err.println("❌ ERREUR CONNEXION BD: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Générer un numéro de réservation unique
     */
    private String genererNumeroSimple() {
        return "TH-" + System.currentTimeMillis();
    }

    /**
     * MÉTHODES REQUISES PAR ADMINSERVLET
     */
    public List<Reservation> getAllReservations() throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, u.nom as client_nom, u.prenom as client_prenom, u.email as client_email, " +
                "d.nom as destination_nom, g.nom as guide_nom, g.prenom as guide_prenom " +
                "FROM reservations r " +
                "LEFT JOIN utilisateurs u ON r.utilisateur_id = u.id " +
                "LEFT JOIN destinations d ON r.destination_id = d.id " +
                "LEFT JOIN guides g ON r.guide_id = g.id " +
                "ORDER BY r.date_reservation DESC";

        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Reservation reservation = extractReservationFromResultSet(rs);
                reservation.setClientNom(rs.getString("client_nom"));
                reservation.setClientPrenom(rs.getString("client_prenom"));
                reservation.setClientEmail(rs.getString("client_email"));
                reservations.add(reservation);
            }
        }
        return reservations;
    }

    public Reservation getReservationById(int id) throws SQLException {
        String sql = "SELECT r.*, u.nom as client_nom, u.prenom as client_prenom, u.email as client_email, " +
                "d.nom as destination_nom, g.nom as guide_nom, g.prenom as guide_prenom " +
                "FROM reservations r " +
                "LEFT JOIN utilisateurs u ON r.utilisateur_id = u.id " +
                "LEFT JOIN destinations d ON r.destination_id = d.id " +
                "LEFT JOIN guides g ON r.guide_id = g.id " +
                "WHERE r.id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Reservation reservation = extractReservationFromResultSet(rs);
                reservation.setClientNom(rs.getString("client_nom"));
                reservation.setClientPrenom(rs.getString("client_prenom"));
                reservation.setClientEmail(rs.getString("client_email"));
                return reservation;
            }
        }
        return null;
    }

    /**
     * Changer le statut d'une réservation par ID
     */
    public boolean updateStatut(int id, String nouveauStatut) throws SQLException {
        String sql = "UPDATE reservations SET statut = ? WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nouveauStatut);
            stmt.setInt(2, id);

            return stmt.executeUpdate() > 0;
        }
    }

    /**
     * Créer une nouvelle réservation avec numéro de réservation automatique
     */
    public boolean create(Reservation reservation) {
        String numeroReservation = genererNumeroSimple();
        reservation.setNumeroReservation(numeroReservation);

        String sql = "INSERT INTO reservations (numero_reservation, utilisateur_id, destination_id, "
                + "date_depart, nb_personnes, prix_total, statut) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, numeroReservation);
            stmt.setInt(2, reservation.getUtilisateurId());
            stmt.setInt(3, reservation.getDestinationId());
            stmt.setDate(4, reservation.getDateDepart());
            stmt.setInt(5, reservation.getNbPersonnes());
            stmt.setBigDecimal(6, reservation.getPrixTotal());
            stmt.setString(7, "en_attente");

            int result = stmt.executeUpdate();

            if (result > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        reservation.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            System.err.println("❌ ERREUR création réservation: " + e.getMessage());
        }
        return false;
    }

    /**
     * Trouver une réservation par son ID
     */
    public Reservation findById(int id) {
        String sql = "SELECT * FROM reservations WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractReservationFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche de la réservation : " + e.getMessage());
        }
        return null;
    }

    /**
     * Rechercher par numéro de réservation
     */
    public Reservation findByNumero(String numeroReservation) {
        String sql = "SELECT * FROM reservations WHERE numero_reservation = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, numeroReservation);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractReservationFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche par numéro : " + e.getMessage());
        }
        return null;
    }

    /**
     * Récupérer toutes les réservations
     */
    public List<Reservation> findAll() {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY date_reservation DESC";

        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                reservations.add(extractReservationFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des réservations : " + e.getMessage());
        }
        return reservations;
    }

    /**
     * Récupérer les réservations d'un utilisateur
     */
    public List<Reservation> findByUtilisateur(int utilisateurId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, d.nom as destination_nom, g.nom as guide_nom, g.prenom as guide_prenom "
                + "FROM reservations r "
                + "LEFT JOIN destinations d ON r.destination_id = d.id "
                + "LEFT JOIN guides g ON r.guide_id = g.id "
                + "WHERE r.utilisateur_id = ? ORDER BY r.date_reservation DESC";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, utilisateurId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                reservations.add(extractReservationFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des réservations utilisateur : " + e.getMessage());
        }
        return reservations;
    }

    /**
     * Récupérer les réservations d'un utilisateur avec filtre par statut
     */
    public List<Reservation> findByUtilisateurAndStatut(int utilisateurId, String statut) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT r.*, d.nom as destination_nom, g.nom as guide_nom, g.prenom as guide_prenom "
                + "FROM reservations r "
                + "LEFT JOIN destinations d ON r.destination_id = d.id "
                + "LEFT JOIN guides g ON r.guide_id = g.id "
                + "WHERE r.utilisateur_id = ? AND r.statut = ? ORDER BY r.date_reservation DESC";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, utilisateurId);
            stmt.setString(2, statut);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                reservations.add(extractReservationFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur recherche réservations filtrées: " + e.getMessage());
        }
        return reservations;
    }

    /**
     * Récupérer les réservations par statut
     */
    public List<Reservation> findByStatut(String statut) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE statut = ? ORDER BY date_reservation DESC";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, statut);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                reservations.add(extractReservationFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des réservations par statut : " + e.getMessage());
        }
        return reservations;
    }

    /**
     * Mettre à jour une réservation
     */
    public boolean update(Reservation reservation) {
        String sql = "UPDATE reservations SET numero_reservation = ?, utilisateur_id = ?, destination_id = ?, guide_id = ?, "
                + "date_depart = ?, nb_personnes = ?, prix_total = ?, statut = ? WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, reservation.getNumeroReservation());
            stmt.setInt(2, reservation.getUtilisateurId());
            stmt.setInt(3, reservation.getDestinationId());

            if (reservation.getGuideId() != null) {
                stmt.setInt(4, reservation.getGuideId());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }

            stmt.setDate(5, reservation.getDateDepart());
            stmt.setInt(6, reservation.getNbPersonnes());
            stmt.setBigDecimal(7, reservation.getPrixTotal());
            stmt.setString(8, reservation.getStatut());
            stmt.setInt(9, reservation.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la mise à jour de la réservation : " + e.getMessage());
        }
        return false;
    }

    /**
     * Changer le statut d'une réservation par numéro
     */
    public boolean updateStatut(String numeroReservation, String nouveauStatut) {
        String sql = "UPDATE reservations SET statut = ? WHERE numero_reservation = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nouveauStatut);
            stmt.setString(2, numeroReservation);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors du changement de statut par numéro : " + e.getMessage());
        }
        return false;
    }

    /**
     * Supprimer une réservation
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM reservations WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de la réservation : " + e.getMessage());
        }
        return false;
    }

    /**
     * Supprimer une réservation par numéro
     */
    public boolean deleteByNumero(String numeroReservation) {
        String sql = "DELETE FROM reservations WHERE numero_reservation = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, numeroReservation);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression par numéro : " + e.getMessage());
        }
        return false;
    }

    /**
     * Compter le nombre total de réservations
     */
    public int count() {
        String sql = "SELECT COUNT(*) FROM reservations";

        try (Connection connection = getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors du comptage des réservations : " + e.getMessage());
        }
        return 0;
    }

    /**
     * Vérifier si un numéro de réservation existe déjà
     */
    public boolean numeroExiste(String numeroReservation) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE numero_reservation = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, numeroReservation);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la vérification du numéro : " + e.getMessage());
        }
        return false;
    }

    /**
     * Méthode utilitaire pour extraire une réservation d'un ResultSet
     */
    private Reservation extractReservationFromResultSet(ResultSet rs) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setId(rs.getInt("id"));
        reservation.setNumeroReservation(rs.getString("numero_reservation"));
        reservation.setUtilisateurId(rs.getInt("utilisateur_id"));
        reservation.setDestinationId(rs.getInt("destination_id"));

        int guideId = rs.getInt("guide_id");
        if (!rs.wasNull()) {
            reservation.setGuideId(guideId);
        } else {
            reservation.setGuideId(null);
        }

        reservation.setDateDepart(rs.getDate("date_depart"));
        reservation.setNbPersonnes(rs.getInt("nb_personnes"));
        reservation.setPrixTotal(rs.getBigDecimal("prix_total"));
        reservation.setStatut(rs.getString("statut"));
        reservation.setDateReservation(rs.getTimestamp("date_reservation"));

        try {
            reservation.setDestinationNom(rs.getString("destination_nom"));
        } catch (SQLException e) {
            reservation.setDestinationNom(null);
        }

        try {
            String guideNom = rs.getString("guide_nom");
            String guidePrenom = rs.getString("guide_prenom");
            if (guideNom != null && guidePrenom != null) {
                reservation.setGuideNom(guidePrenom + " " + guideNom);
            } else if (guideNom != null) {
                reservation.setGuideNom(guideNom);
            } else {
                reservation.setGuideNom(null);
            }
        } catch (SQLException e) {
            reservation.setGuideNom(null);
        }

        return reservation;
    }
}