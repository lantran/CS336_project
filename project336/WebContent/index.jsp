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
		<h1> Project CS 336 : RUMARKET </h1>
		<br>
		<br>
		<br>
		<h2> Hi, welcome 
		
		<% String user = (String) session.getAttribute("current_user") ; 
		 out.println (user);%>
		 
		 to RUMARKET !
		 </h2>
		 <br>
		 <br>
		 
		<a href="user.jsp"> Users </a> <br>
		<a href="item.jsp"> Items </a> <br>
		<a href="mail.jsp"> Mails </a> <br>
		<br>
		
	</body>
</html>
