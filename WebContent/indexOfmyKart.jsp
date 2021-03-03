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
</head>
<body>
<%
	ResultSet rs = null;

	Integer typeOfSelectoinMade = Integer.parseInt((request.getParameter("en") == null ?"-1" : request.getParameter("en")));

	String ctype = new String();
	String cid = new String();
	String vid = new String();
	
	int flag = 0;
	
	if( request.getParameter("venId") != null )	{
		vid = request.getParameter("venId");
		cid = request.getParameter("catId");
		ctype = request.getParameter("catType"); 
		flag = 3;
	}else if( request.getParameter("catId") != null ) {
		cid = request.getParameter("catId");
		ctype = request.getParameter("catType");			
		flag = 2;
	}else if( request.getParameter("catType") != null ){
		ctype = request.getParameter("catType");						
		flag = 1;
	}
%>
	<div style="float: left; width: 15%; height: 500px;">
	<form action="indexOfmyKart.jsp?en=5" method="post">
		<div><label><h3>Category Type</h3></label>
		
		<div style="width: 100%; height: 200px; padding-left: 30px; overflow: auto;">
		<%
			rs = db.execeteQuery("SELECT * FROM CategoryMaster");
			String s[] = {"A","B","C"};
			if( request.getParameterValues("catId") != null )
			s = request.getParameterValues("catId"); 	
			while( rs.next() )	{
				String id = rs.getString(1);
				boolean chkflag = false;
				for( int i = 0; i < s.length; i ++ )	
					if( s[i].equals(id))	{
						chkflag = true;
						break;
					}
				
		%>
			<label class="ckbx" ><input type="checkbox" name="catId" value="<%=rs.getString(1) %>" onChange="submit()" <% if(chkflag) { out.print("checked"); } %> /> <%=rs.getString(2) %></label>
		<%}
			
			rs.close();
		%>
		</div>
		</div>
		<div>
		<label><h3>Vendor Type</h3></label>		
		<div style="width: 100%; height: 200px; padding-left: 30px; overflow: auto;">
			<%
			
				if( request.getParameterValues("catId") != null )	{
					
					String catListString= "";
					
					String vList[] = {"a","b"};
					if( request.getParameterValues("venId") != null )  vList = request.getParameterValues("venId");	

					//					out.print("<BR>using fun : "+db.arrayToString(request.getParameterValues("catId")));
					
					rs = db.execeteQuery("SELECT DISTINCT V.VID, V.VName FROM ProductMaster P JOIN VendorMaster V ON P.VID = V.VID WHERE  P.CID in ("+db.arrayToString(request.getParameterValues("catId"))+")");
					
					while( rs.next() )	{
						String id = rs.getString(1);
						boolean chkflag = false;
						for( int i = 0; i < vList.length; i++ )
							if( vList[i].equals(id))	chkflag = true;
					%>	
						<label class="ckbx" ><input type="checkbox" name="venId" value="<%=rs.getString(1) %>" onChange="submit()"  <% if(chkflag) { out.print("checked"); } %> /> <%=rs.getString(2) %></label>
					<%}
				}
			rs.close();
			%>
		
		</div>
		</div>
	</form>
	</div>
	<div style="width: auto; height: auto; margin-left: 18%; margin-top: 50px;">
<% 		try{ %>
		
			<% 
			if( typeOfSelectoinMade != null && typeOfSelectoinMade == 2 )	{
				
				rs = db.execeteQuery("SELECT * FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID AND CTID = '"+request.getParameter("catType")+"'");
			}else if( typeOfSelectoinMade != null && typeOfSelectoinMade == 3 )	{
				
				rs = db.execeteQuery("SELECT * FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID AND CTID = '"+request.getParameter("catType")+"' AND CID = '"+request.getParameter("catId")+"'");
			}else if( typeOfSelectoinMade != null && typeOfSelectoinMade == 4 )	{
				
				rs = db.execeteQuery("SELECT * FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID AND CTID = '"+request.getParameter("catType")+"' AND CID = '"+request.getParameter("catId")+"' AND P.Vid = '"+request.getParameter("venId")+"' ");
			}else if( typeOfSelectoinMade != null && typeOfSelectoinMade == 5 )	{

				if(request.getParameterValues("catId") != null && request.getParameterValues("venId") == null )		
				rs = db.execeteQuery("SELECT * FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID AND CID in ("+db.arrayToString(request.getParameterValues("catId"))+")");

				if(request.getParameterValues("catId") != null && request.getParameterValues("venId") != null )		
				rs = db.execeteQuery("SELECT * FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID AND CID in ("+db.arrayToString(request.getParameterValues("catId"))+") AND P.Vid in ("+db.arrayToString(request.getParameterValues("venId"))+")");

				if(request.getParameterValues("catId") == null )		
					rs = db.execeteQuery("SELECT DISTINCT P.Vid, P.Pid, P.PName, P.Price, V.VName,P.image  FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID WHERE P.Pid in (SELECT Top 1 Pid FROM ProductMaster WHERE Vid = P.Vid AND Cid = P.Cid )");			
			}else if( typeOfSelectoinMade != null && typeOfSelectoinMade == 1 ){

				String searchKey = request.getParameter("searchKey");

				rs = db.execeteQuery("SELECT DISTINCT* FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID JOIN CategoryMaster CM ON CM.CatID = P.CID "+
										
									"JOIN CategoryType CT ON CT.CatTypeId = P.CTID "+
									
									"AND (CT.TypeName LIKE '%"+searchKey+"%' OR CM.CatName LIKE '%"+searchKey+"%' OR V.VName LIKE '%"+searchKey+"%' OR P.PName LIKE '%"+searchKey+"%')");
			}else if( request.getQueryString() == null ){
				rs = db.execeteQuery("SELECT DISTINCT P.Vid, P.Pid, P.PName, P.Price, V.VName,P.image  FROM ProductMaster P JOIN VendorMaster V ON P.Vid = V.VID WHERE P.Pid in (SELECT Top 1 Pid FROM ProductMaster WHERE Vid = P.Vid AND Cid = P.Cid )");			
			}
			
			boolean rowEffected = false;

			while(rs.next())	{
				rowEffected = true;
				%>				
					<div class ="itemSpace">
						<a href="showProduct.jsp?prodId=<%=rs.getString("Pid")%>"><div class="imgClass"><img src='Products/<%=rs.getString("image") %>' alt="<%=rs.getString("image") %>" width="150px;" height="200px" /></div></a>
						<div class="imgDes"><a href="showProduct.jsp?prodId=<%=rs.getString("Pid")%>"><%=rs.getString("PName") %></a>
						<div style="color: red"><%=rs.getString("VName") %></div>
						<div><b>Rs : </b> <%=rs.getString("Price") %> /- only</div>
						</div>
					</div>
				<%
		
				}
				
				if( !rowEffected )	{
					%>
					<h1 style="color: red; font-weight: bolder;"> Sorry Item Not Found</h1>
					<% 
				}

		}catch(Exception e){
			
			System.out.print("Err : "+e.getLocalizedMessage());		
		}

	%>
	</div>
</body>
</html>