<%@ page import="java.sql.*, online.echanneling.DBConnection" %>
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
    </style>
</head>
<body>
    <h2>Welcome, Doctor <%= sessionObj.getAttribute("userName") %></h2>

    <h3>Appointments</h3>
    <table>
        <tr>
            <th>Appointment ID</th>
            <th>Patient Name</th>
            <th>Problem</th>
            <th>Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT a.id, u.name, a.problem, a.date, a.status FROM appointments a JOIN users u ON a.patient_id = u.id WHERE a.doctor_id = ?")) {
                ps.setInt(1, doctorId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("problem") %></td>
            <td><%= rs.getString("date") %></td>
            <td><%= rs.getString("status") %></td>
            <td>
                <form action="ConfirmAppointmentServlet" method="post">
                    <input type="hidden" name="appointmentId" value="<%= rs.getInt("id") %>">
                    <button type="submit">Confirm</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

    <h3>Payment Alerts</h3>
    <table>
        <tr>
            <th>Payment ID</th>
            <th>Patient Name</th>
            <th>Amount</th>
            <th>Status</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT p.id, u.name, p.amount, p.status FROM payments p JOIN users u ON p.patient_id = u.id WHERE p.doctor_id = ? AND p.status = 'Pending'")) {
                ps.setInt(1, doctorId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td>$<%= rs.getDouble("amount") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
