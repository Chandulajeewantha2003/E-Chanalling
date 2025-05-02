package online.echannelling.ContactMessages;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/viewMessages")
public class ViewMessagesServlet extends HttpServlet {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/echanneling_system";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int senderId = Integer.parseInt(request.getParameter("sender_id"));
        int receiverId = Integer.parseInt(request.getParameter("receiver_id"));

        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            MessageDAO messageDAO = new MessageDAO(connection);

            List<Message> messages = messageDAO.getMessagesBetween(senderId, receiverId);
            request.setAttribute("messages", messages);
            request.setAttribute("sender_id", senderId);
            request.setAttribute("receiver_id", receiverId);

            request.getRequestDispatcher("messages.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
