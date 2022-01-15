
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="../auth.jsp"%>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<h1 align="center">Administrator View</h1>

<h2 align="center"><a href="viewsales.jsp">View Sales</a></h2>

<h2 align="center"><a href="listcust.jsp">List Customers</a></h2>

<h2 align="center"><a href="listorderadm.jsp">List Orders</a></h2>

<%
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>

</body>
</html>

