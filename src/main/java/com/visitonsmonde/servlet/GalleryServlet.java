package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.GalleryDAO;
import com.visitonsmonde.model.GalleryCategory;
import com.visitonsmonde.model.GalleryImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@WebServlet("/gallery")
public class GalleryServlet extends HttpServlet {

    private GalleryDAO galleryDAO;

    @Override
    public void init() {
        galleryDAO = new GalleryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<GalleryCategory> categories = galleryDAO.findAllCategories();
        List<GalleryImage> allImages = galleryDAO.findAllImages();

        // Grouper images par catégorie
        Map<Integer, List<GalleryImage>> imagesByCategory = new HashMap<>();
        for (GalleryImage img : allImages) {
            imagesByCategory.computeIfAbsent(img.getCategoryId(), k -> new ArrayList<>()).add(img);
        }

        request.setAttribute("categories", categories);
        request.setAttribute("imagesByCategory", imagesByCategory);
        request.setAttribute("allImages", allImages);

        request.getRequestDispatcher("/gallery.jsp").forward(request, response);
    }
}