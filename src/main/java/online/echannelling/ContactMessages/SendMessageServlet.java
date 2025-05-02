package online.echannelling.ContactMessages;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/echanneling_system";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int senderId = Integer.parseInt(request.getParameter("sender_id"));
        int receiverId = Integer.parseInt(request.getParameter("receiver_id"));
        String messageContent = request.getParameter("message");

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            MessageDAO messageDAO = new MessageDAO(connection);
            Message message = new Message();
            message.setSenderId(senderId);
            message.setReceiverId(receiverId);
            message.setMessage(messageContent);

            boolean success = messageDAO.sendMessage(message);

            if (success) {
                response.sendRedirect("messages.jsp?sender_id=" + senderId + "&receiver_id=" + receiverId);
            } else {
                response.getWriter().println("Failed to send message.");
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
