<%@ page import="java.sql.*, online.echanneling.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userRole") == null || !"patient".equals(sessionObj.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    int patientId = (Integer) sessionObj.getAttribute("userId");
%>
<!DOCTYPE html>
<html>
<head>
<style>
/* Global Styles */
body {
    font-family: Arial, sans-serif;
    background-color: #0B162D; /* Dark Blue Background */
    color: white;
    margin: 0;
    padding: 20px;
    text-align: center;
}

/* Headings */
h3 {
    color: #007BFF;
    margin-bottom: 15px;
}

/* Table Styles */
table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
    background-color: #152238; /* Darker Table Background */
    color: white;
    border-radius: 10px;
    overflow: hidden;
}

th, td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #2E3B55; /* Subtle Border */
}

th {
    background-color: #007BFF; /* Blue Headers */
    color: white;
}

/* Input Fields */
input, select {
    width: 60%;  /* Adjust width to make it medium-sized */
    padding: 8px;  /* Slightly reduced padding */
    margin-bottom: 10px;
    background-color: #152238;
    color: white;
    border: none;
    border-radius: 5px;
    text-align: center; /* Center align text */
}

/* Center form elements */
form {
    display: flex;
    flex-direction: column;
    align-items: center;
}


/* Forms */
form {
    background-color: #0D1B2A;
    padding: 20px;
    border-radius: 10px;
    width: 50%;
    margin: auto;
    box-shadow: 0px 0px 10px rgba(0, 123, 255, 0.3);
}

/* Input Fields */
label {
    display: block;
    margin: 10px 0 5px;
    font-weight: bold;
}

input, select {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    background-color: #152238;
    color: white;
    border: none;
    border-radius: 5px;
}

button {
    background-color: #007BFF;
    color: white;
    padding: 8px 16px;  /* Reduced padding */
    border: none;
    cursor: pointer;
    border-radius: 5px;
    width: auto; /* Auto width based on text */
    font-size: 14px; /* Smaller font */
}

/* Back Button */
.back-btn {
    background-color: #ff4c4c;
    padding: 8px 16px; /* Smaller padding */
    font-size: 14px;
    margin-top: 10px; /* Reduce space between buttons */
}

.back-btn:hover {
    background-color: #c0392b;
}

</style>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<p>Welcome to <span> <%= sessionObj.getAttribute("userName") %></span></p>
 <h3>Your Appointments</h3>
    <table>
        <tr>
            <th>Appointment ID</th>
            <th>Doctor</th>
            <th>Specialization</th>
            <th>Problem</th>
            <th>Date</th>
            <th>Status</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement("SELECT a.id, u.name, u.specialization, a.problem, a.date, a.status FROM appointments a JOIN users u ON a.doctor_id = u.id WHERE a.patient_id = ?")) {
                ps.setInt(1, patientId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("specialization") %></td>
            <td><%= rs.getString("problem") %></td>
            <td><%= rs.getString("date") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

    <h3>Make a Payment</h3>
    <form action="MakePaymentServlet" method="post">
        <label for="appointment">Select Appointment:</label>
        <select name="appointmentId" required>
            <%
                try (Connection conn = DBConnection.getConnection();
                     PreparedStatement ps = conn.prepareStatement("SELECT id FROM appointments WHERE patient_id = ? AND status = 'Confirmed'")) {
                    ps.setInt(1, patientId);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
            %>
            <option value="<%= rs.getInt("id") %>">Appointment ID: <%= rs.getInt("id") %></option>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </select>
        <br>
        <label for="amount">Amount:</label>
        <input type="text" name="amount" required>
        <br>
        <button type="submit">Pay Now</button>
        <button onclick="goBack()" class="back-btn">Back</button>
    </form>
    

	<script>
	    function goBack() {
	        window.history.back();
	    }
	</script>
    
</body>
</html>

