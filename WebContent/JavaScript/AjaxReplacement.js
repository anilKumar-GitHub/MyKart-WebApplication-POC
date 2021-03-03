// JavaScript Document

function addInsertForm(typeOfOptionSelected)	{

    var ajaxDisplay = document.getElementById('loadForm');
    
	if( typeOfOptionSelected == 1 )	{
		ajaxDisplay.innerHTML = "";
		return;
	}
		
	var ajaxRequest;  // The variable that makes Ajax possible!
	try{
   
		ajaxRequest = new XMLHttpRequest();
	}catch (e){
      
      // Internet Explorer Browsers
      try{
         ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
      }catch (e) {
         
         try{
            ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
         }catch (e){
         
            // Something went wrong
            alert("Your browser broke!");
            return false;
         }
      }
   }
   
   ajaxRequest.onreadystatechange = function(){
   
      if(ajaxRequest.readyState == 4){

    	  ajaxDisplay.innerHTML = ajaxRequest.responseText;
      }
   }
  
   // Now get the value from user and pass it to
   // server script.
   var fileName = "";
  
   if( typeOfOptionSelected == 2 ) fileName = "addInformation.html";
   else if ( typeOfOptionSelected == 5 ) fileName = "searchingInterface.html";
   
   ajaxRequest.open("GET", fileName, true);
   ajaxRequest.send(null); 
   return false;
}


function getStringOfChoice()	{
	
	var dom = document.getElementsByName("selectionList");

	var queryString = "";
	for( var i = 0; i < dom.length; i++ ){
		
		if( dom[i].checked )
			
			queryString = queryString +"selectionList=" dom[i].value+"&";
	}
	
	alert("Query String : "+queryString);
	
}



/*function cancleFun()	{
	location = "homePage.html";
	alert("OH");
	if( confirm(" Are you sure to abort this operation...!") )
		location = "homePage.html";
	else	return false;
}*/