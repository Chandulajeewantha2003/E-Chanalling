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
import com.echanalling.service.DoctorDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private DoctorDAO doctorDAO;
    
    // Encapsulation (Private UserDAO and DoctorDAO)
    public void init() {
        userDAO = new UserDAO();
        doctorDAO = new DoctorDAO();
    }

    // Handle POST requests (Login submission)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Authenticate user
        User user = userDAO.loginUser(email, password);

        // Check if user is authenticated
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userEmail", user.getEmail());

            // Handle different roles (Doctor, Admin, Patient)
            if ("doctor".equals(user.getRole())) {
                // Fetch doctor's specialization and store in session
                com.echanalling.model.Doctor doctor = doctorDAO.getDoctorById(user.getId());
                if (doctor != null) {
                    session.setAttribute("specialization", doctor.getSpecialization());
                }
                response.sendRedirect("doctor_dashboard.jsp"); // Redirect to doctor dashboard
            } else if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin_dashboard.jsp"); // Redirect to admin dashboard
            } else {
                response.sendRedirect("PatientDashboard"); // Redirect to patient dashboard
            }
        } else {
            // Login failed, redirect to login page with error message
            response.sendRedirect("login.jsp?error=Invalid email or password");
        }
    }
}
