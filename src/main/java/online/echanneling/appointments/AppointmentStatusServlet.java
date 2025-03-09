package online.echanneling.appointments;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AppointmentStatusServlet")
public class AppointmentStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        String status = request.getParameter("status");

        AppointmentDAO appointmentDAO = new AppointmentDAO();
        boolean isUpdated = appointmentDAO.updateAppointmentStatus(appointmentId, status);

        if (isUpdated) {
            response.sendRedirect("doctor-dashboard.jsp?success=1");
        } else {
            response.sendRedirect("doctor-dashboard.jsp?error=1");
        }
    }
}
