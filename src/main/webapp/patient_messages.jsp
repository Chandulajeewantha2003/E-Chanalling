<%@ page import="com.echanalling.service.MessageDAO,com.echanalling.model.Message,java.sql.*,java.util.*" %>
<%@ page session="true" %>
<%
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        // Redirect to login page or show an error message
        response.sendRedirect("login.jsp");
        return; // stop further processing if user is not logged in
    }

    Connection conn = online.echanneling.DBConnection.getConnection();
    MessageDAO dao = new MessageDAO(conn);
    List<Message> messages = dao.getMessagesForUser(userId);
%>

<h2>Patient Dashboard - Messages</h2>
<form action="sendMessage" method="post">
    Send to Doctor (Doctor ID): <input type="number" name="receiver_id" required>
    <input type="hidden" name="sender_id" value="<%=userId%>">
    <textarea name="message" placeholder="Type your message"></textarea>
    <button type="submit">Send</button>
</form>

<table border="1">
<tr><th>Sender</th><th>Message</th><th>Time</th><th>Actions</th></tr>
<% for (Message m : messages) { %>
<tr>
<td><%= m.getSenderName() %></td>
<td><%= m.getMessageContent() %></td>
<td><%= m.getSentAt() %></td>
<td>
<% if (m.getSenderId() == userId) { %>
<form action="updateMessage" method="post">
<input type="hidden" name="message_id" value="<%=m.getId()%>">
<input type="hidden" name="user_id" value="<%=userId%>">
<input type="text" name="new_message" value="<%=m.getMessageContent()%>">
<button type="submit">Update</button>
</form>
<a href="deleteMessage?message_id=<%=m.getId()%>&user_id=<%=userId%>">Delete</a>
<% } %>
</td>
</tr>
<% } %>
</table>
