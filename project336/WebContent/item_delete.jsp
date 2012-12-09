<%@ page language="java" import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>


<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'index.jsp' starting page</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	</head>

	<body>
		
		List of the item 
		
		<br><br><br>


		<%
			try {		
		
				//Get the max unit price inputed by the user
				String deleteId =request.getParameter("deleteId");
				String emailId = (String) session.getAttribute("current_pass");
				
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			
	
				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				// find the id of current_user
				rs = stmt.executeQuery("SELECT userid from user u, profile p  where u.profileid = p.profileid and p.emailAddress LIKE '" + emailId +"'");
				
				rs.next();
				String userId = rs.getString(1);
								
				String actionId = "Delete";
			
				
				stmt.executeUpdate(" INSERT INTO  edititem ( userid, itemid, action, editDateTime ) VALUES ('" + userId + "','" + deleteId + "','" + actionId + "', now())" ) ;   
				//stmt.executeUpdate(" DELETE FROM item WHERE item.itemid LIKE'" + deleteId + "'");
			                                       
						
						
				out.println ( " Your deletion is successful!");
			
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		
			
		

			
		%>


	</body>
</html>
