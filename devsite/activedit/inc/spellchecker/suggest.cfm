<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>suggest spelling</title>

<script>
function spell() {
<cfoutput>
<cfscript>
	spellChecker = CreateObject("java", "com.cfdev.activspell2.SpellChecker");
	spellChecker.init(Request.userdict, Request.tlx, Request.clx);
	spellChecker.setEnglishPhoneticComparator(Request.englishphonetic);
	spellChecker.setSearchDepth(Request.searchdepth);
	spellChecker.setNumSuggestions(Request.suggestions);
	jsoutput = spellChecker.checkSpelling("#word#", "javascript", Request.striphtml);
</cfscript>
#jsoutput#
</cfoutput>

	if (typeof(suggestions) == "undefined") { 
		var suggestions = new Array();
		suggestions[0] = new Array();
	}
	<cfoutput>
	parent.topframe.doSuggest("#word#", numMispelled, suggestions);
	</cfoutput>
}
</script>
</head>

<body onload="spell()">

<font face="verdana" size="-2">
	<span name="viewer" id="viewer">&nbsp;&nbsp;Suggestions for <cfoutput>#word#</cfoutput></span>
</font>


</body>
</html>
