<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	 <meta charset="utf-8">
	 <meta http-equiv="X-UA-Compatible" content="IE=edge">
     <meta name="viewport" content="width=device-width, initial-scale=1">
	 <title>A Java SAML Toolkit by OneLogin demo</title>
	 <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

</head>
<body>
	<div class="container">
    	<h1>Logged out</h1>
    	<b>Logout</b>   	
	<%
			out.println("<p>Sucessfully logged out</p>");
			out.println("<a href=\"index.jsp\" class=\"btn btn-primary\">Login</a>");
	%>
	</div>
</body>
</html>
