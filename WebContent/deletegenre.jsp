<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String option[] = request.getParameterValues("option");
			
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt;
				
				for (String s : option) {
					int id = Integer.parseInt(s);
					
					pstmt = conn.prepareStatement("DELETE FROM genre WHERE genreid = ? AND ? NOT IN (SELECT genreid FROM game_genre)");
					pstmt.setInt(1, id);
			        pstmt.setInt(2, id);
					pstmt.execute();
				}
				
				conn.close();
				
				response.sendRedirect("adminpanel.jsp#admingenre");
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