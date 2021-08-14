<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Date" %>


<html> 
<head> 
<title>Write a review</title>
</head>
<body>
<%@ include file="header.jsp" %>


<%
String sql = ""; 
String userID = session.getAttribute("cid");
cid = Integer.valueOf(userID);

String productID = session.getAttribute("PID");
int pid = Integer.valueOf(productID);


String Review = request.getParameter("review");
int rv = -1;
try{
    rv = Integer.valueOf(productID);
} catch (Exception e){
    out.println("<h1>Invalid range. Please return to the previous page and input a value between 1-10</h1>");
    return;
}  

if(rv < 0){
       out.println("<h1>Invalid range. Please return to the previous page and input a value between 1-10</h1>");
       return;
}else if(rv > 10){
    out.println("<h1>Invalid range. Please return to the previous page and input a value between 1-10</h1>");
    return;
}

String reviewcomment = request.getParameter("reviewComment");

try               
{
    sql = "SELECT customerId, productId FROM review WHERE customerId = ? AND productId = ?";
	getConnection();
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, cid);
    pstmt.setInt(2, pid);

    resultSet rst = pstmt.executeQuery();
    if(rst.next()){
        out.println("<h1>You have already submitted a review for this product</h1>");
        return;
    }
}
catch (SQLException ex)
{       out.println(ex);
}
finally
{
	closeConnection();
}

sql = "INSERT INTO review(reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?, ?, ?, ?, ?)";

try               
{
	getConnection();
    PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    pstmt.setInt(1, rv);
   	pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
    pstmt.setInt(3, cid);
    pstmt.setInt(4, pid);
    pstmt.setString(5, reviewcomment);
    pstmt.executeUpdate();

} 
catch (SQLException ex)
{       out.println(ex);
}
finally
{
	closeConnection();
}
%>

<h1>Your review has been submitted!</h1>



</body>
</html>    