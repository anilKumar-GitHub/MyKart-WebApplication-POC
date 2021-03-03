<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="sidePanel.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="CSS/homePageDesign.css" />
</head>
<body>
<div style="width: auto; height: auto; margin-left: 20%; margin-top: 50px;">
<%
	rs = db.execeteQuery("SELECT P.Vid, P.CID, P.Pid, P.PName, P.Quantity, P.Price, P.image, V.VName, C.CatName FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID JOIN CategoryMaster C ON C.CatID = P.CID AND P.Pid = '"+request.getParameter("prodId")+"'");

	rs.next();
	
	String vendId = rs.getString("Vid");
	
	String catId = rs.getString("CID");

	String pId = rs.getString("Pid");
%>
<div style="margin-left: 20px;">
	<div><div class="prodTitleDetails"><%=rs.getString("PName") %></div></div>

	<div class="imgDisplay" style="float: left; width:300px; height:400px;"><img src='Products/<%=rs.getString("image") %>' alt="<%=rs.getString("image") %>"  width="300px" height="400px" /></div>
	<div class="prodDetailTable">
	<table> 
		<tr><td><BR/><BR/></td></tr>	
		<tr><td colspan="2"><h2 style="color: #B358C5;"><%=rs.getString("PName") %></h2></td></tr>
		<tr><td colspan="2"><span style="color: black; font-size: 29px;"><%=rs.getString("CatName") %></span></td></tr>
		<tr><td><BR/></td></tr>	
		<tr><td><b>Company</b></td><td><%=rs.getString("VName") %></td></tr>
		<tr><td><b>Quantity</b></td><td><%=rs.getString("Quantity") %> pieces</td></tr>
		<tr><td><b>Rs : </b></td><td><%=rs.getString("Price") %> /- Only</td></tr>
		<tr><td><BR/><BR/></td></tr>	
	</table>
	
	<%
		boolean containFlag = false;
	
		if( session.getAttribute("curWishList") != null )	{
			containFlag = ((Set) session.getAttribute("curWishList")).contains(rs.getString("Pid"));
		}
		
		String path = new String();
		String linkName = new  String("Add To Cart");
		if(containFlag){
			path = "removeFromCartServlet?en=1&prodId="+rs.getString("Pid");
			linkName = "Remove From Cart";
		}else	{
			path = "addToCartServlet?prodId="+rs.getString("Pid"); 
			linkName = "Add To Cart";
		}
	%>
	
		<a href="<%=path %>"  class="purchasrOptions" style="	background: linear-gradient(to bottom,#f78828 0,#dd771f 100%)"><%=linkName %></a>
		<a class="purchasrOptions" style="background-color:  #7fbf4d;" href="removeFromCartServlet?prodId=<%=rs.getString("Pid")%>">Buy</a>

<!--    	<a href="addToCartServlet?prodId=<%=rs.getString("Pid")%>" class="purchasrOptions" style="	background: linear-gradient(to bottom,#f78828 0,#dd771f 100%)">Add To Cart</a>
<	<a class="purchasrOptions" style="background-color:  #7fbf4d;" href="removeFromCartServlet?prodId=<%=rs.getString("Pid")%>">Buy</a>
-->	</div>	
</div>
</div>
<div style="width: auto; height: auto; margin-left: 5%; margin-top: 150px;">
<div><div class="prodTitleDetails" style="background-color: #EEE; margin-left: -30px; margin-bottom: 30px; font-size:40px; margin-right:30px; border: 2px solid gray;  padding-left: 80px; border-radius:20px;">Related Products</div></div>	
<BR/>
<% 	

	rs.close();

	boolean res = false;
	
	int cnt = 0;

	rs = db.execeteQuery("SELECT * FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID AND CID = '"+catId+"' AND P.Vid = '"+vendId+"'");

	while(rs.next())	{

		if( pId.equals(rs.getString("Pid")))	continue;
		else	res = true;
	%>	
	<div class ="itemSpace">
		<a href="showProduct.jsp?prodId=<%=rs.getString("Pid")%>"><div class="imgClass"><img src="<%=rs.getString("image") %>" alt="<%=rs.getString("image") %>" width="150px;" height="200px" /></div></a>
		<div class="imgDes"><a href="showProduct.jsp?prodId=<%=rs.getString("Pid")%>"><%=rs.getString("PName") %></a>
		<div style="color: red"><%=rs.getString("VName") %></div>
		<div><b>Rs : </b> <%=rs.getString("Price") %> /- only</div>
		</div>
	</div>
	<%
	cnt++;
	}

	if( ! res || cnt < 5 )	{
		rs = db.execeteQuery("SELECT * FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID AND P.CID = '"+catId+"' AND P.Vid != '"+vendId+"'");

		while(rs.next())	{
		
			if( pId.equals(rs.getString("Pid")))	continue;
		%>	
		<div class ="itemSpace">
			<a href="showProduct.jsp?prodId=<%=rs.getString("Pid")%>"><div class="imgClass"><img src="Products/<%=rs.getString("image") %>" alt="<%=rs.getString("image") %>" width="150px;" height="200px" /></div></a>
			<div class="imgDes"><a href="showProduct.jsp?prodId=<%=rs.getString("Pid")%>"><%=rs.getString("PName") %></a>
			<div style="color: red"><%=rs.getString("VName") %></div>
			<div><b>Rs : </b> <%=rs.getString("Price") %> /- only</div>
			</div>
		</div>
		<%
		}
	}
	%>
	</div>
</body>
</html>


<style type="text/css">

.imgDisplay{
	width: 300px;
	height: 400px;
	box-shadow:0px 0px 10px 2px #ccc;
	cursor: pointer;
	display: inline-table;
}

.prodTitleDetails	{
	font-family: Courier New, arial, tahoma, verdana, sans-serif;
	font-style: italic;
	font-size: 50px;
	color: white;
	text-shadow:2px 3px 5px black, -5px -0px 5px black;
}
.prodTitleDetails:hover	{
	color: black;
	text-shadow:-5px -0px 5px black;
	cursor: pointer;
}

.prodDetailTable	{
	display: inline-table;
	font-family: Courier New, arial, tahoma, verdana, sans-serif;
	font-size: 55px;
	margin-left: 80px;
	color: red;
}
.prodDetailTable table tr td{
	font-size: 25px;
}

.prodDetailTable table tr td b{
	color: olive;
}

.purchasrOptions	{
	color:white;
	font-size: 25px;
	margin-left: 50px;
	padding: 10px 40px 10px 40px;
	text-decoration: none;
	border-radius: 10px;
	border: 2px solid blue;
	font-family: monospace;
	letter-spacing: 3px;
}
.purchasrOptions:hover	{
	color:black;
	background-color: #FFF;
}


</style>