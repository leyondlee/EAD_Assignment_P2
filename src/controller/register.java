package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.*;

import java.sql.*;

/**
 * Servlet implementation class register
 */
@WebServlet("/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public register() {
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
		String contact = request.getParameter("contact");
		String address = request.getParameter("address");
		String password = request.getParameter("password");
		String confirmpassword = request.getParameter("confirmpassword");
		
		String error = null;
		
		boolean pass = false;
		if (Webpage.checkPassword(password, confirmpassword)) {
			if (Webpage.checkUsername(username)) {
				if (Webpage.checkEmail(email)) {
					if (Webpage.checkContact(contact)) {
						if (Webpage.checkAddress(address)) {
							try {
								int update;
								
								Connection conn = DB.getConnection();
								PreparedStatement pstmt;
								
								if (!DB.usernameExists(username) && !DB.emailExists(email)) {
									pstmt = conn.prepareStatement("INSERT INTO user VALUES (?,?)");
									pstmt.setString(1, username);
									pstmt.setString(2, password);
									update = pstmt.executeUpdate();
									
									if (update > 0) {
										pstmt = conn.prepareStatement("INSERT INTO member VALUES (?,?,?,?)");
										pstmt.setString(1, username);
										pstmt.setString(2, email);
										pstmt.setString(3, address);
										pstmt.setString(4, contact);
										update = pstmt.executeUpdate();
										
										if (update > 0) {
											pass = true;
											response.sendRedirect("index.jsp");
										}
									}
								}
								
								conn.close();
							} catch (Exception e) {
								//response.sendRedirect("error.jsp");
							}
						}
					}
				}
			}
		} else {
			error = "1";
		}
		
		if (!pass) {
			if (error == null) {
				error = "0";
			}
			
			String[] fields = {username,email,contact,address};
			request.setAttribute("fields", fields);
			request.setAttribute("error", error);
			RequestDispatcher rd = request.getRequestDispatcher("registerform.jsp");
			rd.forward(request, response);
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
