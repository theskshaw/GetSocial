<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Discussion</title>
</head>
<style>
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
#tab{
	border: 1px solid green;
	border-spacing:20px;
	border-radius: 25px;
	width: 80%;
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
<%
	String uname=(String)session.getAttribute("uname");
%>
<ul id="list">
			<li><a href="home.jsp">Home</a></li>
		  	<li><a class="active" href="discuss.jsp">Discussion</a></li>
		  	<%if(!(uname==null)){ %>
			<li><a href="profile.jsp">Profile</a></li>
		    <li><a href="logout.jsp">Logout</a></li>
		    <%} %>
	</ul>
<br>
<%if(uname==null){ %>
	<table align="center">
		<tr><td colspan="2" align="center"><h3>Login to post queries. <a href="login.html"><i>Login Here</i></a></h3></td></tr>
	</table>
<%} %>
<%if(!(uname==null)){ %>
<form action="Post" >
<table align="center">
	<tr><td><textarea name="message" style="width:100%; height:100px;" placeholder="Write Something here.."></textarea></td></tr>
  	<br>
  	<tr><td align="center"><input type="submit" value="Post" accesskey="s"></td></tr>
  </table>
</form>
<%} %>
<%	
	Connection cn=GetDatabase.getCn();
	String sql="select * from discuss";
	PreparedStatement ps=cn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs=ps.executeQuery();
	rs.afterLast();
	while(rs.previous()){
		%>
	<br>
	<table align="center" id="tab">
		<tr><td><b>Posted by:</b> <%=rs.getString(1) %><br><b>On:</b> <%=rs.getString(3) %></td></tr>
		<tr><td colspan="2" align="center"><hr></td></tr>
		<tr><td><%=rs.getString(2) %></td></tr>
		<br>
	</table>
	<%} rs.close(); %>
	<br>
<br>
<br>
<br>
<div class="footer">
		<p>Developed by: WebTek Developers | Copyright: 2018 | <a href="home.jsp" style="color: yellow">www.getSocial.com</a></p>
	</div>
</body>
</html>