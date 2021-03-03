<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/tableDefiniton.css" />
<link rel="stylesheet" type="text/css" href="CSS/General.css" />
<title>ourKart shopping to home</title>
<%

	System.out.println("Visite to myKart Home Page");
	if( session.getAttribute("currentMyKartSessionUser") == null )		{
		RequestDispatcher $disp = request.getRequestDispatcher("LogIn.html");
		$disp.forward(request, response);
		return;

	}
%>
</head>
<body>


<h1> Hello : <%=session.getAttribute("currentMyKartSessionUser") %></h1>
<center>
	<a class="hypLink" href="category.jsp"> Category List </a>
	<a class="hypLink" href="vendors.jsp"> Vendors </a>
	<a class="hypLink" href="products.jsp"> Product List </a>
	<a class="hypLink" href="listOfProducts.jsp"> Product Stock </a>
	<a class="hypLink" href="logOutServlet"> Log Out </a>
</center>
</body>
</html>