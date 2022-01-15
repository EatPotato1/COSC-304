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
</body>


<h1>Shipping Details:</h1>

    
    <div class="form-header">Address Line</div>
    <input  type="search" class="form-input" id="address" placeholder="Search address here..."></input>
    
    <div class="form-header">State</div>
    <input type="text" class="form-input" id="state"></input>
    
    <div class="form-header">Postal Code</div>
    <input class="form-input" id="postal"></input>
    
    <div class="form-header">Country</div>
    <input class="form-input" id="country"></input>
  
    <input class="btn" type="submit" name="next" value="NEXT">
    
  </form>



<%
String reviewcomment = request.getParameter("customerId");
cid = Integer.valueOf(userID);
String address = request.getParameter("address");
String state = request.getParameter("state");
String postal = request.getParameter("postal");
String country = request.getParameter("country");

String sql = "INSERT INTO ordersummary (shiptoAddress, shiptoState, shiptoPostalCode, shiptoCountry, customerId) VALUES (?,?,?,?,?)";

try{
getConnection();
PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
ResultSet rst = pstmt.executeQuery();

rst.next();
pstmt.setString(1, address);
pstmt.setString(2, state);
pstmt.setString(3, postal);
pstmt.setString(4, country);
pstmt.setInt(5, cid);
pstmt.executeUpdate();
}

catch (SQLException ex) {
	out.println(ex);
}
finally
{
	closeConnection();

}
%>


