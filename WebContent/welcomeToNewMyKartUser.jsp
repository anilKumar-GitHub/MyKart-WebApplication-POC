<%@page import="dataModel.myKartDataBaseOperations"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<style>

.welcomeSpace	{
	border: 1px solid #ccc;
	box-shadow:0px 0px 10px 5px #333;
	margin: 150px 100px 100px 120px;
	width: 1060px;
	height: 400px; 
}
.welcomeSpace div{
	width: 400px;
	height: 400px;
	display: inline-table;
	float: left;
}
.welcomeSpace div img{
	width: 400px;
	height: 400px;
}
.welcomeMSG	{
	padding: 20px 10px 0px 50px;
}
.welcomeMSG	h1{
	color:#333;
	text-align: center;
}
.welcomeMSG	h2{
	color: #333;
}
.welcomeMSG	h2 a{
	text-decoration: none;	
}
</style>
<body>


<%
		ResultSet rs = ((myKartDataBaseOperations)application.getAttribute("objectHandler")).execeteQuery("SELECT * FROM myKartUser WHERE Email = '"+request.getParameter("email")+"'");

		if( rs.next() )		{
			
%>
<div class="welcomeSpace">
	<div>
			<img  src="images/myKartUserPics/<%=rs.getString("image")%>">	
	</div>
	<div class="welcomeMSG" style="width: 600px;">
		<h1><%=rs.getString("Name") %></h1>
		<h1>Wel Come To Our Kart</h1>
		<h1><%=rs.getString("Email") %></h1>
		<h1>Phone Number : <%=rs.getString("PhoneNum") %></h1>
		<H1><br/></H1>
		<h2><a href="redirectToLogin?email=<%=rs.getString("Email") %>" >Continue without Log-in</a> | <a href="cartUserLogin.jsp" />Continue with Log-in</a> | <a href="indexOfmyKart.jsp?en=2&catType=1" >Home</a> </h2>
		<h2 align="center"></h2>
	</div>
</div>
<% } %>

<div  class="welcomeImg">
	<img src="images/myKartUserPics/kotti2.jpg">
	<img src="images/myKartUserPics/kotti2.jpg" class="showImage">
</div>
<div  class="welcomeImg1"><img src="images/myKartUserPics/kotti2.jpg"></div>
<div  class="welcomeImg2"><img src="images/myKartUserPics/kotti2.jpg"></div>
<div  class="welcomeImg3"><img src="images/myKartUserPics/kotti2.jpg"></div>

</body>
</html>

<style>

.welcomeImg	{
	
	position: absolute;
	right: 120px;
	top: 120px;
	box-shadow:0px 0px 5px 5px #eee;
	border-radius:100px; 
	z-index: 100;
	cursor: pointer;
}
.welcomeImg	img{
	width: 120px;
	height: 120px;	
	box-shadow: inset 0px 0px 10px 10px #ccc;
	border-radius:100px; 
}

.welcomeImg1	{
	
	position: absolute;
	right:20px;
	top: 50px;
	box-shadow:0px 0px 5px 5px #eee;
	border-radius:100px; 
}

.welcomeImg1	img{
	width: 50px;
	height: 50px;	
	box-shadow: inset 0px 0px 10px 10px #ccc;
	border-radius:100px; 
}

.welcomeImg2	{
	position: absolute;
	right: 43px;
	top: 100px;
	box-shadow:0px 0px 5px 5px #eee;
	border-radius:100px; 
}

.welcomeImg2	img{
	width: 80px;
	height: 80px;	
	box-shadow: inset 0px 0px 10px 10px #ccc;
	border-radius:100px; 
}

.welcomeImg3	{
	position: absolute;
	right: 10px;
	top: 10px;
	box-shadow:0px 0px 5px 5px #eee;
	border-radius:100px; 
}

.welcomeImg3 img{
	width: 30px;
	height: 30px;	
	box-shadow: inset 0px 0px 10px 10px #ccc;
	border-radius:100px; 
}
.showImage	{
	display: none;
}
.welcomeImg:hover .showImage	{
	display:inline;
	width: 660px;
	height: 402px;	
	box-shadow: inset 0px 0px 10px 10px #ccc;
	border-radius:0px; 
	position: absolute;
	top: 30px;
	left:-596px; 
	z-index: 0;
	border-radius:0px 220px 0px 0px;
}
</style>