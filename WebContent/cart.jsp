<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-8 col-md-8 col-md-offset-2">
				<%
					String error = request.getParameter("error");
					if (error != null && error.equals("1")) {
				%>
				<div class="alert alert-danger">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>Error!</strong> Not enough quantity or quantity cannot be below 1.
				</div>
				<%
					}
				%>
				
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>Shopping Cart</h4>
						<div class="clearfix"></div>
					</div>
					
					<div class="panel-body">
						<form action="updateCart" method="post">
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
											
											Cart cart = (Cart) session.getAttribute("cart");
											ArrayList<Item> items;
											if (cart != null) {
												items = cart.getItems();
											} else {
												items = new ArrayList<Item>();
											}
											
											for (int i = 0; i < items.size(); i++) {
												Item item = items.get(i);
												Game g = item.getGame();
												int quantity = item.getQuantity();
												
												int count = i + 1;
												String imageLocation = g.getImageLocation();
												String title = g.getTitle();
												double price = g.getPrice();
												
												totalprice += (price * quantity);
												
												if (g.getPreowned() == 1) {
													title += " (Preowned)";
												}
										%>
										<tr>
											<td><a href="removeFromCart?index=<%=i %>"><span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span></a></td>
											<td><img class="img-thumbnail img-responsive" src="<%=imageLocation %>" alt="<%=title %>"></td>
											<td><%=title %></td>
											<td><input type="number" id="cartquantity" name="<%=i %>" value="<%=quantity %>"></td>
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
							<%
								if (cart != null && cart.getItems().size() > 0) {
							%>
							<div class="pull-right">
								<input type="submit" class="btn btn-default" value="Update"> <a href="confirmCart"><button type="button" class="btn btn-primary">Confirm</button></a>
							</div>
							<%
								}
							%>
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