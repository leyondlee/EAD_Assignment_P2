<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String stocksearch = (String) request.getAttribute("stocksearch");
			ArrayList<Game> stocksearchlist = (ArrayList<Game>) request.getAttribute("stocksearchlist");
		
			if (stocksearch != null) {
				String pgs, pagelinkclass, pghref;
				int pg, end, start, pages, prevpage, nextpage;
	%>
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-10 col-md-10 col-md-offset-1">
				<div class="panel panel-default">
					<div class="panel-heading">
						<%
							if (stocksearch.equals("")) { 
						%>
						<h4>Search Stock</h4>
						<%
							} else {
						%>
						<h4>Search Stock (Products &lt; <%=stocksearch %> in quantity)</h4>
						<%
							}
						%>
					</div>
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
										<th class="col-xs-1">Price</th>
										<th class="col-xs-1">Quantity</th>
									</tr>
								</thead>
								<tbody>
			  						<%
										pgs = (String) request.getAttribute("stockpage");
										if (pgs == null) {
											pg = 1;
										} else {
											pg = Integer.parseInt(pgs);
										}
										
										end = pg * 10;
										start = end - 10;
										
										int count = 0;
										for (Game g : stocksearchlist) {
											if (count >= start && count < end) {
												int id = g.getGameid();
												String title = g.getTitle();
												String imageLocation = g.getImageLocation();
												double price = g.getPrice();
												int quantity = g.getQuantity();
												
												if (g.getPreowned() == 1) {
													title += " (Preowned)";
												}
									%>
									<tr>
										<td><%=(count + 1) %></td>
										<td><img class="img-thumbnail img-responsive" src="<%=imageLocation %>" alt="<%=title %>"></td>
										<td><%=title %></td>
										<td>$<%=Webpage.getPriceString(price) %></td>
										<td><%=quantity %></td>
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
						    				pghref = "searchStock?stocksearch=" + stocksearch +  "&stockpage=" + prevpage;
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
							    	<li class="page-item active"><a class="page-link" href="searchStock?stocksearch=<%=stocksearch %>&stockpage=<%=i %>"><%=i %></a></li>
							    	<%
							    			} else {
							    	%>
							    	<li class="page-item"><a class="page-link" href="searchStock?stocksearch=<%=stocksearch %>&stockpage=<%=i %>"><%=i %></a></li>
							    	<%
							    			}
							    		}
							    		
						    			pagelinkclass = "";
						    			if (pg == pages) {
						    				pagelinkclass = "disabled";
						    				pghref = "";
						    			} else {
						    				pghref = "searchStock?stocksearch=" + stocksearch +  "&stockpage=" + nextpage;
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