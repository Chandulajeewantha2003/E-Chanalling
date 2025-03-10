package online.echanneling.appointments;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/BookAppointmentServlet")
public class AppointmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get patient ID from session
            int patientId = (int) request.getSession().getAttribute("userId");

            // Get form data
            int doctorId = Integer.parseInt(request.getParameter("doctorId"));
            String specialization = request.getParameter("speciality");
            String problem = request.getParameter("message");
            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");
            String status = "Pending";

            // Convert date & time to Date object
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date appointmentDate = sdf.parse(dateStr + " " + timeStr);

            // Create appointment object
            Appointment appointment = new Appointment(0, patientId, doctorId, specialization, problem, appointmentDate, status);

            // Insert into database
            boolean success = AppointmentDAO.addAppointment(appointment);

            if (success) {
                response.sendRedirect("viewappointments.jsp?success=1");
            } else {
                response.sendRedirect("bookappointment.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("bookappointment.jsp?error=1");
        }
    }
}