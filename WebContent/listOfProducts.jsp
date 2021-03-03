<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/General.css" />
<link rel="stylesheet" type="text/css" href="CSS/tableDefinition.css" />
<title>Insert title here</title>
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
<%!	Connection con = null; %>

<%
	try {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		con = DriverManager.getConnection("jdbc:sqlserver://ADMIN-PC;port=1433;database=OurKartDataBase","vayuDev","root");

	}catch (ClassNotFoundException $mySqlErr) {
		System.out.println("Error From Calss Not Found  : "+$mySqlErr.getLocalizedMessage());
	}catch (SQLException $mySqlErr) {
		System.out.println("Error From Calss Not Found  : "+$mySqlErr.getLocalizedMessage());
	}
%>
<BR/><br/>
<center>
	<a class="hypLink" href="category.jsp"> Category List </a>
	<a class="hypLink" href="categoryType.jsp"> Category Type </a>
	<a class="hypLink" href="vendors.jsp"> Vendors </a>
	<a class="hypLink" href="products.jsp"> Product List </a>
	<a class="hypLink" href="listOfProducts.jsp"> Product Stock </a>
	<a class="hypLink" href="logOutServlet"> Log Out </a>
</center>

<%!
	String cid = "";
	String vid = "";
	boolean defaultVendor = false;
%>
<%
	
	if( request.getParameter("submit") != null )	{
		
		
		if( request.getParameter("submit").equals("Delete Selected Row")){

			if( request.getParameter("selectedRow") != null ){

				Statement stDelete = con.createStatement();
			
				try {
					stDelete.execute("DELETE FROM ProductMaster WHERE PId = '"+request.getParameter("selectedRow")+"'");
				}catch(SQLException e)	{
					System.out.print("Error : "+e.getLocalizedMessage());
				}
			}
		}
		
		if( ! request.getParameter("vendor_type").equals("null") )	{
			vid = request.getParameter("vendor_type");
		}
		
		if( ! request.getParameter("category_type").equals("null"))	{
			cid = request.getParameter("category_type");
		}				
	}
%>

<%
	
		
	Statement stSelection = con.createStatement();


boolean selFlag = false;
%>
<form name="searchEngine" method="get" action="listOfProducts.jsp"	>
<div align="left" class="divisionPage" style="width: 1100px; height: 130px; margin-left: 100px; padding-left: 10px; padding-right: 10px;"> 
<fieldset>
<legend><h2> Search Engine</h2></legend>
	<table width="100%">
		<tr><td> Product Vendor </td><td>
		<select name="vendor_type" onChange="submitVendor()">
		<option value="null"> Select </option>
		<%
			ResultSet rsv = stSelection.executeQuery("SELECT * FROM VendorMaster");
			
			while( rsv.next() )	{
				if( rsv.getString(1).equals(vid) ) selFlag = true;
				%>
				
				<option value="<%=rsv.getString(1) %>" <% if( selFlag )  { %> selected="selected" <% } %> > <%=rsv.getString(2) %> </option>
				<% 
				selFlag = false;
			}
		%>
		</select>
		</td>
		<td> Category </td><td>
		<select name="category_type" onChange="submitVendor()">
		<option value="null"> Select </option>
		<% 
		
			if( request.getParameter("vendor_type") != null )
			if( !request.getParameter("vendor_type").equals("null") ) {

				ResultSet rs1 = stSelection.executeQuery("SELECT DISTINCT CatId, CatName FROM CategoryMaster, ProductMaster WHERE CatId = CID AND Vid = '"+request.getParameter("vendor_type")+"'");
		
				while( rs1.next() )	{
					if( rs1.getString(1).equals(cid) ) selFlag = true;				
					%>
				
					<option value="<%=rs1.getString(1) %>" <% if( selFlag )  { %> selected="selected" <% } %> > <%=rs1.getString(2) %> </option>
					<% 
					selFlag = false;
			}
		}
		%>
		</select>
		</td></tr>
	</table>
	</fieldset>
</div>  

<table id="showTable" border="0" width="100%" style="margin-top:3%;" align="center">
<tr><th>Sl No</th><th width="10px;"><input type="submit" name="submit" value="Edit" style="font-size:15px; width:60px; height:30px; margin-left: -10px; margin-right: -10px;"></th><th>Product ID</th><th>Product Name</th><th>Product Category</th><th>Vedor Name</th><th> Quantity  </th><th> Price </th><th>Action</th></tr>
<%
	Statement st = con.createStatement();
	ResultSet rs = null;
	
	if( request.getParameter("category_type") != null && ! request.getParameter("category_type").equals("null") )	{
		
		rs = st.executeQuery("SELECT P.Pid, P.PName, C.CatName, V.VName, P.Quantity, P.Price FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID JOIN CategoryMaster C ON P.CID = C.CatID WHERE P.Vid = '"+request.getParameter("vendor_type")+"' AND P.Cid = '"+request.getParameter("category_type")+"' ORDER BY  P.PName");
	}else
		if( request.getParameter("vendor_type") != null  &&  ! request.getParameter("vendor_type").equals("null")) {

		rs = st.executeQuery("SELECT P.Pid, P.PName, C.CatName, V.VName, P.Quantity, P.Price FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID JOIN CategoryMaster C ON P.CID = C.CatID WHERE P.Vid = '"+request.getParameter("vendor_type")+"' ORDER BY  P.PName");

	}else
		rs = st.executeQuery("SELECT P.Pid, P.PName, C.CatName, V.VName, P.Quantity, P.Price FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID JOIN CategoryMaster C ON P.CID = C.CatID  ORDER BY  P.PName");
		int i = 1;
		while( rs.next() )	{
			
		%>
			<tr>
				<td><%=i++ %></td>
				<td><input type="checkbox" name="selectedList" value="<%=rs.getString(1) %>" /> </td>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %></td>
				<td><a href="products.jsp?selectedRow=<%=rs.getString(1) %>&submit=Update+Row" style="text-decoration:none; color:#00FF00;"> Update </a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="listOfProducts.jsp?selectedRow=<%=rs.getString(1) %>&submit=Delete+Selected+Row"  style="text-decoration:none; color:#FF0000;"> Delete </a></td>
			</tr>
		<% 
		}
	
%>
<tr><th colspan="9" align="center"> www.vayuDev.org &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  All &copy; rigth reserved to vayu Oraganization and Research Center KLB </th></tr>
</table>
<input type="submit" id="sub" name="submit" value="search" style="visibility:hidden;">
</form>
</body>


<script type="text/javascript">


function submitVendor()	{

	document.getElementById("sub").click();
}
</script>