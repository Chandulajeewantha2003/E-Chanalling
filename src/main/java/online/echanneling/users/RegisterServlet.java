package online.echanneling.users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    // Handle GET requests (Redirect to registration page)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp"); // Redirect to registration form
    }

    // Handle POST requests (Form submission)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User newUser = new User(0, name, email, password, role);
        boolean isRegistered = userDAO.registerUser(newUser);

        if (isRegistered) {
            response.sendRedirect("login.jsp?message=Registration successful, please login!");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed, try again.");
        }
    }
}
