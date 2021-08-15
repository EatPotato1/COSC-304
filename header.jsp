<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {box-sizing: border-box;}
body { 
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
}
.header {
  overflow: hidden;
  background-color: #5cc01f;
  padding: 20px 10px;
}
.header a {
  float: left;
  color: white;
  text-align: center;
  padding: 12px;
  text-decoration: none;
  font-size: 18px; 
  line-height: 25px;
  border-radius: 4px;
}
.header a.logo {
  font-size: 25px;  
  font-weight: bold;
}
.header a:hover {
  background-color: rgb(255, 255, 255);
  color: rgb(22, 211, 54);
}
.header a.active {
  background-color: rgb(247, 247, 247);
  color: rgb(34, 161, 87);
}
.header-right {
  float: right;
}
@media screen and (max-width: 500px) {
  .header a {
    float: none;
    display: block;
    text-align: left;
  }
  
  .header-right {
    float: none;
  }
}
</style>
</head>
<body>
    

<div class="header">
  <a href="shop.html" class="logo">Krocs</a>
  <div class="header-right">

    <%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
    %>
  </div>
</div>

</body>
</html>