// JavaScript Document

function selectByRow(ch)	{
	
	if( document.getElementById(ch).checked )
		document.getElementById(ch).checked = false;
	else
		document.getElementById(ch).checked = true;
	
	checkBoxChange(ch);
}

function checkBoxChange(choiceMade)  {

	var dom = document.getElementById(choiceMade);
	var allElements = document.getElementsByName("selectionList");
	//alert("hello : "+dom.name);

	var flag = true;

	for( var i = 0; i < allElements.length; i++ )
		
		if( ! allElements[i].checked )  {
			
			flag = false;
			break;
		}
	
	if( flag == true ) 		document.getElementById("selectAllId").checked = true;
	else					document.getElementById("selectAllId").checked = false;
}


function allSelectionStateChange()	{
	
	var dom = document.getElementById("selectAllId");
	var allElements = document.getElementsByName("selectionList");
	
	if( dom.checked )	{
		for( var i = 0; i < allElements.length; i++ )
			
			allElements[i].checked = true;
	}
	else{
		for( var i = 0; i < allElements.length; i++ )
			
			allElements[i].checked = false;		
	}
}