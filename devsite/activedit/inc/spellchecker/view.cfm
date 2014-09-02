<html>
<head>
	<script>
		function transpose() {
			<cfoutput>SpellCheckForm.spellCheckContent.value = parent.opener.#field#.value;</cfoutput>
			SpellCheckForm.submit();
		}
		
	</script>
</head>
<body onload="transpose()">

<font face="verdana" size="-2">
<span name="viewer" id="viewer">&nbsp;&nbsp;Checking Spelling...</span>
</font>

<form name="SpellCheckForm" style="visibility:hidden;" action="spell.cfm" method="post" target="top">
	<textarea name="spellCheckContent" style="visibility:hidden;"></textarea>
</form>

</body>
</html>


