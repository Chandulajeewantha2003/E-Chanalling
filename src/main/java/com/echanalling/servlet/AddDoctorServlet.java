package com.echanalling.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.echanalling.model.Doctor;
import com.echanalling.service.DoctorDAO;

import java.io.IOException;

@WebServlet("/AddDoctorServlet")
public class AddDoctorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String specialization = request.getParameter("specialization");

        Doctor doctor = new Doctor(0, name, email, password, specialization);
        DoctorDAO doctorDAO = new DoctorDAO();

        if (doctorDAO.addDoctor(doctor)) {
            response.sendRedirect("admin_dashboard.jsp?success=1");
        } else {
            response.sendRedirect("admin_dashboard.jsp?error=1");
        }
    }
}
