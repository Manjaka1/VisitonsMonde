package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.BlogDAO;
import com.visitonsmonde.model.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/blog")
public class BlogServlet extends HttpServlet {

    private BlogDAO blogDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
        System.out.println("✅ BlogServlet initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Récupérer tous les articles
            List<Blog> blogs = blogDAO.findAll();

            // Compter le total
            int totalBlogs = blogDAO.count();

            // Passer les données à la JSP
            request.setAttribute("blogs", blogs);
            request.setAttribute("totalBlogs", totalBlogs);

            System.out.println("📰 " + blogs.size() + " articles de blog chargés");

            // Forward vers la page blog
            request.getRequestDispatcher("/blog.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println(" Erreur dans BlogServlet : " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erreur lors du chargement des articles");
        }
    }
}