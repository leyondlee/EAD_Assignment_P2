package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
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
 * Servlet implementation class viewTransaction
 */
@WebServlet("/viewTransaction")
public class viewTransaction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public viewTransaction() {
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
		
		HttpSession session = request.getSession();
		if (Webpage.checkLoggedin(session)) {
			Transaction transaction = new Transaction();
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt;
				ResultSet rs;
				
				pstmt = conn.prepareStatement("SELECT * FROM transaction WHERE transactionid = ?");
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				if (rs.next()) {
					transaction.setId(rs.getInt("transactionid"));
					transaction.setDate(rs.getDate("date"));
					transaction.setTime(rs.getString("time"));
					
					pstmt = conn.prepareStatement("SELECT * FROM game_transaction WHERE transactionid = ?");
					pstmt.setString(1, id);
					
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String gameid = rs.getString("gameid");
						int quantity = rs.getInt("quantity");
						Game game = DB.getGame(gameid);
						transaction.addToList(game, quantity);
					}
				}
				 
				conn.close();
			} catch (Exception e) {
				response.sendRedirect("error.jsp");
			}
			
			request.setAttribute("transaction", transaction);
			RequestDispatcher rd = request.getRequestDispatcher("viewTransaction.jsp");
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
