<cfset formid ="29"><cfparam name="tablequestions" default="questions"><cfparam name="setupdir" default="http://www.business.auckland.ac.nz/surveyengine/survey"><cfparam name="vendorid" default="0">


	<cfoutput>
	<form action="http://www.business.auckland.ac.nz/surveyengine/survey/default.cfm" method="post">
	<input type="hidden" name="formid" value="29">
	<input type="hidden" name="vendorid" value="0">
	<input type="hidden" name="itemid" value="#itemid#"> 
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Do you publish RFPs that have an emphasis on Usability?</font><br>
<input type=radio name="Variable347" value="1">Yes<br>
<input type=radio name="Variable347" value="2">No<br>
<input type=radio name="Variable347" value="3">Unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Please rank the following from the most important (1) to the least important (4).  Is Usability used as:</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">A Quality Management Tool</font><br>
<select name="Variable349"> 
		<option value="0">Please make your selection
<option value="1">1 - The most Important
<option value="2">2 - important
<option value="3">3 - less important
<option value="4">4 - The least important
</select><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">A way to cut support and development costs</font><br>
<select name="Variable350"> 
		<option value="0">Please make your selection
<option value="1">1 - the most important
<option value="2">2 - important
<option value="3">3- less important
<option value="4">4 - the least important
</select><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">A competitive advantage</font><br>
<select name="Variable351"> 
		<option value="0">Please make your selection
<option value="1">1 - the most important
<option value="2">2 - important
<option value="3">3 - less important
<option value="4">4 - the least important
</select><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Part of our Organisations belief that customers come first</font><br>
<select name="Variable352"> 
		<option value="0">Please make your selection
<option value="1">1 - the most important
<option value="2">2 - important
<option value="3">3 - less important
<option value="4">4 - the least important
</select><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Section Three

If you have not been involved in the use of usability methods, then please complete the following section.
</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Why have you not been involved (please select all that apply)</font><br>
<input type="checkbox" name="Variable354" value="1">Lack of Organisational interest in Usability		<br>
<input type="checkbox" name="Variable354" value="2">My Organisation does not develop software in-house<br>
<input type="checkbox" name="Variable354" value="3">Organisational skill set perceived to be insufficient to use usability methods<br>
<input type="checkbox" name="Variable354" value="4">Budgetary constraints	<br>
<input type="checkbox" name="Variable354" value="5">Time constraints<br>
<input type="checkbox" name="Variable354" value="6">Do not feel the use of Usability methods/testing will be effective<br>
<input type="checkbox" name="Variable354" value="7">Cannot justify the return on investment (both time and money)<br>
<input type="checkbox" name="Variable354" value="8">Organisational policies do not allow for Usability testing<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Section Four - Complete if you have been involved in the deployment of Usability methods/testing</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Have you been involved in a project where usability has made a difference?</font><br>
<input type=radio name="Variable356" value="1">Yes<br>
<input type=radio name="Variable356" value="2">No<br>
<input type=radio name="Variable356" value="3">Unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">We would like to compile case studies of Usability successes.  Will you be willing to share some information regarding the project?  All commercially sensitive information can be excluded.</font><br>
<textarea name="Variable_357" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Demographics - All respondents to complete.
The following questions are about YOU to ensure that we have a demographic profile of our sample population.  Please remember these questions are strictly confidential and this survey is anonymous.</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Which of the following industry sections does your organisation fall into?  (you may select more than one)</font><br>
<input type="checkbox" name="Variable359" value="1">Software Development<br>
<input type="checkbox" name="Variable359" value="2">Transport/Travel<br>
<input type="checkbox" name="Variable359" value="3">Manufacturing<br>
<input type="checkbox" name="Variable359" value="4">Accounting<br>
<input type="checkbox" name="Variable359" value="5">Retail<br>
<input type="checkbox" name="Variable359" value="6">Medical<br>
<input type="checkbox" name="Variable359" value="7">Banking/Finance<br>
<input type="checkbox" name="Variable359" value="8">Primary (e.g. Forestry, oil)<br>
<input type="checkbox" name="Variable359" value="9">Insurance<br>
<input type="checkbox" name="Variable359" value="10">Printing/publishing<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;"></font><br>
<input type="checkbox" name="Variable360" value="1">Engineering/construction<br>
<input type="checkbox" name="Variable360" value="2">Telecommunications<br>
<input type="checkbox" name="Variable360" value="3">Education (University/Polytechnic)<br>
<input type="checkbox" name="Variable360" value="4">Distribution<br>
<input type="checkbox" name="Variable360" value="5">Government Department<br>
<input type="checkbox" name="Variable360" value="6">Business Consulting<br>
<input type="checkbox" name="Variable360" value="7">Local Authority<br>
<input type="checkbox" name="Variable360" value="8">Other<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If 'Other' then please specify</font><br>
<input type="text" name="Variable_361" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Which of the following best describes your place of work?</font><br>
<input type=radio name="Variable362" value="1">A software development company or partnership<br>
<input type=radio name="Variable362" value="2">A company or partnership performing some software development<br>
<input type=radio name="Variable362" value="3">A software development or IT department<br>
<input type=radio name="Variable362" value="4">Other<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If "Other" please specify</font><br>
<input type="text" name="Variable_363" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">The overall objectives of this research are as follows:  
</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">1.To evaluate the general understanding of Usability
2.To evaluate the appreciation of the value of Usability
3.To understand how Usability is executed
4.To discover successful Usability case studies
</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">All responses are anonymous.


