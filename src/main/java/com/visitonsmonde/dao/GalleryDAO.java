package com.visitonsmonde.dao;

import com.visitonsmonde.config.DAOFactory;
import com.visitonsmonde.model.GalleryCategory;
import com.visitonsmonde.model.GalleryImage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GalleryDAO {

    public List<GalleryCategory> findAllCategories() {
        List<GalleryCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM gallery_categories WHERE est_actif = TRUE ORDER BY ordre";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                GalleryCategory cat = new GalleryCategory();
                cat.setId(rs.getInt("id"));
                cat.setNom(rs.getString("nom"));
                cat.setSlug(rs.getString("slug"));
                cat.setOrdre(rs.getInt("ordre"));
                cat.setEstActif(rs.getBoolean("est_actif"));
                list.add(cat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<GalleryImage> findAllImages() {
        List<GalleryImage> list = new ArrayList<>();
        String sql = "SELECT * FROM gallery_images WHERE est_actif = TRUE ORDER BY ordre, date_ajout DESC";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapImageResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<GalleryImage> findImagesByCategory(int categoryId) {
        List<GalleryImage> list = new ArrayList<>();
        String sql = "SELECT * FROM gallery_images WHERE category_id = ? AND est_actif = TRUE ORDER BY ordre, date_ajout DESC";

        try (Connection conn = DAOFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                list.add(mapImageResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private GalleryImage mapImageResultSet(ResultSet rs) throws SQLException {
        GalleryImage img = new GalleryImage();
        img.setId(rs.getInt("id"));
        img.setTitre(rs.getString("titre"));
        img.setDescription(rs.getString("description"));
        img.setImage(rs.getString("image"));
        img.setCategoryId(rs.getInt("category_id"));
        img.setOrdre(rs.getInt("ordre"));
        img.setEstActif(rs.getBoolean("est_actif"));
        img.setDateAjout(rs.getDate("date_ajout"));
        return img;
    }
}