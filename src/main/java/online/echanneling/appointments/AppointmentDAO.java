package online.echanneling.appointments;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import online.echanneling.DBConnection;
public class AppointmentDAO {

    public static boolean addAppointment(Appointment appointment) {
        boolean isInserted = false;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO appointments (patient_id, doctor_id, specialization, problem, appointment_date, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointment.getPatientId());
            stmt.setInt(2, appointment.getDoctorId());
            stmt.setString(3, appointment.getSpecialization());
            stmt.setString(4, appointment.getProblem());
            stmt.setTimestamp(5, new java.sql.Timestamp(appointment.getAppointmentDate().getTime()));
            stmt.setString(6, appointment.getStatus());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                isInserted = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isInserted;
    }
}
