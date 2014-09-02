<html>
<head>
	<title>it works</title>
	<script>
		function transpose() {
			
			<cfoutput>document.SpellCheckForm.spellCheckContent.value = parent.opener.#jsvar#;</cfoutput>
			document.SpellCheckForm.submit();
		}
		
	</script>
</head>
<body onload="transpose()">

<font face="verdana" size="-2">
<span name="viewer" id="viewer">&nbsp;&nbsp;Checking Spelling...</span>
</font>

<form name="SpellCheckForm" style="visibility:hidden;" action="spell.cfm" method="post" target="topframe">
	<textarea name="spellCheckContent" style="visibility:hidden;"></textarea>
	<cfoutput><input type="hidden" name="jsvar" value="#jsvar#"></cfoutput>
</form>

</body>
</html>

