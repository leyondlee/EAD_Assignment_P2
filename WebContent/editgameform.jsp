<%@ include file="head.jsp" %>

<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			String title = "", description = "", imageLocation = "";
			Date releasedate = null;
			int companyid = -1, preowned = -1;
			double price = 0.00;
		
			String id = request.getParameter("id");
			
			try {
				Connection conn = DB.getConnection();
				PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameid = ?");
				pstmt.setInt(1, Integer.parseInt(id));
				ResultSet rs = pstmt.executeQuery();
				
				if (rs.next()) {
					title = rs.getString("title");
					companyid = rs.getInt("companyid");
					releasedate = rs.getDate("releasedate");
					price = rs.getDouble("price");
					preowned = rs.getInt("preowned");
					description = rs.getString("description");
					imageLocation = rs.getString("imageLocation");
					
					if (imageLocation == null) {
						imageLocation = "";
					}
				}
	%>
	
	<div class="wrapper">
		<div class="container">
			<div class="col-sm-6 col-md-6 col-md-offset-3">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>Edit Game ("<%=title %>")</h4>
					</div>
					<div class="panel-body">
						<form action="editgame.jsp" method="post">
							<input type="hidden" name="id" value="<%=id %>">
							<div class="form-group">
								<label for="gameid">ID</label>
								<input class="form-control" id="gameid" type="text" value="<%=id %>" disabled>
							</div>
							
							<div class="form-group">
								<label for="gameimageform">Image</label><br />
								<%
									if (!(imageLocation.equals(""))) {
								%>
								<img src="<%=imageLocation %>" alt="<%=title %>" class="img-thumbnail img-responsive" id="gameimageform">
								<br />
								<br />
								<a href="changeImage.jsp?id=<%=id %>"><button type="button" class="btn btn-default">Change</button></a> <a href="deleteImage.jsp?id=<%=id %>"> <button type="button" class="btn btn-default">Delete</button></a>
								<%
									} else {
								%>
								<a href="addImageForm.jsp?id=<%=id %>"><button type="button" class="btn btn-default">Add Image</button></a>
								<%
									}
								%>
							</div>
							<br />
							<div class="form-group">
								<label for="title">Title</label> <input type="text" class="form-control" id="title" autocomplete="off" name="title" value="<%=title %>">
							</div>
							
							<div class="form-group">
								<label for="company">Company</label>
								<select class="form-control" id="company" name="company">
									<option>-</option>
									<%
										pstmt = conn.prepareStatement("SELECT * FROM company ORDER BY 2 ASC");
										rs = pstmt.executeQuery();
										
										while (rs.next()) {
											int cid = rs.getInt("companyid");
											String name = rs.getString("name");
											
											if (cid == companyid) {
									%>
										<option selected value="<%=cid %>"><%=name %></option>
									<%
											} else {
									%>
										<option value="<%=cid %>"><%=name %></option>
									<%
											}
										}
									%>
								</select>
							</div>
							
							<div class="form-group">
								<label for="date">Release Date</label> <input type="date" class="form-control" id="date" name="date" value="<%=releasedate %>">
							</div>
							
							<div class="form-group">
								<label for="price">Price</label> <input type="number" step="0.01" class="form-control" id="price" name="price" value="<%=price %>">
							</div>
							
							<div class="form-group">
								<label for="preowned">Preowned</label>
								<div class="form-group" id="preowned">
									<%
										if (preowned == 1) {
									%>
									<label class="radio-inline"><input type="radio" name="preowned" value="1" checked>Yes</label>
									<label class="radio-inline"><input type="radio" name="preowned" value="0">No</label>
									<%
										} else if (preowned == 0) {
									%>
									<label class="radio-inline"><input type="radio" name="preowned" value="1">Yes</label>
									<label class="radio-inline"><input type="radio" name="preowned" value="0" checked>No</label>
									<%
										} else {
									%>
									<label class="radio-inline"><input type="radio" name="preowned" value="1">Yes</label>
									<label class="radio-inline"><input type="radio" name="preowned" value="0">No</label>
									<%
										}
									%>
								</div>
							</div>
							
							<div class="form-group">
								<label for="genre">Genre</label>
								<div id="genre">
									<%
										pstmt = conn.prepareStatement("SELECT * FROM genre ORDER BY 2 ASC");
										rs = pstmt.executeQuery();
										
										while (rs.next()) {
											String genreid = rs.getString("genreid");
											String genre = rs.getString("name");
											
											pstmt = conn.prepareStatement("SELECT * FROM game_genre WHERE gameid = ? AND genreid = ?");
											pstmt.setInt(1, Integer.parseInt(id));
											pstmt.setInt(2, Integer.parseInt(genreid));
											ResultSet ggrs = pstmt.executeQuery();
									%>
									<div class="checkbox">
										<%
											if (ggrs.next()) {
										%>
									  	<label><input type="checkbox" name="genre" value="<%=genreid %>" checked><%=genre %></label>
										<%
											} else {
										%>
										<label><input type="checkbox" name="genre" value="<%=genreid %>"><%=genre %></label>
										<%
											}
										%>
									</div>
									<%
										}
									%>
								</div>
							</div>
							
							<br />
							
							<div class="form-group">
								<label for="description">Description</label>
								<textarea class="form-control" id="description" rows="6" name="description"><%=description %></textarea>
							</div>
							
							<br>
							
							<div class="pull-left">
								<button type="reset" class="btn btn-default">Reset</button>
							</div>
							
							<div class="pull-right">
								<a href="adminpanel.jsp#admingame"><button type="button" class="btn btn-danger">Cancel</button></a> <button type="submit" class="btn btn-default">Apply</button>
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
				response.sendRedirect("error.jsp");
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