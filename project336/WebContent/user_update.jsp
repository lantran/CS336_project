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
		
		Update Profile
		
		<br><br><br>
		<%
			try {		
				
				//Get the max unit price inputed by the user
				String profileid =request.getParameter("profileid");
				String firstName =request.getParameter("firstName");
				String lastName =request.getParameter("lastName");
				String dob =request.getParameter("dob");
				String gender =request.getParameter("gender");
				String emailAddress =request.getParameter("emailAddress");
				String schoolName =request.getParameter("schoolName");
				String gradYear =request.getParameter("gradYear");
				String degree =request.getParameter("degree");
				//out.println("<tr><td>The product you wanted is :" + userId + "</td><tr>");
				//out.println("<br><br><br>");
				out.println(profileid+firstName+lastName+dob+gender+emailAddress+schoolName+gradYear+degree);
				
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			

				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				//Get profileid based on userid
				stmt.executeUpdate("UPDATE profile SET profile.firstName='" + firstName + "', profile.lastName='" + lastName +
				"', profile.dob='" + dob + "', profile.gender='" + gender + "', profile.emailAddress='" + emailAddress + 
				"', profile.schoolName='" + schoolName + "', profile.gradYear='" + gradYear + "', profile.degree='" + degree
				+ "' WHERE profile.profileid LIKE '" + profileid +"'");
				stmt.close();
				con.close();	
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		%>


	</body>
</html>
