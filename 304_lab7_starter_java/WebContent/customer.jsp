  
<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
// TODO: Print Customer information
String sql = "Select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid From customer where customerId =?";
PreparedStatement pt1 = con.prepareStatement(sql);
pt1.setString(1,userName);
ResultSet rs1 = pt1.executeQuery();
while(rs1.next()){
	out.println("<table><tr><th>customerId</th><td>"+rs1.getInt(1)+"</td></tr>");
	out.println("<tr><th>FirstName</th><td>"+rs1.getString(2)+"</td></tr>");
	out.println("<tr><th>LastName</th><td>"+rs1.getString(3)+"</td></tr>");
	out.println("<tr><th>Email</th><td>"+rs1.getString(4)+"</td></tr>");
	out.println("<tr><th>Phone number</th><td>"+rs1.getString(5)+"</td></tr>");
	out.println("<tr><th>address</th><td>"+rs1.getString(6)+"</td></tr>");
	out.println("<tr><th>City</th><td>"+rs1.getString(7)+"</td></tr>");
	out.println("<tr><th>State</th><td>"+rs1.getString(8)+"</td></tr>");
	out.println("<tr><th>Postal code</th><td>"+rs1.getString(9)+"</td></tr>");
	out.println("<tr><th>Country</th><td>"+rs1.getString(10)+"</td></tr>");
	out.println("<tr><th>Userid</th><td>"+rs1.getString(11)+"</td></tr>");
}
out.println("</table>");
con.close();
// Make sure to close connection
%>

</body>
</html>