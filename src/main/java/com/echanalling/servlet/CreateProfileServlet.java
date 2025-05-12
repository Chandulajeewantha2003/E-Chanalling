package com.echanalling.servlet;

import online.echanneling.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/CreateProfileServlet")
public class CreateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String bloodGroup = request.getParameter("bloodGroup");
        String ageParam = request.getParameter("age");
        String sex = request.getParameter("sex");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");

        // Basic validation - Check required fields
        if (bloodGroup == null || bloodGroup.isEmpty() ||
            ageParam == null || ageParam.isEmpty() ||
            sex == null || sex.isEmpty() ||
            address == null || address.isEmpty() ||
            telephone == null || telephone.isEmpty()) {

            session.setAttribute("errorMessage", "All fields are required.");
            response.sendRedirect("profile.jsp");
            return;
        }

        // Validate Age is number
        int age = 0;
        try {
            age = Integer.parseInt(ageParam);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Age must be a valid number.");
            response.sendRedirect("profile.jsp");
            return;
        }

        // Validate Telephone is exactly 10 digits
        if (!telephone.matches("\\d{10}")) {
            session.setAttribute("errorMessage", "Telephone number must be exactly 10 digits.");
            response.sendRedirect("profile.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO profile (user_id, blood_group, age, sex, address, telephone) VALUES (?, ?, ?, ?, ?, ?)")) {

            ps.setInt(1, userId);
            ps.setString(2, bloodGroup);
            ps.setInt(3, age);
            ps.setString(4, sex);
            ps.setString(5, address);
            ps.setString(6, telephone);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                session.setAttribute("successMessage", "Profile created successfully.");
            } else {
                session.setAttribute("errorMessage", "Failed to create profile.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred while creating the profile.");
        }

        response.sendRedirect("profile");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("profile");
    }
}
