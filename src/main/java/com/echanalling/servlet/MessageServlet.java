package com.echanalling.servlet;

import com.echanalling.model.Message;
import com.echanalling.model.User;
import com.echanalling.service.DoctorDAO;
import com.echanalling.service.MessageDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

@WebServlet("/messages")
public class MessageServlet extends HttpServlet {

    private MessageDAO messageDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() {
        messageDAO = new MessageDAO();
        doctorDAO = new DoctorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String mode = request.getParameter("mode");
        if (mode == null) mode = "list";
        request.setAttribute("mode", mode);

        if ("edit".equals(mode) || "view".equals(mode)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Message msg = messageDAO.getMessageById(id);
            request.setAttribute("currentMessage", msg);
        }

        List<Message> messages = messageDAO.getMessagesByUserId(userId);
        request.setAttribute("messages", messages);

        // Add data for specialization-doctor filtering
        List<String> specializations = doctorDAO.getAllSpecializations();
        Map<String, List<User>> doctorsBySpecialization = doctorDAO.getDoctorsGroupedBySpecialization();

        request.setAttribute("specializations", specializations);
        request.setAttribute("doctorsBySpecialization", doctorsBySpecialization);

        request.getRequestDispatcher("/messages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer senderId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (senderId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String message;
        boolean isError = false;

        try {
            switch (action) {
                case "create":
                    Message newMsg = extractMessage(request, senderId);
                    if (messageDAO.createMessage(newMsg)) {
                        message = "Message sent successfully.";
                    } else {
                        message = "Failed to send message.";
                        isError = true;
                    }
                    break;

                case "update":
                    Message updateMsg = extractMessage(request, senderId);
                    updateMsg.setId(Integer.parseInt(request.getParameter("id")));
                    if (messageDAO.updateMessage(updateMsg)) {
                        message = "Message updated successfully.";
                    } else {
                        message = "Failed to update message.";
                        isError = true;
                    }
                    break;

                case "delete":
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    if (messageDAO.deleteMessage(deleteId)) {
                        message = "Message deleted.";
                    } else {
                        message = "Failed to delete message.";
                        isError = true;
                    }
                    break;

                default:
                    message = "Invalid action.";
                    isError = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error occurred: " + e.getMessage();
            isError = true;
        }

        if (isError) {
            session.setAttribute("error", message);
        } else {
            session.setAttribute("success", message);
        }
        response.sendRedirect(request.getContextPath() + "/messages");
    }

    private Message extractMessage(HttpServletRequest request, int senderId) {
        Message msg = new Message();
        msg.setSenderId(senderId);
        msg.setReceiverId(Integer.parseInt(request.getParameter("receiverId")));
        msg.setMessage(request.getParameter("message"));
        msg.setSentAt(new Timestamp(System.currentTimeMillis()));
        return msg;
    }
}
