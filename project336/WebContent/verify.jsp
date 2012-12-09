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
		
		Log in
		
		<br><br><br>

		<%
			String user, pass;
			// get parameters sent to this jsp page
			user = request.getParameter("firstname");
			pass = request.getParameter("email");
	
			java.sql.Connection con;			
			Statement stmt;			
			ResultSet rs;			

			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
			con = ds.getConnection();
			stmt = con.createStatement();
			
			rs = stmt.executeQuery("select count(*) as cnt from profile  where firstName = '" + user + "' and emailAddress = '" + pass + "'");
	
			rs.first();
			
			int custCount = rs.getInt("cnt");
			
	
			if (custCount == 1 ) {
				session.setAttribute("current_user", user );
				session.setAttribute("current_pass", pass );
				session.setMaxInactiveInterval(900);
				pageContext.forward("index.jsp");
				
			}
			else {
				pageContext.forward("login.jsp");
			}
	
			rs.close();
			stmt.close();
			con.close();
			
	
				
		%>


	</body>
</html>
