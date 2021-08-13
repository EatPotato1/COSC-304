<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
//make a connection
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

try (Connection con = DriverManager.getConnection(url, uid, pw);) {

	// TODO: Get order id 
	String orderID = request.getParameter("orderId");
	int oid = -1;
          
	// TODO: Check if valid order id

	try{
		oid = Integer.parseInt(orderID);
	}
	catch (Exception e){
		out.println("<h1>invalid Order ID, please return to the previous page and input a correct order ID</h1>");
		return;
	}

	String sql = "SELECT orderId FROM ordersummary where orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, oid);
	ResultSet validOID = pstmt.executeQuery();
	if (!validOID.next()){
		out.println("<h1>invalid Order ID, please return to the previous page and input a correct order ID</h1>");
		return;
	}
	

	// TODO: Start a transaction (turn-off auto-commit)
	con.setAutoCommit(false);



	// TODO: Create a new shipment record. getting shipment date
	long milis = System.currentTimeMillis();
	java.sql.Date date = new java.sql.Date(milis);

	// this isnt working right now, warehouse in DDL doesnt have any values
	String record = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES (?, 1)"; 
	
	pstmt = con.prepareStatement(record, Statement.RETURN_GENERATED_KEYS); 
	pstmt.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));	
	pstmt.executeUpdate();
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int shipmentid = keys.getInt(1);

	// TODO: For each item verify sufficient quantity available in warehouse 1.
	
	// TODO: Retrieve all items in order with given id
	// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
		
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

		while (iterator.hasNext())
		{ 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			String prodId = (String) product.get(0);
			int productId = Integer.valueOf(prodId);
			int qty = ((Integer)product.get(3)).intValue();
			
			//find warehouse information 
			sql = "SELECT productId, quantity FROM productinventory WHERE productId = ? AND warehouseId = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productId);
			ResultSet rst = pstmt.executeQuery();

			// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
			//iterate through the items for now
			while(rst.next()){

				if(qty > rst.getInt(2)) {
					out.println("<h1>there is insufficient inventory for product ID " + productId + "</h1>");
					return;
					con.rollback();
				} else{
					sql = "UPDATE warehouse SET quantity = (quantity - ?) WHERE productId = ? AND warehouseId = 1";
					pstmt = con.prepareStatement(sql, qty, rst.getInt(1));
					pstmt.executeUpdate();
				}

				String statement = "Ordered product: ? Qty: ? Previous inventory: ? New inventory: ?";
				pstmt = con.prepareStatement(statement, productId, rst.getInt(2), (rst.getInt(2) - qty));
				out.println("<h1>" + pstmt + "</h1>");
			}	
		}

		con.commit();
		// TODO: Auto-commit should be turned back on
		con.setAutoCommit(true);
		con.close();

}	
catch(SQLException ex){
	out.println(ex);
	con.rollback();
}	

%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
