package online.echanneling.users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    // Handle GET requests (Redirect to login page)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp"); // Redirect to login form
    }

    // Handle POST requests (Login form submission)
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

            // Redirect based on user role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin_dashboard.jsp");
            } else if ("doctor".equals(user.getRole())) {
                response.sendRedirect("doctor_dashboard.jsp");
            } else {
                response.sendRedirect("patient_dashboard.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid email or password");
        }
    }
}
