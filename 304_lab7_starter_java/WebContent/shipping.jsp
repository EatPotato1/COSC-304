<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<html>
<head>
<title>Shipping Details</title>
</head>
<body>

<h1>Shipping Details:</h1>




<tr><td>Address:</td><td><input type="address" name="address" size="20"></td></tr>
<tr><td>State:</td><td><input type="state" name="state" size="20"></td></tr>
<tr><td>Postal Code:</td><td><input type="postal" name="postal" size="20"></td></tr>
<tr><td>Country:</td><td><input type="country" name="country" size="20"></td></tr>
<input value="Submit" type="submit">

String address = request.getParameter("address");
String state = request.getParameter("state");
String postal = request.getParameter("postal");
String country = request.getParameter("country");

try{

getConnection();
String sql = "INSERT INTO shiptoAddress, shiptoState, shiptoPostalCode, shiptoCountry VALUES (?,?,?,?)";
con = DriverManager.getConnection(url, uid, pw);
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rst = pstmt.executeQuery();

if(rst.next()){

pstmt.setInt(1, address);
pstmt.setInt(2, state);
pstmt.setInt(3, postal);
pstmt.setInt(4, country);

}

}






%>

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>