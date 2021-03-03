<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="listOption.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>ourKart shopping to home</title>
<link rel="stylesheet" type="text/css" href="CSS/logIn4myKartUserLogin.css" />
<link rel="stylesheet" type="text/css" href="CSS/LogInStySheet.css" />
<link rel="icon" href="images/icons/serial.jpg" />
<link rel="stylesheet" type="text/css" href="CSS/cartDesign.css" />
</head>

<%
		if( session.getAttribute("myKartLoginUser") != null )	response.sendRedirect("indexOfmyKart.jsp?en=2&catType=1");	
%>
<body> 
<center>
	<div>
		<div class="tabPaenl" style="color:#B358C5; background-color: white; border-color:#B358C5; border-bottom-color: white; border-bottom-width: 5px;">Log-In</div>
		<a href="registerMyKartNewUser.jsp"><div class="tabPaenl" style="height: 30px;">Register New User</div></a>
		<a href="indexOfmyKart.jsp?en=2&catType=1"><div  class="tabPaenl" style="height: 30px;">Continue Shopping</div></a>
				
		<hr style="margin-top: -4px; height: 2px; background-color: #B358C5"/>		
	</div>
 
    <div class="login" style="width: 25%;">
	
		<h1 >Login</h1>
      <form name="form1" method="post" action="myCartUserAuthentication">
	  	<table>
	  	<tr><td>
       <input class="textBox" type="text" name="email" placeholder="Username">
       </td></tr>
       <tr><td>
		<input class="passWord" type="password" name="pass" placeholder="Password" >
        </td></tr>
        <tr><td>
        <p class="remember_me">
          <label>
            <input type="checkbox" name="rememberme"  id="remember_me">
            Remember me on this computer
          </label>
        </p>
        </td></tr>
		<tr><td>		
		<p> <a class="login-help" href="email.jsp">Forgot your password?</a></p><a class="login-help" href="SignUp.jsp">New User?Sign Up</a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input class="subMit" type="submit" name="commit" value="Login" onclick="return check()">
		</td></tr>
		</table>
      </form>
    </div>
</center>
</body>
</html>
<%	if( request.getParameter("err") != null )	{	%>
	<script type="text/javascript">
		alert("<%=request.getParameter("err")%>");
	</script>
<% } %>


<script type="text/javascript">

function change()	{
	
	if( document.getElementById("ch").checked )	{
		
			document.getElementById("pass").type = "text";			
	}else {
			document.getElementById("pass").type = "password";			
	}
}

var str = new String();

function check()	{
	
	var dom = document.form1;
	
	if( document.form1.email.value == "" )	{
		alert("Enter the Email ID");
		document.form1.email.focus();
		return false;
	}
	if( document.form1.pass.value == "" )	{
		alert("Enter the Password");		
		document.form1.pass.focus();
		return false;
	}
	return true;
}


function Load1()
{

//window.history.back()=false;	
window.history.forward() = false;
	
	
}

</script>