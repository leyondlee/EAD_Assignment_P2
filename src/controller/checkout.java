package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
 * Servlet implementation class checkout
 */
@WebServlet("/checkout")
public class checkout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public checkout() {
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
		if (Webpage.checkLoggedin(session)) {
			User user = (User) session.getAttribute("user");
			Cart cart = (Cart) session.getAttribute("cart");
			if (cart != null) {
				try {
					Connection conn = DB.getConnection();
					
					PreparedStatement pstmt;
					ResultSet rs;
					
					boolean pass = true;
					
					for (Item i : cart.getItems()) {
						int q = DB.getGameQuantity(String.valueOf(i.getGame().getGameid()));
						if (i.getQuantity() > q) {
							pass = false;
							i.setQuantity(q);
						}
					}
					if (pass) {
						pstmt = conn.prepareStatement("INSERT INTO transaction (date,time,username) VALUES (CURDATE(),CURTIME(),?)", Statement.RETURN_GENERATED_KEYS);
						pstmt.setString(1, user.getUsername());
						
						pstmt.execute();
						rs = pstmt.getGeneratedKeys();
						if (rs.next()) {
							int key = rs.getInt(1);
							for (Item i : cart.getItems()) {
								pstmt = conn.prepareStatement("INSERT INTO game_transaction VALUES (?,?,?)");
								pstmt.setInt(1,i.getGame().getGameid());
								pstmt.setInt(2, key);
								pstmt.setInt(3, i.getQuantity());
								
								pstmt.execute();
								
								pstmt = conn.prepareStatement("UPDATE game SET quantity = ? WHERE gameid = ?");
								pstmt.setInt(1, i.getGame().getQuantity() - i.getQuantity());
								pstmt.setInt(2, i.getGame().getGameid());
								
								pstmt.execute();
							}
						}
						
						session.setAttribute("cart", null);
						
						response.sendRedirect("index.jsp");
					} else {
						response.sendRedirect("cart.jsp?error=1");
					}
					
					conn.close();
				} catch (Exception e) {
					response.sendRedirect("error.jsp");
				}
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
