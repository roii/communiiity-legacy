<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Spellchecking Multiple ActivEdit fields on Submit</title>
	
	<!-- Import the library to spellcheck multiple ActivEdit instances. -->
	<script language="JavaScript" src="/spellchecker/spellAE.js"></script>
	
</head>



<script>

function validate() {
	spell('testForm');
	return false;
}

function registerListener() {
	document.testForm.onsubmit = validate;
}

</script>
<body onLoad="registerListener()">

<form name="testForm" id="testForm" action="displayPage.cfm" method="post">

	Title:<input type="title" name="test" size="20"><br><br>

	<cf_activedit
		name="field1"
		inc="inc/">
		This is speled wrang.
	</cf_activedit>
	
	<cf_activedit
		name="field2"
		inc="inc/">
		This is aalso speled wrang.
	</cf_activedit>
	
<br><br>

	<input type="submit" name="submitButton" value="Save Event">

</form>

</body>
</html>
