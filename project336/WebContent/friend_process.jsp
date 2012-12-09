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
		
		Add friend
		
		<br><br><br>
		<%
			try {		
				
				//Get the max unit price inputed by the user
				String processtype =request.getParameter("processtype");
				String userId =request.getParameter("userId");
				String friendId =request.getParameter("friendId");
				String date =request.getParameter("date");

				//out.println("<tr><td>The product you wanted is :" + userId + "</td><tr>");
				//out.println("<br><br><br>");
				
				
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			

				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				//Get profileid based on userid
				if (processtype.equals("add")) {
					stmt.executeUpdate("INSERT isfriend SET user='" + userId + "', friend='" + friendId +
							"', date='" + date + "'");
					out.println("ADD " + userId+ " " + friendId + " " + date);
				}
				else if (processtype.equals("delete")) {
					stmt.executeUpdate("DELETE FROM isfriend WHERE user='" + userId + "' and friend='" + friendId + "'");
					out.println("DELETE " + userId+ " " + friendId);					
				}
				stmt.close();
				con.close();
				
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		%>


	</body>
</html>
