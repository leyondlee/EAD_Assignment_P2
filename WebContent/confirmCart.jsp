<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkLoggedin(session)) {
	%>
	<div class="wrapper">
		<div class="container">
			<%
				ArrayList<Item> items = (ArrayList<Item>) request.getAttribute("items");
				if (items != null) {
			%>
			<div class="col-sm-8 col-md-8 col-md-offset-2">
				<div class="row">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4>Shopping Cart Summary</h4>
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
								<a href="cart.jsp"><button type="button" class="btn btn-danger">Cancel</button></a> <button type="button" class="btn btn-success" data-toggle="modal" data-target="#payment-modal"><span class="glyphicon glyphicon-shopping-cart"></span> Check Out</button>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4>User Particulars</h4>
							<div class="clearfix"></div>
						</div>
						
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table table-bordered table-hover">
									<tbody>
										<%
											User user = (User) session.getAttribute("user");
										%>
										<tr>
											<th class="col-md-3">Name:</th>
											<td><%=user.getUsername() %></td>
										</tr>
										<tr>
											<th>Email:</th>
											<td><%=user.getEmail() %></td>
										</tr>
										<tr>
											<th>Contact:</th>
											<td><%=user.getContact() %></td>
										</tr>
										<tr>
											<th>Address:</th>
											<td><%=Webpage.htmlspecialchars(user.getAddress()) %></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				
				<div class="modal fade" id="payment-modal" role="dialog">
				    <div class="modal-dialog modal-sm">
				      	<div class="modal-content">
				        	<div class="modal-header">
				      			<button type="button" class="close" data-dismiss="modal">&times;</button>
				          		<h4 class="modal-title">Payment</h4>
				      		</div>
				      		<div class="modal-body">
				      			<form role="form" action="checkout">
				      				<div class="form-group col-md-10 col-md-offset-1">
								    	<label for="name">Name:</label>
    									<input type="text" class="form-control" id="name">
								 	</div>
								 	
								 	<br />
								 	
				      				<div class="form-group col-md-10 col-md-offset-1">
								    	<label for="cardnumber">Card Number:</label>
    									<input type="text" class="form-control" id="cardnumber">
								 	</div>
								 	
								 	<br />
								 	
								 	<div class="form-group col-md-10 col-md-offset-1">
								    	<label for="expiry">Expiry:</label>
    									<input type="month" class="form-control" id="expiry">
								 	</div>
								 	
								 	<br />
								 	
								 	<div class="form-group col-md-10 col-md-offset-1">
								    	<label for="cvc">CVC:</label>
    									<input type="text" class="form-control" id="cvc">
								 	</div>
								 	
								 	<br />
								 	
								 	<div class="form-group col-md-10 col-md-offset-1">
								 		<button type="submit" class="btn btn-primary center-block" data-toggle="modal" data-target="#payment-modal"><span class="glyphicon glyphicon-usd"></span> Pay</button>
								 	</div>
				      			</form>
				      			
				      			<div class="clearfix"></div>
				      		</div>
				    	</div>
				  	</div>
				</div>
			</div>
			
			<%
				}
			%>
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