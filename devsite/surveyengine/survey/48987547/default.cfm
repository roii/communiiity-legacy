<cfset formid ="2"><cfparam name="tablequestions" default="questions"><cfparam name="setupdir" default="http://127.0.0.1/af/se"><cfparam name="vendorid" default="0">
<body bgcolor="silver">


	<cfoutput>
	<form action="http://127.0.0.1/af/se/survey/default.cfm" method="post">
	<input type="hidden" name="formid" value="2">
	<input type="hidden" name="vendorid" value="0">
	<input type="hidden" name="itemid" value="#itemid#"> 
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Did you get it?</font><br>
<input type="checkbox" name="Variable1" value="1">Highly Effective<br>
<input type="checkbox" name="Variable1" value="2">Effective<br>
<input type="checkbox" name="Variable1" value="3">Neutral<br>
<input type="checkbox" name="Variable1" value="4">Ineffective<br>
<input type="checkbox" name="Variable1" value="5">Highly Ineffective<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How are you?</font><br>
<input type=radio name="Variable2" value="1">Excellent<br>
<input type=radio name="Variable2" value="2">Very Good<br>
<input type=radio name="Variable2" value="3">Good<br>
<input type=radio name="Variable2" value="4">Fair<br>
<input type=radio name="Variable2" value="5">Poor<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Did you get it?</font><br>
<input type="checkbox" name="Variable3" value="1">Highly Effective<br>
<input type="checkbox" name="Variable3" value="2">Effective<br>
<input type="checkbox" name="Variable3" value="3">Neutral<br>
<input type="checkbox" name="Variable3" value="4">Ineffective<br>
<input type="checkbox" name="Variable3" value="5">Highly Ineffective<br>
<br>
<input type="submit" value="Submit"></form></cfoutput>
<br><h1>Footer</h1>
