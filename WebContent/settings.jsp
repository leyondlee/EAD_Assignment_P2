<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkLoggedin(session)) {
			User user = (User) session.getAttribute("user");
			String curusername = user.getUsername();
			String email = user.getEmail();
			String address = user.getAddress();
			String contact = user.getContact();
			
			String javascript = "updateCheck()";
			if (Webpage.checkAdmin(session)) {
				javascript = "updateCheckAdmin()";
			}
	%>
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<%
					String error = request.getParameter("error");
					if (error != null) {
						if (error.equals("0")) {
							error = "Password cannot be changed";
						} else if (error.equals("1")) {
							error = "One or more setting(s) cannot be changed.";
						} else {
							error = "";
						}
						
						if (!error.equals("")) {
				%>
				<div class="alert alert-danger">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Error!</strong> <%=error %>
				</div>
				<%
						}
					}
				%>
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>User Settings</h4>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" action="updateUser" method="post" onSubmit="return <%=javascript %>" id="updateForm">
							
							<br />
							
							<div class="form-group">
						      	<label class="col-sm-3 control-label">Username:</label>
						      	<div class="col-sm-8">
						      		<%
						      			if (Webpage.checkAdmin(session)) {
						      		%>
						        	<input class="form-control" type="text" value="<%=curusername %>" disabled>
						        	<%
						      			} else {
						        	%>
						        	<input class="form-control" type="text" name="username" value="<%=curusername %>">
						        	<%
						      			}
						        	%>
						      	</div>
						      	<div class="col-sm-12 col-md-offset-3">
						      		<p>This field is required</p>
						      		<p>Invalid Username</p>
						      	</div>
							</div>
							
							<div class="form-group">
						      	<label class="col-sm-3 control-label">Email:</label>
						      	<div class="col-sm-8">
						      		<%
						      			if (email.equals("")) {
						      		%>
						      		<input class="form-control" type="email" name="email" value="" disabled>
						      		<%		
						      			} else {
						      		%>
						        	<input class="form-control" type="email" name="email" value="<%=email %>">
						        	<%
						      			}
						        	%>
						      	</div>
						      	<div class="col-sm-12 col-md-offset-3">
						      		<p>This field is required</p>
						      		<p>Invalid Email</p>
						      	</div>
							</div>
							
							<div class="form-group">
						      	<label class="col-sm-3 control-label">Contact:</label>
						      	<div class="col-sm-8">
						      		<%
						      			if (contact.equals("")) {
						      		%>
						      		<input class="form-control" type="text" name="contact" value="" disabled>
						      		<%
						      			} else {
						      		%>
						        	<input class="form-control" type="text" name="contact" value="<%=contact %>">
						        	<%
						      			}
						        	%>
						      	</div>
						      	<div class="col-sm-12 col-md-offset-3">
						      		<p>This field is required</p>
						      		<p>Contact no. must be 8 digits</p>
									<p>Contact no. can only be made up of numbers</p>
						      	</div>
							</div>
							
							<div class="form-group">
						      	<label class="col-sm-3 control-label">Address:</label>
						      	<div class="col-sm-8">
						      		<%
						      			if (address.equals("")) {
						      		%>
						      		<textarea class="form-control" rows="3" name="address" disabled></textarea>
						      		<%
						      			} else {
						      		%>
						        	<textarea class="form-control" rows="3" name="address"><%=address %></textarea>
						        	<%
						      			}
						        	%>
						      	</div>
						      	<div class="col-sm-12 col-md-offset-3">
						      		<p>This field is required</p>
						      	</div>
							</div>
							
							<br />
							
							<div class="form-group row" id="changepassword">
								<h4 class="col-sm-12">Change Password:</h4>
							</div>
							
							<div class="form-group" autocomplete="off">
								<label class="col-sm-4 control-label">Current Password:</label>
						      	<div class="col-sm-6">
						        	<input type="password" class="form-control" name="currentpassword" placeholder="Enter current password">
						      	</div>
						      	<div class="col-sm-12 col-md-offset-4">
						      		<p>This field is required</p>
						      	</div>
						      	
						      	<label class="col-sm-4 control-label">New Password:</label>
						      	<div class="col-sm-6">
						        	<input type="password" class="form-control" name="newpassword" placeholder="Enter new password">
						      	</div>
						      	<div class="col-sm-12 col-md-offset-4">
						      		<p>This field is required</p>
						      		<p>Password does not meet the requirements</p>
						      	</div>
						      	
						      	<label class="col-sm-4 control-label">Confirm Password:</label>
						      	<div class="col-sm-6">
						        	<input type="password" class="form-control" name="confirmpassword" placeholder="Enter new password">
						      	</div>
						      	<div class="col-sm-12 col-md-offset-4">
						      		<p>This field is required</p>
						      		<p>Password does not match</p>
						      	</div>
							</div>
							
							<br />
							<br />
							
							<div class="pull-left">
								<button type="reset" class="btn btn-default">Reset</button>
							</div>
							
							<div class="pull-right">
								<a href="index.jsp"><button type="button" class="btn btn-danger">Cancel</button></a> <button type="submit" class="btn btn-default">Apply</button>
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