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
<title>Create User</title>
</head>
<body>
</body>


<h1>User Information</h1>

    
    <div class="form-header">First Name:</div>
    <input  type="search" class="form-input" id="firstname" ></input>
    
    <div class="form-header">Last Name:</div>
    <input type="text" class="form-input" id="state"></input>
    
    <div class="form-header">Email:</div>
    <input class="form-input" id="postal"></input>
    
    <div class="form-header">Username</div>
    <input class="form-input" id="id"></input>

    <div class="form-header">Password</div>
    <input class="form-input" id="password"></input>


  
    <input class="btn" type="submit" name="next" value="NEXT">
    
  </form>


<%

String firstname = request.getParameter("firstname");
String lastname = request.getParameter("lastname");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String id = request.getParameter("id");
String password = request.getParameter("password");


String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, userid, password VALUES (?,?,?,?,?,?,?)";



try{
    getConnection();
    PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    ResultSet rst = pstmt.executeQuery();
    
    rst.next();
    pstmt.setString(1, firstname);
    pstmt.setString(2, lastname);
    pstmt.setString(3, email);
    pstmt.setString(4, phone);
    pstmt.setString(5, id);
    pstmt.setString(6, password);

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