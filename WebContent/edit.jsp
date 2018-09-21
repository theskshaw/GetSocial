<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
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
input[type=text], select {
    width: 100%;
    
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}
#tab{
	border: 1px solid green;
	border-spacing:20px;
	border-radius: 25px;
}

#tab{
	padding-top: 10px;
}
input[type=submit] {
    width: 100%;
    background-color: blue;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
input[type=submit]:hover {
    background-color: #45a049;
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
</style>
<body>
<%@page import="getdb.*,java.sql.*" %>
<%String uname=(String)session.getAttribute("uname"); %>
<%if(uname==null){ %>
	<ul id="list">
			<li><a href="home.jsp">Home</a></li>
		  	<li><a href="discuss.jsp">Discussion</a></li>
		  	<li><a href="login.html">Login</a></li>
	</ul>
	
	<br>
	<table align="center">
	<tr><td><p><h2>You're not logged in.</h2></p></td></tr>
	</table>
<%} %>
<% if(!(uname==null)){ %>
<ul id="list">
			<li><a href="home.jsp">Home</a></li>
		  	<li><a href="discuss.jsp">Discussion</a></li>
			<li><a class="active" href="#profile">Profile</a></li>
		    <li><a href="logout.jsp">Logout</a></li>
	</ul>
<%	
try{
	Connection cn=GetDatabase.getCn();
	
	//System.out.println(uname);
	String sql="select * from userdetails where username=?";
	PreparedStatement ps=cn.prepareStatement(sql);
	ps.setString(1,uname);
	ResultSet rs=ps.executeQuery();
	if(rs.next()){
%>	
	<br><br>
	<form action="Update">
		<table align="center" id="tab">
			<tr><td><h3 style="color: red;"><b>Username:</b></h3></td><td><%=rs.getString(1) %></td></tr>
			<tr><td><h3 style="color: red;"><b>Email Id:</b></h3></td><td><input type="text" name="eid" value=<%=rs.getString(2) %>></td></tr>
			<tr><td><h3 style="color: red;"><b>Full Name:</b></h3></td><td><input type="text" name="fname" value=<%=rs.getString(3) %>></td></tr>
			<tr><td colspan="2"><input type="submit" value="Update"></td></tr>
		</table>
	</form>
	<%} %>
	<% }catch(Exception e){
		System.out.println(e);}
		%>
<%} %>
		<br><br>
<div class="footer">
		<p>Developed by: WebTek Developers | Copyright: 2018 | <a href="login.html" style="color: yellow">www.getSocial.com</a></p>
	</div>
</body>
</html>