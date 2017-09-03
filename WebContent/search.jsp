<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		int count = 0, id = -1, companyid = -1, pg, end, start, pages, prevpage, nextpage;
		String imageLocation = "", title = "", company = "", pgs = "", genre = "", extraurl = "", pagelinkclass, pghref;
		double price = 0;
		
		String search = request.getParameter("search");
		String preowned = request.getParameter("preowned");
		String reqgenre[] = request.getParameterValues("genre");
		
		try {
			Connection conn = DB.getConnection();
			PreparedStatement pstmt;
			ResultSet rs;
			
			if (preowned != null) {
				extraurl += "&preowned=" + preowned;
			}
			
			if (reqgenre != null) {
				for (String s : reqgenre) {
					extraurl += "&genre=" + s;
					genre += ",?";
				}
				
				if (!(genre.equals(""))) {
					genre = genre.substring(1);
				}
			}
	%>
	
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-10 col-md-10 col-md-offset-1">
				<div class="panel panel-default">
					<%
						String searchgenres = "";
						if (reqgenre != null) {
							pstmt = conn.prepareStatement("SELECT * FROM genre WHERE genreid IN (" + genre + ")");
							for (int i = 0; i < reqgenre.length; i++) {
								pstmt.setInt((i + 1), Integer.parseInt(reqgenre[i]));
							}
							rs = pstmt.executeQuery();
							
							while (rs.next()) {
								String gname = rs.getString("name");
								searchgenres += ", " + gname;
							}
							
							if (!(searchgenres.equals(""))) {
								searchgenres = searchgenres.substring(2);
							}
						} else {
							searchgenres = "-";
						}
					%>
					<div class="panel-heading">
						<h4>Search Results for "<%=search %>"</h4>
						<p>Genres: <%=searchgenres %></p>
						<div class="clearfix"></div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th>#</th>
										<th class="col-xs-3">Image</th>
										<th class="col-xs-5">Title</th>
										<th>Company</th>
										<th>Price</th>
										<th class="col-xs-1">Action</th>
									</tr>
								</thead>
								<tbody>
									<%
										pgs = request.getParameter("searchpage");
										if (pgs == null) {
											pg = 1;
										} else {
											pg = Integer.parseInt(pgs);
										}
										
										end = pg * 10;
										start = end - 10;
										
										String sql = "";
										if (reqgenre != null) {
											sql = "SELECT * FROM game g WHERE title LIKE ? AND preowned LIKE ? AND gameid IN (SELECT gameid FROM game_genre WHERE genreid IN (" + genre + ") GROUP BY gameid HAVING COUNT(*) = ?) ORDER BY title ASC";
										} else {
											sql = "SELECT * FROM game WHERE title LIKE ? AND preowned LIKE ? ORDER BY title ASC";
										}
										
										pstmt = conn.prepareStatement(sql);
										
										if (reqgenre != null) {
											int curcount = 3;
											int genrecount = reqgenre.length;
											for (int i = 0; i < reqgenre.length; i++) {
												pstmt.setInt(curcount, Integer.parseInt(reqgenre[i]));
												curcount++;
											}
											
											pstmt.setInt(curcount,genrecount);
										}
										
										pstmt.setString(1, "%" + search + "%");
										if (preowned != null) {
											pstmt.setString(2, preowned);
										} else {
											pstmt.setString(2, "%");
										}
										
										rs = pstmt.executeQuery();
										
										ResultSet companyrs;
										while (rs.next()) {
											if (count >= start && count < end) {
												id = rs.getInt("gameid");
												imageLocation = rs.getString("imageLocation");
												title = rs.getString("title");
												companyid = rs.getInt("companyid");
												price = rs.getDouble("price");
												
												if (rs.getInt("preowned") == 1) {
													title += " (Preowned)";
												}
												
												if (imageLocation == null) {
													imageLocation = "";
												}
												
												if (imageLocation.equals("")) {
													imageLocation = "images/defaultimage.jpg";
												}
												
												pstmt = conn.prepareStatement("SELECT * FROM company WHERE companyid = ?");
												pstmt.setInt(1, companyid);
												companyrs = pstmt.executeQuery();
												if (companyrs.next()) {
													company = companyrs.getString("name");
												}
									%>
									<tr>
										<td><%=(count + 1) %></td>
										<td><img class="img-thumbnail img-responsive" src="<%=imageLocation %>" alt="<%=title %>"></td>
										<td><%=title %></td>
										<td><%=company %></td>
										<td>$<%=Webpage.getPriceString(price) %></td>
										<td><a href="game.jsp?id=<%=id %>"><button type="button" class="btn btn-success">View</button></a></td>
									</tr>
									<%
											}
										
											count++;
										}
									%>
								</tbody>
							</table>
						</div>
						
						<div class="text-center">
							<nav>
							  	<ul class="pagination">
							  		<%
							  			pages = (int) Math.ceil((double) count / 10);
						    			pagelinkclass = "";
							  			
						    			prevpage = pg - 1;
						    			nextpage = pg + 1;
						    			
						    			if (pg == 1) {
						    				pagelinkclass = "disabled";
						    				pghref = "";
						    			} else {
						    				pghref = "search.jsp?search=" + search + "&searchpage=" + prevpage;
						    			}
						    		%>
							    	<li class="page-item <%=pagelinkclass %>">
							      		<a class="page-link" href="<%=pghref %>" aria-label="Previous">
							        		<span aria-hidden="true">&laquo;</span>
							        		<span class="sr-only">Previous</span>
							      		</a>
							    	</li>
							    	<%
							    		for (int i = 1; i <= pages; i++) {
							    			String url = "search.jsp?search=" + search + "&searchpage=" + i;
							    			if (pg == i) {
							    	%>
							    	<li class="page-item active"><a class="page-link" href=<%=url + extraurl %>><%=i %></a></li>
							    	<%
							    			} else {
							    	%>
							    	<li class="page-item"><a class="page-link" href=<%=url + extraurl %>><%=i %></a></li>
							    	<%
							    			}
							    		}
							    		
						    			pagelinkclass = "";
						    			if (pg == pages) {
						    				pagelinkclass = "disabled";
						    				pghref = "";
						    			} else {
						    				pghref = "search.jsp?search=" + search + "&searchpage=" + nextpage;
						    			}
						    		%>
							    	<li class="page-item <%=pagelinkclass %>">
							      		<a class="page-link" href="<%=pghref %>" aria-label="Next">
							        		<span aria-hidden="true">&raquo;</span>
							        		<span class="sr-only">Next</span>
							      		</a>
							    	</li>
							  	</ul>
							</nav>
						</div>
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