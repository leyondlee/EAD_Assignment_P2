<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String gameid = "";
			
			String title = request.getParameter("title");
			String company = request.getParameter("company");
			String date = request.getParameter("date");
			String sprice = request.getParameter("price");
			String preowned = request.getParameter("preowned");
			String description = request.getParameter("description");
			String genre[] = request.getParameterValues("genre");
			String quantity = request.getParameter("quantity");
			
			try {
				if (title.isEmpty()) {
					title = null; 
				}
				
				double price = Math.abs(Double.parseDouble(sprice));
				
				Connection conn = DB.getConnection();
				
				PreparedStatement pstmt = conn.prepareStatement("INSERT INTO game (title, releaseDate, description, price, preowned, companyid, quantity) VALUES (?,?,?,?,?,?,?)");
				pstmt.setString(1, title);
				pstmt.setDate(2, Date.valueOf(date));
				pstmt.setString(3, description);
				pstmt.setDouble(4, price);
				pstmt.setInt(5, Integer.parseInt(preowned));
				pstmt.setInt(6, Integer.parseInt(company));
				pstmt.setString(7, quantity);
				
				pstmt.execute();
				
				pstmt = conn.prepareStatement("SELECT gameid FROM game WHERE title = ? AND gameid NOT IN (SELECT gameid FROM game_genre)");
				pstmt.setString(1, title);
				
				ResultSet rs = pstmt.executeQuery();
				if (rs.next()) {
					gameid = Integer.toString(rs.getInt("gameid"));
					
					pstmt = conn.prepareStatement("INSERT INTO game_genre VALUES (?,?)");
					pstmt.setString(1, gameid);
					for (String s : genre) {
						pstmt.setString(2, s);
						pstmt.executeUpdate();
					}
				}
				
				conn.close();
				
				response.sendRedirect("addImageForm.jsp?id=" + gameid);
			} catch (Exception e) {
				response.sendRedirect("error.jsp");
			}
		} else {
	%>
	<%@ include file="nopermission.html" %>
	<%
		}
	%>
	
	<%@ include file="footer.html" %>
</body>
</html>