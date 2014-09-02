<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>

<script language="JavaScript" src="spellInValidation.js"></script>

<script language="JavaScript">
	function validation() {
		// Cancel the submit event
		window.event.returnValue = false;
		
		// Sample validation
		if(myForm.content == "") {
			alert("Please enter some text.");
			myForm.content.focus();
			return false;
		} else {
			spell('myForm');
		}
	}
</script>


 <title>Spell Checker Test Page</title>

</head>
 
<body>
 
<form name="myForm" action="myPage.cfm" method="post" onSubmit="validation()">
 <textarea name="content" rows="14" cols="45">I am speled wrang</textarea><br>
 <textarea name="content2" rows="14" cols="45">I am aalso spelled wrang</textarea>
 <input type="submit" name="formButton" value="Save">
</form>
 
</body>
</html>