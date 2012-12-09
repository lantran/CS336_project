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

		<title>User starting page test</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<head>RUMARKET PROJECT CS336 </head>
	<br><br><br>
	<body>
		<%
			try {	
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			

				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				//Get list of users
				rs = stmt.executeQuery("SELECT u.userid, p.firstName, p.lastName from user u, profile p where u.profileid = p.profileid");
				out.println("Choose a userid that you want to see the profile");
				out.println("<form name=\"input\" action=\"user_result.jsp\" method=\"post\"><select name=\"userId\">");
				out.println("<option value=\"0\" selected>(please select:)</option>");
				while (rs.next()) {
					String userid = rs.getString(1);
					String name = rs.getString(2);
					name += " " + rs.getString(3);
					out.println("<option value=\"" + userid + "\">" + name + "</option>");
				}
				out.println("</select>");
				out.println("<input type=\"submit\" value=\"Submit\"></form>");
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		%>
		<!-- update info  -->
		<!--  search for friends --> 
		<!--  add/del  friends -->
		<!-- access friends/ item list  -->
		<!--  modify item list -->
		<!--  
		<p> Hahhdaidsahkd </p>
		<form name="input" action="user_result.jsp" method="post">
			Choose a userid that you want to see the profile
			<br>
			<input type="text" name="userId" />
			<input type="submit" value="Submit" />
		</form>
		<br>
		 -->
	</body>
</html>
