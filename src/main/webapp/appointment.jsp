<%@ page import="java.sql.*, com.echanalling.util.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userRole") == null || !"patient".equals(sessionObj.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Fetch session user details
    Integer userId = (Integer) sessionObj.getAttribute("userId");
    String userName = (String) sessionObj.getAttribute("userName");
    String userEmail = (String) sessionObj.getAttribute("userEmail");
    String userPhone = (String) sessionObj.getAttribute("userPhone");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book Appointment</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>Book an Appointment</h2>
    
    <form action="BookAppointmentServlet" method="post">
        <!-- Specialization Selection -->
        <label>Specialization:</label>
        <select id="speciality" name="speciality" required>
            <option value="">Select Specialization</option>
            <option value="Cardiologist">Cardiologist</option>
            <option value="Dermatologist">Dermatologist</option>
            <option value="Neurologist">Neurologist</option>
            <option value="General Physician">General Physician</option>
        </select>

        <!-- Doctor Selection (Populated via AJAX) -->
        <label>Doctor:</label>
        <select id="doctorId" name="doctorId" required>
            <option value="">Select Doctor</option>
        </select>

        <!-- Auto-Filled Patient Details -->
        <label>Name:</label>
        <input type="text" name="name" id="name" value="<%= userName %>" readonly>

        <label>Email:</label>
        <input type="email" name="email" id="email" value="<%= userEmail %>" readonly>

        <label>Phone:</label>
        <input type="text" name="number" id="number" value="<%= userPhone %>" readonly>

        <label>Date:</label>
        <input type="date" name="date" required>

        <label>Time:</label>
        <input type="time" name="time" required>

        <label>Message:</label>
        <textarea name="message" required></textarea>

        <button type="submit">Make an Appointment</button>
    </form>

    <script>
        $(document).ready(function() {
            // When specialization is changed, fetch doctors
            $("#speciality").change(function() {
                var speciality = $(this).val().trim(); 

                if (speciality) {
                    $.ajax({
                        type: "GET",
                        url: "GetDoctorsServlet",
                        data: { speciality: speciality },
                        success: function(response) {
                            $("#doctorId").html(response);
                        },
                        error: function() {
                            console.log("Error fetching doctors.");
                        }
                    });
                } else {
                    $("#doctorId").html('<option value="">Select Doctor</option>');
                }
            });
        });
    </script>
</body>
</html>
