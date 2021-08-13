<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver

String sql = "SELECT orderId, O.customerId, totalAmount, firstName + ' ' + lastName, orderDate FROM ordersummary O JOIN customer C ON (O.customerId = C.customerId)";
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

try (Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();)

{
	ResultSet rst = stmt.executeQuery(sql);
	out.println("<table border=\"1\"><tr><td>Order Id</td><td>Order Date</td><td>Customer Id</td><td>Customer Name</td><td>Total Amount</td></tr>");


	sql = "SELECT O.productId, O.quantity, (P.productPrice * O.quantity) FROM OrderProduct O JOIN product P ON (O.productId = P.productId) WHERE orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	while(rst.next()){
		int orderId = rst.getInt(1);
		out.print("<tr><td>" + rst.getInt(1) + "</td>");
		out.print("<td>" + rst.getString(5) + "</td>");
		out.print("<td>" + rst.getInt(2) + "</td>");
		out.print("<td>" + rst.getString(4) + "</td>");
		out.print("<td>" + currFormat.format(rst.getDouble(3)) + "</td>");
		out.println("</tr>");

		pstmt.setInt(1, orderId);
		ResultSet rst2 = pstmt.executeQuery();

		out.println("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">");
		out.println("<th>Product Id</th> <th>Quantity</th> <th>Price </th></tr>");
		
		while(rst2.next()){
			out.print("<tr><td>" + rst2.getInt(1) + "</td>");
			out.print("<td>" + rst2.getInt(2) + "</td>");
			out.print("<td>" + currFormat.format(rst2.getDouble(3)) + "</td></tr>");

		}
		out.println("</table></td></tr>");
	}
	out.println("</table>");
	}

	catch(SQLException ex){
		out.println(ex);
	}




// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

