<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
<style type="text/css">
ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow: hidden;
    background-color: #333;
}

li {
    float: left;
}

li a {
    display: block;
    color: white;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}
#list a{
	 	display:block;
		text-align:center;
		width:100px; /* fixed width */
		text-decoration:none;
	}
li a:hover {
    background-color: white;
    color: black;
}
.active{
	background-color: lightblue;
	color: black;
}
.footer {
	margin:0;
	padding:0;
	overflow: hidden;
   position: fixed;
   left: 0;
   bottom: 0;
   height: 7%;
   width: 100%;
   background-color: black;
   color: yellow;
   font-size: 15px;
   text-align: center;
}
a{
	text-decoration:none;
}
input[type=button] {
    width: 100%;
    background-color: blue;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
input[type=button]:hover {
    background-color: #45a049;
}
#mess{
	align: "center";
}
</style>
</head>
<body>
<%@page import="getdb.*,java.sql.*" %>
<%String u=(String)session.getAttribute("uname");
if(u==null){%>
	<ul id="list">
			<li><a href="home.jsp">Home</a></li>
		  	<li><a href="#discuss">Discussion</a></li>
			<li><a class="active" href="#profile">Profile</a></li>
	</ul>
	<br>
	<br>
	<div id="mess">
	<table align="center">
	<tr><td><p><h2>You're not logged in.</h2></p></td></tr>
	</table>
	</div>
<%} %>
<%if(!(u==null)){ %>
<ul id="list">
			<li><a href="home.jsp">Home</a></li>
		  	<li><a href="discuss.jsp">Discussion</a></li>
			<li><a class="active" href="#profile">Profile</a></li>
		    <li><a href="logout.jsp">Logout</a></li>
	</ul>
	<br>
	<br>
	<%
		try{
		Connection cn=GetDatabase.getCn();
		String uname=(String)session.getAttribute("uname");
		//System.out.println(uname);
		String sql="select * from userdetails where username=?";
		PreparedStatement ps=cn.prepareStatement(sql);
		ps.setString(1,uname);
		ResultSet rs=ps.executeQuery();
		if(rs.next()){
		%>
		
		<table align="center" colspan="2">
			<tr><td colspan="1"><h3>Username: </h3></td><td><h4><%=rs.getString(1) %></h4></td></tr>
			<tr><td colspan="1"><h3>Email Id: </h3></td><td><h4><%=rs.getString(2) %></h4></td></tr>
			<tr><td colspan="1"><h3>Full Name: </h3></td><td><h4><%=rs.getString(3) %></h4></td></tr>
			<tr><td align="center"><a href="edit.jsp"><input type="button" value="Edit"></a></td></tr>
		</table>
	<%}%>
		
	<%}catch(Exception e){
		out.println(e);}%>
<%} %>	
<div class="footer">
		<p>Developed by: WebTek Developers | Copyright: 2018 | <a href="login.html" style="color: yellow">www.getSocial.com</a></p>
	</div>
</body>
</html>