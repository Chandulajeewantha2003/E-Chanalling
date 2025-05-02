package online.echannelling.ContactMessages;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/deleteMessage")
public class DeleteMessagesServlet extends HttpServlet {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/echanneling_system";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int messageId = Integer.parseInt(request.getParameter("id"));
        int senderId = Integer.parseInt(request.getParameter("sender_id"));
        int receiverId = Integer.parseInt(request.getParameter("receiver_id"));

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            MessageDAO messageDAO = new MessageDAO(connection);
            messageDAO.deleteMessage(messageId);

            response.sendRedirect("viewMessages?sender_id=" + senderId + "&receiver_id=" + receiverId);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
