package com.echanalling.servlet;

import com.echanalling.model.Message;
import com.echanalling.service.MessageDAO;
import online.echanneling.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int senderId = Integer.parseInt(request.getParameter("sender_id"));
        int receiverId = Integer.parseInt(request.getParameter("receiver_id"));
        String messageContent = request.getParameter("message");

        try (Connection conn = DBConnection.getConnection()) {
            MessageDAO dao = new MessageDAO(conn);
            Message msg = new Message();
            msg.setSenderId(senderId);
            msg.setReceiverId(receiverId);
            msg.setMessageContent(messageContent);
            dao.sendMessage(msg);
            response.sendRedirect("messages.jsp?status=sent");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("messages.jsp?status=error");
        }
    }
}
