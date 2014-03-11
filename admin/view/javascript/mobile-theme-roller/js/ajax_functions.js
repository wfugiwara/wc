	function getXMLHTTP() { //fuction to return the xml http object
			
		var xmlhttp=false;	
		try{
			xmlhttp=new XMLHttpRequest();
		}
		catch(e)	{		
			try{			
				xmlhttp= new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(e){
				try{
				xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
				}
				catch(e1){
					xmlhttp=false;
				}
			}
		}
		 	//alert(xmlhttp);
		return xmlhttp;
    
	}
	
	function reset_preview() {
		//alert(ID);
		var strURL="view/javascript/theme-roller/js/Ajax_pages/preview.php";
		var req = getXMLHTTP();

		if (req) {
			
			req.onreadystatechange = function() {
				if (req.readyState == 4) {
					// only if "OK"
					if (req.status == 200) {						
						//var Status=req.responseText;
						//alert('preview');
						document.getElementById('main_style').innerHTML=req.responseText;
						//document.getElementById('quickswatch').style.display="none";
						document.getElementById('themeroller_mobile').innerHTML='';
						//document.getElementById("frame").src = "view/javascript/theme-roller/preview6.html";
						$('#form').submit();
					} else {
						alert("There was a problem while using XMLHTTP:\n" + req.statusText);
					}
				}				
			}			
			req.open("GET", strURL, true);
			req.send(null);
		}		
	}
	
	function default_style() {
		//alert(ID);
		var strURL="view/javascript/mobile-theme-roller/js/Ajax_pages/default.php";
		var req = getXMLHTTP();

		if (req) {
			
			req.onreadystatechange = function() {
				if (req.readyState == 4) {
					// only if "OK"
					if (req.status == 200) {						
						//var Status=req.responseText;
						//alert('style');
						document.getElementById('themeroller_mobile').innerHTML=req.responseText;
						$('#form').submit();
					} else {
						alert("There was a problem while using XMLHTTP:\n" + req.statusText);
					}
				}				
			}			
			req.open("GET", strURL, true);
			req.send(null);
		}		
	}