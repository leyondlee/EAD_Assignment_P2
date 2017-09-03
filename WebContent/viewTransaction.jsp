<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkLoggedin(session)) {
			Transaction transaction = (Transaction) request.getAttribute("transaction");
			if (transaction != null) {
	%>
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-8 col-md-8 col-md-offset-2">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4 class="pull-left">Transaction [ID: <%=transaction.getId() %>]</h4>
						<h4 class="pull-right"><%=Webpage.dateFormat(transaction.getDate(), "dd-MM-yy") %> <%=transaction.getTime() %></h4>
						<div class="clearfix"></div>
					</div>
					
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-bordered table-hover">
								<thead>
									<tr>
										<th>#</th>
										<th class="col-xs-2">Image</th>
										<th class="col-xs-6">Title</th>
										<th>Quantity</th>
										<th class="col-xs-2">Price</th>
									</tr>
								</thead>
								<tbody>
									<%
										double totalprice = 0;
										for (int i = 0; i < transaction.getItems().size(); i++) {
											Item item = transaction.getItems().get(i);
											
											Game game = item.getGame();
											int quantity = item.getQuantity();
											
											String imageLocation = game.getImageLocation();
											String title = game.getTitle();
											double price = game.getPrice();
											
											totalprice += (price * quantity);
											
											if (game.getPreowned() == 1) {
												title += " (Preowned)";
											}
									%>
									<tr>
										<td><%=(i + 1) %></td>
										<td><img class="img-thumbnail img-responsive" src="<%=imageLocation %>" alt="<%=title %>"></td>
										<td><%=title %></td>
										<td><%=quantity %></td>
										<%
											if (quantity > 1) {
										%>
										<td>
											$<%=Webpage.getPriceString(price * quantity) %>
											<br />
											($<%=Webpage.getPriceString(price) %> each)
										</td>
										<%
											} else {
										%>
										<td>$<%=Webpage.getPriceString(price) %></td>
										<%
											}
										%>
									</tr>			
									<%
										}
									%>
								</tbody>
								<thead>
									<tr>
										<td colspan="3"></td>
										<th>Total Price</th>
										<td>$<%=Webpage.getPriceString(totalprice) %></td>
									</tr>
								</thead>
							</table>
						</div>
						
						<div class="pull-right">
							<a href="history"><button type="button" class="btn btn-primary">OK</button></a>
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