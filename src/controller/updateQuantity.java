package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.*;

import java.sql.*;

/**
 * Servlet implementation class updateQuantity
 */
@WebServlet("/updateQuantity")
public class updateQuantity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateQuantity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String id = request.getParameter("id");
		String quantity = request.getParameter("quantity");
		String page = request.getHeader("Referer");
		HttpSession session = request.getSession();
		
		if (Webpage.checkAdmin(session)) {
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt = conn.prepareStatement("UPDATE game SET quantity = ? WHERE gameid = ?");
				pstmt.setString(1, quantity);
				pstmt.setString(2, id);
				pstmt.execute();
				
				response.sendRedirect(page + "#adminstock");
				
				conn.close();
			} catch (Exception e) {
				response.sendRedirect("error.jsp");
			}
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
