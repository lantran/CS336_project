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
				else if (processtype.equals("interests")) {
					out.println("Friends with similar interests<br>");
					
					//Get profileid based on userid
					rs = stmt.executeQuery("SELECT userid, profileid from user where user.userid LIKE '" + userId +"'");
					rs.next();
					String profileid = rs.getString(2);
					String sql = "SELECT h1.interestName, p.firstName, p.lastName FROM hasinterest h1, hasinterest h2, profile p WHERE h1.interestName = h2.interestName and h1.profileid LIKE '" + profileid + "' and h2.profileid = p.profileid and h2.profileid IN (SELECT friend from isfriend where user LIKE '" + userId + "');";
					out.println(sql);
					rs = stmt.executeQuery(sql);
					out.println("<table border=1 width=400>");
					out.println("<tr><th> </th><th> </th><th> </th><th> </th></tr>");
					while (rs.next()) {
						String interestName = rs.getString(1);
						String firstName = rs.getString(2);
						String lastName = rs.getString(3);
						out.println("<tr><td>" + interestName + "</td><td>" + firstName + " " + lastName + "</td></tr>");
					} 
					out.println("</table>");
				}
				stmt.close();
				con.close();
				
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		%>


	</body>
</html>
