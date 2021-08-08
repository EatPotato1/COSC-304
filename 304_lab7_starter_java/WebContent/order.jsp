<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
int cid;
try{
cid = Integer.valueOf(custId);
} catch (NumberFormatException e){
	out.println("invalid customer Id, please go back a page and enter a correct ID");
}
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered

//if(cid < 0 || cid > 5 ){
//	out.println("incorrect customer Id, please enter a valid customer ID");
//	//determine if  there are products in shopping cart
//} else if (productList == null){
//	out.println("There are no items in your shopping cart");
//} else {
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

	// Save order information to database
	//Use retrieval of auto-generated keys.

	String sql = "INSERT INTO OrderSummary (orderId, customerId) VALUES (?, ?);";
	
	try
		{    // Load driver class
   		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

	}
	catch (java.lang.ClassNotFoundException e)
		{
    	out.println("ClassNotFoundException: " +e);
	}

	try(Connection con = DriverManager.getConnection(url, uid, pw); Statement stmt = con.createStatement();){
		PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		ResultSet keys = pstmt.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);
		double total = 0;
		// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				int productId = (Integer) product.get(0);
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
				total = total + pr*qty;
				sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES(?,?,?,?)";
				pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, orderId);
                pstmt.setInt(2, productId);
                pstmt.setInt(3, qty);
                pstmt.setString(4, price);
                pstmt.executeUpdate();

				ResultSet rst2 = pstmt.executeQuery();
				con.commit();	
			}
			out.println("</table>");
			sql = "UPDATE OrderSummary SET totalAmount = ? WHERE orderId = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setDouble(1, total);
            pstmt.setInt(2, orderId);
            pstmt.executeUpdate();
			out.println("<h1>Order Completed. Will be shipped soon...</h1>");

}

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
//}
%>
</BODY>
</HTML>

