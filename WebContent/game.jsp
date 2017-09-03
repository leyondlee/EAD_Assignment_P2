<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		boolean loggedin = Webpage.checkLoggedin(session);
		
		String id = request.getParameter("id");
		String title = "", imageLocation = "", description = "", company = "", date = "", name = "", comment = "";
		int companyid = -1, rating = -1, nameid = -1, preowned = -1, pub = -1, quantity = -1;
		double price = -1;
		
		try {
			Connection conn = DB.getConnection();
			PreparedStatement pstmt;
			ResultSet rs;
	%>
	
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-10 col-md-10 col-md-offset-1">
				<%
					pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameid = ?");
					pstmt.setInt(1, Integer.parseInt(id));
					rs = pstmt.executeQuery();
					
					if (rs.next()) {
						title = rs.getString("title");
						imageLocation = rs.getString("imageLocation");
						description = rs.getString("description");
						companyid = rs.getInt("companyid");
						date = Webpage.dateFormat(rs.getDate("releaseDate"),"dd MMM yy");
						price = rs.getDouble("price");
						preowned = rs.getInt("preowned");
						quantity = rs.getInt("quantity");
						
						imageLocation = Webpage.imageLocation(imageLocation);
						
						pstmt = conn.prepareStatement("SELECT * FROM company WHERE companyid = ?");
						pstmt.setInt(1, companyid);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							company = rs.getString("name");
						}
					} else {
						response.sendRedirect("error.jsp");
					}
				%>
				<div class="panel panel-default">
	 				<div class="panel-heading">
	 					<%
							if (preowned == 1) {
						%>
		 				<h4><%=title %> (Preowned)</h4>
		 				<%
							} else {
		 				%>
		 				<h4><%=title %></h4>
		 				<%
							}
		 				%>
					</div>
					
					<div class="panel-body">
						<div class="col-sm-7 col-md-7">
							<div class="row">
		               			<img class="img-thumbnail img-responsive" id="gamepageimage" src="<%=imageLocation %>" alt="">
		               		</div>
		               	
		               		<br />
		               	
		               		<div class="row">
		               			<strong>Description:</strong>
		                		<p><%=Webpage.htmlspecialchars(description) %></p>
		               		</div>
	               		</div>
		                
		                <div class="col-sm-5 col-md-5">
		                	<div class="well">
		                		<strong>Developer:</strong>
		                		<p><%=company %></p>
		                		
		                		<br />
		                		
		                		<strong>Release Date:</strong>
		                		<p><%=date %></p>
		                		
		                		<br />
		                		
		                		<strong>Genre:</strong>
		                		<br />
		                		<div class="btn-toolbar" id="gamegenrebutton">
		                			<%
		                				pstmt = conn.prepareStatement("SELECT * FROM genre WHERE genreid IN (SELECT genreid FROM game_genre WHERE gameid = ?)");
		                				pstmt.setString(1,id);
		                				rs = pstmt.executeQuery();
		                				
		                				while (rs.next()) {
		                					String genre = rs.getString("name");
		                			%>
		                			<button type="button" class="btn btn-default"><%=genre %></button>
		                			<%
		                				}
		                			%>
		                		</div>
		                		
		                		<br />
		                		
		                		<strong>Price:</strong>
		                		<p>$<%=Webpage.getPriceString(price) %></p>
		                		
		                		<br />
		                		
		                		<strong>Quantity:</strong>
		                		<%
		                			if (quantity > 0) {
		                		%>
		                		<p><%=quantity %></p>
		                		<%
		                			} else {
		                		%>
		                		<p>Out of stock</p>
		                		<%
		                			}
		                		%>
		                		
		                		<br />
		                		
		                		<a href="addToCart?id=<%=id %>" class="btn btn-success"><span class="glyphicon glyphicon-shopping-cart"></span> Add to Cart</a>
		                	</div>
		                </div>
		        	</div>
		  		</div>
		        
		       	<div class="col-sm-12 col-md-12" id="gamecomment">
		       		<%
		       			if (preowned == 1) {
		       		%>
		       		<div class="alert alert-warning">
						<strong><span class="glyphicon glyphicon-ban-circle"></span> Comments are disabled for preowned games</strong>
					</div>
	                <%
		       			} else {
	    	        %>
	    	        <form class="form-horizontal" role="form" action="addcomment.jsp" autocomplete="off">
	            		<div class="well">
		                   	<h4>Write a Review:</h4>
		                   	<input type="hidden" value="<%=id %>" name="id">
		                   	
		                   	<br />
		                   	
		                   	<div class="form-group">
						      	<label class="col-sm-1 control-label">Name:</label>
						      	<div class="col-sm-4">
						      	<%
			                   		if (!loggedin) {
			                   	%>
			                   		<input class="form-control" type="text" name="name">
								<%
			                   		} else {
			                   			User user = (User) session.getAttribute("user");
			                   			String username = user.getUsername();
								%>
									<input type="hidden" name="username" value="<%=username %>">
									<input class="form-control" type="text" name="name" value="<%=username %>" disabled>
								<%
			                   		}
								%>
								</div>
						    </div>
		                   	
                  			<div class="form-group">
		                   		<label class="col-sm-1 control-label">Rating:</label>
		                   		<div class="col-sm-2">
		                   			<select class="form-control" name="rating">
						        		<option>5</option>
							        	<option>4</option>
							        	<option>3</option>
							        	<option>2</option>
							        	<option>1</option>
							      	</select>
		                   		</div>
                   			</div>
		                   	
		                   	<br />
		                   	
			              	<div class="form-group">
			              		<div class="col-sm-12">
									<textarea class="form-control" rows="6" id="comment" name="comment" placeholder="Write a Review"></textarea>
								</div>
							</div>
							
							<div class="form-group text-right">
								<div class="col-sm-10 col-sm-offset-2">
									<button type="reset" class="btn btn-default">Reset</button> <button type="submit" class="btn btn-default">Submit</button>
								</div>
							</div>
						</div>
					</form>
					
					<br />
					<hr>
					<br />
					
					<%
		                   	pstmt = conn.prepareStatement("SELECT * FROM comment WHERE gameid = ? ORDER BY 1 DESC");
		   	        		pstmt.setString(1, id);
		   	        		
		   	        		rs = pstmt.executeQuery();
		   	        		
		   	        		ResultSet namers;
		   	        		while (rs.next()) {
		   	        			rating = rs.getInt("rating");
		   	        			name = rs.getString("name");
		   	        			comment = rs.getString("comment");
		   	        			date = (new SimpleDateFormat("dd/MM/yy")).format(rs.getDate("date"));
		   	        			name = rs.getString("name");
		   	        			
		   	        			if (name == null) {
		   	        				name = rs.getString("username");
		   	        			} else {
		   	        				name += " (Public)";
		   	        			}
		   	        %>
					
					<div class="row">
	    	        	<div class="col-md-12">
	    	        		<div class="panel panel-default">
	    	        			<div class="panel-heading">
				    	        	<strong><%=name %></strong>
				    	        	<strong class="pull-right"><%=date %></strong>
				    	        	
					    	        <br />
					    	        
					    	        <span>
				    	 				<%
				    	 					for (int i = 0; i < 5; i++) {
				    	 						if (rating > 0) {
				    	 				%>
				    	 				<span class="glyphicon glyphicon-star" id="ratingstar"></span>
				    	 				<%
				    	 							rating--;
				    	 						} else {
				    	 				%>
				    	 				<span class="glyphicon glyphicon-star-empty"></span>
				    	 				<%
				    	 						}
				    	 					}
				    	 				%>
				    	 			</span>
			    	        	</div>
			    	        	
			    	        	<div class="panel-body">
		                     		<p><%=Webpage.htmlspecialchars(comment) %></p>
		                		</div>
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