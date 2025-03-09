<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>User Management</title></head>
<body>
    <h2>Users</h2>
    <table border="1">
        <tr><th>ID</th><th>Username</th><th>Role</th><th>Specialization</th><th>Actions</th></tr>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.role}</td>
                <td>${user.specialization}</td>
                <td><a href="UserServlet?action=delete&id=${user.id}">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
    <h3>Add User</h3>
    <form action="UserServlet" method="post">
        <input type="hidden" name="action" value="add">
        Username: <input type="text" name="username">
        Password: <input type="text" name="password">
        Role: <input type="text" name="role">
        Specialization: <input type="text" name="specialization">
        Availability: <input type="text" name="availability">
        <input type="submit" value="Add">
    </form>
</body>
</html>