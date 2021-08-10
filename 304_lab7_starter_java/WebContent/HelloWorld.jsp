<%@ page import="java.sql.*" %>
<html>
<head>
<title>Hello World in JSP</title>
</head>
<body>

<% out.println("Hello World!"); 
long milis = System.currentTimeMillis();
java.sql.Date date = new java.sql.Date(milis);
out.println(date);
%>

</body>
</html>