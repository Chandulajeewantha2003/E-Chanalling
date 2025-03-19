<%@ page import="java.sql.*" %>
<%@ page import="online.echanneling.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Total Appointments</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">All Appointments</h2>

        <table class="table table-bordered">
            <thead class="table-dark">
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
                    try (Connection conn = DBConnection.getConnection()) {
                        String sql = "SELECT a.id, p.name AS patient_name, d.name AS doctor_name, a.specialization, a.appointment_date, a.problem, a.status " +
                                     "FROM appointments a " +
                                     "JOIN users p ON a.patient_id = p.id " +
                                     "JOIN users d ON a.doctor_id = d.id " +
                                     "ORDER BY a.appointment_date DESC";

                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
                            int appointmentId = rs.getInt("id");
                            String patientName = rs.getString("patient_name");
                            String doctorName = rs.getString("doctor_name");
                            String specialization = rs.getString("specialization");
                            String appointmentDate = rs.getString("appointment_date");
                            String problem = rs.getString("problem");
                            String status = rs.getString("status");
                %>
                <tr id="row-<%= appointmentId %>">
                    <td><%= appointmentId %></td>
                    <td><%= patientName %></td>
                    <td><%= doctorName %></td>
                    <td><%= specialization %></td>
                    <td><%= appointmentDate %></td>
                    <td><%= problem %></td>
                    <td>
                        <span id="status-<%= appointmentId %>" class="badge <%= status.equals("Pending") ? "bg-warning" : (status.equals("Confirmed") ? "bg-success" : "bg-danger") %>">
                            <%= status %>
                        </span>
                    </td>
                    <td>
                        <button class="btn btn-success btn-sm approve-btn" data-id="<%= appointmentId %>" <%= status.equals("Confirmed") ? "disabled" : "" %>>Approve</button>
                        <button class="btn btn-danger btn-sm reject-btn" data-id="<%= appointmentId %>" <%= status.equals("Cancelled") ? "disabled" : "" %>>Reject</button>
                    </td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- AJAX for Approve/Reject Actions -->
    <script>
        $(document).ready(function() {
            $(".approve-btn").click(function() {
                var appointmentId = $(this).data("id");
                updateAppointmentStatus(appointmentId, "Confirmed");
            });

            $(".reject-btn").click(function() {
                var appointmentId = $(this).data("id");
                updateAppointmentStatus(appointmentId, "Cancelled");
            });

            function updateAppointmentStatus(appointmentId, status) {
                $.ajax({
                    url: "UpdateAppointmentStatusServlet",
                    type: "POST",
                    data: { appointmentId: appointmentId, status: status },
                    success: function(response) {
                        $("#status-" + appointmentId).removeClass("bg-warning bg-success bg-danger")
                            .addClass(status === "Confirmed" ? "bg-success" : "bg-danger")
                            .text(status);

                        $(".approve-btn[data-id='" + appointmentId + "']").prop("disabled", status === "Confirmed");
                        $(".reject-btn[data-id='" + appointmentId + "']").prop("disabled", status === "Cancelled");
                    },
                    error: function() {
                        alert("Error updating appointment status.");
                    }
                });
            }
        });
    </script>
</body>
</html>
