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

<!-- 		<img src ="sandisk01.jpeg" >

			<img src ="images/sandisk01.jpeg" >

			<img src ="images/cartImages/sandisk01.jpeg" >
 -->
<%!
	String cid = "";
	String ctid ="";
	String vid = "";
	String pid = "";
	String pname = ""; 
	String qnt = "";
	String price = "";
	String saveButtonText = "Save";
	String imgName = "";
%>

<%!
	boolean updateFlag = false;
	String readOnlyString = "";
%>
<%
	
	if( request.getParameter("submit") != null )	{
		
		if( request.getParameter("submit").equals("Update Row") )	{
			
			if( request.getParameter("selectedRow") != null ){

				Statement stUpdate = con.createStatement();
				
				ResultSet rsUpdate = stUpdate.executeQuery("SELECT * FROM  ProductMaster  WHERE Pid='"+request.getParameter("selectedRow")+"'");
				
				if( rsUpdate.next() )	{
					
					vid = rsUpdate.getString(1);
					cid = rsUpdate.getString(2);
					ctid = rsUpdate.getString(3);
					pid = rsUpdate.getString(4);
					pname = rsUpdate.getString(5);
					qnt = rsUpdate.getString(6);
					price = rsUpdate.getString(7);
					
//					out.print(vid+"  "+cid+"  "+pid+"  "+pid+"   "+pname+"   "+qnt+"   "+price);
				}
				
				
				saveButtonText = "Save Update";
				readOnlyString = "readonly";
				updateFlag = true;
			}
		}

		if( request.getParameter("submit").equals("Save Update"))	{

			saveButtonText = "Save";
						
			Statement stDoUpdate = con.createStatement();
			stDoUpdate.executeUpdate("UPDATE ProductMaster SET Vid = '"+request.getParameter("vendor_type")+"', CID = '"+request.getParameter("category_type")+"' , CTID = "+request.getParameter("catGroupType")+",  PName = '"+request.getParameter("txtName")+"', Quantity = "+request.getParameter("txtQnt")+", Price = "+request.getParameter("txtPrice")+" WHERE Pid = '"+request.getParameter("txtId")+"'");
			cid = "";
			ctid = "";
			vid = "";
			pid = "";
			pname = "";
			qnt = "";
			price = "";
			updateFlag = false;
		}
		
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
		
		if( request.getParameter("submit").equals("Save")){

				Statement stInsert = con.createStatement();
			try	{		
				stInsert.executeUpdate("INSERT INTO ProductMaster VALUES ('"+request.getParameter("vendor_type")+"', "+
					" '"+request.getParameter("category_type")+"', "+request.getParameter("catGroupType")+" ,'"+request.getParameter("txtId")+"','"+
					request.getParameter("txtName")+"',"+request.getParameter("txtQnt")+","+request.getParameter("txtPrice")+")");

				stInsert.executeQuery("INSERT INTO  imageList VALUES ('"+request.getParameter("txtId")+"',  '"+request.getParameter("imageName")+"', default)");
				
			}catch(SQLException e)	{
				System.out.print("Error : "+e.getErrorCode());
			}
		}
	}

Statement stSelection = con.createStatement();


boolean selFlag = false;
%>
<form method="get" action="products.jsp"	>
<div align="left" class="divisionPage" style="width: 1100px; height: auto; margin-left: 100px; padding-left: 50px; padding-bottom: 10px;"> 
	<table width="100%">
		<tr><td> Product ID </td><td><input type="text" name="txtId" size="15" maxlength="10" value="<%=pid %>" <% if( updateFlag )%><%=readOnlyString %> /></td>
		<td align="center" colspan="2"><input type="submit" name="submit" value="<%=saveButtonText %>" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="Reset"></td></tr>
		<tr><td> Product Name </td><td><input type="text" name="txtName" size="15" maxlength="50" value="<%=pname%>" /></td>
		<td> Quantity </td><td><input type="text" name="txtQnt" size="15" maxlength="50" value="<%=qnt %>" style="width:100px;" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
		Price <input type="text" name="txtPrice" size="15" maxlength="50" value="<%=price %>" style="width:150px;" /></td></tr>

		<tr><td> Product Vendor </td><td>
		<select name="vendor_type">
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
		<select name="category_type">
		<option value="null"> Select </option>
		<% 
			ResultSet rs1 = stSelection.executeQuery("SELECT * FROM CategoryMaster");
		
			while( rs1.next() )	{
				if( rs1.getString(1).equals(cid) ) selFlag = true;				
				%>
				
				<option value="<%=rs1.getString(1) %>" <% if( selFlag )  { %> selected="selected" <% } %> > <%=rs1.getString(2) %> </option>
				<% 
				selFlag = false;
			}
		%>
		</select>
		</td></tr>

<tr><td>Category Type </td>
		<td> 
			<select name="catGroupType">
			<option value="null"> Select </option>
		<%
		rs1 = stSelection.executeQuery("SELECT * FROM CategoryType");
		
		while( rs1.next() )	{
			if( rs1.getString(1).equals(ctid) ) selFlag = true;				
			%>
			
			<option value="<%=rs1.getString(1) %>" <% if( selFlag )  { %> selected="selected" <% } %> > <%=rs1.getString(2) %> </option>
			<% 
			selFlag = false;
		}

		%>	
			</select>
</td>
<td>Image Name</td><td><input type="text" name="imageName" /></td> </tr>
	</table>
</div>  

<table id="showTable" border="0" width="90%" style="margin-top:3%;" align="center">
<tr><th>Sl No</th><th>Product ID</th><th>Product Name</th><th>Product Category</th><th>Vedor Name</th><th> Quantity  </th><th> Price </th><th>Action</th></tr>
<%
		Statement st = con.createStatement();
		
		ResultSet rs = st.executeQuery("SELECT P.Pid, P.PName, C.CatName, V.VName, P.Quantity, P.Price, I.Name, I.dirPath FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID JOIN CategoryMaster C ON P.CID = C.CatID  JOIN imageList I  ON P.Pid = I.PID");
	
		int i = 1;
		while( rs.next() )	{
			
		%>
 			<tr>
				<td><%=i++ %>&nbsp;&nbsp;<img src="<%=rs.getString(7) %>"></td>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %></td>
				<td><a href="products.jsp?selectedRow=<%=rs.getString(1) %>&submit=Update+Row" style="text-decoration:none; color:#00FF00;"> Update </a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="products.jsp?selectedRow=<%=rs.getString(1) %>&submit=Delete+Selected+Row"  style="text-decoration:none; color:#FF0000;"> Delete </a></td>
			</tr>
			
<!--		<img src="<%=rs.getString(8)%><%=rs.getString(7) %>" >
			<img src ="images/icons/ReFlective User.png" >

			<img src ="images/icons/Buddy-Blue.ico" >

			<img src ="images/icons/keme.jpg" >
-->		<% 
		}
%>
<tr><th colspan="8" align="center"> www.vayuDev.org &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  All &copy; rigth reserved to vayu Oraganization and Research Center KLB </th></tr>
</table>
</form>
</body>
</html>