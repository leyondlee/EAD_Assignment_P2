<%@ page import="java.sql.*, common.*, controller.*, model.*" %>

<%
	try {
		Connection conn = DB.getConnection();
		PreparedStatement pstmt;
		ResultSet rs;
%>
<nav class="navbar navbar-inverse">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">SP Games</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">Home</a></li>
				<li><a href="store.jsp">Store</a></li>
				<li><a href="about.jsp">About</a></li>
			</ul>
			
			<form class="navbar-form navbar-left" role="search" action="search.jsp">
				<div class="form-group" id="searchbar">
					<input type="text" class="form-control" placeholder="Search" name="search">
				</div>
				<button type="button" class="btn btn-default" data-toggle="modal" data-target="#search-modal">Options <span class="caret"></span></button>
				<button type="submit" class="btn btn-default" id="searchbutton"><span class="glyphicon glyphicon-search"></span></button>
				
				<div class="modal fade" id="search-modal" role="dialog">
				    <div class="modal-dialog modal-m">
				      	<div class="modal-content">
				        	<div class="modal-header">
				          		<button type="button" class="close" data-dismiss="modal">&times;</button>
				          		<h4 class="modal-title">Search Options</h4>
				        	</div>
				        	<div class="modal-body">
				        		<div class="row col-md-offset-1">
				        			<h4>Preowned</h4>
					        		<label class="radio-inline">
								      	<input type="radio" name="preowned" value="1">Yes
								    </label>
								    
								    <label class="radio-inline">
								      	<input type="radio" name="preowned" value="0">No
								    </label>
								</div>
				        		
				        		<br />
				        		<hr>
				        		
				        		<div class="row col-md-offset-1">
				        			<h4>Genres</h4>
				        			
				        			<%
										pstmt = conn.prepareStatement("SELECT * FROM genre ORDER BY 2 ASC");
										rs = pstmt.executeQuery();
											
										while (rs.next()) {
											String genreid = rs.getString("genreid");
											String genre = rs.getString("name");
									%>
									<div class="row">
										<div class="checkbox">
									     	<label><input type="checkbox" name="genre" value=<%=genreid %>> <%=genre %></label>
									    </div>
									</div>
									<%
										}
				        			%>
								</div>
								
								<div class="clearfix"></div>
				        	</div>
				        	<div class="modal-footer">
				          		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        	</div>
				      	</div>
				   	</div>
				 </div>
			</form>
			
			<ul class="nav navbar-nav navbar-right">
				<li><a href="cart.jsp"><span class="glyphicon glyphicon-shopping-cart"></span></a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">Account <span class="caret"></span></a>
					<ul class="dropdown-menu">
	        	    	<%
	        	    		User user = (User) session.getAttribute("user");
							
	        	    		if (user == null) {
	        	    	%>
	        			
	        			<li><a href="#" data-toggle="modal" data-target="#login-modal"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
	        			
	        			<%
	        	    		} else {
	        	    			String username = user.getUsername();
	        	    	%>
	        	    	<li><a href="history"><span class="glyphicon glyphicon-calendar"></span> History</a></li>
        	    		<li><a href="settings.jsp"><span class="glyphicon glyphicon-cog"></span> Settings</a></li>
        	    		<li><a href="logout"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
        	    		<%
	       	    				pstmt = conn.prepareStatement("SELECT * FROM administrator WHERE username = ?");
		        	    		pstmt.setString(1, username);
		        	    		rs = pstmt.executeQuery();
		        	    				
								if (rs.next()) {
	                    %>
	                    <li role="separator" class="divider"></li>
	    	        	<li><a href="adminpanel.jsp">Admin Panel</a></li>
	    	        	<%
								}
	        	    		}
	        	    	%>
					</ul>
				</li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>
<%
		conn.close();
	} catch (Exception e) {
		
	}

	if (!Webpage.checkLoggedin(session)) {
%>

<div class="modal fade" id="login-modal" role="dialog">
	<div class="modal-dialog">
		<div class="loginmodal-container">
			<%
				String loginfail = (String) session.getAttribute("loginfail");
				if (loginfail != null) {
					session.setAttribute("loginfail",null);
					if (loginfail.equals("1")) {
			%>
			<div class="alert alert-danger">
  				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  				<strong>Error!</strong> Wrong username or password.
			</div>
			<%
					}
				}
			%>
			<h1>Login</h1>
			<br />
			<form action="login" method="post">
				<input type="text" name="username" placeholder="Username or Email">
				<input type="password" name="password" placeholder="Password">
				<input type="submit" name="login" class="login loginmodal-submit" value="Login">
			</form>

			<div class="login-help">
				<a href="registerform.jsp">Register</a> - <a href="#">Forgot Password</a>
			</div>
		</div>
	</div>
</div>
<%
	}
%>