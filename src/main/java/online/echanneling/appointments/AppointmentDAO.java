package online.echanneling.appointments;

import java.sql.*;

import online.echanneling.DBConnection;

public class AppointmentDAO {
    private Connection connection;
    
    public AppointmentDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new RuntimeException("Database connection failed!");
        }
    }
    
    public boolean bookAppointment(Appointment appointment) {
        String query = "INSERT INTO appointments (patient_id, doctor_id, specialization, problem, appointment_date, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, appointment.getPatientId());
            ps.setInt(2, appointment.getDoctorId());
            ps.setString(3, appointment.getSpecialization());
            ps.setString(4, appointment.getProblem());
            ps.setTimestamp(5, new Timestamp(appointment.getAppointmentDate().getTime()));
            ps.setString(6, "Pending");

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateAppointmentStatus(int appointmentId, String status) {
        String query = "UPDATE appointments SET status = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, appointmentId);

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
