package online.echanneling.appointments;

import online.echanneling.DBConnection;
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

@WebServlet("/GetDoctorsServlet")
public class GetDoctorsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String speciality = request.getParameter("speciality");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, name FROM users WHERE role='doctor' AND specialization=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, speciality);
            ResultSet rs = stmt.executeQuery();

            PrintWriter out = response.getWriter();
            out.println("<option value=''>Select Doctor</option>");
            while (rs.next()) {
                out.println("<option value='" + rs.getInt("id") + "'>" + rs.getString("name") + "</option>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
