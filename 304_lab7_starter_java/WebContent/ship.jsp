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

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

try (Connection con = DriverManager.getConnection(url, uid, pw);) {

	// TODO: Get order id atm just set to 1 for testing purposes still needs to be implemented to have oid not be just 1
	int oid = 1;
          
	// TODO: Check if valid order id
	String sql = "SELECT orderId FROM ordersummary where orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, oid);
	ResultSet validOID = pstmt.executeQuery();
	if (!validOID.next()){
		out.println("invalid Order ID, please return to the previous page and input a correct order ID");
		return;
	}
	

	// TODO: Start a transaction (turn-off auto-commit)
	con.setAutoCommit(false);

	// TODO: Retrieve all items in order with given id
	//sql = "SELECT "

	// TODO: Create a new shipment record. getting shipment date
	long milis = System.currentTimeMillis();
	java.sql.Date date = new java.sql.Date(milis);

	String record = "INSERT INTO shipment (warehouseId) VALUES (?)";
	pstmt = con.prepareStatement(record, Statement.RETURN_GENERATED_KEYS); // this isnt working right now, 
	pstmt.setInt(1, 1);
	pstmt.executeUpdate();
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int shipmentid = keys.getInt(1);
	out.println(shipmentid);

	// TODO: For each item verify sufficient quantity available in warehouse 1.
	//shipment = "UPDATE shipment SET shipmentDate = ?, warehouseID = 1 WHERE shipmentId = ?";
	
	//getting the current date
	

	//pstmt = con.prepareStatement(shipment, date, shipmentid);

	// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

		while (iterator.hasNext())
		{ 
			Map.Entry<String, ArrayList<Object>> entry = iterator.next();
			ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
			int productId = (int)product.get(0);
			String price = (String) product.get(2);
			double pr = Double.parseDouble(price);
			int qty = ((Integer)product.get(3)).intValue();
			
			//find warehouse information 
			sql = "SELECT productId, quantity FROM productinventory WHERE productId = ? AND warehouseId = 1";
			pstmt = con.prepareStatement(sql, productId);
			ResultSet rst = pstmt.executeQuery();

			// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
			//iterate through the items for now
			while(rst.next()){

				if(qty > rst.getInt(2)) {
					out.println("there is insufficient inventory for product ID " + productId);
					return;
				}

				String statement = "Ordered product: ? Qty: ? Previous inventory: ? New inventory: ?";
				pstmt = con.prepareStatement(statement, productId, qty, rst.getInt(2));
				out.println(pstmt);
			}	
		}

	
		// TODO: Auto-commit should be turned back on
		con.setAutoCommit(true);

}	
catch(SQLException ex){
	out.println(ex);
	//con.rollback();
}	


%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
