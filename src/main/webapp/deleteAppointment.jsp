<%@ page import="java.sql.*" %>
<%@ page import="online.echanneling.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String appointmentIdStr = request.getParameter("appointmentId");

    if (sessionObj != null && sessionObj.getAttribute("userId") != null && appointmentIdStr != null) {
        int patientId = (Integer) sessionObj.getAttribute("userId");
        int appointmentId = Integer.parseInt(appointmentIdStr);

        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM appointments WHERE id = ? AND patient_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, appointmentId);
            stmt.setInt(2, patientId);

            int rowsAffected = stmt.executeUpdate();

            // Optional: You could add a message in session to show on the next page
            // sessionObj.setAttribute("message", rowsAffected > 0 ? "Appointment deleted successfully." : "Deletion failed.");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }

    // Redirect back to My Appointments page (you can change this path if your JSP filename is different)
    response.sendRedirect("viewappointments.jsp");
%>
