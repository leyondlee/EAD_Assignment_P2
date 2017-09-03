<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String options[] = request.getParameterValues("option");
			
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt;
				ResultSet rs;
				
				for (String s : options) {
					int id = Integer.parseInt(s);
					
					pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameid = ?");
					pstmt.setInt(1, id);
					rs = pstmt.executeQuery();
					
					if (rs.next()) {
						String imageLocation = rs.getString("imageLocation");
						
						if (imageLocation == null) {
							imageLocation = "";
						}
						
						if (!(imageLocation.equals(""))) {
							Webpage.deleteImage(getServletContext().getRealPath("/").replace("/", "\\") + (imageLocation.replace("/","\\")));
						}
						
						pstmt = conn.prepareStatement("DELETE FROM game WHERE gameid = ?");
						pstmt.setInt(1, id);
						pstmt.execute();
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