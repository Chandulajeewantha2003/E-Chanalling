<%@ page import="java.sql.*" %>
<%@ page import="online.echanneling.DBConnection" %>
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
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .header h2 {
            text-align: center;
            color: #333;
        }

        .dashboard {
            display: flex;
            justify-content: space-between;
            margin: 30px 0;
        }

        .card {
            width: 30%;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: 0.3s;
            text-align: center;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card i {
            font-size: 36px;
            margin-bottom: 10px;
            color: #f44336;
        }

        .card h3 {
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        th, td {
            text-align: center;
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f44336;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .action-btn {
            padding: 10px 15px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            margin: 5px;
            cursor: pointer;
        }

        .update-btn {
            background-color: #4CAF50;
            color: white;
        }

        .update-btn:hover {
            background-color: #45a049;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }

        .form-container {
            margin-top: 40px;
            padding: 25px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .form-container h3 {
            margin-bottom: 20px;
        }

        .form-container input, .form-container select, .form-container button {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .form-container button {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: #45a049;
        }

        .confirm-popup {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.6);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .confirm-popup-content {
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            text-align: center;
        }

        .confirm-popup .btn {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            background-color: #f44336;
            color: white;
            cursor: pointer;
        }

        .confirm-popup .btn:hover {
            background-color: #c82333;
        }

        .action-dropdown {
            padding: 8px;
            border-radius: 5px;
            font-size: 14px;
        }
    </style>

    <script>
        function confirmDelete(doctorId) {
            document.getElementById('confirmPopup').style.display = 'flex';
            document.getElementById('confirmYes').onclick = function () {
                document.getElementById("deleteDoctorForm_" + doctorId).submit();
            };
            document.getElementById('confirmNo').onclick = function () {
                document.getElementById('confirmPopup').style.display = 'none';
            };
        }

        function validateDoctorForm() {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
            const specialCharRegex = /[!@#$%^&*(),.?":{}|<>]/;

            if (password.length < 7) {
                alert("Password must be more than 6 characters.");
                return false;
            }

            if (!specialCharRegex.test(password)) {
                alert("Password must contain at least one special character.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>Welcome, Admin <%= sessionObj.getAttribute("userName") %></h2>
    </div>

    <div class="dashboard">
        <div class="card">
            <i class="fas fa-user-md"></i>
            <h3>Manage Doctors</h3>
            <p>View, add, and update doctors</p>
        </div>
        <div class="card">
            <i class="fas fa-calendar-check"></i>
            <h3>Appointments</h3>
            <p>Track all appointments</p>
        </div>
        <div class="card">
            <i class="fas fa-money-bill-wave"></i>
            <h3>Payments</h3>
            <p>Review payment history</p>
        </div>
    </div>

    <h3>Manage Doctors</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Specialization</th>
            <th>Actions</th>
        </tr>

        <%
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT id, name, specialization FROM users WHERE role = 'doctor'")) {

                String[] specializations = {"Cardiologist", "Dermatologist", "Neurologist", "General Physician"};

                while (rs.next()) {
                    int docId = rs.getInt("id");
                    String docName = rs.getString("name");
                    String spec = rs.getString("specialization");
        %>
        <tr>
            <td><%= docId %></td>
            <td><%= docName %></td>
            <td>
                <form action="UpdateDoctorServlet" method="post" style="display:inline;">
                    <input type="hidden" name="doctorId" value="<%= docId %>">
                    <select name="newSpecialization" class="action-dropdown">
                        <% for (String s : specializations) { %>
                            <option value="<%= s %>" <%= s.equals(spec) ? "selected" : "" %>><%= s %></option>
                        <% } %>
                    </select>
                    <button type="submit" class="action-btn update-btn">Update</button>
                </form>
            </td>
            <td>
                <form id="deleteDoctorForm_<%= docId %>" action="DeleteDoctorServlet" method="post" style="display:inline;">
                    <input type="hidden" name="doctorId" value="<%= docId %>">
                    <button type="button" class="action-btn delete-btn" onclick="confirmDelete(<%= docId %>)">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <tr><td colspan="4">Error loading doctors.</td></tr>
        <%
            }
        %>
    </table>

    <div class="form-container">
        <h3>Add New Doctor</h3>
        <form action="AddDoctorServlet" method="post" onsubmit="return validateDoctorForm();">
            <input type="text" name="name" placeholder="Doctor Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>

            <select name="specialization" required>
                <option value="">Select Specialization</option>
                <% for (String s : new String[]{"Cardiologist", "Dermatologist", "Neurologist", "General Physician"}) { %>
                    <option value="<%= s %>"><%= s %></option>
                <% } %>
            </select>

            <button type="submit">Add Doctor</button>
        </form>
    </div>

    <!-- Confirmation Popup -->
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