package online.echanneling.appointments;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String specialization = request.getParameter("specialization");
        String problem = request.getParameter("problem");
        String appointmentDateStr = request.getParameter("appointmentDate");

        // Convert date string to Date object
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date appointmentDate = null;
        try {
            appointmentDate = sdf.parse(appointmentDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Appointment appointment = new Appointment(patientId, doctorId, specialization, problem, appointmentDate);
        
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        boolean isBooked = appointmentDAO.bookAppointment(appointment);

        if (isBooked) {
            response.sendRedirect("patient-dashboard.jsp?success=1");
        } else {
            response.sendRedirect("patient-dashboard.jsp?error=1");
        }
    }
}
