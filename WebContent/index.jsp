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
			<div class="row">
				<div class="col-md-12">
					<br />
					
					<div class="row carousel-holder">
						<div class="col-md-6" id="homepagebanner">
							<%
								String id = "", name = "", imageLocation = "", price = "";
								int rows, rnd;
								
								pstmt = conn.prepareStatement("SELECT * FROM game WHERE preowned = 0");
	                        	rs = pstmt.executeQuery();
	                        	
	                        	rs.last();
                            	rows = rs.getRow();
                            	rs.beforeFirst();
                            	
                            	rnd = 1 + (int) (Math.random() * rows);
                            	rs.absolute(rnd);
                            	
                            	id = rs.getString("gameid");
                        		imageLocation = rs.getString("imageLocation");
                        		
                        		imageLocation = Webpage.imageLocation(imageLocation);
							%>
							<div>
								<a href="game.jsp?id=<%=id %>"><img class="slide-image .img-responsive" src="<%=imageLocation %>" alt=""></a>
	                    	</div>
	                    </div>
						
	                    <div class="col-md-6">
	                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	                            <ol class="carousel-indicators">
	                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	                            </ol>
	                           
	                            <div class="carousel-inner">
	                            	<%
		                            	rs.beforeFirst();
		                            	
		                            	int row[] = new int[3];
		                            	int count = 0;
		                            	while (count < 3) {
		                            		boolean valid = true;
		                            		rnd = 1 + (int) (Math.random() * rows);
		                            		for (int i = 0; i < row.length; i++) {
		                            			if (rnd == row[i]) {
		                            				valid = false;
		                            			}
		                            		}
		                            		
		                            		if (valid) {
	                            				row[count] = rnd;
	                            				count++;
	                            			}
		                            	}
		                            	
		                            	for (int i = 0; i < row.length; i++) {
		                            		rs.absolute(row[i]);
		                            		id = rs.getString("gameid");
		                            		imageLocation = rs.getString("imageLocation");
		                            		
		                            		imageLocation = Webpage.imageLocation(imageLocation);
		                            		
		                            		if (i == 0) {
		                            %>
		                            <div class="item active">
		                            	<a href="game.jsp?id=<%=id %>"><img class="slide-image" src="<%=imageLocation %>" alt=""></a>
		                            </div>
		                            <%
		                            		} else {
		                            %>
		                            <div class="item">
		                            	<a href="game.jsp?id=<%=id %>"><img class="slide-image" src="<%=imageLocation %>" alt=""></a>
		                            </div>
		                            <%
		                            		}
		                            	}
		                            %>
	                            </div>
	                            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
	                                <span class="glyphicon glyphicon-chevron-left"></span>
	                            </a>
	                            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
	                                <span class="glyphicon glyphicon-chevron-right"></span>
	                            </a>
	                        </div>
	                    </div>
	                </div>
	                
	                <br />
	            </div>
	        </div>
	        
	        <br />
			
			<div class="panel panel-default">
				<div class="panel-heading"><h4>New Releases</h4></div>
				<div class="panel-body">
					<div class="row">
						<%
							pstmt = conn.prepareStatement("SELECT * FROM game WHERE preowned = 0 ORDER BY releaseDate DESC");
							rs = pstmt.executeQuery();
							
							for (int i = 0; i < 8; i++) {
								if (rs.next()) {
									id = rs.getString("gameid");
									name = rs.getString("title");
									price = Webpage.getPriceString(rs.getDouble("price"));
									imageLocation = rs.getString("imagelocation");
									
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