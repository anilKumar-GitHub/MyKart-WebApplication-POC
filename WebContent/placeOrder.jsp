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
<script type="text/javascript" src="JavaScript/jquery-2.1.4.js"></script>
<% 		
		if( session.getAttribute("myKartLoginUser") == null )	{
			
			response.sendRedirect("indexOfmyKart.jsp");
		}		
		if( session.getAttribute("curWishList") == null )	{
			response.sendRedirect("myCart.jsp");
		}
		if( session.getAttribute("curWishList") != null )	{
			if(((Set)session.getAttribute("curWishList")).size() < 1 )
			response.sendRedirect("myCart.jsp");
		}
%>
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
<body style="padding-bottom: 100px">
<form action="editmyCart.jsp" id="myCart">
<h1 class="shippingDiv" id="prodInf">Product Information</h1>
<div style="width: auto; height: auto; margin: 0% 8% 10% 5%;">
	
		<div class="tabPaenl" onclick="myCart.submit()">edit myCart <div><%=cartSize %></div></div>
		<a href="indexOfmyKart.jsp?en=2&catType=1"><div class="tabPaenl" style="width: 200px; height: 30px;">Continue Shopping</div></a>
		<hr style="margin-top: -3px; height: 2px; background-color: #B358C5"/>		

	<table width="100%">
	<tr class="tableHead"><th></th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Delivery Details</th><th>SubTotal</th></tr>
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
			
			totalCostEstimated = totalCostEstimated + Double.parseDouble(rs.getString("Price")) * Integer.parseInt(request.getParameter(rs.getString("Pid")));
%>	
		<tr class="mainDiv">
			<td width="10%"><div class="imageDiv"><h1></h1></div></td>
			<td width="36%"><div class="prodNameDiv"><%=rs.getString("PName") %>
				<div>Seller : <%=rs.getString("VName") %></div>
				<div>Product : <%=rs.getString("CatName") %></div>
				<div><BR/></div>
				<div>Delivered within 10 day's</div>
				</div>
			</td>
			
		<td align="center"><div class="qntDiv"><%=request.getParameter(rs.getString("Pid")) %></div></td>
		<td><div class="priceDiv"><b>Rs. </b><div style="display: inline-table;" id="<%=rs.getString("Pid") %>Price"><%=rs.getInt("Price")%></div> <br/> only /- </div></td>
		<td><div class="delDiv">Free<div>Delivered in 2-3 <br/> business days.<br/>Including 5% Tax <br/>Tax Rs.<%=(Double.parseDouble(rs.getString("Price"))*.05) %></div></div></td>
		<td><div class="subTotalDiv">
			<b>Rs. </b>
				<div style="display: inline-table;" name="subCost" id="<%=rs.getString("Pid") %>SubTotal"><%=(Integer.parseInt(request.getParameter(rs.getString("Pid"))) * rs.getDouble("Price")) + (rs.getDouble("Price")*.05)%></div>
			</div>
		</td>		
		<input type="hidden" value="<%=request.getParameter(rs.getString("Pid"))%>" name="<%=rs.getString("Pid") %>" />
		</tr>
		<tr><td colspan="7"><hr/></td></tr>
	<%} 
	}%>
	<tr class="tableHead"><th colspan="5" align="right">Total Estimated Cost : <b>Rs</b></th><th align="right"><div style="display: inline-table;" id="totalCost"><%=totalCostEstimated %></div> /- only</th></tr>
	</table>	
	<%
		session.setAttribute("estimatedCost", totalCostEstimated);
	%>
</div>

<h1 class="shippingDiv">Shipping Details</h1>
<div class="subDiv">
	<table class="tableContent" cellspacing="15px;">
		<tr><td>Customer Name</td><td><input class="textBox" type="text" name="userName"></td> </tr>
		<tr><td>Phone Number</td><td><input class="textBox" type="text" name="phno"></td> </tr>
		<tr><td>Address</td><td><textarea rows="5" cols="100" class="textBox" name="add" style="height: 100px; padding: 10px;"></textarea></td> </tr>
		<tr><td>City</td><td><input class="textBox" type="text" name="city"></td> </tr>
		<tr><td>State</td><td><input class="textBox" type="text" name="state"></td> </tr>
		<tr><td>Pin Code</td><td><input class="textBox" type="text" name="pin"></td> </tr>
	</table>
