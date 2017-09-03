<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkLoggedin(session)) {
			ArrayList<String[]> history = (ArrayList<String[]>) request.getAttribute("history");
			if (history != null) {
	%>
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>Transaction History</h4>
						<div class="clearfix"></div>
					</div>
					
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th>#</th>
										<th class="col-md-3">Transaction ID</th>
										<th class="col-md-3">Date</th>
										<th class="col-md-3">Time</th>
										<th class="col-md-1">Action</th>
									</tr>
								</thead>
								<tbody>
									<%
										for (int i = 0; i < history.size(); i++) {
											String[] h = history.get(i);
									%>
									<tr>
										<td><%=(i + 1) %></td>
										<td><%=h[0] %></td>
										<td><%=h[1] %></td>
										<td><%=h[2] %></td>
										<td>
											<form action="viewTransaction" method="post">
												<input type="hidden" name="id" value="<%=h[0] %>">
												<button type="submit" class="btn btn-success">View</button>
											</form>
										</td>
									</tr>
									<%
										}
									%>
								</tbody>
							</table>
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