<%@page import="java.sql.ResultSet"%>
<%@ include file="listOption.jsp" %>

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
	<div style="float: left; height: 100px;">
	<form action="indexOfmyKart.jsp?en=5" method="post">
		<div>		<label><h3>Category Type</h3></label>
		
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
					if( s[i].equals(id))	chkflag = true;
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

					//out.print("<BR>using fun : "+db.arrayToString(request.getParameterValues("catId")));
					
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
    