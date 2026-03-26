package com.visitonsmonde.dao;

import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.model.Blog;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {

    /**
     * Récupérer tous les articles de blog actifs
     */
    public List<Blog> findAll() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM Blog WHERE actif = 1 ORDER BY date_publication DESC";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Blog blog = mapResultSetToBlog(rs);
                blogs.add(blog);
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la récupération des articles de blog : " + e.getMessage());
            e.printStackTrace();
        }

        return blogs;
    }

    /**
     * Récupérer un article par son ID
     */
    public Blog findById(int id) {
        String sql = "SELECT * FROM Blog WHERE id = ? AND actif = 1";
        Blog blog = null;

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    blog = mapResultSetToBlog(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la récupération de l'article " + id + " : " + e.getMessage());
            e.printStackTrace();
        }

        return blog;
    }

    /**
     * Récupérer les N derniers articles
     */
    public List<Blog> findLatest(int limit) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM Blog WHERE actif = 1 ORDER BY date_publication DESC LIMIT ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Blog blog = mapResultSetToBlog(rs);
                    blogs.add(blog);
                }
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors de la récupération des derniers articles : " + e.getMessage());
            e.printStackTrace();
        }

        return blogs;
    }

    /**
     * Compter le nombre total d'articles actifs
     */
    public int count() {
        String sql = "SELECT COUNT(*) as total FROM Blog WHERE actif = 1";
        int count = 0;

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (SQLException e) {
            System.err.println(" Erreur lors du comptage des articles : " + e.getMessage());
            e.printStackTrace();
        }

        return count;
    }

    /**
     * Incrémenter le nombre de likes
     */
    public boolean incrementLikes(int id) {
        String sql = "UPDATE Blog SET likes = likes + 1 WHERE id = ?";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println(" Erreur lors de l'incrémentation des likes : " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Mapper un ResultSet vers un objet Blog
     */
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        Blog blog = new Blog();
        blog.setId(rs.getInt("id"));
        blog.setTitre(rs.getString("titre"));
        blog.setAuteur(rs.getString("auteur"));
        blog.setDatePublication(rs.getDate("date_publication"));
        blog.setImage(rs.getString("image"));
        blog.setDescriptionCourte(rs.getString("description_courte"));
        blog.setContenu(rs.getString("contenu"));
        blog.setLikes(rs.getInt("likes"));
        blog.setCommentaires(rs.getInt("commentaires"));
        blog.setActif(rs.getBoolean("actif"));
        blog.setCreatedAt(rs.getTimestamp("created_at"));
        return blog;
    }
}