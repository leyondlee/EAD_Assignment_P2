package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.*;
import model.*;

import java.sql.*;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		HttpSession session = request.getSession();
		
		String email = "", address = "", contact = "";
		boolean isAdmin = false;
		
		try {
			Connection conn = DB.getConnection();
			
			PreparedStatement pstmt;
			ResultSet rs;
			
			pstmt = conn.prepareStatement("SELECT * FROM user WHERE (username = ? OR username IN (SELECT username FROM member WHERE email = ?)) AND password = ?");
			pstmt.setString(1, username);
			pstmt.setString(2, username);
			pstmt.setString(3, password);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (DB.checkAdmin(rs.getString("username"))) {
					isAdmin = true;
				}
				
				pstmt = conn.prepareStatement("SELECT * FROM member WHERE username = ? OR email = ?");
				pstmt.setString(1, username);
				pstmt.setString(2, username);
				
				rs = pstmt.executeQuery();
				if (rs.next()) {
					username = rs.getString("username");
					email = rs.getString("email");
					address = rs.getString("address");
					contact = rs.getString("contact");
				}
				
				User user = new User(username,password,email,address,contact,isAdmin);
				
				session.invalidate();
				session = request.getSession();
				session.setMaxInactiveInterval(15 * 60);
				
				session.setAttribute("user", user);
				
				response.sendRedirect("index.jsp");
			} else {
				session.setAttribute("loginfail", "1");
				response.sendRedirect("index.jsp#login-modal");
			}
			
			conn.close();
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
