package com.echanalling.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.echanalling.util.DBConnection;

@WebServlet("/GetDoctorsServlet")
public class GetDoctorsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String speciality = request.getParameter("speciality");
        List<Map<String, String>> doctorList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {
            String query = "SELECT id, name FROM users WHERE role = 'Doctor' AND specialization = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, speciality);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Map<String, String> doctor = new HashMap<>();
                doctor.put("id", String.valueOf(rs.getInt("id")));
                doctor.put("name", rs.getString("name"));
                doctorList.add(doctor);
            }

            // Convert list to JSON and send response
            Gson gson = new Gson();
            out.print(gson.toJson(doctorList));
        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]"); // Return an empty JSON array on error
        }
    }
}
