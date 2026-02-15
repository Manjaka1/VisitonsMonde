package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.BlogPostDAO;
import com.visitonsmonde.model.BlogPost;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/blog")
public class BlogServlet extends HttpServlet {

    private BlogPostDAO blogDAO;

    @Override
    public void init() {
        blogDAO = new BlogPostDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<BlogPost> posts = blogDAO.findAllPublies();
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/blog.jsp").forward(request, response);
    }
}