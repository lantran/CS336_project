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
				String processtype =request.getParameter("processtype");
				//Get the max unit price inputed by the user
				//out.println("<tr><td>The product you wanted is :" + userId + "</td><tr>");
				//out.println("<br><br><br>");
				
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			

				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				//Modify database
				if (processtype.equals("addlocation")) {
					String profileid =request.getParameter("profileid");
					String address =request.getParameter("address");
					String city =request.getParameter("city");
					String state =request.getParameter("state");
					String country =request.getParameter("country");
					stmt.executeUpdate("INSERT haslocation SET profileid='" + profileid + "', address='" + address +
							"', city='" + city + "', state='" + state + "', country='" + country + "'");
					out.println("ADD LOCATION " + profileid + " " + address + " " + city + " " + state + " " + country);
				}
				else if (processtype.equals("deletelocation")) {
					String profileid =request.getParameter("profileid");
					String locationid =request.getParameter("locationid");
					stmt.executeUpdate("DELETE FROM haslocation WHERE locationid='" + locationid + "'");
					out.println("DELETE LOCATION " + locationid);					
				}
				if (processtype.equals("addinterest")) {
					String profileid =request.getParameter("profileid");
					String interestName =request.getParameter("interestName");
					stmt.executeUpdate("INSERT hasinterest SET profileid='" + profileid + "', interestName='" + interestName + "'");
					out.println("ADD INTEREST " + profileid + " " + interestName);
				}
				else if (processtype.equals("deleteinterest")) {
					String profileid =request.getParameter("profileid");
					String interestid =request.getParameter("interestid");
					stmt.executeUpdate("DELETE FROM hasinterest WHERE interestid='" + interestid + "'");
					out.println("DELETE INTEREST " + interestid);					
				}
				if (processtype.equals("addjobexperience")) {
					String profileid =request.getParameter("profileid");
					String CompanyName =request.getParameter("CompanyName");
					String position =request.getParameter("position");
					String startDate =request.getParameter("startDate");
					String endDate =request.getParameter("endDate");
					stmt.executeUpdate("INSERT hasjobexperience SET profileid='" + profileid + "', CompanyName='" + CompanyName +
							"', position='" + position + "', startDate='" + startDate + "', endDate='" + endDate + "'");
					out.println("ADD JOB EXPERIENCE " + profileid + " " + CompanyName + " " + position + " " + startDate + " " + endDate);
				}
				else if (processtype.equals("deletejobexperience")) {
					String profileid =request.getParameter("profileid");
					String jobid =request.getParameter("jobid");
					stmt.executeUpdate("DELETE FROM hasjobexperience WHERE jobid='" + jobid + "'");
					out.println("DELETE JOB EXPERIENCE " + jobid);					
				}
				else if (processtype.equals("updateinfo")) {
					String profileid =request.getParameter("profileid");
					String firstName =request.getParameter("firstName");
					String lastName =request.getParameter("lastName");
					String dob =request.getParameter("dob");
					String gender =request.getParameter("gender");
					String emailAddress =request.getParameter("emailAddress");
					String schoolName =request.getParameter("schoolName");
					String gradYear =request.getParameter("gradYear");
					String degree =request.getParameter("degree");
					
					stmt.executeUpdate("UPDATE profile SET profile.firstName='" + firstName + "', profile.lastName='" + lastName +
							"', profile.dob='" + dob + "', profile.gender='" + gender + "', profile.emailAddress='" + emailAddress + 
							"', profile.schoolName='" + schoolName + "', profile.gradYear='" + gradYear + "', profile.degree='" + degree
							+ "' WHERE profile.profileid LIKE '" + profileid +"'");					
				}		

				stmt.close();
				con.close();	
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		%>


	</body>
</html>
