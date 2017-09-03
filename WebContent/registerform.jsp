<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<%
					String error = (String) request.getAttribute("error");
					if (error != null) {
						if (error.equals("0")) {
							error = "Username/email has already been used or one or more particulars do not meet the requirements.";
						} else if (error.equals("1")) {
							error = "Password does not match or meet the requirements.";
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
					
					String username = null, email = null, contact = null, address = null;
					String[] fields = (String[]) request.getAttribute("fields");
					if (fields != null) {
						username = fields[0];
						email = fields[1];
						contact = fields[2];
						address = fields[3];
					}
					
					username = Webpage.stringCheck(username);
					email = Webpage.stringCheck(email);
					contact = Webpage.stringCheck(contact);
					address = Webpage.stringCheck(address);
				%>
			
				<div class="panel panel-default">
					<div class="panel-heading"><h4>Registration Form</h4></div>
					<div class="panel-body">
						<form action="register" method="post" name="registrationForm" onSubmit="return registrationCheck()" id="registrationForm">
							<div class="form-group">
								<label for="username">Username</label> <input type="text" class="form-control" id="username" autocomplete="off" name="username" placeholder="Username" value="<%=username %>">
								<p>This field is required</p>
								<p>Invalid Username</p>
							</div>
							
							<div class="form-group">
								<label for="password">Password</label> <input type="password" class="form-control" id="password" autocomplete="off" name="password" placeholder="Password">
								<p>This field is required</p>
								<p>Password must be within 8 to 16 characters</p>
								<p>Password must contain both letters and numbers</p>
							</div>
							
							<div class="form-group">
								<label for="confirmpassword">Confirm Password</label> <input type="password" class="form-control" id="confirmpassword" autocomplete="off" name="confirmpassword" placeholder="Confirm Password">
								<p>This field is required</p>
								<p>Password does not match</p>
							</div>
							
							<br />
							<hr>
							<br />
							
							<div class="form-group">
								<label for="email">Email</label> <input type="email" class="form-control" id="email" autocomplete="off" name="email" placeholder="Email" value="<%=email %>">
								<p>This field is required</p>
								<p>Invalid Email</p>
							</div>
							
							<div class="form-group">
								<label for="contact">Contact no.</label> <input type="text" class="form-control" id="contact" autocomplete="off" name="contact" placeholder="Contact No." value="<%=contact %>">
								<p>This field is required</p>
								<p>Contact no. must be 8 digits</p>
								<p>Contact no. can only be made up of numbers</p>
							</div>
							
							<div class="form-group">
								<label for="address">Mailing Address</label>
								<textarea class="form-control" id="address" rows="3" name="address"><%=address %></textarea>
								<p>This field is required</p>
							</div>
							
							<br />
							<br />
							
							<div class="pull-left">
								<button type="reset" class="btn btn-default">Reset</button>
							</div>
							
							<div class="pull-right">
								<a href="index.jsp"><button type="button" class="btn btn-danger">Cancel</button></a> <button type="submit" class="btn btn-default">Register</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div class="push"></div>
	</div>
	
	<%@ include file="footer.html" %>
</body>
</html>