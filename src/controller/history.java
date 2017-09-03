package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;
import common.*;
import java.util.*;
import java.sql.*;

/**
 * Servlet implementation class history
 */
@WebServlet("/history")
public class history extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public history() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		String username = user.getUsername();
		
		ArrayList<String[]> history = new ArrayList<String[]>();
		try {
			Connection conn = DB.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM transaction WHERE username = ?");
			pstmt.setString(1, username);
			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String[] h = {rs.getString("transactionid"),Webpage.dateFormat(rs.getDate("date"), "dd-MM-yy"),rs.getString("time")};
				history.add(h);
			}
			
			conn.close();
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
		
		request.setAttribute("history", history);
		RequestDispatcher rd = request.getRequestDispatcher("history.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
