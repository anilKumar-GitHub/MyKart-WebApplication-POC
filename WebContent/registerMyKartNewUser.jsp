<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="listOption.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ourKart shopping to home</title>
<link rel="icon" href="images/icons/serial.jpg" />
<link rel="stylesheet" type="text/css" href="CSS/cartDesign.css" />
</head>

<%
		if( session.getAttribute("myKartLoginUser") != null )	response.sendRedirect("indexOfmyKart.jsp?en=2&catType=1");	
%>

<body> 
<center>
	<div>
		<a href="cartUserLogin.jsp"><div class="tabPaenl" style="height: 30px;">Log-In</div></a>
		<div class="tabPaenl" style=" color:#B358C5; background-color: white; border-color:#B358C5; border-bottom-color: white; border-bottom-width: 5px;">Register New User</div>
		<a href="indexOfmyKart.jsp?en=2&catType=1"><div  class="tabPaenl" style="height: 30px;">Continue Shopping</div></a>
				
		<hr style="margin-top: -4px; height: 2px; background-color: #B358C5"/>		
	</div>

<form name="form1" method="post" action="myCartUserRegistration">
<div class="logPage">
<table cellspacing="30">
		
		<tr><td colspan="2" align="center">
			<div  class="imgClass" >
				<img src="images/myKartUserPics/no_photo.png" id="profilePic" width="120" height="120"/>
			<h2 onclick="pic.click()" onmouseout="showImage()">Upload</h2>  

				<input type="file" value="123" name="file" id="pic"/> 
				<input type="hidden" name="picName" id="picScr" value=""/>
			</div>
		</td>
		</tr>
		<tr><td><span class="colDes">Name</span></td><td><input class="textBox" type="text" id="uname" name="uname" placeholder="User Name" required="required" maxlength="50" autofocus="autofocus" accesskey="u" /></td></tr>
		<tr><td><span class="colDes">Email</span></td><td><input class="textBox" type="text" id="email" name="email" placeholder="@gmail.com" required="required" maxlength="50" autofocus="autofocus" accesskey="u" /></td></tr>
	
		<tr><td><span class="colDes">Phone Number</span></td><td><input class="textBox" type="text" id="phno" name="phno" placeholder="+91-" required="required" maxlength="50" autofocus="autofocus" accesskey="u" /></td></tr>
		<tr><td><span class="colDes">Password</span></td><td><input class="textBox" type="password" id="pass1" name="pass1" placeholder="Password" required="required" maxlength="50" autofocus="autofocus" accesskey="u" /></td></tr>
		<tr><td><span class="colDes">Confirm Password</span></td><td><input class="textBox" type="password" id="pass2" name="pass2" placeholder="Confirm Password" required="required" maxlength="50" autofocus="autofocus" accesskey="u" /></td></tr>
		<tr><td colspan="2" align="center"><span class="colDes"><input class="submitBtn"  type="submit" value="Create Account" onclick="return check()" accesskey="L"/></td></tr>
		
		<% if( request.getParameter("err") != null ) { %>	
		<tr><td colspan="2" align="center" style="font-size: 20px; color: red; font-weight: bolder;"><%=request.getParameter("err") %></td></tr>
		<% } %>
</table>
</div>
</form>
</center>
</body>
</html>

<script type="text/javascript">
function showImage()	{
	
	var path = document.getElementById("pic").value;
	
	if( path != "")		{
		path = path.substr(path.lastIndexOf("\\")+1	,path.length);
		//alert(document.getElementById("pic").value);
	}
	else	path="no_photo.png";
	document.getElementById("profilePic").src = "images/myKartUserPics/" + path;
	document.getElementById("picScr").value = path; 
}


function check()	{
	
	var dom = document.form1;
	
	if( document.getElementById("uname").value == "" ){
		alert("Enter Correct User Name");
		document.getElementById("uname").focus();
		return false;
	}
	if( document.form1.email.value == "" )	{
		alert("Enter Correct Email ID");
		document.getElementById("email").focus();
		return false;
	}
	if( document.getElementById("phno").value == "" ){
		alert("Enter Correct Phone Number");
		document.getElementById("phno").focus();
		return false;
	}
	if( document.form1.pass1.value == "" )	{
		alert("Enter Corrrect the Password");		
		document.getElementById("pass1").focus();
		return false;
	}
	if( document.getElementById("pass2").value == "" ){
		alert("Enter Correct Confirm Password");
		document.getElementById("pass3").focus();
		return false;
	}
	if( document.getElementById("pass1").value != document.getElementById("pass2").value )	{
		alert("Enter Correct Re-Password");
		document.getElementById("pass2").value = "";
		document.getElementById("pass2").focus();
		return false;
	}
	//alert(document.getElementById("picScr").value);
	if( document.getElementById("picScr").value == "" || document.getElementById("picScr").value == "no_photo.png" )	{
		alert("Please Upload Profile Pic");
		return false;
	}
	
	return true;
}

</script>
<style>
.imgClass{
 	width: 180px;
	height: 185px;
 	background-image:url(123.ico);
	box-shadow:0px 0px 10px 2px #ccc;
	margin-top: -20px;
	border-radius:200px; 
	overflow: hidden;
}
.imgClass:hover{
	box-shadow:inset 0px 0px 10px 2px #ccc,0px 0px 5px 20px #ccc;
	box-shadow:0px 0px 5px 2px #ccc;
	cursor: pointer;
	letter-spacing: 5px;
}
.imgClass h2	{
	transition:.9s;
}
.imgClass:hover h2	{
	color: white;
	position: relative;
	bottom: 138px;
	background-color:rgba(42, 26, 26, 0.5);	
	padding:10px 0px 10px 0px; 
}
.imgClass img{
	width: inherit;
	height: inherit;
}
body	{
	margin-bottom: 200px;
}
.colDes	{
	font-size: 25px;
	
}
.logPage
{
	width:600px;
	height:auto;
	border:1px solid #CCC;
	background:#FFF;
	margin-top:50px;
	padding:30px 0px 0px 0px;
	border-radius:120px 120px 5px 5px;
	box-shadow:0px 0px 40px 1px #CCC, inset 0px 0px 20px 2px #EEE;
	-webkit-box-shadow:0px 0px 40px 1px #CCC, inset 0px 0px 20px 2px #EEE;
	-ms-box-shadow:0px 0px 40px 1px #CCC, inset 0px 0px 20px 2px #EEE;
	-moz-box-shadow:0px 0px 40px 1px #CCC, inset 0px 0px 20px 2px #EEE;
}

.textBox, .passWord
{
	width:230px;
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

	transition:background 10s;	
	-ms-transition:background 10s;	
	-moz-transition:background 10s;	
	-webkit-transition:background 10s;
}
.submitBtn:hover
{
	cursor:pointer;
	
	background:linear-gradient(white,blue,skyblue);
	-ms-background:linear-gradient(white,blue,skyblue);
	-moz-background:linear-gradient(white,blue,skyblue);
	-webkit-background:linear-gradient(white,blue,skyblue);

	box-shadow:0px 0px 5px 0px #ccc;
	-ms-box-shadow:0px 0px 5px 0px #ccc;
	-moz-box-shadow:0px 0px 5px 0px #ccc;
	-webkit-box-shadow:0px 0px 5px 0px #ccc;
}

input[type=checkbox]
{
	width:30px;
	height:20px;
	padding:10px 10px 0px 10px;
	margin:10px 0px 0px 0px;
}
</style>