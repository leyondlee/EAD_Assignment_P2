<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String id = request.getParameter("id");
			
			String imageLocation = "";
			
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt = conn.prepareStatement("SELECT * from game WHERE gameid = ?");
				pstmt.setInt(1, Integer.parseInt(id));
				ResultSet rs = pstmt.executeQuery();
				
				if (rs.next()) {
					imageLocation = rs.getString("imageLocation");
					response.sendRedirect("addImageForm.jsp?id=" + id);
				}
				
				conn.close();
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