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

		<%
			try {	
				
				String buyId =request.getParameter("buyId");
				
				java.sql.Connection con;			
				Statement stmt;			
				ResultSet rs;			
	
				Context ctx = new InitialContext();
				DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/test");	
				con = ds.getConnection();
				stmt = con.createStatement();
				
				//Use maxUnitPrice as the condition in the query
				rs = stmt.executeQuery("SELECT * FROM item WHERE item.itemid = '" + buyId+ "'");
				
				// get the price of the item
				rs.next();
				String priceId = rs.getString(2);
				
				
				// get the id of seller 
				rs = stmt.executeQuery("SELECT userid FROM edititem e WHERE e.action ='Add' and e.itemid = '" + buyId+ "'");
				rs.next();
				String sellerId = rs.getString(1);
			
				
				// get the id of buyer 
				String emailId = (String) session.getAttribute("current_pass");
				rs = stmt.executeQuery("SELECT userid from user u, profile p  where u.profileid = p.profileid and p.emailAddress LIKE '" + emailId +"'");
				rs.next();
				String buyerId = rs.getString(1);
			
							
				// insert the data into the transaction table
				
				stmt.executeUpdate("INSERT INTO  transaction ( buyerid, sellerid, itemid, realPrice, transactiontype , transactionDateTime ) VALUES ('" + buyerId + "','" + sellerId +"','" + buyId + "','" + priceId + "', 'Buy'  , now())" ) ;   
			
				// update the status of the product
				stmt.executeUpdate("UPDATE item SET status = 'Sold' WHERE itemid = '"+ buyId+ "'"); 
				
				// print out the detail of the transaction
				
				out.println (" The detail of the transaction : ");
				out.println("<br>");
				out.println("<br>");
				rs = stmt.executeQuery("SELECT firstName, lastName from profile p  where p.emailAddress LIKE '" + emailId +"'");		
				rs.next();			
				
				out.println ("Buyer  :  " + rs.getString(1) + " " + rs.getString(2) );
				out.println("<br>");
				
				rs = stmt.executeQuery("SELECT  p.firstName, p.lastName from profile p, user u  WHERE p.profileid = u.profileid and userid LIKE '" + sellerId +"'");		
				rs.next();
				out.println ("Seller  :  " + rs.getString(1) + " " + rs.getString(2) );
				out.println("<br>");
						
				out.println ("Price :  " + priceId );
				out.println("<br>");
				
				rs = stmt.executeQuery("SELECT now() ");
				rs.next();
				out.println ("Date and Time  :  " + rs.getString(1) );
				out.println("<br>");
				
				rs.close();
				stmt.close();
				con.close();
				
			} catch (Exception e) {
				out.println(e.getMessage());
			}
	
			
		%>
		
		 <br>
		 
		<a href="index.jsp"> Return to the index page </a> <br>


	</body>
</html>
