package com.echanalling.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.echanalling.model.Doctor;

import com.echanalling.util.DBConnection;

public class DoctorDAO {

    // Method to add a new doctor
    public boolean addDoctor(Doctor doctor) {
        String sql = "INSERT INTO users (name, email, password, role, specialization) VALUES (?, ?, ?, 'doctor', ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, doctor.getName());
            stmt.setString(2, doctor.getEmail());
            stmt.setString(3, doctor.getPassword());
            stmt.setString(4, doctor.getSpecialization());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to fetch doctors by specialization
    public List<Doctor> getDoctorsBySpecialization(String specialization) {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT id, name FROM users WHERE role = 'doctor' AND specialization = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, specialization);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                doctors.add(new Doctor(rs.getInt("id"), rs.getString("name"), "", "", specialization));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctors;
    }

    // Method to fetch doctor details by ID
    public Doctor getDoctorById(int id) {
        String sql = "SELECT * FROM users WHERE id = ? AND role = 'doctor'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Doctor(rs.getInt("id"), rs.getString("name"), rs.getString("email"),
                        rs.getString("password"), rs.getString("specialization"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // **NEW: Method to update doctor's specialization**
    public boolean updateDoctorSpecialization(int doctorId, String newSpecialization) {
        String sql = "UPDATE users SET specialization = ? WHERE id = ? AND role = 'doctor'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newSpecialization);
            stmt.setInt(2, doctorId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // **NEW: Method to delete a doctor**
    public boolean deleteDoctor(int doctorId) {
        String sql = "DELETE FROM users WHERE id = ? AND role = 'doctor'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, doctorId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
