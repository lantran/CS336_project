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
		
		List of user 
		
		<br><br><br>


		<%
			try {		
				
				//Get the max unit price inputed by the user
				String userId =request.getParameter("userId");

				out.println("<tr><td>The product you wanted is :" + userId + "</td><tr>");
				out.println("<br><br><br>");
				
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			

				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				//Use maxUnitPrice as the condition in the query
				rs = stmt.executeQuery("SELECT userid, profileid from user where user.userid LIKE '" + userId +"'");
				
				out.println("<table border=1 width=400>");
				out.println("<tr><td>    userId"  + "</td><td>    ProfileId"  + "</td></tr>");
				while (rs.next()) {
					String name = rs.getString(1);
					String price = rs.getString(2);
					out.println("<tr><td>" + name + "</td><td>" + price+ "</td></tr>");
				} 
				out.println("</table>");
				
				rs.close();
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		%>


	</body>
</html>
