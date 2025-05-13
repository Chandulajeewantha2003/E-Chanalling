<%@ page import="java.sql.*, online.echanneling.DBConnection" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("userRole") == null || !"patient".equals(sessionObj.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (Integer) sessionObj.getAttribute("userId");

    String bloodGroup = "", sex = "", address = "", telephone = "";
    int age = 0;

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT blood_group, age, sex, address, telephone FROM profile WHERE user_id = ?")) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            bloodGroup = rs.getString("blood_group");
            age = rs.getInt("age");
            sex = rs.getString("sex");
            address = rs.getString("address");
            telephone = rs.getString("telephone");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    boolean profileExists = (bloodGroup != null && !bloodGroup.isEmpty());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Patient Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex justify-content-center align-items-center vh-100">
    <div class="container bg-white p-4 rounded shadow" style="max-width: 500px;">
        <h3 class="text-center text-primary mb-3"><%= sessionObj.getAttribute("userName") %>'s Profile</h3>

        <!-- Success & Error Messages -->
        <% if (sessionObj.getAttribute("successMessage") != null) { %>
            <p class="text-success text-center"><%= sessionObj.getAttribute("successMessage") %></p>
            <% sessionObj.removeAttribute("successMessage"); %>
        <% } %>
        <% if (sessionObj.getAttribute("errorMessage") != null) { %>
            <p class="text-danger text-center"><%= sessionObj.getAttribute("errorMessage") %></p>
            <% sessionObj.removeAttribute("errorMessage"); %>
        <% } %>

        <% if (profileExists) { %>
            <!-- Update Form -->
            <form action="UpdateProfileServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Blood Group:</label>
                    <input type="text" name="bloodGroup" value="<%= bloodGroup %>" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Age:</label>
                    <input type="number" name="age" value="<%= age %>" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Sex:</label>
                    <select name="sex" class="form-control" required>
                        <option value="Male" <%= "Male".equals(sex) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(sex) ? "selected" : "" %>>Female</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Address:</label>
                    <input type="text" name="address" value="<%= address %>" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Telephone:</label>
                    <input type="tel" name="telephone" value="<%= telephone %>" class="form-control" required />
                </div>
                <button type="submit" class="btn btn-primary w-100">Update Profile</button>
            </form>

            <!-- Delete Button (Triggers Modal) -->
            <button type="button" class="btn btn-danger w-100 mt-3" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal">
                Delete Age, Address, and Phone
            </button>
        <% } else { %>
            <!-- Create Profile Form -->
            <form action="CreateProfileServlet" method="post" class="mt-3">
                <div class="mb-3">
                    <label class="form-label">Blood Group:</label>
                    <input type="text" name="bloodGroup" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Age:</label>
                    <input type="number" name="age" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Sex:</label>
                    <select name="sex" class="form-control" required>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Address:</label>
                    <input type="text" name="address" class="form-control" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Telephone:</label>
                    <input type="tel" name="telephone" class="form-control" required />
                </div>
                <button type="submit" class="btn btn-success w-100">Create Profile</button>
            </form>
        <% } %>

        <button type="button" class="btn btn-secondary w-100 mt-3" onclick="window.location.href='PatientDashboard'">Go Back</button>
    </div>

    <!-- Bootstrap Modal for confirmation -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-danger text-white">
            <h5 class="modal-title" id="confirmDeleteModalLabel">Confirm Deletion</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            Are you sure you want to delete <strong>Age</strong>, <strong>Address</strong>, and <strong>Telephone</strong> from your profile? This action cannot be undone.
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, Cancel</button>
            <form action="DeleteProfileServlet" method="post">
                <button type="submit" class="btn btn-danger">Yes, Delete</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
