<%@ page language="java" import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
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
	<head>RUMARKET PROJECT CS336 </head>
	<br><br><br>
	<body>
		<% String user = (String) session.getAttribute("current_user") ; 
		 out.println (user);
	    java.util.Date date = new java.util.Date();
	    SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
	    String datetime= ft.format(date);
		%>
		Hello!  The time is now <%= datetime %>
		 
		 <%
		 	try { 
		 		
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
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		 %>

		<form name="selectItem" action="mail_listAll.jsp" method="post">
			If you want to list all the messages, press the button List all messages
			<input type="submit" value="List all messages " />
		</form>
		
		<form name="addMessage" action="mail_add.jsp" method="post">
			Input put the information you want to send:
			<br>
		
			Title : 
			<input type="text" name="title">
			<br>
			
			Content: <br>
			<textarea name= "content" rows="5" cols ="60" > </textarea>
			<br>
			
			Receivers (select up to 3):
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
					out.println("<select name=\"receiverID1\">");
					out.println("<option value=\"0\" selected>(please select:)</option>");
					while (rs.next()) {
						String userid = rs.getString(1);
						String name = rs.getString(2);
						name += " " + rs.getString(3);
						out.println("<option value=\"" + userid + "\">" + name + "</option>");
					}
					out.println("</select>");
					
					//Get list of users
					rs = stmt.executeQuery("SELECT u.userid, p.firstName, p.lastName from user u, profile p where u.profileid = p.profileid");
					out.println("<select name=\"receiverID2\">");
					out.println("<option value=\"0\" selected>(please select:)</option>");
					while (rs.next()) {
						String userid = rs.getString(1);
						String name = rs.getString(2);
						name += " " + rs.getString(3);
						out.println("<option value=\"" + userid + "\">" + name + "</option>");
					}
					out.println("</select>");

					//Get list of users
					rs = stmt.executeQuery("SELECT u.userid, p.firstName, p.lastName from user u, profile p where u.profileid = p.profileid");
					out.println("<select name=\"receiverID3\">");
					out.println("<option value=\"0\" selected>(please select:)</option>");
					while (rs.next()) {
						String userid = rs.getString(1);
						String name = rs.getString(2);
						name += " " + rs.getString(3);
						out.println("<option value=\"" + userid + "\">" + name + "</option>");
					}
					out.println("</select>");
				} catch (Exception e) {
					out.println(e.getMessage());
				}
			%>
			
			<br>
			<input type="hidden" name="datetime" value='<%= datetime %>' />
		    <input type="submit" value="Add Message" />
		</form>
	
		<form name="searchMessage" action="mail_search.jsp" method="post">
			Search messages:
			<br>
		
			Title : 
			<input type="text" name="title">
			<br>

			Sender:
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
					out.println("<select name=\"sender\">");
					out.println("<option value=\"0\" selected>(please select:)</option>");
					while (rs.next()) {
						String userid = rs.getString(1);
						String name = rs.getString(2);
						name += " " + rs.getString(3);
						out.println("<option value=\"" + userid + "\">" + name + "</option>");
					}
					out.println("</select>");
				} catch (Exception e) {
					out.println(e.getMessage());
				}
			%>
						
			Receiver:
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
					out.println("<select name=\"receiver\">");
					out.println("<option value=\"0\" selected>(please select:)</option>");
					while (rs.next()) {
						String userid = rs.getString(1);
						String name = rs.getString(2);
						name += " " + rs.getString(3);
						out.println("<option value=\"" + userid + "\">" + name + "</option>");
					}
					out.println("</select>");
				} catch (Exception e) {
					out.println(e.getMessage());
				}
			%>
			
			<br>
		    <input type="submit" value="Search Message" />
		</form>
		
	</body>
</html>
