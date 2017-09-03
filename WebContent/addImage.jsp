<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%@ include file="head.jsp" %>
<body>
	<%@ include file="navbar.jsp" %>
	
	<%
		if (Webpage.checkAdmin(session)) {
			File file;
			int maxFileSize = 5000 * 1024;
			int maxMemSize = 5000 * 1024;
			ServletContext context = pageContext.getServletContext();
			//String filePath = getServletContext().getRealPath("/").replace(".metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\","") + "images\\";
			String filePath = getServletContext().getRealPath("/") + "images\\";
		
			// Verify the content type
			String contentType = request.getContentType();
			if ((contentType.indexOf("multipart/form-data") >= 0)) {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				// maximum size that will be stored in memory
				factory.setSizeThreshold(maxMemSize);
				
				// Location to save data that is larger than maxMemSize.
				factory.setRepository(new File(getServletContext().getRealPath("/").replace("/", "\\") + "temp"));
		
				// Create a new file upload handler
				ServletFileUpload upload = new ServletFileUpload(factory);
				
				// maximum file size to be uploaded.
				upload.setSizeMax(maxFileSize);
				try {
					// Parse the request to get file items.
					List fileItems = upload.parseRequest(request);
		
					// Process the uploaded file items
					Iterator i = fileItems.iterator();
					
					String fileName = "", id = "";
					while (i.hasNext()) {
						FileItem fi = (FileItem) i.next();
						if (!fi.isFormField()) {
							// Get the uploaded file parameters
							String fieldName = fi.getFieldName();
							fileName = fi.getName();
							
							//MY OWN PART: String fileName = request.getParameter("file");
							boolean isInMemory = fi.isInMemory();
							long sizeInBytes = fi.getSize();
							
							// Write the file
							if (fileName.lastIndexOf("\\") >= 0) {
								file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
							} else {
								file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
							}
							
							fi.write(file);
						} else {
							if (fi.getFieldName().equals("id")) {
								id = fi.getString();
							};
						}
					}
					
					Connection conn = DB.getConnection();
					PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameid = ?");
					pstmt.setInt(1, Integer.parseInt(id));
					ResultSet rs = pstmt.executeQuery();
					if (rs.next()) {
						String imageLocation = rs.getString("imageLocation");
						if (imageLocation == null) {
							imageLocation = "";
						}
						
						if (!(imageLocation.equals(""))) {
							Webpage.deleteImage(getServletContext().getRealPath("/").replace("/", "\\") + (imageLocation.replace("/","\\")));
						}
					}
					
					pstmt = conn.prepareStatement("UPDATE game SET imageLocation = ? WHERE gameid = ?");
					pstmt.setString(1, "images/" + fileName);
					pstmt.setInt(2, Integer.parseInt(id));
					pstmt.execute();
					
					conn.close();
					
					response.sendRedirect("adminpanel.jsp#admingame");
				} catch (Exception e) {
					response.sendRedirect("error.jsp");
				}
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