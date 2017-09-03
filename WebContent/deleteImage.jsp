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
					
					if (imageLocation == null) {
						imageLocation = "";
					}
					
					if (!(imageLocation.equals(""))) {
						boolean deleted = Webpage.deleteImage(getServletContext().getRealPath("/").replace("/", "\\") + (imageLocation.replace("/","\\")));
						
						if (deleted) {
							pstmt = conn.prepareStatement("UPDATE game SET imageLocation = '' WHERE gameid = ?");
							pstmt.setInt(1, Integer.parseInt(id));
							pstmt.execute();
						}
					}
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