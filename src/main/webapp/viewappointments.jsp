<%@ page import="online.echanneling.appointments.AppointmentDAO, online.echanneling.appointments.Appointment, java.util.List" %>
<%@ page session="true" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Appointment> appointments = AppointmentDAO.getAppointmentsByPatient(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Appointments</title>
</head>
<body>
    <h2>My Appointments</h2>
    <table border="1">
        <tr>
            <th>Doctor</th>
            <th>Specialization</th>
            <th>Date</th>
            <th>Time</th>
            <th>Appointment Number</th>
        </tr>
        <%
            int totalAppointments = appointments.size();
            for (int i = 0; i < totalAppointments; i++) {
                Appointment appt = appointments.get(i);
                int appointmentNumber = i + 1;
        %>
        <tr>
            <td><%= appt.getDoctorId() %></td>
            <td><%= appt.getSpecialization() %></td>
            <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(appt.getAppointmentDate()) %></td>
            <td><%= new java.text.SimpleDateFormat("HH:mm").format(appt.getAppointmentDate()) %></td>
            <td><%= appointmentNumber + "/" + totalAppointments %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
