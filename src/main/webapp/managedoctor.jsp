<%@ page import="java.sql.*, online.echanneling.DBConnection, online.echanneling.doctors.Doctor, online.echanneling.doctors.DoctorDAO" %>
<%@ page import="java.util.List, online.echanneling.doctors.Doctor, online.echanneling.doctors.DoctorDAO" %>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        h2 {
            color: #333;
            font-size: 28px;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .dashboard {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            gap: 20px;
        }

        /* Card Styling */
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 20px;
            width: 30%;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .card i {
            font-size: 40px;
            margin-bottom: 10px;
            color: #f44336;
        }

        .card h3 {
            font-size: 22px;
            margin-bottom: 10px;
            color: #333;
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: center;
        }

        th {
            background-color: #f44336;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        /* Button Styles */
        .action-btn {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            margin: 5px;
        }

        .update-btn {
            background-color: #4CAF50;
            color: white;
            transition: background-color 0.3s ease;
        }

        .update-btn:hover {
            background-color: #45a049;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
            transition: background-color 0.3s ease;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }

        /* Add Doctor Form */
        .form-container {
            background-color: #fff;
            padding: 30px;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-container input, .form-container select, .form-container button {
            
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .form-container button {
        	margin: 20px;
            background-color: #4CAF50;
            color: white;
            transition: background-color 0.3s ease;
        }

        .form-container button:hover {
            background-color: #45a049;
        }

        /* Confirmation Pop-up Animation */
        .confirm-popup {
            display: none;
            background-color: rgba(0, 0, 0, 0.7);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .confirm-popup-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 300px;
        }

        .confirm-popup .btn {
            background-color: #f44336;
            color: white;
            padding: 10px;
            width: 100%;
            margin: 10px 0;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .confirm-popup .btn:hover {
            background-color: #c82333;
        }
    </style>
    <script>
        function confirmDelete(doctorId) {
            let popup = document.getElementById('confirmPopup');
            popup.style.display = 'flex';

            document.getElementById('confirmYes').onclick = function () {
                document.getElementById("deleteDoctorForm_" + doctorId).submit();
            };

            document.getElementById('confirmNo').onclick = function () {
                popup.style.display = 'none';
            };
        }
    </script>
</head>
<body>

    <div class="container">
        <div class="header">
           <h2>Welcome, Admin <%= sessionObj.getAttribute("userName") %></h2>
        </div>
		
			<!-- Admin Dashboard Overview -->
        <div class="dashboard">
            <div class="card">
                <h3>Manage Doctors</h3>
                <i class="fas fa-user-md" style="font-size: 40px; color: #f44336;"></i>
                <p>View, add, and delete doctors in the system.</p>
            </div>
            <div class="card">
                <h3>Total Appointments</h3>
                <i class="fas fa-calendar-check" style="font-size: 40px; color: #4CAF50;"></i>
                <p>View and manage all patient appointments.</p>
            </div>
            <div class="card">
                <h3>Payments Overview</h3>
                <i class="fas fa-money-bill-wave" style="font-size: 40px; color: #2196F3;"></i>
                <p>Track payments made by patients.</p>
            </div>
        </div>
		
        <h3>Manage Doctors</h3>
        <table>
            <tr>
                <th>Doctor ID</th>
                <th>Name</th>
                <th>Specialization</th>
                <th>Actions</th>
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
                    <!-- Update Button -->
                    <form action="UpdateDoctorServlet" method="post" style="display:inline;">
                        <input type="hidden" name="doctorId" value="<%= rs.getInt("id") %>">
                        <input type="text" name="newSpecialization" value="<%= rs.getString("specialization") %>">
                        <button type="submit" class="action-btn update-btn">Update</button>
                    </form>
                    <!-- Delete Button -->
                    <form id="deleteDoctorForm_<%= rs.getInt("id") %>" action="DeleteDoctorServlet" method="post" style="display:inline;">
                        <input type="hidden" name="doctorId" value="<%= rs.getInt("id") %>">
                        <button type="button" class="action-btn delete-btn" onclick="confirmDelete(<%= rs.getInt("id") %>)">Delete</button>
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

        <!-- Add Doctor Form -->
        <div class="form-container">
            <h3>Add New Doctor</h3>
            <form action="AddDoctorServlet" method="post">
                <input type="text" name="name" placeholder="Doctor Name" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Password" required>

                <select name="specialization" required>
                    <option value="">Select Specialization</option>
                    <option value="Cardiologist">Cardiologist</option>
                    <option value="Dermatologist">Dermatologist</option>
                    <option value="Neurologist">Neurologist</option>
                    <option value="General Physician">General Physician</option>
                </select>

                <button type="submit">Add Doctor</button>
            </form>
        </div>

        <!-- Confirmation Pop-up -->
        <div id="confirmPopup" class="confirm-popup">
            <div class="confirm-popup-content">
                <h4>Are you sure you want to delete this doctor?</h4>
                <button id="confirmYes" class="btn">Yes</button>
                <button id="confirmNo" class="btn">No</button>
            </div>
        </div>
    </div>

</body>
</html>
