<%@page import="java.sql.*"%>
<%@page import="dataModel.myKartDataBaseOperations"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<link rel="stylesheet" type="text/css" href="CSS/listOptionDesign.css" />
	<div class="topSpace">
	
	<div class="linkDiv"><a href="#">Sing-Up</a><a href="#">Log-In</a></div>
<center>
	<div style="font-size: 35px; color: white; display: inline-table; margin-right: 50px;" >ourKart</div>
	
   	<div style="display: inline-table;">
   	<input type="text" size="20" name="searchKey" class="searchTextBox"/>
	<input class="searchButton" type="submit" value="Search" />
	</div>
	<div class="kartView">Cart <div style="background-color: white; margin-left:10px; border-radius:10px; color: black; display: inline-table; width: 30px; border:2px solid black;">5</div></div>
</center>
	</div>


<div style="background-color:#C7A6DC;margin-left: -7px; margin-right: -10px;" >
<ul class="nav" >  

<%

	if( application.getAttribute("objectHandler") == null )	return;

	myKartDataBaseOperations db = (myKartDataBaseOperations) application.getAttribute("objectHandler");

	try{
				
		ResultSet rsCat = null;

		ResultSet rsVen = null;

		ResultSet rsCatType = null ;

		rsCatType = db.execeteQuery("SELECT * FROM CategoryType");

		while(rsCatType.next() )	{
	%>
	<li><a class="option" href="onlineMarket/indexOfmyKart.jsp?catType=<%=rsCatType.getString(1)%>"><%=rsCatType.getString(2).toUpperCase() %></a>
		<div class="linkList">
		<% 
			
			rsCat = db.execeteQuery("SELECT DISTINCT C.CatID, C.CatName FROM ProductMaster P JOIN CategoryMaster C ON C.CatID = P.CID WHERE P.CTID = "+rsCatType.getString(1));

		while(rsCat.next() )	{
			%>
			<div class="linkListSubDivision" style="display: inline-table;">
			<a class="listOption" href="onlineMarket/indexOfmyKart.jsp?catType=<%=rsCatType.getString(1)%>&catId=<%=rsCat.getString(1)%>"><%=rsCat.getString(2) %></a>			
			<%			
			rsVen = db.execeteQuery("SELECT DISTINCT V.VID, V.VName FROM ProductMaster P JOIN CategoryMaster C ON C.CatID = P.CID JOIN VendorMaster V ON P.VID = V.VID WHERE P.CTID = "+rsCatType.getString(1)+" AND  P.CID= '"+rsCat.getString(1)+"'");
			
			System.out.print("opened");

			while( rsVen.next() )	{

				
				System.out.print(rsVen.getString(1)+ " \t\t "+rsVen.getString(2));
			%>
					<a class="subListOption" href="listOption.jsp?catType=<%=rsCatType.getString(1)%>&catId=<%=rsCat.getString(1)%>&venId=<%=rsVen.getString(1)%>"><%=rsVen.getString(2) %></a>
			<% 
			}
			rsVen.close();	
			%>		
			</div>
			<%
		}
		rsCat.close();
		%>
		</div>
	</li>
	<% 
		}
		rsCatType.close();
	}catch(SQLException mySqlErr){
		
		out.print("Error from heer "+mySqlErr.getLocalizedMessage());
		System.out.print("Error from heer "+mySqlErr.getLocalizedMessage());
	}
	%>
	
<li><a class="option" href="#">OFFERS</a><div class="linkList"></div></li>	

</ul>
</div>