<%@ page import="java.sql.*, java.util.List" %>
<%@ page import="online.echanneling.DBConnection" %>
<%@ page import="com.echanalling.model.Doctor" %>
<%@ page import="com.echanalling.service.DoctorDAO" %>
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
            position: relative;
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .logout-container {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .logout-btn {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .logout-btn i {
            margin-right: 8px;
        }

        .logout-btn:hover {
            background-color: #d32f2f;
            transform: translateY(-2px);
        }

        .dashboard {
            display: flex;
            gap: unset;
            align-content: center;
            justify-content: center;
            align-items: flex-start;
            flex-wrap: wrap;
            flex-direction: column;
        }

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

        .card p {
            color: #666;
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Logout Button -->
        <div class="logout-container">
            <form action="login.jsp" method="post">
                <button type="submit" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </form>
        </div>

        <div class="header">
            <h2>Welcome, Admin <%= sessionObj.getAttribute("userName") %></h2>
        </div>

        <!-- Admin Dashboard Overview -->
        <div class="dashboard">
            <div class="card" onclick="window.location.href='managedoctor.jsp'" style="cursor: pointer;">
                <h3>Manage Doctors</h3>
                <i class="fas fa-user-md"></i>
                <p>View, add, and delete doctors in the system.</p>
            </div>
        </div>

        <div class="dashboard">
            <div class="card" onclick="window.location.href='totalAppointments.jsp'" style="cursor: pointer;">
                <h3>Total Appointments</h3>
                <i class="fas fa-calendar-check" style="color: #4CAF50;"></i>
                <p>View and manage all patient appointments.</p>
            </div>
        </div>

        <div class="dashboard">
            <div class="card" onclick="window.location.href='paymentoverview.jsp'" style="cursor: pointer;">
                <h3>Payments Overview</h3>
                <i class="fas fa-money-bill-wave" style="color: #2196F3;"></i>
                <p>Track payments made by patients.</p>
            </div>
        </div>

    </div>

</body>
</html>
