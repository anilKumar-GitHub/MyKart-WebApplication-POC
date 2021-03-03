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

<table id="showTable" border="0" width="100%" style="margin-top:3%;" align="center">
<tr><th>Sl No</th><th>Product ID</th><th>Product Name</th><th>Product Category</th><th>Vedor Name</th><th> Quantity  </th><th> Price </th></tr>
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
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %></td>
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