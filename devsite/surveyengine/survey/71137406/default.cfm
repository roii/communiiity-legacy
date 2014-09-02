<cfset formid ="32"><cfparam name="tablequestions" default="questions"><cfparam name="setupdir" default="http://www.business.auckland.ac.nz/surveyengine/survey"><cfparam name="vendorid" default="0">


	<cfoutput>
	<form action="http://www.business.auckland.ac.nz/surveyengine/survey/default.cfm" method="post">
	<input type="hidden" name="formid" value="32">
	<input type="hidden" name="vendorid" value="0">
	<input type="hidden" name="itemid" value="#itemid#"> 
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Wastes my time</font><br>
<input type=radio name="Variable482" value="1">Highly Important<br>
<input type=radio name="Variable482" value="2">Important<br>
<input type=radio name="Variable482" value="3">Neutral<br>
<input type=radio name="Variable482" value="4">Unimportant<br>
<input type=radio name="Variable482" value="5">Highly Unimportant<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">content is disturbing(sexual etc.)</font><br>
<input type=radio name="Variable483" value="1">Highly Important<br>
<input type=radio name="Variable483" value="2">Important<br>
<input type=radio name="Variable483" value="3">Neutral<br>
<input type=radio name="Variable483" value="4">Unimportant<br>
<input type=radio name="Variable483" value="5">Highly Unimportant<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">worried I may lose my genuine messages</font><br>
<input type=radio name="Variable484" value="1">Highly Important<br>
<input type=radio name="Variable484" value="2">Important<br>
<input type=radio name="Variable484" value="3">Neutral<br>
<input type=radio name="Variable484" value="4">Unimportant<br>
<input type=radio name="Variable484" value="5">Highly Unimportant<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other - please specify:</font><br>
<input type="text" name="Variable_485" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other - please specify</font><br>
<input type="text" name="Variable_486" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other - please specify</font><br>
<input type="text" name="Variable_487" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other - please specify</font><br>
<input type="text" name="Variable_488" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other - please specify</font><br>
<input type="text" name="Variable_489" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other - please specify</font><br>
<input type="text" name="Variable_490" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other - please specify</font><br>
<input type="text" name="Variable_491" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How do you connect to the Internet? Please choose the most important one:</font><br>
<input type=radio name="Variable457" value="1">Your own Internet connection via ISP<br>
<input type=radio name="Variable457" value="2">Internet cafe<br>
<input type=radio name="Variable457" value="3">At work<br>
<input type=radio name="Variable457" value="4">Other – please specify:<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Please mark all the activities for which you use the Internet:</font><br>
<input type="checkbox" name="Variable458" value="1">email<br>
<input type="checkbox" name="Variable458" value="2">research<br>
<input type="checkbox" name="Variable458" value="3">chat<br>
<input type="checkbox" name="Variable458" value="4">games<br>
<input type="checkbox" name="Variable458" value="5">business<br>
<input type="checkbox" name="Variable458" value="6">personal services (Banking, news, purchases)<br>
<input type="checkbox" name="Variable458" value="7">other – please specify:<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Do you get unsolicited emails (spam)?</font><br>
<input type=radio name="Variable459" value="1">Yes<br>
<input type=radio name="Variable459" value="2">No<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If no – why not?

