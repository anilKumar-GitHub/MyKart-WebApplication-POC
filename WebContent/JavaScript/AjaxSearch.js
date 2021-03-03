// JavaScript Document

function getUpdatedData(){

var key = document.getElementById("searchBox").value;

//alert("String : "+key);

var ajaxRequest;  // The variable that makes Ajax possible!
 
	try{
   
      // Opera 8.0+, Firefox, Safari
      ajaxRequest = new XMLHttpRequest();
   }catch (e){
      
      // Internet Explorer Browsers
      try{
         ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
      }catch (e) {
         
         try{
            ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
         }catch (e){
         
            alert("Your browser broke!");
            return false;
         }
      }
   }
   
   ajaxRequest.onreadystatechange = function(){
   
      if(ajaxRequest.readyState == 4){
         var ajaxDisplay = document.getElementById('tableDisplayArea');
         ajaxDisplay.innerHTML = ajaxRequest.responseText;
      }
   }
   
   ajaxRequest.open("GET", "showTable.jsp?searchKey="+key, true);
   ajaxRequest.send(null); 
}