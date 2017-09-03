package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import common.*;
import model.*;

/**
 * Servlet implementation class updateUser
 */
@WebServlet("/updateUser")
public class updateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateUser() {
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
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String contact = request.getParameter("contact");
		String currentpassword = request.getParameter("currentpassword");
		String newpassword = request.getParameter("newpassword");
		String confirmpassword = request.getParameter("confirmpassword");
		String page = request.getHeader("Referer");
		HttpSession session = request.getSession();
		
		if (Webpage.checkLoggedin(session)) {
			User user = (User) session.getAttribute("user");
			String curusername = user.getUsername();
			
			int error = -1;
			if (currentpassword.length() > 0) {
				if (currentpassword.equals(user.getPassword()) && Webpage.checkPassword(newpassword, confirmpassword)) {
					user.setPassword(newpassword);
				} else {
					error = 0;
				}
			}
			
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt;
				
				pstmt = conn.prepareStatement("UPDATE user SET password = ? WHERE username = ?");
				pstmt.setString(1, user.getPassword());
				pstmt.setString(2, curusername);
				pstmt.execute();
				
				if (!Webpage.checkAdmin(session)) {
					if (!user.getUsername().equals(username)) {
						if (Webpage.checkUsername(username) && !DB.usernameExists(username)) {
							user.setUsername(username);
						} else {
							error = 1;
						}
					}
					
					if (!user.getEmail().equals(email)) {
						if (Webpage.checkEmail(email) && !DB.emailExists(email)) {
							user.setEmail(email);
						} else {
							error = 1;
						}
					}
					
					if (!user.getAddress().equals(address)) {
						if (Webpage.checkAddress(address)) {
							user.setAddress(address);
						} else {
							error = 1;
						}
					}
					
					if (!user.getContact().equals(contact)) {
						if (Webpage.checkContact(contact)) {
							user.setContact(contact);
						} else {
							error = 1;
						}
					}
					
					pstmt = conn.prepareStatement("UPDATE user SET username = ? WHERE username = ?");
					pstmt.setString(1, user.getUsername());
					pstmt.setString(2, curusername);
					pstmt.execute();
					
					pstmt = conn.prepareStatement("UPDATE member SET email = ?, address = ?, contact = ? WHERE username = ?");
					pstmt.setString(1, user.getEmail());
					pstmt.setString(2, user.getAddress());
					pstmt.setString(3, user.getContact());
					pstmt.setString(4, user.getUsername());
					pstmt.execute();
				}
				
				if (error != -1) {
					response.sendRedirect("settings.jsp?error=" + error);
				} else {
					response.sendRedirect("settings.jsp");
				}
				
				conn.close();
			} catch (Exception e) {
				response.sendRedirect("error.jsp");
			}
		} else {
			response.sendRedirect(page + "#login-modal");
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
