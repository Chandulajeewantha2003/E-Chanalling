package com.echanalling.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import online.echanneling.DBConnection;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get patient session details
        HttpSession session = request.getSession();
        int patientId = (int) session.getAttribute("userId"); // Assuming userId is stored in session
        String patientName = (String) session.getAttribute("userName"); 
         
        // Get form values
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String specialization = request.getParameter("speciality");
        String appointmentDate = request.getParameter("date");
        String appointmentTime = request.getParameter("time");
        String problem = request.getParameter("message");

        // Insert appointment into the database
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO appointments (patient_id, doctor_id, specialization, problem, appointment_date, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, patientId);
            ps.setInt(2, doctorId);
            ps.setString(3, specialization);
            ps.setString(4, problem); 
            ps.setString(5, appointmentDate + " " + appointmentTime);

            int result = ps.executeUpdate();
            if (result > 0) {
                session.setAttribute("successMessage", "Appointment booked successfully!");
                response.sendRedirect("viewappointments.jsp");
            } else {
                session.setAttribute("errorMessage", "Failed to book appointment.");
                response.sendRedirect("BookAppointment.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("BookAppointment.jsp");
        }
    }
}
