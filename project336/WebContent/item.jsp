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
		<h1> Project CS 336 : RUMARKET  </h1>
		<br> 
		<br> 
		<br>
		<!-- list all item -->
		
		<form name="selectItem" action="item_listAll.jsp" method="post">
			If you want to list all items, press the button List all items
			<input type="submit" value="List all items " />
		</form>
		<br>
		
		<!-- add an item -->
		
		<form name="addItem" action="item_add.jsp" method="post">
			Input put the information you want to add:
			<br>
		
			Price : 
			<input type="text" name="price">
			<br>
			
			Category :		
			<select name="category" >
				<option value ="book"> BOOK 
				<option value ="car"> CAR
				<option value ="electronic"> ELECTRONIC 
				<option value ="furniture"> FURNITURE 
				<option value =""> OTHERS  
			</select>
			<br>
			
			Quality : 
			<input type="text" name="quality">
			<br>
			
			Description: <br>
			<textarea name= "description" rows="5" cols ="60" > </textarea>
			<br>
			
			Type of listing:
			<input type="radio" name="typeoflisting" value= "Sell"> SELL
			<input type="radio" name="typeoflisting" value= "Buy"> BUY
			<br>
			<br>
		    <input type="submit" value="Add Item" /> 
		</form>
		
	
		<!-- del an item -->
		
		<form name="deleteItem" action="item_delete.jsp" method="post">
			Please, input the id of the item you want to delete:
			<br>
			<input type = "text" name="deleteId" >
		    <input type="submit" value="Delete Item" /> 
		</form>
	
		<!-- search an item  -->
		<br>
		<br>
		<form name="searchItem" action="item_search.jsp" method="post">
			Choose a category you want to search:
			<br>
			<select name="category" >
				<option value ="book"> BOOK 
				<option value ="car"> CAR
				<option value ="electronic"> ELECTRONIC 
				<option value ="furniture"> FURNITURE 
				<option value =""> OTHERS  
				
			</select> 
		    <input type="submit" value="Search Item" /> 
		</form>
		
		
		<!--  buy an item  -->
		
		<!--  sell an item  -->
		
		
		
	</body>
</html>
