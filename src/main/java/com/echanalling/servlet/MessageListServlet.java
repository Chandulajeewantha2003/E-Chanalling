package com.echanalling.servlet;

import com.echanalling.model.Message;
import com.echanalling.service.MessageDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/all-messages")
public class MessageListServlet extends HttpServlet {
    private final MessageDAO messageDAO = new MessageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Message> messages = messageDAO.getAllMessages();
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}
