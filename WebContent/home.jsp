<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
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
input[type=file], select {
    width: 100%;
    padding: 12px 20px;
    margin: 8px 0;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
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
</head>
<body>
<%@page import="getdb.*,java.sql.*" %>
<%
	String uname=(String)session.getAttribute("uname");
	//out.println(uname);
	if(uname==null){
%>
	<ul id="list">
		  <li><a class="active" href="#home">Home</a></li>
		  <li><a href="discuss.jsp">Discussion</a></li>
		  <li><a href="login.html">Login</a></li>
	</ul>
<%} %>
<%
	if(!(uname==null)){
		%>
		<ul id="list">
			<li><a class="active" href="#home">Home</a></li>
		  	<li><a href="discuss.jsp">Discussion</a></li>
			<li><a href="profile.jsp">Profile</a></li>
		    <li><a href="logout.jsp">Logout</a></li>
	</ul>
	<br>
	<form action="Upload" method="post" enctype="multipart/form-data">
		<table align="center">
			<tr>
			<td>Select:</td><td><input type="file" name="photo" multiple></td>
			</tr>
			<tr>
			<td colspan="2" align="center"><input type="submit" value="Upload"></td>
			</tr>
		</table>
	</form>
	<%} %>
	
	<%
		try{
		Connection cn=GetDatabase.getCn();
		String sql="select * from images";
		PreparedStatement ps=cn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs=ps.executeQuery();
		rs.afterLast();
		String loc="";
		String up="";
		while(rs.previous()){
			loc=rs.getString(3);
			loc="D:/photo/"+loc;
			up=rs.getString(2);
	%>
		<table align="center">
			<tr>
			<td>
			<b>Posted By:</b> <%=up %>
			</td>
			</tr>
			<tr>
			<td colspan="2"><hr></td>
			</tr>
			<tr>
			<td><img src=<%=loc %> style="width:550px;height:400px;"></td><br>
			</tr>
			<tr><td colspan="2" align="center"><h3><u>Comments<u></u></h3></td></tr>
		</table>
	<%
		String sql1="select * from comm where imgid=?";
		
		PreparedStatement ps1=cn.prepareStatement(sql1,ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ps1.setString(1, rs.getString(1));
		ResultSet rs1=ps1.executeQuery();
		
		//rs1.afterLast();
		while(rs1.next()){
			%>	
			
		<table align="center">
			<tr><td><b><%=rs1.getString(3) %></b>:</td>
			<td><%=rs1.getString(2) %><br></td></tr>
			<tr>
			<td colspan="2"><hr></td></tr>
		</table>		
		<%} %>
		<%if(!(uname==null)) {%>
		<form action="Comment">
			<table align="center">
				<tr><td><input type="text" name="com">
				<input type="hidden" name="imgid" value=<%=rs.getString(1) %>>
				<input type="submit" value="Comment" >
				</td>
				</tr>
			</table>
		</form>
		<%} %>
		<hr>
	<%} %>
	<%}catch(Exception e){
		System.out.println(e);}%>
	<br><br><br>
	<div class="footer">
		<p>Developed by: WebTek Developers | Copyright: 2018 | <a href="login.html" style="color: yellow">www.getSocial.com</a></p>
	</div>
</body>
</html>