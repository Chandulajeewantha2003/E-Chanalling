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

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null || !"patient".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String bloodGroup = request.getParameter("bloodGroup");
        String ageParam = request.getParameter("age");
        String sex = request.getParameter("sex");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        // Telephone validation - must be exactly 10 digits
        if (telephone == null || !telephone.matches("\\d{10}")) {
            session.setAttribute("errorMessage", "Telephone number must be exactly 10 digits.");
            response.sendRedirect("profile.jsp");
            return;
        }

        // Age validation (ensure it's a number)
        int age;
        try {
            age = Integer.parseInt(ageParam);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Age must be a valid number.");
            response.sendRedirect("profile.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE profile SET blood_group = ?, age = ?, sex = ?, address = ?, telephone = ? WHERE user_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, bloodGroup);
            ps.setInt(2, age);
            ps.setString(3, sex);
            ps.setString(4, address);
            ps.setString(5, telephone);
            ps.setInt(6, userId);
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                session.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                session.setAttribute("errorMessage", "Error updating profile.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Error updating profile.");
        }

        response.sendRedirect("profile");
    }
}
