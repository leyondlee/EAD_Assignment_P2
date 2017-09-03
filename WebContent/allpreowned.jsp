<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		try {
			Connection conn = DB.getConnection();
			PreparedStatement pstmt;
			ResultSet rs;
	%>
	
	<div class="wrapper">
		<div class="container">
			<div class="panel panel-default">
				<div class="panel-heading"><h4>All Preowned Games</h4></div>
				<div class="panel-body">
					<div class="row">
					<%
							pstmt = conn.prepareStatement("SELECT * FROM game WHERE preowned = 1 ORDER BY releaseDate DESC");
							rs = pstmt.executeQuery();
							
							while (rs.next()) {
								String id = rs.getString("gameid");
								String name = rs.getString("title");
								String price = Webpage.getPriceString(rs.getDouble("price"));
								String imageLocation = rs.getString("imagelocation");
								
								imageLocation = Webpage.imageLocation(imageLocation);
						%>
						<div class="col-xs-18 col-sm-6 col-md-3">
							<div class="thumbnail">
								<a href="game.jsp?id=<%=id %>" data-toggle="tooltip" title="<%=name %>"><img class="img-thumbnail" src="<%=imageLocation %>" alt="<%=name %>"></a>
								<div class="caption">
									<h4 id="gamepanelheader"><%=name %></h4>
									
									<div class="pull-left">
										<h4>$<%=price %></h4>
									</div>
									
									<div class="pull-right">
										<a href="game.jsp?id=<%=id %>" class="btn btn-default"><span class="glyphicon glyphicon-info-sign"></span></a> <a href="addToCart?id=<%=id %>" class="btn btn-success"><span class="glyphicon glyphicon-shopping-cart
										"></span></a>
									</div>
									
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
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
	%>
	
	<%@ include file="footer.html" %>
</body>
</html>