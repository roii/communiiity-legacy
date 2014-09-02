<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>jQuery UI Progressbar - Default functionality</title> 
<cfinclude template="../app_globals.cfm">
<cfset percentValue = URL.percentValue>
<cfoutput>
<link rel="stylesheet" href="#request.webroot#/css/jquery-ui.css"> 
<script src="#request.webroot#/js/jquery-1.9.1.js"></script> 
<script src="#request.webroot#/js/jquery-ui.js"></script>  
</cfoutput>
<script>
	$(function() {
		$( "#progressbar" ).progressbar({
			value: <cfoutput>#percentValue#</cfoutput>
		});
	});
</script>
</head>
<body>
	<div id="progressbar" style="width: 206px; height: 11px;"></div>
</body>
</html>