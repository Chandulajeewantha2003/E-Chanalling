package com.echanalling.servlet;

import com.echanalling.service.MessageDAO;
import online.echanneling.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/updateMessage")
public class UpdateMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int messageId = Integer.parseInt(request.getParameter("message_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String newContent = request.getParameter("new_message");

        try (Connection conn = DBConnection.getConnection()) {
            MessageDAO dao = new MessageDAO(conn);
            dao.updateMessage(messageId, newContent, userId);
            response.sendRedirect("messages.jsp?status=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("messages.jsp?status=error");
        }
    }
}
