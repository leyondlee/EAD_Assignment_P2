<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String options[] = request.getParameterValues("option");
			String type = request.getParameter("btnSubmit");
			String action = "";
			
			if (options != null) {
				try {
					Connection conn = DB.getConnection();
					PreparedStatement pstmt;
					ResultSet rs;
					
					int itype = Integer.parseInt(type);
					if (itype == 0) {
						type = "game";
						action = "deletegame.jsp";
					} else if (itype == 1) {
						type = "genre";
						action = "deletegenre.jsp";
					} else {
						type = "company";
						action = "deletecompany.jsp";
					}
	%>
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<div class="panel panel-default">
					<div class="panel-heading"><h4>Confirm delete of the following <%=type %>:</h4></div>
					<div class="panel-body">
						<%
							if (!(action.equals(""))) {
								for (String s : options) {
									int id = Integer.parseInt(s);
									
									String sql = "SELECT * FROM " + type + " WHERE " + type + "id = ?";
									pstmt = conn.prepareStatement(sql);
									pstmt.setInt(1, id);
									rs = pstmt.executeQuery();
									
									if (rs.next()) {
										String name = "";
										if (itype == 0) {
											name = rs.getString("title");
										} else {
											name = rs.getString("name");
										}
						%>
						<form action="<%=action %>" method="post">
							<div class="checkbox">
						      	<label><input type="checkbox" name="option" value="<%=id %>" checked><%=name %></label>
						    </div>
						<%
									}
								}
						%>
						<div class="pull-right">
							<a href="adminpanel.jsp"><button type="button" class="btn btn-default">No</button></a> <button type="submit" class="btn btn-default">Yes</button>
						</div>
						
						<br />
						
						</form>
						<%
							}
						%>
					</div>
				</div>
			</div>
		</div>
		
		<div class="push"></div>
	</div>
	<%
					conn.close();
				} catch (Exception e) {
					response.sendRedirect("error.jsp");
				}
			} else {
				response.sendRedirect("adminpanel.jsp");
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