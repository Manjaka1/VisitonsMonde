package com.visitonsmonde.dao;

import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.model.Testimonial;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TestimonialDAO {

    public List<Testimonial> findAllActifs() {
        List<Testimonial> list = new ArrayList<>();
        String sql = "SELECT * FROM testimonials WHERE est_actif = TRUE ORDER BY date_publication DESC";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Testimonial mapResultSet(ResultSet rs) throws SQLException {
        Testimonial t = new Testimonial();
        t.setId(rs.getInt("id"));
        t.setNom(rs.getString("nom"));
        t.setVille(rs.getString("ville"));
        t.setPays(rs.getString("pays"));
        t.setNote(rs.getInt("note"));
        t.setCommentaire(rs.getString("commentaire"));
        t.setPhoto(rs.getString("photo"));
        t.setDatePublication(rs.getDate("date_publication"));
        t.setEstActif(rs.getBoolean("est_actif"));
        return t;
    }
}