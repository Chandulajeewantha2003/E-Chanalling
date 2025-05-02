<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Message" %>
<%@ page import="dao.MessageDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor - Patient Messages</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
</head>
<body>
<div class="container py-5">
    <h2 class="mb-4">Patient Messages Dashboard</h2>

    <table id="messagesTable" class="table table-striped table-hover shadow rounded">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Patient Name</th>
                <th>Email</th>
                <th>Message</th>
                <th>Reply</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% 
            MessageDAO dao = new MessageDAO(); 
            List<Message> messages = dao.getAllMessages(); 
            for(Message msg : messages) {
        %>
            <tr>
                <td><%= msg.getId() %></td>
                <td><%= msg.getName() %></td>
                <td><%= msg.getEmail() %></td>
                <td><%= msg.getMessage() %></td>
                <td><%= msg.getReply() == null ? "No reply" : msg.getReply() %></td>
                <td>
                    <a href="viewMessage.jsp?id=<%= msg.getId() %>" class="btn btn-info btn-sm">View</a>
                    <a href="replyMessage.jsp?id=<%= msg.getId() %>" class="btn btn-success btn-sm">Reply</a>
                    <a href="editMessage.jsp?id=<%= msg.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="deleteMessage?id=<%= msg.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function() {
        $('#messagesTable').DataTable();
    });
</script>
</body>
</html>
