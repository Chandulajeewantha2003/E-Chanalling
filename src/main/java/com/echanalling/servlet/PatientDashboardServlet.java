package com.echanalling.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PatientDashboardServlet") // Optional: can be used with @WebServlet instead of web.xml
public class PatientDashboardServlet extends HttpServlet {
	 @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Forward the request to patientdashboard.jsp
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/patient_dashboard.jsp");
	        dispatcher.forward(request, response);
	    }
	}