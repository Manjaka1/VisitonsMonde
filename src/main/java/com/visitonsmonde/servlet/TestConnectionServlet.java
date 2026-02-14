package com.visitonsmonde.servlet;

import com.visitonsmonde.config.DAOFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/test-connection")
public class TestConnectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><body>");
        out.println("<h1>Test Connexion BDD</h1>");

        try {
            Connection conn = DAOFactory.getConnection();

            if (conn != null && !conn.isClosed()) {
                out.println("<p style='color:green;'>✅ Connexion OK !</p>");
            } else {
                out.println("<p style='color:red;'>❌ Connexion fermée</p>");
            }

            DAOFactory.closeConnection(conn);

        } catch (Exception e) {
            out.println("<p style='color:red;'>❌ Erreur : " + e.getMessage() + "</p>");
        }

        out.println("<a href='" + request.getContextPath() + "'>Retour</a>");
        out.println("</body></html>");
    }
}