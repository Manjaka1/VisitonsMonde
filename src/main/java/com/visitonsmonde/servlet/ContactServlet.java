package com.visitonsmonde.servlet;

import com.visitonsmonde.service.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String sujet = request.getParameter("sujet");
        String message = request.getParameter("message");

        try {
            String contenuEmail = "Nouveau message de contact\n\n" +
                    "De: " + nom + " (" + email + ")\n" +
                    "Sujet: " + sujet + "\n\n" +
                    "Message:\n" + message;

            EmailService.sendEmail("admin@visitonsmonde.com",
                    "Contact: " + sujet, contenuEmail);

            request.setAttribute("messageSucces",
                    "Votre message a été envoyé ! Nous vous répondrons rapidement.");
        } catch (Exception e) {
            request.setAttribute("erreur",
                    "Erreur d'envoi. Réessayez ou appelez-nous.");
        }

        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}