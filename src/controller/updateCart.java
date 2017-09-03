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

/**
 * Servlet implementation class updateCart
 */
@WebServlet("/updateCart")
public class updateCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String page = request.getHeader("Referer");
		HttpSession session = request.getSession();
		
		if (Webpage.checkLoggedin(session)) {
			Cart cart = (Cart) session.getAttribute("cart");
			if (cart != null) {
				boolean error = false;
				for (int i = 0; i < cart.getItems().size(); i++) {
					Item item = cart.getItems().get(i);
					String quantity = request.getParameter(String.valueOf(i));
					int q = Webpage.getInt(quantity);
					if (q > 0 && DB.getGameQuantity(String.valueOf(item.getGame().getGameid())) >= q) {
						item.setQuantity(q);
					} else {
						error = true;
					}
				}
				
				if (!error) {
					response.sendRedirect("cart.jsp");
				} else {
					response.sendRedirect("cart.jsp?error=1");
				}
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
