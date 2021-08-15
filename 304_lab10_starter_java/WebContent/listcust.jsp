<!DOCTYPE html>
<html>
<head>
<title>Administrator Customer List Page</title>
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

// Print out total order amount by day
String sql = "SELECT customerId, userid, firstName, lastName, email, phonenum FROM customer";

try 
{	
	out.println("<h3>Customer List</h3>");
	
	getConnection();
	ResultSet rst = con.createStatement().executeQuery(sql);		
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Customer Id</th><th>User Id</th><th>Name</th><th>Email</th><th>Phone Number</th>");	

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getString(2)+"</td><td>"+rst.getString(3)+" "+rst.getString(4)+"</td><td>"+rst.getString(5)+"</td><td>"+rst.getString(6)+"</td></tr>");
	}
	out.println("</table>");		
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

<%
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>

</body>
</html>

