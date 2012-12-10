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
		
		List of the messages 
		
		<br><br><br>


		<%
			try {
				String msgid =request.getParameter("msgid");
				String search_receiver =request.getParameter("receiver");
				String search_sender =request.getParameter("sender");
				//out.println(search_title+" "+search_receiver+" "+search_sender);
				java.sql.Connection con;			
				Statement stmt;	
				Statement stmt2;
				Statement stmt3;
				Statement stmt4;
				ResultSet rs;
	
				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				stmt2 = con.createStatement();
				stmt3 = con.createStatement();
				stmt4 = con.createStatement();
 				// get userId
				String emailId = (String) session.getAttribute("current_pass");
				rs = stmt.executeQuery("SELECT userid from user u, profile p  where u.profileid = p.profileid and p.emailAddress LIKE '" + emailId +"'");
				rs.next();
				String userId = rs.getString(1);
				out.println (userId);
				
				
				//Use maxUnitPrice as the condition in the query
				out.println("Messages");
				stmt.executeUpdate("DELETE FROM message WHERE msgid='" + msgid + "'");
				out.println("DELETE " + msgid);	

				
				rs.close();
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		
			
		

			
		%>


	</body>
</html>
