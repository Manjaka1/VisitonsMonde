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

@WebServlet("/blog-details")
public class BlogDetailsServlet extends HttpServlet {

    private BlogDAO blogDAO;

    @Override
    public void init() throws ServletException {
        blogDAO = new BlogDAO();
        System.out.println("✅ BlogDetailsServlet initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Récupérer l'ID de l'article depuis les paramètres
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.isEmpty()) {
                response.sendRedirect("blog");
                return;
            }

            int blogId = Integer.parseInt(idParam);

            // Récupérer l'article
            Blog blog = blogDAO.findById(blogId);

            if (blog == null) {
                response.sendRedirect("blog");
                return;
            }

            // Récupérer 3 articles récents pour la sidebar
            List<Blog> recentBlogs = blogDAO.findLatest(3);

            // Passer les données à la JSP
            request.setAttribute("blog", blog);
            request.setAttribute("recentBlogs", recentBlogs);

            System.out.println("📰 Article chargé : " + blog.getTitre());

            // Forward vers la page détails
            request.getRequestDispatcher("/blog-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.err.println("❌ ID invalide : " + e.getMessage());
            response.sendRedirect("blog");
        } catch (Exception e) {
            System.err.println("❌ Erreur dans BlogDetailsServlet : " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erreur lors du chargement de l'article");
        }
    }
}