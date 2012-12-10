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
				String title =request.getParameter("title");
				String content =request.getParameter("content");
				String datetime =request.getParameter("datetime");
				String receiver1 =request.getParameter("receiverID1");
				String receiver2 =request.getParameter("receiverID2");
				String receiver3 =request.getParameter("receiverID3");
				
				
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			
	
				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				// get userId
				String emailId = (String) session.getAttribute("current_pass");
				rs = stmt.executeQuery("SELECT userid from user u, profile p  where u.profileid = p.profileid and p.emailAddress LIKE '" + emailId +"'");
				rs.next();
				String userId = rs.getString(1);
				
				//Use maxUnitPrice as the condition in the query
				stmt.executeUpdate("INSERT INTO message (title,content) VALUES ('" + title + "','" + content +" ')" ) ;                                          
			
				// get msgid
				rs = stmt.executeQuery("SELECT last_insert_id() from message ");
				rs.next();
				String msgid = rs.getString(1);
				
				//----------------------------
				
				stmt.executeUpdate(" INSERT INTO  sendmessage ( datetime, sender, msgid ) VALUES ('" + datetime + "','" + userId  + "','" + msgid +" ')" ) ;

				// get sendmessageid
				rs = stmt.executeQuery("SELECT last_insert_id() from sendmessage ");
				rs.next();
				String sendsMessageid = rs.getString(1);

				//----------------------------
				
				if (!receiver1.equals("0")) {
					stmt.executeUpdate(" INSERT INTO  receiver ( receiverid, sendsMessageid ) VALUES ('" + receiver1  + "','" + sendsMessageid +" ')" ) ;				
				}
				if (!receiver2.equals("0")) {
					stmt.executeUpdate(" INSERT INTO  receiver ( receiverid, sendsMessageid ) VALUES ('" + receiver2  + "','" + sendsMessageid +" ')" ) ;			
				}
				if (!receiver3.equals("0")) {
					stmt.executeUpdate(" INSERT INTO  receiver ( receiverid, sendsMessageid ) VALUES ('" + receiver3  + "','" + sendsMessageid +" ')" ) ;				
				}
				out.println ( " Your message is successful!");
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		
			
		

			
		%>


	</body>
</html>
