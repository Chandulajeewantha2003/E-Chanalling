<%@ page import="java.sql.*, online.echanneling.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userRole") == null || !"admin".equals(sessionObj.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #f44336; color: white; }
    </style>
</head>
<body>
    <h2>Welcome, Admin <%= sessionObj.getAttribute("userName") %></h2>

    <h3>Manage Doctors</h3>
    <table>
        <tr>
            <th>Doctor ID</th>
            <th>Name</th>
            <th>Specialization</th>
            <th>Action</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT id, name, specialization FROM users WHERE role = 'doctor'")) {
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("specialization") %></td>
            <td>
                <form action="DeleteDoctorServlet" method="post" style="display:inline;">
                    <input type="hidden" name="doctorId" value="<%= rs.getInt("id") %>">
                    <button type="submit">Delete</button>
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

    <h3>Add Doctor</h3>
    <form action="AddDoctorServlet" method="post">
        Name: <input type="text" name="name" required>
        Specialization: <input type="text" name="specialization" required>
        Email: <input type="email" name="email" required>
        Password: <input type="password" name="password" required>
        <button type="submit">Add Doctor</button>
    </form>

    <h3>Total Payments</h3>
    <%
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT SUM(amount) AS total FROM payments WHERE status = 'Confirmed'")) {
            if (rs.next()) {
    %>
    <p><strong>Total Payments Received: $<%= rs.getDouble("total") %></strong></p>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
