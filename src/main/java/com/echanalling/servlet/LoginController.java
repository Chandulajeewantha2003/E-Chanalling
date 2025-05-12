package com.echanalling.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")  // clean URL = /login
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    //Polymorphism (DOGET)
    // Display the login page (GET request)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    //Polymorphism (DOPOST)
    // Handle login logic (POST request)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the username and password from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Authenticate the user (this is just an example; you should validate against a database)
        if ("patient".equals(username) && "password123".equals(password)) {
            // If the user is valid, set the session attribute
            HttpSession session = request.getSession();
            session.setAttribute("user", username); // Store user info in session

            // Redirect to the Patient Dashboard after successful login
            response.sendRedirect("PatientDashboard");
        } else {
            // If login fails, forward back to the login page with an error message
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
