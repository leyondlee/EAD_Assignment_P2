<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		boolean loggedin = Webpage.checkLoggedin(session);
		
		String id = request.getParameter("id");
		String comment = request.getParameter("comment");
		String rating = request.getParameter("rating");
		String name = request.getParameter("name");
		
		if (name == null) {
			name = request.getParameter("username");
		}
		
		try {
			Connection conn = DB.getConnection();
			PreparedStatement pstmt;
			
			if (name.isEmpty()) {
				name = null; 
			}
			
			if (comment.isEmpty()) {
				comment = null; 
			}
			
			if (name != null && comment != null) {
				if (!loggedin) {
					pstmt = conn.prepareStatement("INSERT INTO comment (gameid, comment, rating, date, name) VALUES (?, ?, ?, CURDATE(), ?)");
				} else {
					pstmt = conn.prepareStatement("INSERT INTO comment (gameid, comment, rating, date, username) VALUES (?, ?, ?, CURDATE(), ?)");
				}
				
				pstmt.setInt(1, Integer.parseInt(id));
				pstmt.setString(2, comment);
				pstmt.setInt(3, Integer.parseInt(rating));
				pstmt.setString(4, name);
				
				pstmt.execute();
			}
			
			conn.close();
			
			response.sendRedirect("game.jsp?id=" + id + "#gamecomment");
		} catch (Exception e) {
			out.println(e);
		}
	%>
	
	<%@ include file="footer.html" %>
</body>
</html>