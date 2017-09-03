<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String name = request.getParameter("name");
			
			//try {
				if (name.isEmpty()) {
					name = null; 
				}
				
				Connection conn = DB.getConnection();
				
				PreparedStatement pstmt = conn.prepareStatement("INSERT INTO company (name) VALUES (?)");
				pstmt.setString(1, name);
				
				pstmt.executeUpdate();
				
				conn.close();
				
				response.sendRedirect("adminpanel.jsp#admincompany");
			//} catch (Exception e) {
				//response.sendRedirect("error.jsp");
			//}
		} else {
	%>
	<%@ include file="nopermission.html" %>
	<%
		}
	%>
	
	<%@ include file="footer.html" %>
</body>
</html>