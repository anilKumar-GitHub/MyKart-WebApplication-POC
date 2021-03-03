<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="listOption.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="CSS/homePageDesign.css" />
<link rel="stylesheet" type="text/css" href="CSS/cartDesign.css" />
</head>
<body>
<div style="width: auto; height: auto; margin: 0% 8% 10% 5%;">
	
	<a href="myCart.jsp"><div class="tabPaenl">myCart <div><%=cartSize %></div></div></a>
	
	<a href="indexOfmyKart.jsp?en=2&catType=1"><div class="tabPaenl" style="height: 30px;">Continue Shopping</div></a>
	<div class="tabPaenl" style="color:#B358C5; background-color: white; border-color:#B358C5; border-bottom-color: white; border-bottom-width: 5px;">Order Placed Successfully</div>
			
	<hr style="margin-top: -3px; height: 2px; background-color: #B358C5"/>		
	<%
		ResultSet rs = ((myKartDataBaseOperations)application.getAttribute("objectHandler")).execeteQuery("SELECT * FROM DeliveredProductList WHERE OrderNo='"+session.getAttribute("lastTransactionTokenId")+"'");
	
		Map<String, Integer> prodList = new HashMap<String, Integer>();
		String str = new String();
		while( rs.next() )	{
			prodList.put(rs.getString("ProdId"), rs.getInt("Quantity"));
			str = str+"'"+rs.getString("ProdId")+"',";
		}
		rs.close();
		str = str.substring(0,str.lastIndexOf(","));
	
		Double cost = 0.0;	 
%>		
	<% 	
		rs = ((myKartDataBaseOperations)application.getAttribute("objectHandler")).execeteQuery("SELECT * FROM ProductMaster P JOIN  VendorMaster V ON P.Vid = V.VID WHERE P.Pid IN ("+str+")");
	%>
	<table width="100%">
	<tr class="tableHead"><th width="6%">Sl No</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Tax</th><th>Total</th></tr>
	<% 
		double totalCost = 0.0;
		int i = 1;
		while( rs.next() )	{
			totalCost = totalCost + rs.getFloat("Price") + ( rs.getFloat("Price") * .05 );
	%> 
	<tr class="mainDiv"><td align="center"><%=i++ %></td><td><div style="display: inline-table; float: left;"><%=rs.getString("PName") %></div><div style="direction: rtl;"><%=rs.getString("VName") %></div></td><td width="10%" align="center"><%=prodList.get(rs.getString("Pid"))%></td><td><div style="display: inline-table; float: left;">Rs</div><div style="direction: rtl;"><%=rs.getString("Price") %></div></td><td align="right" width="20%"><%=rs.getString("Price") %> + <%=String.format("%5.2f",rs.getFloat("Price")*.05) %> tax 5%</td><td align="right" width="20%" style="padding-right: 20px;"><div style="display: inline-table; float: left;">Rs.</div> <%=rs.getFloat("Price") + (rs.getFloat("Price") * .05) %></td></tr>	
	<% } 
	
		cost = totalCost;
	%>
	<tr class="tableHead"><th colspan="5" align="right">Total Price</th><th align="right"><div style="display: inline-table; float: left;">Rs. </div> <%=totalCost %> Only/-</th></tr>
	</table>
	<%
		rs = ((myKartDataBaseOperations)application.getAttribute("objectHandler")).execeteQuery("SELECT * FROM DeliveryDetail WHERE OrderNo = '"+session.getAttribute("lastTransactionTokenId")+"'");
	
	//response.setContentType("application/ms-word");
	
	if( ! rs.next() ) return;

	%>		
	<div class="billDiv">	
		<div class="billDetails" style="width: 350px;">
		<h1>Shipping Address</h1>
			<%=rs.getString("CustName") %><br/>
			<%=rs.getString("Address") %><br/>
			<%=rs.getString("City") %>  -  <%=rs.getString("PinCode") %><br/>
			<%=rs.getString("State") %> - India <br/>
			Phone No : <%=rs.getString("PhNo") %>.
		</div>
		<div class="billDetails" style="margin-left: 10px; width: 360px;">
		<h1>Account Details</h1>
		M O Payment : <%=rs.getString("MOP")%><br/>
		<% if( rs.getString("MOP").equals("Cash On Delivery")) 	{ %>	
			Product will be delivered shortly. <br/>
			Be ready with money...!<br/>
			Total Cost : <%=cost %>
		<%}else if(rs.getString("MOP").equals("Credit Card"))	{ %>
			Credit Card No : <%=rs.getString("CardNo") %><br/>
			<div style="text-decoration: underline;"><%=rs.getString("Bank") %></div>	<br/>
			<%
				Float bal = (float)(Math.random()*1000000);
			%>
			Availble Bal : <%=bal %><br/>
			Total Amount : <%=cost %><br/>
			Current Bal : <%=(bal-cost) %><br/>
		<%}else if(rs.getString("MOP").equals("Debit Card"))	{ %>
		Debit Card No : <%=rs.getString("CardNo") %><br/>
		Frm : <%=rs.getString("Bank") %>	<br/>
		<%
		Float bal = new Float(0.0);
			if( cost > 1000 && cost < 100000)
				bal = (float)(Math.random()*100000);
			else 
				bal = (float)(Math.random()*10000000);
		%>
		Availble Bal : <%=bal %><br/>
		Total Amount : <%=cost %><br/>
		Current Bal : <%=(bal-cost) %><br/>
	<%} %>		
	</div>
	
	<div class="billDetails"  style="margin-left: 50px; width: 350px; font-size: 22px;">
		<h1>Delivery Details</h1>
		<div style="color:black; font-weight: bold; text-decoration:underline; cursor: pointer;">Track Id : <%=session.getAttribute("lastTransactionTokenId") %></div>
		Delivered within 3-5 working days! <br/>
		<% if ( cost > 10000 && cost < 100000 ) {
		%>
			Shipping Charge is Rs.1000 /-
		<% }if( cost > 100000 )	 {%>
			
			Shipping Charge is Rs. <%=cost/1000 %> only /-
		<%} %>	
		<div style="font-size: 20px; color:green; font-weight: bold;">Free service if cost is below Rs.10000.</div>
		<div style="font-size: 18px; color: orange; font-weight: bold;">
			Help Line : +91-9060544890.<br/>
			Customer Care : 8800 8081 1221<br/>
		</div>
		<div style="font-size: 18px; color: blue; font-weight: bold;">
			Email Us : anilkumar@vayu.com<br/>
			Visit Us @ <a href="#">www.ourKart.com</a>
		</div>
	</div>
	
	</div>	
</div>
</body>
</html>


<style>

.billDiv	{

	width: auto;
	height: auto;
	margin-left: 30px;
}
.billDiv div	{
	float:left;
	width: auto;
	height: auto;
}

.billDetails	{

	font-size: 25px;
	color: #333;
	line-height: 40px;
}

.billDetails h1{
	font-size: 35px;
	color: rgba(196, 131, 224, 1);
	cursor: pointer;
}
</style>