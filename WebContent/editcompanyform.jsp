<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String name = "";
		
			String id = request.getParameter("id");
			
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM company WHERE companyid = ?");
				pstmt.setInt(1, Integer.parseInt(id));
				ResultSet rs = pstmt.executeQuery();
				
				if (rs.next()) {
					name = rs.getString("name");
				}
	%>
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>Edit Company ("<%=name %>")</h4>
					</div>
					<div class="panel-body">
						<form action="editcompany.jsp" method="post">
							<input type="hidden" name="id" value="<%=id %>">
							
							<div class="form-group">
								<label for="companyid">ID</label>
								<input class="form-control" id="companyid" type="text" name="id" value="<%=id %>" disabled>
							</div>
							
							<div class="form-group">
								<label for="title">Name</label>
								<input type="text" class="form-control" id="name" autocomplete="off" name="name" value="<%=name %>">
							</div>
							
							<br />
							
							<div class="pull-left">
								<button type="reset" class="btn btn-default">Reset</button>
							</div>
							
							<div class="pull-right">
								<a href="adminpanel.jsp#admincompany"><button type="button" class="btn btn-danger">Cancel</button></a> <button type="submit" class="btn btn-default">Apply</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div class="push"></div>
	</div>
	<%
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