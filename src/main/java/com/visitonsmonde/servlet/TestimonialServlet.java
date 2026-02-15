package com.visitonsmonde.servlet;

import com.visitonsmonde.dao.TestimonialDAO;
import com.visitonsmonde.model.Testimonial;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/testimonial")
public class TestimonialServlet extends HttpServlet {

    private TestimonialDAO testimonialDAO;

    @Override
    public void init() {
        testimonialDAO = new TestimonialDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Testimonial> testimonials = testimonialDAO.findAllActifs();
        request.setAttribute("testimonials", testimonials);
        request.getRequestDispatcher("/testimonial.jsp").forward(request, response);
    }
}