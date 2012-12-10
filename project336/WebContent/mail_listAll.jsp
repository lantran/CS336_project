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
				out.println("Sent Messages");
				rs = stmt.executeQuery("SELECT * FROM sendmessage i WHERE i.sender LIKE '" + userId + "'");
				
				while (rs.next()) {
					out.println("<table border=1 width=400>");
					//out.println("<tr><td>    id"  + "</td><td>    datetime"  + "</td><td>    sender" + "</td><td>    msgid"  + "</td></tr>");
					String sendsMessageid = rs.getString(1);
					String datetime = rs.getString(2);
					String sender = rs.getString(3);
					String msgid = rs.getString(4);
					//out.println("<tr><td>" + id + "</td><td>" + datetime+ "</td><td>" + sender + "</td><td>" + msgid + "</td></tr>");
					out.println("<tr><td>Date and Time: " + datetime + "</td></tr>");
					ResultSet msgcontent = stmt2.executeQuery("SELECT title, content from message m where m.msgid= '" + msgid +"'");
					msgcontent.next();
					String title = msgcontent.getString(1);
					String content = msgcontent.getString(2);
					out.println("<tr><td>Title: " + title + "</td></tr>");
					out.println("<tr><td>Content: " + content + "</td></tr>");
					
					ResultSet receivers = stmt3.executeQuery("SELECT p.firstName, p.lastName from user u, profile p, receiver r where u.profileid=p.profileid and r.receiverid = u.userid and r.sendsMessageid= '" + sendsMessageid +"'");
					String name="";
					while(receivers.next()) {
						name += receivers.getString(1);
						name += " " + receivers.getString(2);
						name += ", ";
					}

					out.println("<tr><td>Receivers: " + name + "</td></tr>");
					
					out.println("</table><br>");
				} 


				out.println("Received Messages");
				rs = stmt.executeQuery("SELECT s.id, s.datetime, s.sender, s.msgid FROM receiver i, sendmessage s WHERE s.id=i.sendsMessageid and i.receiverid LIKE '" + userId + "'");
				
				while (rs.next()) {
					out.println("<table border=1 width=400>");
					//out.println("<tr><td>    id"  + "</td><td>    datetime"  + "</td><td>    sender" + "</td><td>    msgid"  + "</td></tr>");
					String sendsMessageid = rs.getString(1);
					String datetime = rs.getString(2);
					String senderid = rs.getString(3);
					ResultSet senderresult = stmt4.executeQuery("SELECT p.firstName, p.lastName from user u, profile p where u.profileid=p.profileid and u.userid= '" + senderid + "'" );
					senderresult.next();
					String sender = senderresult.getString(1);
					sender += " " + senderresult.getString(2);
					String msgid = rs.getString(4);
					//out.println("<tr><td>" + id + "</td><td>" + datetime+ "</td><td>" + sender + "</td><td>" + msgid + "</td></tr>");
					out.println("<tr><td>Date and Time: " + datetime + "</td></tr>");
					out.println("<tr><td>Sender: " + sender + "</td></tr>");
					ResultSet msgcontent = stmt2.executeQuery("SELECT title, content from message m where m.msgid= '" + msgid +"'");
					msgcontent.next();
					String title = msgcontent.getString(1);
					String content = msgcontent.getString(2);
					out.println("<tr><td>Title: " + title + "</td></tr>");
					out.println("<tr><td>Content: " + content + "</td></tr>");
					
					ResultSet receivers = stmt3.executeQuery("SELECT p.firstName, p.lastName from user u, profile p, receiver r where u.profileid=p.profileid and r.receiverid = u.userid and r.sendsMessageid= '" + sendsMessageid +"'");
					String name="";
					while(receivers.next()) {
						name += receivers.getString(1);
						name += " " + receivers.getString(2);
						name += ", ";
					}

					out.println("<tr><td>Receivers: " + name + "</td></tr>");
					
					out.println("</table><br>");
				} 
				
				rs.close();
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		
			
		

			
		%>


	</body>
</html>
