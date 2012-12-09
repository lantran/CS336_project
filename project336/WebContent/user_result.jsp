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
		
		User Profile
		
		<br><br>
		<%
		String profileid=null;
		String gradYear=null;
		String firstName=null;
		String lastName=null;
		String emailAddress=null;
		String dob=null;
		String gender=null;
		String schoolName=null;
		String degree=null;
			try {		
				
				//Get the max unit price inputed by the user
				String userId =request.getParameter("userId");
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
				rs = stmt.executeQuery("SELECT userid, profileid from user where user.userid LIKE '" + userId +"'");
				rs.next();
				profileid = rs.getString(2);
				
				//Get profile information from profile table
				rs = stmt.executeQuery("SELECT * from profile p where p.profileid LIKE '" + profileid +"'");
				rs.next();
				gradYear = rs.getString(2);
				firstName = rs.getString(3);
				lastName = rs.getString(4);
				emailAddress = rs.getString(5);
				dob = rs.getString(6);
				gender = rs.getString(7);
				schoolName = rs.getString(8);
				degree = rs.getString(9);
				
				//Output profile info
				out.println("Name: " + firstName + " " + lastName + "<br>");
				out.println("Date of Birth: " + dob + "<br>");
				out.println("Gender: " + gender + "<br>");
				out.println("E-mail Address: " + emailAddress + "<br>");
				out.println("School: " + schoolName + "<br>");
				out.println("Graduation Year: " + gradYear + "<br>");
				out.println("Major: " + degree + "<br>");
				
				//Get and output location info
				out.println("<br><hr><br>Location<br>");
				rs = stmt.executeQuery("SELECT * from haslocation h where h.profileid LIKE '" + profileid +"'");
				out.println("<table border=1 width=400>");
				out.println("<tr><th>Address</th><th>City</th><th>State</th><th>Country</th></tr>");
				while (rs.next()) {
					String city = rs.getString(3);
					String state = rs.getString(4);
					String address = rs.getString(5);
					String country = rs.getString(6);
					out.println("<tr><td>" + address + "</td><td>" + city+ "</td><td>" + state + "</td><td>" + country + "</td></tr>");
				} 
				out.println("</table>");				
				
				//Get and output interest info
				out.println("<br><hr><br>Interests<br>");
				rs = stmt.executeQuery("SELECT * from hasinterest h where h.profileid LIKE '" + profileid +"'");
				out.println("<table border=1 width=400>");
				out.println("<tr><th>Name of Interest</th></tr>");
				while (rs.next()) {
					String interestName = rs.getString(2);
					out.println("<tr><td>" + interestName + "</td></tr>");
				} 
				out.println("</table>");
				
				//Get and output job info
				out.println("<br><hr><br>Job Experience<br>");
				rs = stmt.executeQuery("SELECT * from hasjobexperience h where h.profileid LIKE '" + profileid +"'");
				out.println("<table border=1 width=400>");
				out.println("<tr><th>Company</th><th>Position</th><th>Start</th><th>End</th></tr>");
				while (rs.next()) {
					String CompanyName = rs.getString(3);
					String position = rs.getString(4);
					String startDate = rs.getString(5);
					String endDate = rs.getString(6);
					out.println("<tr><td>" + CompanyName + "</td><td>" + position + "</td><td>" + startDate + "</td><td>" + endDate + "</td></tr>");
				} 
				out.println("</table>");
				
				//Get and output friend info
				out.println("<br><hr><br>Friends<br>");
				rs = stmt.executeQuery("SELECT  p.firstName, p.lastName, f.date from isfriend f, user u, profile p where f.friend=u.userid and u.profileid=p.profileid and f.user LIKE '" + userId +"'");
				out.println("<table border=1 width=400>");
				out.println("<tr><th>Name</th><th>Friends since</th></tr>");
				while (rs.next()) {
					String friendname = rs.getString(1);
					friendname += " " + rs.getString(2);
					String date = rs.getString(3);
					out.println("<tr><td>" + friendname + "</td><td>" + date + "</td></tr>");
				} 
				out.println("</table>");
				
				//Add friend
				rs = stmt.executeQuery("SELECT u.userid, p.firstName, p.lastName from user u, profile p where u.profileid = p.profileid");
				out.println("<form name=\"input\" action=\"friend_process.jsp\" method=\"post\">Add a friend: <select name=\"friendId\">");
				out.println("<option value=\"0\" selected>(please select:)</option>");
				while (rs.next()) {
					String userid = rs.getString(1);
					String name = rs.getString(2);
					name += " " + rs.getString(3);
					out.println("<option value=\"" + userid + "\">" + name + "</option>");
				}
				out.println("</select>");
				out.println("<input type='hidden' name='processtype' value='add' />");
				out.println("<input type='hidden' name='userId' value=" + userId + " />");
				out.println("<label>Friends since (YYYY-MM-DD): </labe><input type='text' name='date' />");
				out.println("<input type=\"submit\" value=\"Submit\"></form>");

				//Delete friend
				rs = stmt.executeQuery("SELECT u.userid, p.firstName, p.lastName from user u, profile p, isfriend f where u.profileid = p.profileid and f.friend=u.userid and f.user LIKE '" + userId +"'");
				out.println("<form name=\"input\" action=\"friend_process.jsp\" method=\"post\">Delete a friend: <select name=\"friendId\">");
				out.println("<option value=\"0\" selected>(please select:)</option>");
				while (rs.next()) {
					String userid = rs.getString(1);
					String name = rs.getString(2);
					name += " " + rs.getString(3);
					out.println("<option value=\"" + userid + "\">" + name + "</option>");
				}
				out.println("</select>");
				out.println("<input type='hidden' name='processtype' value='delete' />");
				out.println("<input type='hidden' name='userId' value=" + userId + " />");
				out.println("<input type=\"submit\" value=\"Submit\"></form>");
				
				/*
				out.println("<table border=1 width=400>");
				out.println("<tr><td>    userId"  + "</td><td>    ProfileId"  + "</td></tr>");
				while (rs.next()) {
					String name = rs.getString(1);
					String price = rs.getString(2);
					out.println("<tr><td>" + name + "</td><td>" + price+ "</td></tr>");
				} 
				out.println("</table>");
				*/
				rs.close();
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		%>
		<br><hr><br>
		<form name="input" action="user_update.jsp" method="post">
			Update profile information
			<input type="hidden" name="profileid" value=<%=profileid%> />
			<br>
			<label>First Name: </label><input type="text" name="firstName" value=<%=firstName%> />
			<br>
			<label>Last Name: </label><input type="text" name="lastName" value=<%=lastName%> />
			<br>
			<label>Date of Birth: </label><input type="text" name="dob" value=<%=dob%> />
			<br>
			<label>Gemder: </label><input type="text" name="gender" value=<%=gender%> />
			<br>
			<label>E-mail Address: </label><input type="text" name="emailAddress" value=<%=emailAddress%> />
			<br>
			<label>School: </label><input type="text" name="schoolName" value=<%=schoolName%> />
			<br>
			<label>Graduation Year: </label><input type="text" name="gradYear" value=<%=gradYear%> />
			<br>
			<label>Major: </label><input type="text" name="degree" value=<%=degree%> />
			<input type="submit" value="Submit" />
		</form>

	</body>
</html>
