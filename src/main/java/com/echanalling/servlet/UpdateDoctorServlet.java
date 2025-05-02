package com.echanalling.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.echanalling.service.DoctorDAO;

import java.io.IOException;

@WebServlet("/UpdateDoctorServlet")
public class UpdateDoctorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int doctorId = Integer.parseInt(request.getParameter("doctorId"));
            String newSpecialization = request.getParameter("newSpecialization");

            DoctorDAO doctorDAO = new DoctorDAO();
            boolean success = doctorDAO.updateDoctorSpecialization(doctorId, newSpecialization);

            if (success) {
                response.sendRedirect("admin_dashboard.jsp?updateSuccess=1");
            } else {
                response.sendRedirect("admin_dashboard.jsp?updateError=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?updateError=1");
        }
    }
}
