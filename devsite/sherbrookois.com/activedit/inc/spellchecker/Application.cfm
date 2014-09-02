<!--- 
	CONFIGURATION PARAMS FOR ActivSpell
	Company: CFDEV.COM
	Author: Pete Freitag, Greg Alton
	Date: 08/03	
 --->

<!--- SEE THE DOCS FOR DETAILS ABOUT THESE ATTRIBUTES --->

<!---
	The American English Dictionary is set as the default. The British dictionary
	is also included in the /spellchecker/lex directory.
	
	Multiple User Dictionaries:
	The easiest way to implement support for multiple user dictionaries is to copy
	and rename the user dictionary. The new name would typically have a user id 
	appended to the filename. Then you can set Request.userdict using the user id 
	from a session variable. <cfset Request.userdict = ExpandPath("lex") & "/userdic" 
	& Session.userID & ".tlx">
--->

<cfset Request.tlx = ExpandPath("lex/british.tlx")>
<cfset Request.clx = ExpandPath("lex/british.clx")>
<cfset Request.userdict = ExpandPath("lex/userdic.tlx")>

<!--- 
	Multilingual Spelling Sessions and Language Extensions:
	
	Add application variables for each dictionary to be used in the spelling session. 
	You need a compressed lexicon (.clx) and text lexicon (.tlx) for each dictionary.
	
	Call the addLexicon() method in the object instance after the init() method.
	(line 26 of spell.cfm and line 13 of suggest.cfm). addword.cfm also has an object
	instance, but doesn't need a call to addLexicon() because it only writes to the 
	user dictionary. There only needs to be one user dictionary for each spelling
	session.
	
	spellchecker.addLexcon(Request.med_tlx, Request.med_clx);

 --->
 
 <!---
 		<cfset Request.med_tlx = ExpandPath("lex/medical.tlx")>
		<cfset Request.med_clx = ExpandPath("lex/medical.clx")>
 --->


<cfset Request.searchdepth = 50>
<!--- 
	The English phonetic comparator uses english language rules to form
	suggestions, it is faster than the typographical comparator, but can 
	only be used on English Dictionaries.
 --->
<cfset Request.englishphonetic = 1>
<cfset Request.striphtml = 1>
<!--- other option is wddx, only change this in your own apps --->
<cfset Request.format = "javascript">
<!--- The number of suggestions to load --->
<cfset Request.Suggestions = 14>
