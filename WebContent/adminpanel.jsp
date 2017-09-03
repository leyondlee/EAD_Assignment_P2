<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String pgs, pagelinkclass, pghref;
			int pg, end, start, pages, prevpage, nextpage;
			
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt;
				ResultSet rs;
	%>
	
	<div class="wrapper">
		<div class="container">
			<div class="col-md-offset-1">
				<div class="page-header">
				  <h3>Admin Panel</h3>
				</div>
			</div>
			
			<div class="row">
				<div class="col-sm-10 col-md-10 col-md-offset-1" id="admingame">
					<div class="panel panel-default">
	  					<div class="panel-heading"><h4>Games</h4></div>
	  					<div class="panel-body">
	  						<form role="form" action="deleteconfirmation.jsp" method="post">
	  							<div class="table-responsive">
									<table class="table table-bordered table-hover">
										<thead>
											<tr>
												<th>#</th>
												<th class="col-xs-2">Image</th>
												<th>Title</th>
												<th>Price</th>
												<th>Company</th>
												<th class="col-xs-1">Action</th>
											</tr>
										</thead>
										<tbody>
											<%
												pstmt = conn.prepareStatement("SELECT * FROM game ORDER BY 2 ASC");
												rs = pstmt.executeQuery();
												
												pgs = request.getParameter("gamepage");
												if (pgs == null) {
													pg = 1;
												} else {
													pg = Integer.parseInt(pgs);
												}
												
												end = pg * 10;
												start = end - 10;
												
												int count = 0;
												while (rs.next()) {
													if (count >= start && count < end) {
														String id = rs.getString("gameid");
														String name = rs.getString("title");
														String price = Webpage.getPriceString(rs.getDouble("price"));
														String imageLocation = rs.getString("imagelocation");
														int preowned = rs.getInt("preowned");
														int quantity = rs.getInt("quantity");
														
														if (preowned == 1) {
															name += " (Preowned)";
														}
														
														if (imageLocation == null) {
															imageLocation = "";
														}
														
														String company = "";
														pstmt = conn.prepareStatement("SELECT * FROM company WHERE companyid = ?");
														pstmt.setInt(1, rs.getInt("companyid"));
														ResultSet companyrs = pstmt.executeQuery();
														if (companyrs.next()) {
															company = companyrs.getString("name");
														}
													
											%>
												<tr>
													<td><input type="checkbox" id="check-game" name="option" value="<%=id %>"></td>
											<%
													if (imageLocation.equals("")) {
											%>
													<td><a href="addImageForm.jsp?id=<%=id %>"><button type="button" class="btn btn-default">Add Image</button></a></td>
											<%
													} else {
											%>
													<td><img class="img-thumbnail img-responsive" src="<%=imageLocation %>"></td>
											<%
													}
											%>
													<td><%=name %></td>
													<td>$<%=price %></td>
													<td><%=company %></td>
													<td><a href="editgameform.jsp?id=<%=id %>"><button type="button" class="btn btn-default">Edit</button></a></td>
												</tr>
											<%
													}
													
													count++;
												}
											%>
										</tbody>
									</table>
								</div>
								
								<div class="pull-right"><button type="submit" class="btn btn-danger" name="btnSubmit" value="0">Delete</button> <a href="addgameform.jsp"><button type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span> Add Game</button></a></div>
								<div class="clearfix"></div>
								
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
								    				pghref = "adminpanel.jsp?gamepage=" + prevpage + "#admingame";
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
									    			if (pg == i) {
									    	%>
									    	<li class="page-item active"><a class="page-link" href="adminpanel.jsp?gamepage=<%=i %>#admingame"><%=i %></a></li>
									    	<%
									    			} else {
									    	%>
									    	<li class="page-item"><a class="page-link" href="adminpanel.jsp?gamepage=<%=i %>#admingame"><%=i %></a></li>
									    	<%
									    			}
									    		}
									    		
								    			pagelinkclass = "";
								    			if (pg == pages) {
								    				pagelinkclass = "disabled";
								    				pghref = "";
								    			} else {
								    				pghref = "adminpanel.jsp?gamepage=" + nextpage + "#admingame";
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
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-sm-5 col-md-5 col-md-offset-1" id="admingenre">
					<div class="panel panel-default">
	  					<div class="panel-heading"><h4>Genres</h4></div>
	  					<div class="panel-body">
	  						<form role="form" action="deleteconfirmation.jsp">
	  							<div class="table-responsive">
									<table class="table table-bordered table-hover">
										<thead>
											<tr>
												<th class="col-xs-1">#</th>
												<th>Name</th>
												<th class="col-xs-4">No. of Games</th>
												<th class="col-xs-1">Action</th>
											</tr>
										</thead>
										<tbody>
											<%
												pstmt = conn.prepareStatement("SELECT * FROM genre ORDER BY 2 ASC");
												rs = pstmt.executeQuery();
												
												pgs = request.getParameter("genrepage");
												if (pgs == null) {
													pg = 1;
												} else {
													pg = Integer.parseInt(pgs);
												}
												
												end = pg * 10;
												start = end - 10;
												
												count = 0;
												while (rs.next()) {
													if (count >= start && count < end) {
														String id = rs.getString("genreid");
														String name = rs.getString("name");
														int num = 0;
														
														pstmt = conn.prepareStatement("SELECT COUNT(genreid) FROM game_genre WHERE genreid = ?");
														pstmt.setString(1, id);
														ResultSet numofgames = pstmt.executeQuery();
														
														if (numofgames.next()) {
															num = numofgames.getInt(1);
														}
											%>
												<tr>
													<%
														if (num > 0) {
													%>
													<td><input type="checkbox" name="option" value="<%=id %>" disabled></td>
													<%
														} else {
													%>
													<td><input type="checkbox" name="option" value="<%=id %>"></td>
													<%
														}
													%>
													<td><%=name %></td>
													<td><%=num %></td>
													<td><a href="editgenreform.jsp?id=<%=id %>"><button type="button" class="btn btn-default">Edit</button></a></td>
												</tr>
											<%
													}
													
													count++;
												}
											%>
										</tbody>
									</table>
								</div>
								
								<div class="pull-right"><button type="submit" class="btn btn-danger" name="btnSubmit" value="1">Delete</button> <a href="addgenreform.jsp"><button type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span> Add Genre</button></a></div>
								<div class="clearfix"></div>
								
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
								    				pghref = "adminpanel.jsp?genrepage=" + prevpage + "#admingenre";
								    			}
								    		%>
									    	<li class="page-item <%=pagelinkclass %>">
									      		<a class="page-link" href="<%=pghref %>" aria-label="Previous">
									        		<span aria-hidden="true">&laquo;</span>
									        		<span class="sr-only">Previous</span>
									      		</a>
									    	</li>
									    	<%
									    		for (int i = 1; i <= Math.ceil((double) count / 10); i++) {
									    			if (pg == i) {
									    	%>
									    	<li class="page-item active"><a class="page-link" href="adminpanel.jsp?genrepage=<%=i %>#admingenre"><%=i %></a></li>
									    	<%
									    			} else {
									    	%>
									    	<li class="page-item"><a class="page-link" href="adminpanel.jsp?genrepage=<%=i %>#admingenre"><%=i %></a></li>
									    	<%
									    			}
									    		}
									    		
										    	pagelinkclass = "";
								    			if (pg == pages) {
								    				pagelinkclass = "disabled";
								    				pghref = "";
								    			} else {
								    				pghref = "adminpanel.jsp?genrepage=" + nextpage + "#admingenre";
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
							</form>
	  					</div>
	  				</div>
				</div>
				
				<div class="col-sm-5 col-md-5" id="admincompany">
					<div class="panel panel-default">
	  					<div class="panel-heading"><h4>Companies</h4></div>
	  					<div class="panel-body">
	  						<form role="form" action="deleteconfirmation.jsp">
	  							<div class="table-responsive">
									<table class="table table-bordered table-hover">
										<thead>
											<tr>
												<th class="col-xs-1">#</th>
												<th>Name</th>
												<th class="col-xs-4">No. of Games</th>
												<th class="col-xs-1">Action</th>
											</tr>
										</thead>
										<tbody>
											<%
												pstmt = conn.prepareStatement("SELECT * FROM company ORDER BY 2 ASC");
												rs = pstmt.executeQuery();
												
												pgs = request.getParameter("companypage");
												if (pgs == null) {
													pg = 1;
												} else {
													pg = Integer.parseInt(pgs);
												}
												
												end = pg * 10;
												start = end - 10;
												
												count = 0;
												while (rs.next()) {
													if (count >= start && count < end) {
														String id = rs.getString("companyid");
														String name = rs.getString("name");
														int num = 0;
														
														pstmt = conn.prepareStatement("SELECT COUNT(*) FROM game WHERE companyid = ?");
														pstmt.setString(1, id);
														ResultSet numofgames = pstmt.executeQuery();
														
														if (numofgames.next()) {
															num = numofgames.getInt(1);
														}
											%>
												<tr>
													<%
														if (num > 0) {
													%>
													<td><input type="checkbox" name="option" value="<%=id %>" disabled></td>
													<%
														} else {
													%>
													<td><input type="checkbox" name="option" value="<%=id %>"></td>
													<%
														}
													%>
													<td><%=name %></td>
													<td><%=num %></td>
													<td><a href="editcompanyform.jsp?id=<%=id %>"><button type="button" class="btn btn-default">Edit</button></a></td>
												</tr>
											<%
													}
													
													count++;
												}
											%>
										</tbody>
									</table>
								</div>
								
								<div class="pull-right"><button type="submit" class="btn btn-danger" name="btnSubmit" value="2">Delete</button> <a href="addcompanyform.jsp"><button type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span> Add Company</button></a></div>
								<div class="clearfix"></div>
								
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
								    				pghref = "adminpanel.jsp?companypage=" + prevpage + "#admincompany";
								    			}
								    		%>
									    	<li class="page-item <%=pagelinkclass %>">
									      		<a class="page-link" href="<%=pghref %>" aria-label="Previous">
									        		<span aria-hidden="true">&laquo;</span>
									        		<span class="sr-only">Previous</span>
									      		</a>
									    	</li>
									    	<%
									    		for (int i = 1; i <= Math.ceil((double) count / 10); i++) {
									    			if (pg == i) {
									    	%>
									    	<li class="page-item active"><a class="page-link" href="adminpanel.jsp?companypage=<%=i %>#admincompany"><%=i %></a></li>
									    	<%
									    			} else {
									    	%>
									    	<li class="page-item"><a class="page-link" href="adminpanel.jsp?companypage=<%=i %>#admincompany"><%=i %></a></li>
									    	<%
									    			}
									    		}
									    		
										    	pagelinkclass = "";
								    			if (pg == pages) {
								    				pagelinkclass = "disabled";
								    				pghref = "";
								    			} else {
								    				pghref = "adminpanel.jsp?companypage=" + nextpage + "#admincompany";
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
							</form>
	  					</div>
	  				</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-sm-5 col-md-5 col-md-offset-1" id="adminstock">
					<div class="panel panel-default">
	  					<div class="panel-heading"><h4>Stock Quantity</h4></div>
	  					<div class="panel-body">
	  						<div class="row">
		  						<form class="navbar-form navbar-left" role="search" action="searchStock" method="post">
									<div class="form-group" id="searchbar">
										Find products less than: 
										<input type="number" class="form-control" placeholder="" name="stocksearch">
										<button type="submit" class="btn btn-default" id="searchbutton"><span class="glyphicon glyphicon-circle-arrow-right"></span></button>
									</div>
								</form>
	  						</div>
	  						
	  						<br />
	  						
	  						<div class="table-responsive">
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>#</th>
											<th class="col-xs-2">Image</th>
											<th>Title</th>
											<th class="col-xs-1">Quantity</th>
										</tr>
									</thead>
									<tbody>
				  						<%
				  							pstmt = conn.prepareStatement("SELECT * FROM game ORDER BY 2 ASC");
				  							
											rs = pstmt.executeQuery();
											
											pgs = request.getParameter("stockpage");
											if (pgs == null) {
												pg = 1;
											} else {
												pg = Integer.parseInt(pgs);
											}
											
											end = pg * 10;
											start = end - 10;
											
											count = 0;
											while (rs.next()) {
												if (count >= start && count < end) {
													int id = rs.getInt("gameid");
													String title = rs.getString("title");
													String imageLocation = rs.getString("imageLocation");
													int quantity = rs.getInt("quantity");
													
													if (rs.getInt("preowned") == 1) {
														title += " (Preowned)";
													}
										%>
										<tr>
											<td><%=(count + 1) %></td>
											<td><img class="img-thumbnail img-responsive" src="<%=imageLocation %>" alt="<%=title %>"></td>
											<td><%=title %></td>
											<td>
												<form action="updateQuantity">
													<input type="hidden" name="id" value="<%=id %>">
													<input type="number" id="cartquantity" name="quantity" value="<%=quantity %>">
													<input type="submit" class="btn btn-default" value="Update">
												</form>
											</td>
										</tr>
										<%
												}
												
												count++;
											}
				  						%>
			  						</tbody>
			  					</table>
			  				</div>
			  				
							<div class="clearfix"></div>
							
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
							    				pghref = "adminpanel.jsp?stockpage=" + prevpage + "#adminstock";
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
								    			if (pg == i) {
								    	%>
								    	<li class="page-item active"><a class="page-link" href="adminpanel.jsp?stockpage=<%=i %>#adminstock"><%=i %></a></li>
								    	<%
								    			} else {
								    	%>
								    	<li class="page-item"><a class="page-link" href="adminpanel.jsp?stockpage=<%=i %>#adminstock"><%=i %></a></li>
								    	<%
								    			}
								    		}
								    		
							    			pagelinkclass = "";
							    			if (pg == pages) {
							    				pagelinkclass = "disabled";
							    				pghref = "";
							    			} else {
							    				pghref = "adminpanel.jsp?stockpage=" + nextpage + "#adminstock";
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
		</div>
		
		<div class="push"></div>
	</div>
	
	<%
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