<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String id = request.getParameter("id");
			String title = "";
		
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt = conn.prepareStatement("SELECT title FROM game WHERE gameid = ?");
				pstmt.setInt(1, Integer.parseInt(id));
				
				ResultSet rs = pstmt.executeQuery();
				if (rs.next()) {
					title = rs.getString(1);
				}
				
				conn.close();
			} catch (Exception e) {
				response.sendRedirect("error.jsp");
			}
	%>
	
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<div class="panel panel-default">
					<div class="panel-heading"><h4>Add Image for <%=title %> (ID: <%=id %>)</h4></div>
					<div class="panel-body">
						<form action="addImage.jsp" method="post" enctype="multipart/form-data">
							<br />
							<input type="hidden" name="id" value="<%=id %>">
							<input type="file" name="file" accept=".jpg">
							<br />
							<br />
							<div class="pull-left">
								<button type="reset" class="btn btn-default">Reset</button>
							</div>
							<div class="pull-right">
								<a href="adminpanel.jsp#admingame"><button type="button" class="btn btn-default">Skip</button></a> <button type="submit" class="btn btn-default">Upload</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div class="push"></div>
	</div>
	<%
		} else {
	%>
	<%@ include file="nopermission.html" %>
	<%
		}
	%>
	
	<%@ include file="footer.html" %>
</body>
</html>