<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String commentid = request.getParameter("commentid");
			String gameid = request.getParameter("gameid");
			
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt = conn.prepareStatement("DELETE FROM comment WHERE gameid = ? AND commentid = ?");
				pstmt.setInt(1, Integer.parseInt(gameid));
				pstmt.setInt(2, Integer.parseInt(commentid));
				pstmt.execute();
				
				conn.close();
				
				response.sendRedirect("adminpanel.jsp");
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