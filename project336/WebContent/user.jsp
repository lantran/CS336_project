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

		<title>User starting page test</title>
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
		<!-- update info  --> 
		<!--  search for friends --> 
		<!--  add/del  friends -->
		<!-- access friends/ item list  -->
		<!--  modify item list -->
		
		<p> Hahhdaidsahkd </p>
		<form name="input" action="user_result.jsp" method="post">
			Choose a userid that you want to see the profile
			<br>
			<input type="text" name="userId" />
			<input type="submit" value="Submit" />
		</form>
		<br>
		
	</body>
</html>
