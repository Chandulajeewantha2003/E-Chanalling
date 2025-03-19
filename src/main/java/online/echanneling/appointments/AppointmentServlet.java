package online.echanneling.appointments;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import online.echanneling.DBConnection;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        int patientId = (int) session.getAttribute("userId"); // Patient ID from session
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String specialization = request.getParameter("speciality");
        String problem = request.getParameter("message");
        String appointmentDate = request.getParameter("date") + " " + request.getParameter("time");
        
        // Default status is "Pending"
        String status = "Pending";

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO appointments (patient_id, doctor_id, specialization, problem, appointment_date, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, patientId);
            stmt.setInt(2, doctorId);
            stmt.setString(3, specialization); 
            stmt.setString(4, problem);
            stmt.setString(5, appointmentDate);
            stmt.setString(6, status);
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                // Fetch the generated appointment ID
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int appointmentId = rs.getInt(1);
                    session.setAttribute("appointmentId", appointmentId);
                }
                response.sendRedirect("viewappointments.jsp?success=true");
            } else {
                response.sendRedirect("BookAppointment.jsp?error=DatabaseError");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("BookAppointment.jsp?error=SQLException");
        }
    }
}