</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Section One

Objective:  To gain an understanding as to what Usability is/is not
</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Question One:  To what extent do you agree with the following statements?</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Functionality is more important than usability</font><br>
<input type=radio name="Variable294" value="1">Strongly Agree<br>
<input type=radio name="Variable294" value="2">Agree<br>
<input type=radio name="Variable294" value="3">Somewhat Agree<br>
<input type=radio name="Variable294" value="4">Neutral<br>
<input type=radio name="Variable294" value="5">Somewhat Disagree<br>
<input type=radio name="Variable294" value="6">Disagree<br>
<input type=radio name="Variable294" value="7">Strongly Disagree<br>
<input type=radio name="Variable294" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Focus groups and user testing are the same thing</font><br>
<input type=radio name="Variable295" value="1">Strongly Agree<br>
<input type=radio name="Variable295" value="2">Agree<br>
<input type=radio name="Variable295" value="3">Somewhat Agree<br>
<input type=radio name="Variable295" value="4">Neutral<br>
<input type=radio name="Variable295" value="5">Somewhat Disagree<br>
<input type=radio name="Variable295" value="6">Disagree<br>
<input type=radio name="Variable295" value="7">Strongly Disagree<br>
<input type=radio name="Variable295" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability saves us money</font><br>
<input type=radio name="Variable296" value="1">Strongly Agree<br>
<input type=radio name="Variable296" value="2">Agree<br>
<input type=radio name="Variable296" value="3">Somewhat Agree<br>
<input type=radio name="Variable296" value="4">Neutral<br>
<input type=radio name="Variable296" value="5">Somewhat Disagree<br>
<input type=radio name="Variable296" value="6">Disagree<br>
<input type=radio name="Variable296" value="7">Strongly Disagree<br>
<input type=radio name="Variable296" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability makes us money</font><br>
<input type=radio name="Variable297" value="1">Strongly Agree<br>
<input type=radio name="Variable297" value="2">Agree<br>
<input type=radio name="Variable297" value="3">Somewhat Agree<br>
<input type=radio name="Variable297" value="4">Neutral<br>
<input type=radio name="Variable297" value="5">Somewhat Disagree<br>
<input type=radio name="Variable297" value="6">Disagree<br>
<input type=radio name="Variable297" value="7">Strongly Disagree<br>
<input type=radio name="Variable297" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If designers are familiar with UI guidelines & principles, then good user interfaces will be designed</font><br>
<input type=radio name="Variable298" value="1">Strongly Agree<br>
<input type=radio name="Variable298" value="2">Agree<br>
<input type=radio name="Variable298" value="3">Somewhat Agree<br>
<input type=radio name="Variable298" value="4">Neutral<br>
<input type=radio name="Variable298" value="5">Somewhat Disagree<br>
<input type=radio name="Variable298" value="6">Disagree<br>
<input type=radio name="Variable298" value="7">Strongly Disagree<br>
<input type=radio name="Variable298" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability is subjective and cannot be measured or engineered</font><br>
<input type=radio name="Variable299" value="1">Strongly Agree<br>
<input type=radio name="Variable299" value="2">Agree<br>
<input type=radio name="Variable299" value="3">Somewhat Agree<br>
<input type=radio name="Variable299" value="4">Neutral<br>
<input type=radio name="Variable299" value="5">Somewhat Disagree<br>
<input type=radio name="Variable299" value="6">Disagree<br>
<input type=radio name="Variable299" value="7">Strongly Disagree<br>
<input type=radio name="Variable299" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability testing is expensive</font><br>
<input type=radio name="Variable300" value="1">Strongly Agree<br>
<input type=radio name="Variable300" value="2">Agree<br>
<input type=radio name="Variable300" value="3">Somewhat Agree<br>
<input type=radio name="Variable300" value="4">Neutral<br>
<input type=radio name="Variable300" value="5">Somewhat Disagree<br>
<input type=radio name="Variable300" value="6">Disagree<br>
<input type=radio name="Variable300" value="7">Strongly Disagree<br>
<input type=radio name="Variable300" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability testing/methods will increase the overall software quality</font><br>
<input type=radio name="Variable301" value="1">Strongly Agree<br>
<input type=radio name="Variable301" value="2">Agree<br>
<input type=radio name="Variable301" value="3">Somewhat Agree<br>
<input type=radio name="Variable301" value="4">Neutral<br>
<input type=radio name="Variable301" value="5">Somewhat Disagree<br>
<input type=radio name="Variable301" value="6">Disagree<br>
<input type=radio name="Variable301" value="7">Strongly Disagree<br>
<input type=radio name="Variable301" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability testing will cause delays in the delivery of software</font><br>
<input type=radio name="Variable302" value="1">Strongly Agree<br>
<input type=radio name="Variable302" value="2">Agree<br>
<input type=radio name="Variable302" value="3">Somewhat Agree<br>
<input type=radio name="Variable302" value="4">Neutral<br>
<input type=radio name="Variable302" value="5">Somewhat Disagree<br>
<input type=radio name="Variable302" value="6">Disagree<br>
<input type=radio name="Variable302" value="7">Strongly Disagree<br>
<input type=radio name="Variable302" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Listening to customers means that usability testing/methods are not required</font><br>
<input type=radio name="Variable303" value="1">Strongly Agree<br>
<input type=radio name="Variable303" value="2">Agree<br>
<input type=radio name="Variable303" value="3">Somewhat Agree<br>
<input type=radio name="Variable303" value="4">Neutral<br>
<input type=radio name="Variable303" value="5">Somewhat Disagree<br>
<input type=radio name="Variable303" value="6">Disagree<br>
<input type=radio name="Variable303" value="7">Strongly Disagree<br>
<input type=radio name="Variable303" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability testing/methods will make the software 'easier to use'</font><br>
<input type=radio name="Variable304" value="1">Strongly Agree<br>
<input type=radio name="Variable304" value="2">Agree<br>
<input type=radio name="Variable304" value="3">Somewhat Agree<br>
<input type=radio name="Variable304" value="4">Neutral<br>
<input type=radio name="Variable304" value="5">Somewhat Disagree<br>
<input type=radio name="Variable304" value="6">Disagree<br>
<input type=radio name="Variable304" value="7">Strongly Disagree<br>
<input type=radio name="Variable304" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Good Usability comes at the expense of creative design</font><br>
<input type=radio name="Variable305" value="1">Strongly Agree<br>
<input type=radio name="Variable305" value="2">Agree<br>
<input type=radio name="Variable305" value="3">Somewhat Agree<br>
<input type=radio name="Variable305" value="4">Neutral<br>
<input type=radio name="Variable305" value="5">Somewhat Disagree<br>
<input type=radio name="Variable305" value="6">Disagree<br>
<input type=radio name="Variable305" value="7">Strongly Disagree<br>
<input type=radio name="Variable305" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability testing/methods are highly important in your professional work</font><br>
<input type=radio name="Variable306" value="1">Strongly Agree<br>
<input type=radio name="Variable306" value="2">Agree<br>
<input type=radio name="Variable306" value="3">Somewhat Agree<br>
<input type=radio name="Variable306" value="4">Neutral<br>
<input type=radio name="Variable306" value="5">Somewhat Disagree<br>
<input type=radio name="Variable306" value="6">Disagree<br>
<input type=radio name="Variable306" value="7">Strongly Disagree<br>
<input type=radio name="Variable306" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">I've seen usability make a difference</font><br>
<input type=radio name="Variable307" value="1">Strongly Agree<br>
<input type=radio name="Variable307" value="2">Agree<br>
<input type=radio name="Variable307" value="3">Somewhat Agree<br>
<input type=radio name="Variable307" value="4">Neutral<br>
<input type=radio name="Variable307" value="5">Somewhat Disagree<br>
<input type=radio name="Variable307" value="6">Disagree<br>
<input type=radio name="Variable307" value="7">Strongly Disagree<br>
<input type=radio name="Variable307" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability methods/testing increases the level of end user satisfaction with the final product</font><br>
<input type=radio name="Variable308" value="1">Strongly Agree<br>
<input type=radio name="Variable308" value="2">Agree<br>
<input type=radio name="Variable308" value="3">Somewhat Agree<br>
<input type=radio name="Variable308" value="4">Neutral<br>
<input type=radio name="Variable308" value="5">Somewhat Disagree<br>
<input type=radio name="Variable308" value="6">Disagree<br>
<input type=radio name="Variable308" value="7">Strongly Disagree<br>
<input type=radio name="Variable308" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability methods will increase the level of 'learnability' of the software</font><br>
<input type=radio name="Variable309" value="1">Strongly Agree<br>
<input type=radio name="Variable309" value="2">Agree<br>
<input type=radio name="Variable309" value="3">Somewhat Agree<br>
<input type=radio name="Variable309" value="4">Neutral<br>
<input type=radio name="Variable309" value="5">Somewhat Disagree<br>
<input type=radio name="Variable309" value="6">Disagree<br>
<input type=radio name="Variable309" value="7">Strongly Disagree<br>
<input type=radio name="Variable309" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability methods will increase the level of 'efficiency' with which end users perform tasks</font><br>
<input type=radio name="Variable310" value="1">Strongly Agree<br>
<input type=radio name="Variable310" value="2">Agree<br>
<input type=radio name="Variable310" value="3">Somewhat Agree<br>
<input type=radio name="Variable310" value="4">Neutral<br>
<input type=radio name="Variable310" value="5">Somewhat Disagree<br>
<input type=radio name="Variable310" value="6">Disagree<br>
<input type=radio name="Variable310" value="7">Strongly Disagree<br>
<input type=radio name="Variable310" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">My Organisation places little emphasis on the use of Usability methods and/or testing</font><br>
<input type=radio name="Variable311" value="1">Strongly Agree<br>
<input type=radio name="Variable311" value="2">Agree<br>
<input type=radio name="Variable311" value="3">Somewhat Agree<br>
<input type=radio name="Variable311" value="4">Neutral<br>
<input type=radio name="Variable311" value="5">Somewhat Disagree<br>
<input type=radio name="Variable311" value="6">Disagree<br>
<input type=radio name="Variable311" value="7">Strongly Disagree<br>
<input type=radio name="Variable311" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Section Two

