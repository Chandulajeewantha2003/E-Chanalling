package online.echanneling.appointments;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import online.echanneling.DBConnection;

public class AppointmentDAO {
     
    // Fetch appointments for a patient
    public static List<Appointment> getAppointmentsByPatient(int patientId) {
        List<Appointment> appointments = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM appointments WHERE patient_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, patientId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment appointment = new Appointment(
                    rs.getInt("id"),
                    rs.getInt("patient_id"),
                    rs.getInt("doctor_id"),
                    rs.getString("specialization"),
                    rs.getString("problem"),
                    rs.getTimestamp("appointment_date").toString(),
                    rs.getString("status")
                );
                appointments.add(appointment);
            } 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return appointments;
    }
}
