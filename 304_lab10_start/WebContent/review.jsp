<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html> 
<head> 
<title>Write a review</title>
</head>
<body>
<%@ include file="header.jsp" %>

<div style="margin:0 auto;text-align:center;display:inline">

<% 
String id = request.getParameter("id");
int pid = Integer.valueOf(id);
%>

<br>
<form name="MyForm" method=post action="reviewSubmit.jsp">
<table style="display:inline">
<tr>
	<td><div align="middle"><font face="Arial, Helvetica, sans-serif" size="2">Your customer ID:</font></div></td>
	<td><input type="text" name="ID"  size=5 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Review: </font></div></td>
	<td><input type="text" name="review" size=100 maxlength="100"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Submit Review">
</div>

</body>
</html>    