package online.echanneling.appointments;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import online.echanneling.DBConnection;

@WebServlet("/GetDoctorsServlet")
public class GetDoctorsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String speciality = request.getParameter("speciality");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, name FROM users WHERE role = 'doctor' AND specialization = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, speciality);
            ResultSet rs = stmt.executeQuery();

            out.println("<option value=''>Select Doctor</option>");
            while (rs.next()) {
                out.println("<option value='" + rs.getInt("id") + "'>" + rs.getString("name") + "</option>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
