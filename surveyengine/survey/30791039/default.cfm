<cfset formid ="18"><cfparam name="tablequestions" default="questions"><cfparam name="setupdir" default="http://www.testbusiness.auckland.ac.nz/dynamic/surveyengine/survey"><cfparam name="vendorid" default="0">


	<cfoutput>
	<form action="http://www.testbusiness.auckland.ac.nz/dynamic/surveyengine/survey/default.cfm" method="post">
	<input type="hidden" name="formid" value="18">
	<input type="hidden" name="vendorid" value="0">
	<input type="hidden" name="itemid" value="#itemid#"> 
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How are You</font><br>
<input type=radio name="Variable70" value="1">Easy<br>
<input type=radio name="Variable70" value="2">Somewhat Easy<br>
<input type=radio name="Variable70" value="3">Neutral<br>
<input type=radio name="Variable70" value="4">Somewhat Difficult<br>
<input type=radio name="Variable70" value="5">Difficult<br>
<br>
<input type="submit" value="Submit"></form></cfoutput>
<br>
