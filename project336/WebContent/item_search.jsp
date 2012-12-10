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
				String categoryid =request.getParameter("category");
				
			
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			
	
				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				//Use maxUnitPrice as the condition in the query
				rs = stmt.executeQuery("SELECT *  FROM item WHERE item.status= 'Available' and item.category = '" + categoryid +"'" );
				
				out.println("<form name='buyItem' action='item_buy.jsp' method='post' >");
				out.println("<table border=1 width=400>");
				out.println("<tr><td>    itemId"  + "</td><td>    price"  + "</td><td>    picture" 
							+ "</td><td>    category"  + "</td><td>   quality"  + "</td><td>   description" 
							+ "</td><td>  type of listing "  + "</td><td>   status "  + "</td> <td>   Buy     Item   </td></tr>");
				while (rs.next()) {
					String itemid = rs.getString(1);
					String price = rs.getString(2);
					String picture = rs.getString(3);
					String category = rs.getString(4);
					String quality = rs.getString(5);
					String description = rs.getString(6);
					String typeoflisting = rs.getString(7);
					String status = rs.getString(8);
					out.println("<tr><td>" + itemid + "</td><td>" + price+ "</td><td>" + picture + "</td><td>"
								+ category + "</td><td>" + quality + "</td><td>" 
							+ description + "</td><td>" + typeoflisting + "</td><td>" + status + "</td><td> <input type='radio' name='buyId' value=' " + rs.getString(1)  +  "  ' />   </td> </tr>");
				} 
				
				out.println("</table>");
				out.println("<br>");
				out.println("<br>");
				out.println("<br>");
			
				
				out.println("<input type='submit' value='Buy Item' />");
				
				out.println("</form>");
				
				
				rs.close();
				stmt.close();
				con.close();
				
			} 
			catch (Exception e) {
				out.println(e.getMessage());
			}
			
			
		%>
		
		<% 
		//<form name="buyItem" action="item_buy.jsp" method="post">
		//	<h2> Want to buy? Please, Input the id of the item you want to buy </h2>
		//	<br>
		//	<input type = "text" name="buyId" >
		//   <input type="submit" value="Buy Item" /> 
		//</form>
		%>

	</body>
</html>
