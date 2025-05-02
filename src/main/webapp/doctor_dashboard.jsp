<%@ page import="java.sql.*, com.echanalling.util.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userRole") == null || !"doctor".equals(sessionObj.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    int doctorId = (Integer) sessionObj.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        .badge { padding: 5px 10px; border-radius: 4px; }
        .bg-warning { background-color: #ffc107; color: #000; }
        .bg-success { background-color: #28a745; color: white; }
        .bg-danger { background-color: #dc3545; color: white; }
        button { margin-right: 5px; padding: 5px 10px; border: none; cursor: pointer; border-radius: 4px; }
        .approve-btn { background-color: #28a745; color: white; }
        .reject-btn { background-color: #dc3545; color: white; }
        button:disabled { background-color: #cccccc; cursor: not-allowed; }
    </style>
</head>
<body>

<h2>Welcome, Doctor <%= sessionObj.getAttribute("userName") %></h2>
 <a href="messages.jsp" class="btn medilife-btn mt-50">Contact <span>+</span></a>
<div>
    <h2>My Appointments</h2>
    <table>
        <thead>
            <tr>
                <th>Appointment ID</th>
                <th>Patient Name</th>
                <th>Doctor</th>
                <th>Specialization</th>
                <th>Date & Time</th>
                <th>Problem</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                    "SELECT a.id, p.name AS patient_name, d.name AS doctor_name, a.specialization, a.appointment_date, a.problem, a.status " +
                    "FROM appointments a " +
                    "JOIN users p ON a.patient_id = p.id " +
                    "JOIN users d ON a.doctor_id = d.id " +
                    "WHERE a.doctor_id = ? " +
                    "ORDER BY a.appointment_date DESC")) {

                stmt.setInt(1, doctorId);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    int appointmentId = rs.getInt("id");
                    String patientName = rs.getString("patient_name");
                    String doctorName = rs.getString("doctor_name");
                    String specialization = rs.getString("specialization");
                    String appointmentDate = rs.getString("appointment_date");
                    String problem = rs.getString("problem");
                    String status = rs.getString("status");

                    String badgeClass = "";
                    if ("Pending".equals(status)) badgeClass = "bg-warning";
                    else if ("Confirmed".equals(status)) badgeClass = "bg-success";
                    else badgeClass = "bg-danger";
        %>
        <tr>
            <td><%= appointmentId %></td>
            <td><%= patientName %></td>
            <td><%= doctorName %></td>
            <td><%= specialization %></td>
            <td><%= appointmentDate %></td>
            <td><%= problem %></td>
            <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
            <td>
                <button class="approve-btn" data-id="<%= appointmentId %>" <%= "Confirmed".equals(status) ? "disabled" : "" %>>Approve</button>
                <button class="reject-btn" data-id="<%= appointmentId %>" <%= "Cancelled".equals(status) ? "disabled" : "" %>>Reject</button>
            </td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                out.println("<tr><td colspan='8'>Error loading appointments.</td></tr>");
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>

<div>
    <h3>Payment Alerts</h3>
    <table>
        <thead>
            <tr>
                <th>Payment ID</th>
                <th>Patient Name</th>
                <th>Amount</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
        <%
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(
                         "SELECT p.id, u.name, p.amount, p.status FROM payments p " +
                         "JOIN users u ON p.patient_id = u.id " +
                         "WHERE p.doctor_id = ? AND p.status = 'Pending'")) {
                ps.setInt(1, doctorId);
                ResultSet rs = ps.executeQuery();

                boolean hasPayments = false;
                while (rs.next()) {
                    hasPayments = true;
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td>$<%= rs.getDouble("amount") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
                }
                if (!hasPayments) {
        %>
        <tr><td colspan="4">No pending payments.</td></tr>
        <%
                }
            } catch (SQLException e) {
                out.println("<tr><td colspan='4'>Error loading payments.</td></tr>");
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
