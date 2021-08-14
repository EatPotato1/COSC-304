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
session.setAttribute("PID", id);

String custId = request.getParameter("custId");
session.setAttribute("cid", cid);


String sql = "SELECT productName from product where productId = ?";

try{
	getConnection();
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, pid);
	ResultSet rst = pstmt.executeQuery();
	rst.next();
		out.println("<h1>" + rst.getString(1)+ "</h1>");
	
} catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();
}

%>

<br>
<form name="reviewForm" method=post action="reviewSubmit.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Review from 0-10: </font></div></td>
	<td><input type="text" name="review" size=5 maxlength="2"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Review comments: </font></div></td>
	<td><input type="text" name="reviewComment" size=100 maxlength="300"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Submit Review">
</div>

</body>
</html>    