<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Using ActivSpell 2.0 with the spellcheck button in ActivEdit</title>
	
	<!-- Import the library to spellcheck multiple ActivEdit instances. -->
	<script language="JavaScript" src="/spellchecker/spellButton.js"></script>
	
	<!-- Override ae_spellcheckwin -->
	<script language="JavaScript">
		function aeapi_local_onLoad(aeObject, fieldname) {
			ae_spellcheckwin = function(num) {
				spell(num);
			}
		}
	</script>
	
</head>

<body>

<form name="testForm" id="testForm" action="displayPage.cfm" method="post">

	Title:<input type="title" name="test" size="20"><br><br>

	<cf_activedit
		name="field1"
		inc="inc/"
		toolbar="spellcheck">
		This is speled wrang.
	</cf_activedit>
	
<br><br>

	<input type="submit" name="submitButton" value="Save Event">

</form>

</body>
</html>
