<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
// TODO: Include files auth.jsp and jdbc.jsp
<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>

%>


<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%

// TODO: Write SQL query that prints out total order amount by day

NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String sql = "Select orderDate, sum(totalAmount) From ordersummary group by orderDate";
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rst = pstmt.executeQuery();
out.println("<h3>Administrator Sales Report by Day</h3>");
out.println("<table><tr><th>orderDate</th><th>Total_amount_per_day</th></tr>");
// while(rst.next()) {
//    out.println("<tr><td>"+rst.getDate(1)+"</td><td>"+currFormat.format(rst.getDouble(2))+"</td></tr>");
// }
catch (SQLException ex)
	{
		System.out.println("SQLException: " + ex);
	}	
    
    out.println("</table>");


%>

</body>
</html>

