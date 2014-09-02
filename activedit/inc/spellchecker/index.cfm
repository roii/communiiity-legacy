<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
	<script>
		function spell() 
		{
			window.open("window.cfm?jsvar=document.myForm.content.value",null, "height=230,width=450,status=no,toolbar=no,menubar=no,location=no");	
		}
		
	</script>
</head>

<body>

<!--- <cfx_JSpellCheck RELOAD="ALWAYS" propertiesfile="c:/java/speller.properties" action="check" words="this is  fsdjaklfsd giong to be spelled wornf"> --->
<form name="myForm">
	<textarea name="content" rows="14" cols="45">I am speled wrang</textarea>
	<input type="button" value="Check Spelling" onClick="spell()">
</form>

</body>
</html>
