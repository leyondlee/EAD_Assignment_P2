<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt;
				ResultSet rs;
	%>
	
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>Add Game</h4>
					</div>
					<div class="panel-body">
						<form action="addgame.jsp" method="post">
							<div class="form-group">
								<label for="title">Title</label> <input type="text" class="form-control" id="title" autocomplete="off" name="title">
							</div>
							
							<div class="form-group">
								<label for="company">Company</label>
								<select class="form-control" id="company" name="company">
									<option>-</option>
									<%
										pstmt = conn.prepareStatement("SELECT * FROM company ORDER BY 2 ASC");
										rs = pstmt.executeQuery();
										
										while (rs.next()) {
											String id = String.valueOf(rs.getInt("companyid"));
											String name = rs.getString("name");
									%>
										<option value="<%=id %>"><%=name %></option>
									<%
										}
									%>
								</select>
							</div>
							
							<div class="form-group">
								<label for="date">Release Date</label> <input type="date" class="form-control" id="date" name="date">
							</div>
							
							<div class="form-group">
								<label for="price">Price</label> <input type="number" step="0.01" value="0.00" class="form-control" id="price" name="price">
							</div>
							
							<div class="form-group">
								<label for="preowned">Preowned</label>
								<div class="form-group" id="preowned">
									<label class="radio-inline"><input type="radio" name="preowned" value="1">Yes</label>
									<label class="radio-inline"><input type="radio" name="preowned" value="0">No</label>
								</div>
							</div>
							
							<div class="form-group">
								<label for="genre">Genre</label>
								<div id="genre">
									<%
										pstmt = conn.prepareStatement("SELECT * FROM genre ORDER BY 2 ASC");
										rs = pstmt.executeQuery();
										
										while (rs.next()) {
											String id = String.valueOf(rs.getInt("genreid"));
											String name = rs.getString("name");
									%>
										<div class="checkbox">
										  	<label><input type="checkbox" name="genre" value="<%=id %>"><%=name %></label>
										</div>
									<%
										}
									%>
								</div>
							</div>
							
							<br />
							
							<div class="form-group">
								<label for="description">Description</label>
								<textarea class="form-control" id="description" rows="6" name="description"></textarea>
							</div>
							
							<br />
							
							<div class="form-group">
								<label for="quantity">Quantity</label> <input type="number" class="form-control" id="quantity" name="quantity">
							</div>
							
							<br />
							
							<div class="pull-left">
								<button type="reset" class="btn btn-default">Reset</button>
							</div>
							
							<div class="pull-right">
								<a href="adminpanel.jsp#admingame"><button type="button" class="btn btn-danger">Cancel</button></a> <button type="submit" class="btn btn-default">Add Game</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div class="push"></div>
	</div>
	<%
				conn.close();
			} catch (Exception e) {
				
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