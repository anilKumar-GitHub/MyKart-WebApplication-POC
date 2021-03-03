<%@page import="java.util.Set"%>
<%@page import="java.sql.*"%>
<%@page import="dataModel.myKartDataBaseOperations"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<link rel="stylesheet" type="text/css" href="CSS/listOptionDesign.css" />
<style>
.showProfileDiv	{
	display: inline-table; 
	position:absolute; 
	right: 20px; 
	top: 30px;
	cursor: pointer;
}
.showProfileDiv .roundedPic	{
	width: 50px;
	height: 50px;
	border-radius:40px;
}
.showProfileDiv:hover .roundedPic	{
	box-shadow:0px 0px 10px 5px #ccc;
}
.showProfileDiv div	{
	direction:ltr;
	display: none;
	border: 1px solid #CCC;
	position:absolute; 
	right: -15px; 
	top: 50px;
	background-color: white;
	box-shadow:0px 0px 10px 5px #333;
	border-radius:3px;
	padding: 5px;
	width: auto;
	height: auto;
}
.showProfileDiv:hover .roundedPic	{
	border-shadow:1px;
	box-shadow:0px 0px 10px 5px #ccc;
}
.showProfileDiv div img	{
	width: 100px;
	height: 100px;
	border: 1px solid #ccc;
	padding: 1px;
}
.showProfileDiv:hover	{
	direction: rtl;
}
.showProfileDiv:hover div{
	display: inline-table;
}
.showProfileDiv:hover .logOut	{
	color: white;
	padding: 5px 10px 5px 10px;
	margin: 0px 10px;
	background-color: rgba(196, 131, 224, 1);
	border-radius:10px;
}
.showProfileDiv:hover .logOut:hover	{
	color: white;
	background-color: red;
	border: 1px solid green;
}
</style>

<%

	Integer cartSize = new Integer(0);
	
	if( session.getAttribute("curWishList") != null )	{
		cartSize = ((Set) session.getAttribute("curWishList")).size();
	}
%>
	<div class="topSpace">
	<% 
		if( session.getAttribute("myKartLoginUser") == null )	{
	%>	
	<div class="linkDiv"><a href="registerMyKartNewUser.jsp">Sign-Up</a><a href="cartUserLogin.jsp">Log-In</a></div>
	
	<% }else 	{	%>
		
<!--	<div class="linkDiv"><a href="logOutmyKartUser"><div style="display: inline-table;">[ Log Out ]</div></a>&nbsp;&nbsp;<a href="#"><div style="display: inline-table;"><%=session.getAttribute("myKartLoginUser") %></div></a></div> -->
 	
	<div class="showProfileDiv"><img class="roundedPic" src="images/myKartUserPics/<%=session.getAttribute("seessionProfilePic")%>" />
		<div>		
			<table>
				<tr><td rowspan="5" colspan="2"><img src="images/myKartUserPics/<%=session.getAttribute("seessionProfilePic")%>" /></td></tr>
				<tr><td align="right" colspan="2"><h2 style="color: #666;"><%=session.getAttribute("myKartLoginUser") %></h2></td></tr>
				<tr><td><a href="http://www.gmail.com?gamil=<%=session.getAttribute("seessionEmailId") %>" style="color: blue;"><%=session.getAttribute("seessionEmailId") %></a></td></tr>
				<tr><td align="right"><br/><a class="logOut" href="logOutmyKartUser"> Log Out </a></td></tr>
				<tr><td></td></tr>
			</table>
		</div>
	</div>
	<br/>
	<%} %>
	<center>

	<div style="font-size: 35px; color: white; display: inline-table;" >ourKart</div>
	
   	<div style="display: inline-table;">
   	<form action="indexOfmyKart.jsp?en=1" method="post">
   	<input type="text" size="20" name="searchKey" class="searchTextBox"/>
	<input class="searchButton" type="submit" value="Search" />
	</form>
	</div>
	<a href="myCart.jsp"><div class="kartView">myCart <div style="background-color: white; margin-left:10px; border-radius:10px; color: black; display: inline-table; width: 30px; border:2px solid black;"><%=cartSize %></div></a></div>
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
	<li><a class="option" href="indexOfmyKart.jsp?en=2&catType=<%=rsCatType.getString(1)%>"><%=rsCatType.getString(2).toUpperCase() %></a>
		<div class="linkList">
		<% 
			
			rsCat = db.execeteQuery("SELECT DISTINCT C.CatID, C.CatName FROM ProductMaster P JOIN CategoryMaster C ON C.CatID = P.CID WHERE P.CTID = "+rsCatType.getString(1));

		while(rsCat.next() )	{
			%>
			<div class="linkListSubDivision" style="display: inline-table;">
			<a class="listOption" href="indexOfmyKart.jsp?en=3&catType=<%=rsCatType.getString(1)%>&catId=<%=rsCat.getString(1)%>"><%=rsCat.getString(2) %></a>			
			<%			
			rsVen = db.execeteQuery("SELECT DISTINCT V.VID, V.VName FROM ProductMaster P JOIN CategoryMaster C ON C.CatID = P.CID JOIN VendorMaster V ON P.VID = V.VID WHERE P.CTID = "+rsCatType.getString(1)+" AND  P.CID= '"+rsCat.getString(1)+"'");
			

			while( rsVen.next() )	{


			%>
					<a class="subListOption" href="indexOfmyKart.jsp?en=4&catType=<%=rsCatType.getString(1)%>&catId=<%=rsCat.getString(1)%>&venId=<%=rsVen.getString(1)%>"><%=rsVen.getString(2) %></a>
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