<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
	%>
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<div class="panel panel-default">
					<div class="panel-heading"><h4>Add Company</h4></div>
					<div class="panel-body">
						<form action="addcompany.jsp" method="post">
							<div class="form-group">
								<label for="name">Name</label> <input type="text" class="form-control" id="name" autocomplete="off" name="name">
							</div>
							
							<br />
							
							<div class="pull-left">
								<button type="reset" class="btn btn-default">Reset</button>
							</div>
							
							<div class="pull-right">
								<a href="adminpanel.jsp#admincompany"><button type="button" class="btn btn-danger">Cancel</button></a> <button type="submit" class="btn btn-default">Add Company</button>
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