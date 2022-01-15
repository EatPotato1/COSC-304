<!DOCTYPE html>
<%@ page import="java.text.NumberFormat" %>

<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<%@include file="auth.jsp"%>
<%@include file="jdbc.jsp"%>
<%
try{getConnection();
// TODO: Write SQL query that prints out total order amount by day
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String sql = "Select orderDate, sum(totalAmount) From ordersummary group by orderDate";
PreparedStatement st1 = con.prepareStatement(sql);
ResultSet rs1 = st1.executeQuery();
out.println("<table><tr><th>orderDate</th><th>Total_amount_per_day</th></tr>");

while(rs1.next()){
out.println("<tr><td>"+rs1.getDate(1)+"</td><td>"+currFormat.format(rs1.getDouble(2))+"</td></tr>");}
}catch(Exception e){
	out.println(e);
}
out.println("</table>");
%>

</body>
</html>

