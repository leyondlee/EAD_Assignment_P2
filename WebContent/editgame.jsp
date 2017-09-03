<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String company = request.getParameter("company");
			String date = request.getParameter("date");
			String price = request.getParameter("price");
			String preowned = request.getParameter("preowned");
			String description = request.getParameter("description");
			String genre[] = request.getParameterValues("genre");
			
			try {
				if (title.isEmpty()) {
					title = null; 
				}
				
				int gameid = Integer.parseInt(id);
				
				Connection conn = DB.getConnection();
				
				PreparedStatement pstmt = conn.prepareStatement("UPDATE game SET title = ?, releasedate = ?, description = ?, price = ?, companyid = ?, preowned = ? WHERE gameid = ?");
				pstmt.setString(1, title);
				pstmt.setDate(2, Date.valueOf(date));
				pstmt.setString(3, description);
				pstmt.setDouble(4, Double.parseDouble(price));
				pstmt.setInt(5, Integer.parseInt(company));
				pstmt.setInt(6, Integer.parseInt(preowned));
				pstmt.setInt(7, gameid);
				pstmt.execute();
				
				pstmt = conn.prepareStatement("DELETE FROM game_genre WHERE gameid = ?");
				pstmt.setInt(1, gameid);
				pstmt.execute();
				
				for (String s : genre) {
					pstmt = conn.prepareStatement("INSERT INTO game_genre VALUES (?,?)");
					pstmt.setInt(1, gameid);
					pstmt.setInt(2, Integer.parseInt(s));
					pstmt.execute();
				}
				
				conn.close();
				
				response.sendRedirect("adminpanel.jsp#admingame");
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