</div>
<h1 class="shippingDiv">Account Information</h1>
<div class="subDiv">
	<div><label id="l1"><input type="radio" name="mode" id="r1" value="Cash On Delivery" />Cash On Delivery</label></div>
	<div><label id="l2"><input type="radio" name="mode" id="r2" value="Credit Card" />Credit Card</label></div>
	<div><label id="l3"><input type="radio" name="mode" id="r3" value="Debit Card" />Debit Card</label></div>


	<table class="tableContent" cellspacing="15px;" id="t1">
		<tr><td>Product will be delivered Shortly...!</td></tr>
	</table>
	<table class="tableContent" cellspacing="15px;" id="t2">
		<tr><td>Credit Card No</td><td><input class="textBox" type="text" name="creditNo"></td> </tr>
		<tr><td>Bank</td>
			<td>
				<select name="bankName1"	 class="textBox">			
				<option>Punjab National Bank</option>
				<option>Swiss Bank</option>
				<option>Punjab National Bank</option>
				<option>State Bank India</option>
				<option>Hydrabad State Bank</option>
				<option>Corporation Bank</option>
				</select>
			</td> 
		</tr>
	</table>
	<table class="tableContent" cellspacing="15px;" id="t3">
		<tr><td>Debit Card No</td><td><input class="textBox" type="text" name="debitNo"></td> </tr>
		<tr><td>Bank</td>
			<td>
				<select name="bankName2"	 class="textBox">			
				<option>Punjab National Bank</option>
				<option>Swiss Bank</option>
				<option>Punjab National Bank</option>
				<option>State Bank India</option>
				<option>Hydrabad State Bank</option>
				<option>Corporation Bank</option>
				</select>
			</td> 
		</tr>
	</table>	
</div>
	<input type="submit" value="Place Order" class="submitBtn" formaction="checkOutOrder">
</form>
</body>
</html>

 <script type="text/javascript">

$(function()	{
	var selected = 't1';
	$('.shippingDiv+div').hide();
	$('#prodInf+div').show();
	$('.shippingDiv').css({'margin':'0px 50px 0px 50px','color':'#666'});
	$('.shippingDiv+div').css('margin','0px 60px 0px 100px');
	$('.shippingDiv').click(function(e){
		$(this).next('div').fadeToggle(500);
	}).css('cursor','pointer');
	
	$('.typeOfAccount+table').hide();	

	$('#t1').hide();
	$('#t3').hide();
	$('#t2').hide();

	$('#r1').click(function(e){
		$('#t3').hide();
		$('#t2').hide();
		$('#t1').show();	
		selected = 't1';
	})

	$('#r2').click(function(e){
		$('#t3').hide();
		$('#t1').hide();
		$('#t2').show();	
		selected = 't2';
	})

	$('#r3').click(function(e){
		$('#t1').hide();
		$('#t2').hide();
		$('#t3').show();	
		selected = 't2';
	})


/* 	$('#l1').hover(function(e){
		$('#t3').hide();
		$('#t2').hide();
		$('#t1').show();	
		selected = 't1';
	})

	$('#l2').hover(function(e){
		$('#t3').hide();
		$('#t1').hide();
		$('#t2').show();	
		selected = 't2';
	})

	$('#l3').hover(function(e){
		$('#t1').hide();
		$('#t2').hide();
		$('#t3').show();	
		selected = 't2';
	})
 */
});

</script> 

<style>
.shippingDiv{
	margin: 100px;
	padding: 10px;
}
.subDiv
{
	width:85%;
	height:auto;
	border:1px solid #CCC;
	background:#FFF;
	margin:100px;
	padding:30px 0px 20px 30px;
	box-shadow:0px 0px 10px 1px #CCC;
	-webkit-box-shadow:0px 0px 10px 1px #CCC;
	-ms-box-shadow:0px 0px 10px 1px #CCC;
	-moz-box-shadow:0px 0px 10px 1px #CCC;
	display: inline-table;
}
.subDiv div {
	display: inline-table;
	font-size: 28px;
	color:#333;
	padding-right: 100px;
		
}

.subDiv .tableContent	{
	font-size: 28px;
	color:#333;
}
.subDiv .tableContent tr td	{
	width:50%
}
.typeOfAccount	{
	font-size: 28px;
	color:#333;
	float: left;
	display: inline-table;
}
.textBox, .passWord
{
	width:350px;
	height:35px;
	padding:0px 10px 0px 10px;
	font-size:18px;
	float:right;
	font-family:Georgia, "Times New Roman", Times, serif;
	letter-spacing:4px;
}
.textBox:hover, .passWord:hover
{
	box-shadow:0px 0px 10px 1px black;
	cursor:pointer;
}
.textBox:focus, .passWord:focus
{
	box-shadow:inset 0px 0px 20px 2px #ccc;
	cursor:text;
}

.submitBtn
{
	width:300px;	
	height:60px;
	font-size:30px;
	color:#FFFFFF;
	letter-spacing:5px;
	border-radius:10px;
	font-family:Georgia, "Times New Roman", Times, serif;

	background:linear-gradient(skyblue,blue);
	-ms-background:linear-gradient(skyblue,blue);
	-moz-background:linear-gradient(skyblue,blue);
	-webkit-background:linear-gradient(skyblue,blue);
	
	margin: 20px 20px 10px 950px;
}
.submitBtn:hover
{
	cursor:pointer;	
	background:tomato;
}

input[type=checkbox]
{
	width:30px;
	height:20px;
	padding:10px 10px 0px 10px;
	margin:10px 0px 0px 0px;
}
</style>

</style>