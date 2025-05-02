package com.echanalling.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.echanalling.service.DoctorDAO;

import java.io.IOException;

@WebServlet("/DeleteDoctorServlet")
public class DeleteDoctorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int doctorId = Integer.parseInt(request.getParameter("doctorId"));

            DoctorDAO doctorDAO = new DoctorDAO();
            boolean success = doctorDAO.deleteDoctor(doctorId);

            if (success) {
                response.sendRedirect("admin_dashboard.jsp?deleteSuccess=1");
            } else {
                response.sendRedirect("admin_dashboard.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=1");
        }
    }
}
