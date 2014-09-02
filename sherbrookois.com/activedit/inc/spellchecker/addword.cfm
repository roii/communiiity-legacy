<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>addword</title>
</head>

<cfscript>
 	spellChecker = CreateObject("java", "com.cfdev.activspell2.SpellChecker");
	spellChecker.addWord(Request.userdict, word);
</cfscript>


<body onLoad="parent.topframe.increment()">
<font face="verdana" size="-2">
<span name="viewer" id="viewer">&nbsp;&nbsp;<cfoutput>#word# Added To Dictionary.</cfoutput>...</span>
</font>

</body>
</html>
