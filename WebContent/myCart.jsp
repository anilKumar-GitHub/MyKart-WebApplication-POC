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
		<%
		Set<String> arr = new HashSet<String>();
		String s[] = new String[1];
		if( session.getAttribute("curWishList") != null )	{
			arr = (Set)session.getAttribute("curWishList");			
			s = new String[arr.size()];
			Iterator it = arr.iterator();
			int i = 0;
			while( it.hasNext() )	{
				s[i] = (String)it.next();	
				i++;
			}
		}
		
		%>
<body>

<div style="width: auto; height: auto; margin: 0% 8% 10% 5%;">
	
		<div class="tabPaenl">myCart <div><%=cartSize %></div></div>
		<a href="indexOfmyKart.jsp?en=2&catType=1"><div class="tabPaenl" style="height: 30px;">Continue Shopping</div></a>

	<!-- 
		<div class="tabPaenl" style="height: 30px;" onclick="orderForm.submit()">Place Order</div>		
	 -->
		<div class="tabPaenl" style="height: 30px;" <%if( cartSize > 0 )	{ %>onclick="orderForm.submit()" <%} %>>Check Out</div>
				
		<hr style="margin-top: -3px; height: 2px; background-color: #B358C5"/>		

	<form action="placeOrderRedirectServlet" id="orderForm" method="get">
	<table width="100%">
	<tr class="tableHead"><th></th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Delivery Details</th><th>SubTotal</th><th></th></tr>
<% 
		if( arr.size() == 0 )	{			
		%>
			<tr class="mainDiv"><td></td><td class="prodNameDiv" colspan="6" align="center" valign="middle" height="50px;">Cart is empty</td></tr>
		<%			
		}

		Double totalCostEstimated = 0.0;

		if( arr.size() != 0)	{
			ResultSet rs = db.execeteQuery("SELECT P.Vid, P.CID, P.Pid, P.PName, P.Quantity, P.Price, P.image, V.VName, C.CatName FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID JOIN CategoryMaster C ON C.CatID = P.CID AND P.Pid in("+db.arrayToString(s)+")");
			while(rs.next())	{
				totalCostEstimated = totalCostEstimated + Double.parseDouble(rs.getString("Price"));
%>			<!-- color: E8E8E8 -->
			<tr class="mainDiv">
				<td width="10%"><div class="imageDiv"><img src="Products/<%=rs.getString("image") %>" alt="<%=rs.getString("image") %>" width="100px;" height="120px" /></div></td>
				<td width="36%"><div class="prodNameDiv"><%=rs.getString("PName") %>
					<div>Seller : <%=rs.getString("VName") %></div>
					<div>Product : <%=rs.getString("CatName") %></div>
					<div><BR/></div>
					<div>Delivered within 10 day's</div>
					</div>
				</td>
					
			<td><div class="qntDiv"><input type="number" name="<%=rs.getString("Pid") %>" id="<%=rs.getString("Pid") %>" value="1" min="1"  max="<%=rs.getString("Quantity") %>" onkeyup="calculateEstimateCost('<%=rs.getString("Pid") %>')" onchange="calculateEstimateCost('<%=rs.getString("Pid") %>')" onblur="if(<%=rs.getString("Pid") %>.value == '' || isNaN(<%=rs.getString("Pid") %>.value) ) <%=rs.getString("Pid") %>.value = '1'; calculateEstimateCost('<%=rs.getString("Pid") %>')"  /></div></td>
			<td width="10%">
				<div class="priceDiv"><b>Rs. </b><div id="<%=rs.getString("Pid") %>Price"  style="display: inline-table;"><%=rs.getString("Price") %></div>only /- </div>
		</td>
		<td>	<% String tax = String.format("%9.5f", Float.parseFloat(rs.getString("Price"))*.05); %>
			<div class="delDiv">Free<div>Delivered in 2-3 <br/> business days.<br/>Including 5% Tax <br/>Tax Rs.<%=tax%> </div></div></td>
		<td><div class="subTotalDiv">
			<b>Rs. </b>
				<div style="display: inline-table;" name="subCost" id="<%=rs.getString("Pid") %>SubTotal"><%= Double.parseDouble(rs.getString("Price")) + (Double.parseDouble(rs.getString("Price"))*.05) %></div>
			</div>
		</td>
		<td><div class="deleteDiv"><a href="removeFromCartServlet?en=2&prodId=<%=rs.getString("Pid") %>" >X</a></div></td>
		
		</tr>
		<tr ><td colspan="7"><hr style="margin-top: -5px; margin-bottom: -20px;"/></td></tr>
		<input type="hidden" value="<%=rs.getString("Quantity") %>" id="<%=rs.getString("Pid") %>MaxQuatity" />
		<%	} 
	}%>
	<tr class="tableHead"><th colspan="5" align="right">Total Estimated Cost : <b>Rs</b></th><th align="right"><div style="display: inline-table;" id="totalCost"><%=totalCostEstimated %></div> /- only</th><th></th></tr>
	</table>
	</form>
</div>
</body>
</html> 



<script type="text/javascript">

var preValue = 1;

function calculateEstimateCost(id)	{

//	alert(document.getElementById(id+"MaxQuatity").value);
	
	if( parseInt(document.getElementById(id).value) > parseInt(document.getElementById(id+"MaxQuatity").value))  {
		
		document.getElementById(id).value = preValue;
		
		alert("Out of Stock : Maximum Available Quantity is "+document.getElementById(id+"MaxQuatity").value+" pieces only");
	}
	
	if( parseInt(document.getElementById(id).value) <= 0 )	document.getElementById(id).value = "1";

	var subTotal = 0.0;
 	if( document.getElementById(id).value == "" )	
 		subTotal = 1 * parseFloat(document.getElementById(id+"Price").innerHTML);
	else	subTotal = parseInt(document.getElementById(id).value ) * parseFloat(document.getElementById(id+"Price").innerHTML);

 	document.getElementById(id+"SubTotal").innerHTML = subTotal + ( subTotal * .05);

	var totalCost = 0;
	for(var i = 0; i < document.getElementsByName("subCost").length; i++ )		{
			
//		alert(document.getElementsByName("subCost").item(i).innerHTML);
		
		totalCost = totalCost + parseFloat(document.getElementsByName("subCost").item(i).innerHTML);
		
//		alert(totalCost);
	}
	document.getElementById("totalCost").innerHTML = totalCost;
	
	preValue = parseInt(document.getElementById(id).value );
}

</script>