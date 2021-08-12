<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
boolean hasParameter = false;
String sql = "";

if(name == null)
	name = "";

if(name.equals("")){
	out.println("<h2>All Products</h2>");
	sql = "SELECT productId, productName, productPrice, categoryName FROM Product JOIN category ON product.categoryId=category.categoryId";
		
}else{
	out.println("<h2>Products containing '" + name + "'</h2>");
	hasParameter = true;
	sql = "SELECT productId, productName, productPrice, categoryName FROM Product JOIN category ON product.categoryId=category.categoryId WHERE productName LIKE ?";
	name = '%' + name + '%';
}


//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}



// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try ( Connection con = DriverManager.getConnection(url, uid, pw);)
{	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	if(hasParameter)
		pstmt.setString(1, name);

	ResultSet rst = pstmt.executeQuery();	
	out.println("<table><tr><th> </th><th>Product Name</th><th>Category</th><th>Price</th></tr>");	
	while (rst.next())
	{		
		out.println("<tr><td><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2) + "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td><td><a href=\"product.jsp?id=" + rst.getInt(1) + "\">"+ rst.getString(2) + "</a></td><td>" +  rst.getString(4) + "</td><td>" +currFormat.format(rst.getDouble(3)) +"</td></tr>");

	}
	out.println("</table>");
	
}

catch (SQLException ex) 
{ 	out.println(ex); 
}

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>