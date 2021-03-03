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
	String cname = "";
	String saveButtonText = "Save";
	boolean updateFlag = false;
	String readOnlyString = "";
%>
<%
	
	if( request.getParameter("submit") != null )	{
		
		if( request.getParameter("submit").equals("Update Row") )	{
			
			if( request.getParameter("selectedRow") != null ){

				Statement stUpdate = con.createStatement();
				
				ResultSet rsUpdate = stUpdate.executeQuery("SELECT * FROM CategoryMaster WHERE CatID='"+request.getParameter("selectedRow")+"'");
				
				if( rsUpdate.next() )	{
					
					cid = rsUpdate.getString(1);
					cname = rsUpdate.getString(2);
					
					//out.print(cid+"  "+cname);
				}
				
				saveButtonText = "Save Update";
				readOnlyString = "readonly";
				updateFlag = true;
			}
		}

		if( request.getParameter("submit").equals("Save Update"))	{

			saveButtonText = "Save";
						
			Statement stDoUpdate = con.createStatement();
			stDoUpdate.executeUpdate("UPDATE CategoryMaster SET CatName = '"+request.getParameter("txtCatName")+"' WHERE CatID ='"+request.getParameter("txtCatId")+"'");

			cid = "";
			cname = "";
			updateFlag = false;
		}
		
		if( request.getParameter("submit").equals("Delete Selected Row")){

			if( request.getParameter("selectedRow") != null ){

				Statement stDelete = con.createStatement();
			
				try {
					stDelete.execute("DELETE FROM CategoryMaster WHERE CatId = '"+request.getParameter("selectedRow")+"'");
				}catch(SQLException e)	{
					System.out.print("Error : "+e.getLocalizedMessage());
				}
			}
		}
 			
		if( request.getParameter("submit").equals("Save")){

			Statement stInsert = con.createStatement();
			try	{		
				stInsert.executeUpdate("INSERT INTO CategoryMaster VALUES( '"+request.getParameter("txtCatId")+"', '"+request.getParameter("txtCatName")+"')");
			}catch(SQLException e)	{
				System.out.print("Error : "+e.getErrorCode());
			}
		}
	}
%>

<form method="get" action="category.jsp">
<div align="left" class="divisionPage" style="width: 500px; height: 180px; padding-left: 30px;"> 
	<table>
		<tr><td> Category ID </td><td><input type="text" name="txtCatId" size="15" maxlength="10" value="<%=cid %>" <% if( updateFlag )%><%=readOnlyString %> /></td></tr>
		<tr><td>Category Name </td><td><input type="text" name="txtCatName" size="15" maxlength="50" value="<%=cname %>" /></td></tr>
		<tr><td><input type="reset" value="Reset"></td><td align="center"><input type="submit" name="submit" value="<%=saveButtonText %>" ></td></tr>
	</table>
</div>  

<table id="showTable" border="0" width="50%" style="margin-top:3%;" align="center">
<tr><th>Select</th><th>Sl No</th><th> Category Id  </th><th> Category Name </th></tr>
<%
		Statement st = con.createStatement();
		
		ResultSet rs = st.executeQuery("SELECT * FROM CategoryMaster");
	
		int i = 1;
		while( rs.next() )	{
			
		%>
			<tr>
				<td> <input type="radio" name="selectedRow" value="<%=rs.getString(1) %>">
				<td><%=i++ %></td>
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
			</tr>
		<% 
		}
%>
<tr><td colspan="4" align="center"><input type="submit" name="submit" value="Update Row" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Delete Selected Row" /></td></tr>
</table>
</form>
</body>
</html>