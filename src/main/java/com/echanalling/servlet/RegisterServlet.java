package com.echanalling.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.echanalling.model.User;
import com.echanalling.service.UserDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    // Encapsulation (Private UserDAO)
    public void init() {
        userDAO = new UserDAO();
    }

    // Polymorphism (DOGET)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    // Polymorphism (DOPOST)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Server-side validation
        if (name == null || name.trim().isEmpty() ||
            email == null || !email.contains("@") ||
            password == null || password.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {

            response.sendRedirect("register.jsp?error=Please fill all fields correctly. Email must contain '@'");
            return;
        }

        User newUser = new User(0, name, email, password, role);
        boolean isRegistered = userDAO.registerUser(newUser);

        if (isRegistered) {
            response.sendRedirect("login.jsp?message=Registration successful, please login!");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed, try again.");
        }
    }
}
