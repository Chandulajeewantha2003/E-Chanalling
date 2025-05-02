<%@ page import="java.sql.*" %>
<%@ page import="com.echanalling.util.DBConnection" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">    
    <title>Book Appointment</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Book an Appointment</h2>
        <form action="BookAppointmentServlet" method="post" class="p-4 border rounded bg-light">
            <div class="mb-3">
                <label for="speciality" class="form-label">Speciality</label>
                <select class="form-control" id="speciality" name="speciality" required>
                    <option value="">Select Speciality</option>
                    <option value="Cardiologist">Cardiologist</option>
                    <option value="Dermatologist">Dermatologist</option>
                    <option value="Neurologist">Neurologist</option>
                    <option value="General Physician">General Physician</option>
                </select>
            </div>

            <!-- Doctor Selection (Filtered by Speciality using AJAX) -->
            <div class="mb-3">
                <label for="doctor" class="form-label">Doctor</label>
                <select class="form-control" id="doctor" name="doctorId" required>
                    <option value="">Select Doctor</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="date" class="form-label">Date</label>
                <input type="date" class="form-control" name="date" id="date" required min="<%= java.time.LocalDate.now() %>">
            </div>
            <div class="mb-3">
                <label for="time" class="form-label">Time</label>
                <input type="time" class="form-control" name="time" id="time" required>
            </div>

            <!-- Auto-Filled Patient Details -->
            <div class="mb-3">
                <label for="name" class="form-label">Your Name</label>
                <input type="text" class="form-control" name="name" id="name" value="<c:out value='${sessionScope.userName}'/>" readonly>
            </div>
            <div class="mb-3">
                <label for="number" class="form-label">Phone</label>
                <input type="text" class="form-control" name="number" id="number" pattern="[0-9]{10}" placeholder="Enter 10-digit phone number" required>
            </div>

            <div class="mb-3">
                <label for="message" class="form-label">Message</label>
                <textarea name="message" class="form-control" id="message" rows="3" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary w-100">Book Appointment</button>
        </form>
    </div>

    <!-- AJAX to Load Doctors Based on Selected Speciality -->
    <script>
        $(document).ready(function() {
            $('#speciality').change(function() {
                var speciality = $(this).val();
                if (speciality !== "") {
                    $.ajax({
                        url: "GetDoctorsServlet",
                        type: "GET",
                        data: { speciality: speciality },
                        dataType: "json",  // Expecting a JSON response
                        success: function(response) {
                            // Clear the doctor dropdown
                            $('#doctor').html('<option value="">Select Doctor</option>');

                            // Populate the doctor dropdown with new options
                            $.each(response, function(index, doctor) {
                                $('#doctor').append('<option value="' + doctor.id + '">' + doctor.name + '</option>');
                            });
                        },
                        error: function() {
                            alert("Error fetching doctors. Please try again.");
                        }
                    });
                } else {
                    $('#doctor').html('<option value="">Select Doctor</option>');
                }
            });

            // Set minimum date (disable past dates)
            var today = new Date().toISOString().split("T")[0];
            document.getElementById("date").setAttribute("min", today);
        });
    </script>
</body>
</html>
