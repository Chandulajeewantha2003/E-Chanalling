<%@ page import="java.sql.*" %>
<%@ page import="online.echanneling.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">My Appointments</h2>

        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Appointment Number</th>
                    <th>Doctor</th>
                    <th>Specialization</th>
                    <th>Date & Time</th>
                    <th>Problem</th>
                    <th>Status</th>
                    <th>Action</th> <!-- Added Action column -->
                </tr>
            </thead>
            <tbody>
                <%
                    HttpSession sessionObj = request.getSession(false);
                    if (sessionObj != null && sessionObj.getAttribute("userId") != null) {
                        Integer patientId = (Integer) sessionObj.getAttribute("userId");
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;
                        try {
                            conn = DBConnection.getConnection();
                            String sql = "SELECT a.id, d.name AS doctor_name, a.specialization, a.appointment_date, a.problem, a.status, " +
                                         "(SELECT COUNT(*) FROM appointments WHERE patient_id = ?) AS totalAppointments, " +
                                         "(SELECT COUNT(*) FROM appointments WHERE patient_id = ? AND id <= a.id) AS currentIndex " +
                                         "FROM appointments a " +
                                         "JOIN users d ON a.doctor_id = d.id " +
                                         "WHERE a.patient_id = ? ORDER BY a.appointment_date DESC";
                            stmt = conn.prepareStatement(sql);
                            stmt.setInt(1, patientId);
                            stmt.setInt(2, patientId);
                            stmt.setInt(3, patientId);
                            rs = stmt.executeQuery();
                            
                            boolean hasAppointments = false;
                            while (rs.next()) {
                                hasAppointments = true;
                %>
                <tr>
                    <td><%= rs.getInt("currentIndex") %>/<%= rs.getInt("totalAppointments") %></td>
                    <td><%= rs.getString("doctor_name") %></td>
                    <td><%= rs.getString("specialization") %></td>
                    <td><%= rs.getString("appointment_date") %></td>
                    <td><%= rs.getString("problem") %></td>
                    <td>
                        <span class="badge <%= rs.getString("status").equals("Pending") ? "bg-warning" : (rs.getString("status").equals("Confirmed") ? "bg-success" : "bg-danger") %>">
                            <%= rs.getString("status") %>
                        </span>
                    </td>
                    <td>
                        <form action="deleteAppointment.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this appointment?');">
                            <input type="hidden" name="appointmentId" value="<%= rs.getInt("id") %>">
                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                        </form>
                    </td>
                </tr>
                <%
                            }
                            if (!hasAppointments) {
                %>
                <tr>
                    <td colspan="7" class="text-center">No appointments found.</td>
                </tr>
                <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" class="text-center">Please <a href="login.jsp">login</a> to view your appointments.</td>
                </tr>
                <%
                    }
                %>
               
            </tbody>
             <div class="mt-3">
				    <a href="PatientDashboard" class="btn btn-secondary">Back to Dashboard</a>
				</div>
                
        </table>
    </div>
</body>
</html>