Please go to demographics!</font><br>
<textarea name="Variable_460" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If you have multiple email accounts which one is the worst and can you think of why?</font><br>
<textarea name="Variable_461" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How many spam emails do you get on this account? </font><br>
<input type=radio name="Variable462" value="1">none<br>
<input type=radio name="Variable462" value="2">1-5 per week<br>
<input type=radio name="Variable462" value="3">1-5 per day<br>
<input type=radio name="Variable462" value="4">5-50 per day<br>
<input type=radio name="Variable462" value="5">more than 50 per day<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Approximately for how long have you been using this email address? </font><br>
<input type=radio name="Variable463" value="1">less than 3 months<br>
<input type=radio name="Variable463" value="2">3 to 6 months<br>
<input type=radio name="Variable463" value="3">6 to 12 months<br>
<input type=radio name="Variable463" value="4">1 to 2 years<br>
<input type=radio name="Variable463" value="5">more than 2 years<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How often would you reply to spam? </font><br>
<input type=radio name="Variable464" value="1">never<br>
<input type=radio name="Variable464" value="2">rarely<br>
<input type=radio name="Variable464" value="3">sometimes<br>
<input type=radio name="Variable464" value="4">often<br>
<input type=radio name="Variable464" value="5">all the time<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Does spam bother you? </font><br>
<input type=radio name="Variable465" value="1">not at all<br>
<input type=radio name="Variable465" value="2">very little<br>
<input type=radio name="Variable465" value="3">neutral<br>
<input type=radio name="Variable465" value="4">somewhat significant<br>
<input type=radio name="Variable465" value="5">significant<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If it bothers you at all, why? (rank these reasons in terms of importance. 1 = highest, 5 = lowest)</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Do you know of any good ways to solve your spam problem but are not using it currently? </font><br>
<textarea name="Variable_467" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Why are you not using them? (select as many as you need to): </font><br>
<input type="checkbox" name="Variable468" value="1">can’t be bothered<br>
<input type="checkbox" name="Variable468" value="2">too complicated<br>
<input type="checkbox" name="Variable468" value="3">too expensive<br>
<input type="checkbox" name="Variable468" value="4">don’t know<br>
<input type="checkbox" name="Variable468" value="5">other – please specify:<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Can you imagine how these spammers got your address? </font><br>
<textarea name="Variable_469" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Did you have any other personal experiences with spamming on the Internet beyond just getting random unsolicited emails? eg: Personal contact attempts, stalker email or contact attempts via phone or snail mail resulting from spam. Please explain:</font><br>
<textarea name="Variable_470" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Age group: </font><br>
<input type=radio name="Variable471" value="1">under 15<br>
<input type=radio name="Variable471" value="2">15 to 20<br>
<input type=radio name="Variable471" value="3">20 to 30<br>
<input type=radio name="Variable471" value="4">30 to 45<br>
<input type=radio name="Variable471" value="5">45 to 65<br>
<input type=radio name="Variable471" value="6">65+<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Gender: </font><br>
<input type=radio name="Variable472" value="1">male<br>
<input type=radio name="Variable472" value="2">female<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Marital status: </font><br>
<input type=radio name="Variable473" value="1">single<br>
<input type=radio name="Variable473" value="2">married/permanent relationship<br>
<input type=radio name="Variable473" value="3">divorced/separated<br>
<input type=radio name="Variable473" value="4">widowed<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Highest level of education: </font><br>
<input type=radio name="Variable474" value="1">elementary school<br>
<input type=radio name="Variable474" value="2">high school<br>
<input type=radio name="Variable474" value="3">undergraduate degree<br>
<input type=radio name="Variable474" value="4">postgraduate degree<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Present employment status:</font><br>
<input type=radio name="Variable475" value="1">student<br>
<input type=radio name="Variable475" value="2">self-employed<br>
<input type=radio name="Variable475" value="3">waged/salaried<br>
<input type=radio name="Variable475" value="4">retired<br>
<input type=radio name="Variable475" value="5">unemployed<br>
<input type=radio name="Variable475" value="6">other – please specify:<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Professional group: </font><br>
<input type=radio name="Variable476" value="1">IT/IS<br>
<input type=radio name="Variable476" value="2">Accounting<br>
<input type=radio name="Variable476" value="3">Marketing<br>
<input type=radio name="Variable476" value="4">Science/Engineering<br>
<input type=radio name="Variable476" value="5">other – please specify:<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Annual household income before tax : </font><br>
<input type=radio name="Variable477" value="1">under 36,000<br>
<input type=radio name="Variable477" value="2">36,001 – 50,000<br>
<input type=radio name="Variable477" value="3">50,001 – 70,000<br>
<input type=radio name="Variable477" value="4">70,001 – 90,000<br>
<input type=radio name="Variable477" value="5">over 90,000<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">In which currency is this income? </font><br>
<input type="text" name="Variable_478" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Please email to: udan002@ec.auckland.ac.nz; fax to 64-9-3737430 or leave in OCH141.</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Fills up storage in my email</font><br>
<input type=radio name="Variable481" value="1">Highly Important<br>
<input type=radio name="Variable481" value="2">Important<br>
<input type=radio name="Variable481" value="3">Neutral<br>
<input type=radio name="Variable481" value="4">Unimportant<br>
<input type=radio name="Variable481" value="5">Highly Unimportant<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Do you use any spam protection? If yes, is it (tick as many as you need to):</font><br>
<input type="checkbox" name="Variable480" value="1">software installed on your PC <br>
<input type="checkbox" name="Variable480" value="2">run by your ISP <br>
<input type="checkbox" name="Variable480" value="3">run by your organisation (work email) <br>
<input type="checkbox" name="Variable480" value="4">run by a spam protection service <br>
<input type="checkbox" name="Variable480" value="5">filters in the email account<br>
<input type="checkbox" name="Variable480" value="6">other - please specify:<br>
<br>
<input type="submit" value="Submit"></form></cfoutput>
<br>
