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
                </tr>
            </thead>
            <tbody>
                <%
                    HttpSession sessionObj = request.getSession();
                    Integer patientId = (Integer) sessionObj.getAttribute("userId");

                    if (patientId != null) {
                        try (Connection conn = DBConnection.getConnection()) {
                            String sql = "SELECT a.id, d.name AS doctor_name, a.specialization, a.appointment_date, a.problem, a.status, " +
                                         "(SELECT COUNT(*) FROM appointments WHERE patient_id = ?) AS totalAppointments, " +
                                         "(SELECT COUNT(*) FROM appointments WHERE patient_id = ? AND id <= a.id) AS currentIndex " +
                                         "FROM appointments a " +
                                         "JOIN users d ON a.doctor_id = d.id " +
                                         "WHERE a.patient_id = ? ORDER BY a.appointment_date DESC";

                            PreparedStatement stmt = conn.prepareStatement(sql);
                            stmt.setInt(1, patientId);
                            stmt.setInt(2, patientId);
                            stmt.setInt(3, patientId);
                            ResultSet rs = stmt.executeQuery();

                            while (rs.next()) {
                                int appointmentId = rs.getInt("id");
                                String doctorName = rs.getString("doctor_name");
                                String specialization = rs.getString("specialization");
                                String appointmentDate = rs.getString("appointment_date");
                                String problem = rs.getString("problem");
                                String status = rs.getString("status");
                                int totalAppointments = rs.getInt("totalAppointments");
                                int currentIndex = rs.getInt("currentIndex");
                %>
                <tr>
                    <td><%= currentIndex %>/<%= totalAppointments %></td>
                    <td><%= doctorName %></td>
                    <td><%= specialization %></td>
                    <td><%= appointmentDate %></td>
                    <td><%= problem %></td>
                    <td>
                        <span class="badge <%= status.equals("Pending") ? "bg-warning" : (status.equals("Confirmed") ? "bg-success" : "bg-danger") %>">
                            <%= status %>
                        </span>
                    </td>
                </tr>
                <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" class="text-center">Please <a href="login.jsp">login</a> to view your appointments.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
