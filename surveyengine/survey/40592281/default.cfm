<cfset formid ="24"><cfparam name="tablequestions" default="questions"><cfparam name="setupdir" default="http://www.business.auckland.ac.nz/surveyengine/survey"><cfparam name="vendorid" default="0">


	<cfoutput>
	<form action="http://www.business.auckland.ac.nz/surveyengine/survey/default.cfm" method="post">
	<input type="hidden" name="formid" value="24">
	<input type="hidden" name="vendorid" value="0">
	<input type="hidden" name="itemid" value="#itemid#"> 
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">During the last 12 months, how many times did your organisation use external venues for training and seminors?</font><br>
<input type=radio name="Variable118" value="1">0<br>
<input type=radio name="Variable118" value="2">1-3<br>
<input type=radio name="Variable118" value="3">4-6<br>
<input type=radio name="Variable118" value="4">7-12<br>
<input type=radio name="Variable118" value="5">more than 12<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">On average, how many people attended the events?</font><br>
<input type=radio name="Variable119" value="1">1-10<br>
<input type=radio name="Variable119" value="2">11-20<br>
<input type=radio name="Variable119" value="3">21-30<br>
<input type=radio name="Variable119" value="4">31-40<br>
<input type=radio name="Variable119" value="5">more than 40<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Which 2 factors most influence your choice of external venue (please tick two)?</font><br>
<input type="checkbox" name="Variable120" value="1">Proximity to your office<br>
<input type="checkbox" name="Variable120" value="2">Car parking<br>
<input type="checkbox" name="Variable120" value="3">Standard of decor<br>
<input type="checkbox" name="Variable120" value="4">Catering facilities<br>
<input type="checkbox" name="Variable120" value="5">Technology available<br>
<input type="checkbox" name="Variable120" value="6">Hire charges<br>
<input type="checkbox" name="Variable120" value="7">Others<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other Factor influence choice</font><br>
<input type="text" name="Variable_121" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Are you aware of The Corporate Venue's training and seminar facilities at No.1 Short Street, Auckland Central?</font><br>
<input type=radio name="Variable122" value="1">Yes<br>
<input type=radio name="Variable122" value="2">No<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Would you like to receive an Information Pack about The Corporate Venue's facilities</font><br>
<input type=radio name="Variable123" value="1">Yes<br>
<input type=radio name="Variable123" value="2">No<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">First Name</font><br>
<input type="text" name="Variable_124" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Last Name</font><br>
<input type="text" name="Variable_125" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Organisation</font><br>
<input type="text" name="Variable_128" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Address</font><br>
<textarea name="Variable_127" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Role</font><br>
<input type="text" name="Variable_129" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Email</font><br>
<input type="text" name="Variable_130" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Phone</font><br>
<input type="text" name="Variable_131" size=40><br>
<br>
<input type="submit" value="Submit"></form></cfoutput>
<br>
