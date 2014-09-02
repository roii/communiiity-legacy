<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>

<script language="JavaScript" src="spell.js"></script>


 <title>Spell Checker Test Page</title>

</head>
 
<body>
 
<form name="myForm">
 <textarea name="content" rows="14" cols="45">This is speeled wrang.</textarea><br>
 <textarea name="content2" rows="14" cols="45">I am aalso spelled wrang</textarea>
 <input type="button" value="Check Spelling" onClick="spell('document.myForm.content.value', 'document.myForm.content2.value')">
</form>
 
</body>
</html>