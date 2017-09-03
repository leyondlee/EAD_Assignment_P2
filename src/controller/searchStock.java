package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.*;
import model.*;
import java.sql.*;
import java.util.*;

/**
 * Servlet implementation class searchStock
 */
@WebServlet("/searchStock")
public class searchStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchStock() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String stocksearch = request.getParameter("stocksearch");
		String page = request.getParameter("stockpage");
		
		if (stocksearch == null) {
			stocksearch = "";
		}
		
		String sql = "";
		if (stocksearch.equals("")) {
			sql = "SELECT * FROM game ORDER BY quantity ASC";
		} else {
			sql = "SELECT * FROM game WHERE quantity < ? ORDER BY quantity ASC";
		}
		
		ArrayList<Game> stocksearchlist = new ArrayList<Game>();
		try {
			Connection conn = DB.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			if (!stocksearch.equals("")) {
				pstmt.setString(1, stocksearch);
			}
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Game g = new Game(rs.getInt("gameid"),rs.getString("title"),rs.getDate("releaseDate"),rs.getString("description"),rs.getDouble("price"),rs.getString("imageLocation"),rs.getInt("companyid"),rs.getInt("preowned"),rs.getInt("quantity"));
				stocksearchlist.add(g);
			}
			
			conn.close();
		} catch (Exception e) {
			response.sendRedirect("error.jsp");
		}
		
		request.setAttribute("stockpage", page);
		request.setAttribute("stocksearch", stocksearch);
		request.setAttribute("stocksearchlist", stocksearchlist);
		RequestDispatcher rd = request.getRequestDispatcher("searchStock.jsp");
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
