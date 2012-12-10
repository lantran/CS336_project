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
				String search_title =request.getParameter("title");
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
				String sql="SELECT DISTINCT s.id, s.datetime, s.sender, s.msgid FROM sendmessage s, message m, receiver r where s.id=r.sendsMessageid and s.msgid=m.msgid";
				if (search_title != null && !search_title.equals("")) {
					sql+= " and m.title LIKE '" + search_title + "'";
				}
				if (search_sender != null && !search_sender.equals("") && !search_sender.equals("0")) {
					sql+= " and s.sender LIKE '" + search_sender + "'";
				}
				if (search_receiver != null && !search_receiver.equals("") && !search_receiver.equals("0")) {
					sql+= " and r.receiverid LIKE '" + search_receiver + "'";
				}
				out.println("<br>" + sql);
				rs = stmt.executeQuery(sql);
				
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

				
				rs.close();
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		
			
		

			
		%>


	</body>
</html>
