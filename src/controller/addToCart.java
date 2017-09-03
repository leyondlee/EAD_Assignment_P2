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
 * Servlet implementation class addToCart
 */
@WebServlet("/addToCart")
public class addToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addToCart() {
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
		String page = request.getHeader("Referer");
		HttpSession session = request.getSession();
		
		if (page == null) {
			page = "index.jsp";
		}
		
		if (Webpage.checkLoggedin(session)) {
			boolean addnew = true;
			Cart cart = (Cart) session.getAttribute("cart");
			if (cart == null) {
				cart = new Cart();
			} else {
				for (Item i: cart.getItems()) {
					if (id.equals(String.valueOf(i.getGame().getGameid()))) {
						if (i.getQuantity() + 1 <= DB.getGameQuantity(String.valueOf(i.getGame().getGameid()))) {
							i.setQuantity(i.getQuantity() + 1);
						}
						
						addnew = false;
						break;
					}
				}
			}
			
			if (addnew) {
				try {
					Connection conn = DB.getConnection();
					PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameid = ?");
					pstmt.setString(1, id);
					
					ResultSet rs = pstmt.executeQuery();
					if (rs.next()) {
						if(rs.getInt("quantity") > 0) {
							Game game = new Game(rs.getInt("gameid"), rs.getString("title"), rs.getDate("releaseDate"), rs.getString("description"), rs.getDouble("price"), rs.getString("imageLocation"), rs.getInt("companyid"), rs.getInt("preowned"), rs.getInt("quantity"));
							cart.addToCart(game, 1);
						}
					}
					
					conn.close();
				} catch(Exception e) {
					response.sendRedirect("error.jsp");
				}
			}
			
			session.setAttribute("cart", cart);
			response.sendRedirect(page);
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
