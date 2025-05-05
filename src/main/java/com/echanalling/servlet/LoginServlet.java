package com.echanalling.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.echanalling.model.User;
import com.echanalling.service.UserDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private com.echanalling.service.DoctorDAO doctorDAO;

    public void init() {
        userDAO = new UserDAO();
        doctorDAO = new com.echanalling.service.DoctorDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.loginUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userEmail", user.getEmail());

            if ("doctor".equals(user.getRole())) {
                com.echanalling.model.Doctor doctor = doctorDAO.getDoctorById(user.getId());
                if (doctor != null) {
                    session.setAttribute("specialization", doctor.getSpecialization());
                }
                response.sendRedirect("doctor_dashboard.jsp");
            } else if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin_dashboard.jsp");
            } else {
            	response.sendRedirect("PatientDashboardServlet");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid email or password");
        }
    }
}