If you have been involved in the use of Usability methods and/or testing, please complete the following section, otherwise, complete section three
</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Please select from the list below whether the stated Usability method was used, and (if applicable) the number of times each was employed.</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Method - Usability Walkthrough</font><br>
<input type=radio name="Variable314" value="1">Yes<br>
<input type=radio name="Variable314" value="2">No<br>
<input type=radio name="Variable314" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Method - Heuristic evaluation</font><br>
<input type=radio name="Variable315" value="1">Yes<br>
<input type=radio name="Variable315" value="2">No<br>
<input type=radio name="Variable315" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Method - User testing</font><br>
<input type=radio name="Variable316" value="1">Yes<br>
<input type=radio name="Variable316" value="2">No<br>
<input type=radio name="Variable316" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Method - Paper Prototyping</font><br>
<input type=radio name="Variable317" value="1">Yes<br>
<input type=radio name="Variable317" value="2">No<br>
<input type=radio name="Variable317" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">method - Card Sorting</font><br>
<input type=radio name="Variable318" value="1">Yes<br>
<input type=radio name="Variable318" value="2">No<br>
<input type=radio name="Variable318" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Method - content modelling</font><br>
<input type=radio name="Variable319" value="1">Yes<br>
<input type=radio name="Variable319" value="2">No<br>
<input type=radio name="Variable319" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">other</font><br>
<input type=radio name="Variable320" value="1">Yes<br>
<input type=radio name="Variable320" value="2">No<br>
<input type=radio name="Variable320" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">other - please specify</font><br>
<input type="text" name="Variable_321" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usability Walkthrough - number of times used</font><br>
<input type="text" name="Variable_322" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Heuristic evaluation - number of times used</font><br>
<input type="text" name="Variable_323" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">User testing - number of times used</font><br>
<input type="text" name="Variable_324" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Paper Prototyping - number of times used</font><br>
<input type="text" name="Variable_325" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Card Sorting - number of times used</font><br>
<input type="text" name="Variable_326" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Other - number of times used</font><br>
<input type="text" name="Variable_327" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">On what percentage of projects do you use usability techniques of some kind?</font><br>
<input type="text" name="Variable_328" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Approximate amount of time taken to employ these methods (per project)? (hours/days)</font><br>
<input type="text" name="Variable_329" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Approximate cost of this technique(s) per project</font><br>
<input type="text" name="Variable_330" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Who performed the testing - was it internal or outsourced?</font><br>
<textarea name="Variable_331" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Do you anticipate hiring a Usability professional, either on contract or as a permanent employee in the next year?</font><br>
<input type=radio name="Variable332" value="1">Yes<br>
<input type=radio name="Variable332" value="2">No<br>
<input type=radio name="Variable332" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If yes, how many?</font><br>
<input type="text" name="Variable_333" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How likely is it that you will use such usability methods again?</font><br>
<input type=radio name="Variable336" value="1">Highly Likely<br>
<input type=radio name="Variable336" value="2">Likely<br>
<input type=radio name="Variable336" value="3">Somewhat Likely<br>
<input type=radio name="Variable336" value="4">Neutral<br>
<input type=radio name="Variable336" value="5">Somewhat Unlikely<br>
<input type=radio name="Variable336" value="6">Unlikely<br>
<input type=radio name="Variable336" value="7">Highly Unlikely<br>
<input type=radio name="Variable336" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Has the use of usability increased in your Organisation in the last year?</font><br>
<input type=radio name="Variable337" value="1">Yes<br>
<input type=radio name="Variable337" value="2">No<br>
<input type=radio name="Variable337" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">To what extent do you consider users with disabilities when designing software?</font><br>
<input type=radio name="Variable338" value="1">Strongly Agree<br>
<input type=radio name="Variable338" value="2">Agree<br>
<input type=radio name="Variable338" value="3">Somewhat Agree<br>
<input type=radio name="Variable338" value="4">Neutral<br>
<input type=radio name="Variable338" value="5">Somewhat Disagree<br>
<input type=radio name="Variable338" value="6">Disagree<br>
<input type=radio name="Variable338" value="7">Strongly Disagree<br>
<input type=radio name="Variable338" value="8">Not Applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">To what extent do you believe this method(s) increased the overall quality of the software produced?</font><br>
<input type=radio name="Variable334" value="1">Very Significantly<br>
<input type=radio name="Variable334" value="2">Significantly<br>
<input type=radio name="Variable334" value="3">Somewhat Significantly<br>
<input type=radio name="Variable334" value="4">Neutral<br>
<input type=radio name="Variable334" value="5">Somewhat Insignificantly<br>
<input type=radio name="Variable334" value="6">Insignificantly<br>
<input type=radio name="Variable334" value="7">Very Insignificantly<br>
<input type=radio name="Variable334" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">To what extent do you  believe the use of this method increased the overall level of end-user satisfaction with the software?</font><br>
<input type=radio name="Variable335" value="1">Very Significantly<br>
<input type=radio name="Variable335" value="2">Significantly<br>
<input type=radio name="Variable335" value="3">Somewhat Significantly<br>
<input type=radio name="Variable335" value="4">Neutral<br>
<input type=radio name="Variable335" value="5">Somewhat Insignificantly<br>
<input type=radio name="Variable335" value="6">Insignificantly<br>
<input type=radio name="Variable335" value="7">Very Insignificantly<br>
<input type=radio name="Variable335" value="8">Not applicable<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Do you or any of your employees receive/have received training in Usability?</font><br>
<input type=radio name="Variable339" value="1">Yes<br>
<input type=radio name="Variable339" value="2">No<br>
<input type=radio name="Variable339" value="3">unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Do you know of any Usability companies or consultancies in New Zealand?</font><br>
<input type=radio name="Variable340" value="1">Yes<br>
<input type=radio name="Variable340" value="2">No<br>
<input type=radio name="Variable340" value="3">Unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If yes, please state the Organisation's name (if known)</font><br>
<input type="text" name="Variable_341" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Do you know of any Usability companies overseas?</font><br>
<input type=radio name="Variable342" value="1">Yes<br>
<input type=radio name="Variable342" value="2">No<br>
<input type=radio name="Variable342" value="3">Unsure<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If yes, please state the name of the Organisation (if known)</font><br>
<input type="text" name="Variable_343" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Where do you consider the responsibility of Usability to lie in your Organisation?  Please select all that apply</font><br>
<input type="checkbox" name="Variable344" value="1">IT<br>
<input type="checkbox" name="Variable344" value="2">Communications<br>
<input type="checkbox" name="Variable344" value="3">Marketing<br>
<input type="checkbox" name="Variable344" value="4">Other<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If 'Other' please state</font><br>
<input type="text" name="Variable_345" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How would you define "Usability"</font><br>
<textarea name="Variable_346" cols=40 rows=3></textarea><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Content Modelling - number of times used</font><br>
<input type="text" name="Variable_373" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">What general types of software does your organisation/department develop?</font><br>
<input type="checkbox" name="Variable364" value="1">Application software for re-sale<br>
<input type="checkbox" name="Variable364" value="2">Application software for in-house use<br>
<input type="checkbox" name="Variable364" value="3">Application software for individual clients<br>
<input type="checkbox" name="Variable364" value="4">Systems software for re-sale<br>
<input type="checkbox" name="Variable364" value="5">Systems software for in-house use<br>
<input type="checkbox" name="Variable364" value="6">Systems software for individual clients<br>
<input type="checkbox" name="Variable364" value="7">None, that is, we implement packaged solutions<br>
<input type="checkbox" name="Variable364" value="8">Other<br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">If 'other' then please specify</font><br>
<input type="text" name="Variable_365" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Approximately, how long has your organisation been in existence (in years)?</font><br>
<input type="text" name="Variable_366" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How many full time employees in your Organisation?</font><br>
<input type="text" name="Variable_367" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">How many part time employees in your Organisation?</font><br>
<input type="text" name="Variable_368" size=40><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Thank you for your cooperation in completing this questionnaire.
If you have any queries, please contact me:

</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Emma Sharkey,  Email: e.sharkey@auckland.ac.nz
Or my supervisor: Mr. John Paynter, Phone: 373-7599 ext 87385    E-mail: j.paynter@auckland.ac.nz 
</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">The Chair, The University of Auckland Human Subjects Ethics Committee,
The University of Auckland, Research Office - Office of the Vice Chancellor, Private Bag 92019, Auckland.  Tel. 373-7999 extn 87830
</font><br>
<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">APPROVED BY THE UNIVERSITY OF AUCKLAND HUMAN SUBJECTS ETHICS COMMITTEE on18/06/2003 for a period of 3 years, from18/06/2003 (Reference 2003/ Q / 017)</font><br>
<br>
<input type="submit" value="Submit"></form></cfoutput>
<br>
