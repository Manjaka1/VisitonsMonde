package com.visitonsmonde.dao;

import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.model.BlogPost;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogPostDAO {

    public List<BlogPost> findAllPublies() {
        List<BlogPost> list = new ArrayList<>();
        String sql = "SELECT * FROM blog_posts WHERE est_publie = TRUE ORDER BY date_publication DESC";

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

    public BlogPost findById(int id) {
        String sql = "SELECT * FROM blog_posts WHERE id = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private BlogPost mapResultSet(ResultSet rs) throws SQLException {
        BlogPost b = new BlogPost();
        b.setId(rs.getInt("id"));
        b.setTitre(rs.getString("titre"));
        b.setContenu(rs.getString("contenu"));
        b.setImage(rs.getString("image"));
        b.setAuteur(rs.getString("auteur"));
        b.setDatePublication(rs.getDate("date_publication"));
        b.setCategorie(rs.getString("categorie"));
        b.setEstPublie(rs.getBoolean("est_publie"));
        return b;
    }
}