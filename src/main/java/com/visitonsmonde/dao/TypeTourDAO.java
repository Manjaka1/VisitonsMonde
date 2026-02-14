package com.visitonsmonde.dao;


import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.model.TypeTour;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TypeTourDAO {

    private Connection getConnection() throws SQLException {
        return DAOFactory.getConnection();
    }

    public boolean create(TypeTour typeTour) {
        String sql = """
            INSERT INTO type_tour (nom, description, image, date_creation)
            VALUES (?, ?, ?, ?)
        """;

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)
        ) {
            stmt.setString(1, typeTour.getNom());
            stmt.setString(2, typeTour.getDescription());
            stmt.setString(3, typeTour.getImage());
            stmt.setTimestamp(4, typeTour.getDateCreation());

            if (stmt.executeUpdate() > 0) {
                ResultSet keys = stmt.getGeneratedKeys();
                if (keys.next()) {
                    typeTour.setId(keys.getInt(1));
                }
                System.out.println("Type de tour créé : " + typeTour.getNom());
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR création TypeTour : " + e.getMessage());
        }
        return false;
    }

    public TypeTour findById(int id) {
        String sql = "SELECT * FROM type_tour WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractTypeTour(rs);
            }
        } catch (SQLException e) {
            System.err.println("ERREUR findById TypeTour : " + e.getMessage());
        }
        return null;
    }

    public List<TypeTour> findAll() {
        List<TypeTour> types = new ArrayList<>();
        String sql = "SELECT * FROM type_tour ORDER BY nom";

        try (
                Connection connection = getConnection();
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery(sql)
        ) {
            while (rs.next()) {
                types.add(extractTypeTour(rs));
            }
            System.out.println("Nombre de types de tours : " + types.size());
        } catch (SQLException e) {
            System.err.println("ERREUR findAll TypeTour : " + e.getMessage());
        }

        return types;
    }

    public boolean update(TypeTour typeTour) {
        String sql = """
            UPDATE type_tour SET nom = ?, description = ?, image = ?, date_creation = ?
            WHERE id = ?
        """;

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setString(1, typeTour.getNom());
            stmt.setString(2, typeTour.getDescription());
            stmt.setString(3, typeTour.getImage());
            stmt.setTimestamp(4, typeTour.getDateCreation());
            stmt.setInt(5, typeTour.getId());

            if (stmt.executeUpdate() > 0) {
                System.out.println("Type de tour mis à jour : #" + typeTour.getId());
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR update TypeTour : " + e.getMessage());
        }

        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM type_tour WHERE id = ?";

        try (
                Connection connection = getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);
            if (stmt.executeUpdate() > 0) {
                System.out.println("Type de tour supprimé : #" + id);
                return true;
            }
        } catch (SQLException e) {
            System.err.println("ERREUR delete TypeTour : " + e.getMessage());
        }

        return false;
    }

    private TypeTour extractTypeTour(ResultSet rs) throws SQLException {
        TypeTour typeTour = new TypeTour();
        typeTour.setId(rs.getInt("id"));
        typeTour.setNom(rs.getString("nom"));
        typeTour.setDescription(rs.getString("description"));
        typeTour.setImage(rs.getString("image"));
        typeTour.setDateCreation(rs.getTimestamp("date_creation"));
        return typeTour;
    }

    public static void main(String[] args) {
        TypeTourDAO dao = new TypeTourDAO();

        System.out.println("=== Test création ===");
        TypeTour t1 = new TypeTour("Tour Historique", "Découverte des monuments historiques", "historique.jpg");
        dao.create(t1);

        System.out.println("=== Test findAll ===");
        for (TypeTour t : dao.findAll()) {
            System.out.println(t);
        }

        System.out.println("=== Test findById ===");
        TypeTour t2 = dao.findById(t1.getId());
        System.out.println(t2);

        System.out.println("=== Test update ===");
        t2.setNom("Tour Historique Modifié");
        dao.update(t2);
        System.out.println(dao.findById(t2.getId()));

        System.out.println("=== Test delete ===");
        dao.delete(t2.getId());
    }
}

