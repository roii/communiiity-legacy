<cfset formid ="23"><cfparam name="tablequestions" default="questions"><cfparam name="setupdir" default="http://www.business.auckland.ac.nz/surveyengine/survey"><cfparam name="vendorid" default="0">


	<cfoutput>
	<table width="600" align="center"><tr><td align="center">
	<img align="middle" src="http://www.business.auckland.ac.nz/comwebcontent/images/mba/mbaSurvey.gif">
	</td></tr><tr><td>
	<h1>Student Satisfaction Survey</h1>
	<p> The Auckland MBA is committed to world-class executive education and development of the future business leaders. With this objective in mind we are keen to get feed back from all MBA students currently enrolled on the programme.  Your opinion and the opinions of others associated with the programme are vital for quality assurance and ongoing programme development. </p> 

    <p>This electronic questionnaire ensures that we can gather information on a confidential and anonymous basis.  It also enables us to combine your responses with those from other programme participant to enable us to assess the overall student satisfaction.</p>

    <p>We are looking for an evaluation of the overall programme, not feedback on any particular lecturer, administrator, or course.</p>

    <p>The results will be forwarded to the MBA Director's Advisory Board for evaluation and consideration.  Consolidated results will also be shown on The Auckland MBA web site.</p>
  </td></tr> <tr><td>
	<form action="http://www.business.auckland.ac.nz/surveyengine/survey/default.cfm" method="post">
	<input type="hidden" name="formid" value="23">
	<input type="hidden" name="vendorid" value="0">
	<input type="hidden" name="itemid" value="#itemid#"> 
<hr>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Course</font><br>

<input type=radio name="Variable83" value="1">2003 cohort programme<br>

<input type=radio name="Variable83" value="2">Transition programme<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Period covered</font><br>

<input type=radio name="Variable84" value="1">End of Trimester 1 2003<br>

<input type=radio name="Variable84" value="2">End of Trimester 2 2003<br>

<input type=radio name="Variable84" value="3">End of Trimester 3 2003<br>

<br>
<hr>
<h3>Looking back on over last trimester; how satisfied are you with:</h3>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Course content</font><br>

<input type=radio name="Variable85" value="1">Excellent<br>

<input type=radio name="Variable85" value="2">Very Good<br>

<input type=radio name="Variable85" value="3">Good<br>

<input type=radio name="Variable85" value="4">Fair<br>

<input type=radio name="Variable85" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Mix of theory and pratice</font><br>

<input type=radio name="Variable86" value="1">Excellent<br>

<input type=radio name="Variable86" value="2">Very Good<br>

<input type=radio name="Variable86" value="3">Good<br>

<input type=radio name="Variable86" value="4">Fair<br>

<input type=radio name="Variable86" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Course(s) delivered on or exceeded expectations</font><br>

<input type=radio name="Variable87" value="1">Excellent<br>

<input type=radio name="Variable87" value="2">Very Good<br>

<input type=radio name="Variable87" value="3">Good<br>

<input type=radio name="Variable87" value="4">Fair<br>

<input type=radio name="Variable87" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Analytical skills taught</font><br>

<input type=radio name="Variable88" value="1">Excellent<br>

<input type=radio name="Variable88" value="2">Very Good<br>

<input type=radio name="Variable88" value="3">Good<br>

<input type=radio name="Variable88" value="4">Fair<br>

<input type=radio name="Variable88" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Problem solving skills taught</font><br>

<input type=radio name="Variable89" value="1">Excellent<br>

<input type=radio name="Variable89" value="2">Very Good<br>

<input type=radio name="Variable89" value="3">Good<br>

<input type=radio name="Variable89" value="4">Fair<br>

<input type=radio name="Variable89" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Synthesis skills taught (recombining parts)</font><br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Skills relating to making presentation and handling questions</font><br>

<input type=radio name="Variable91" value="1">Excellent<br>

<input type=radio name="Variable91" value="2">Very Good<br>

<input type=radio name="Variable91" value="3">Good<br>

<input type=radio name="Variable91" value="4">Fair<br>

<input type=radio name="Variable91" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Feedback from lecturer(s)</font><br>

<input type=radio name="Variable92" value="1">Excellent<br>

<input type=radio name="Variable92" value="2">Very Good<br>

<input type=radio name="Variable92" value="3">Good<br>

<input type=radio name="Variable92" value="4">Fair<br>

<input type=radio name="Variable92" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Pastoral Care (support) of lecturer(s)</font><br>

<input type=radio name="Variable93" value="1">Excellent<br>

<input type=radio name="Variable93" value="2">Very Good<br>

<input type=radio name="Variable93" value="3">Good<br>

<input type=radio name="Variable93" value="4">Fair<br>

<input type=radio name="Variable93" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">The workload associated with your course(s)</font><br>

<input type=radio name="Variable94" value="1">High<br>

<input type=radio name="Variable94" value="2">Somewhat High<br>

<input type=radio name="Variable94" value="3">Average<br>

<input type=radio name="Variable94" value="4">Somewhat Low<br>

<input type=radio name="Variable94" value="5">Low<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Personal development in terms of Increased knowledge</font><br>

<input type=radio name="Variable95" value="1">Excellent<br>

<input type=radio name="Variable95" value="2">Very Good<br>

<input type=radio name="Variable95" value="3">Good<br>

<input type=radio name="Variable95" value="4">Fair<br>

<input type=radio name="Variable95" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Increased Confidence</font><br>

<input type=radio name="Variable96" value="1">Strongly Agree<br>

<input type=radio name="Variable96" value="2">Agree<br>

<input type=radio name="Variable96" value="3">I don't know<br>

<input type=radio name="Variable96" value="4">Disagree<br>

<input type=radio name="Variable96" value="5">Strongly Disagree<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Strategic thinking</font><br>

<input type=radio name="Variable97" value="1">Significant<br>

<input type=radio name="Variable97" value="2">Somewhat Significant<br>

<input type=radio name="Variable97" value="3">Neutral<br>

<input type=radio name="Variable97" value="4">Somewhat Insignificant<br>

<input type=radio name="Variable97" value="5">Insignificant<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Leadership Skills</font><br>

<input type=radio name="Variable98" value="1">Excellent<br>

<input type=radio name="Variable98" value="2">Very Good<br>

<input type=radio name="Variable98" value="3">Good<br>

<input type=radio name="Variable98" value="4">Fair<br>

<input type=radio name="Variable98" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Entrepreneurial skills</font><br>

<input type=radio name="Variable99" value="1">Excellent<br>

<input type=radio name="Variable99" value="2">Very Good<br>

<input type=radio name="Variable99" value="3">Good<br>

<input type=radio name="Variable99" value="4">Fair<br>

<input type=radio name="Variable99" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Communication Skills</font><br>

<input type=radio name="Variable100" value="1">Significant<br>

<input type=radio name="Variable100" value="2">Somewhat Significant<br>

<input type=radio name="Variable100" value="3">Neutral<br>

<input type=radio name="Variable100" value="4">Somewhat Insignificant<br>

<input type=radio name="Variable100" value="5">Insignificant<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Usefulness for career/work</font><br>

<input type=radio name="Variable101" value="1">Useful<br>

<input type=radio name="Variable101" value="2">Somewhat Useful<br>

<input type=radio name="Variable101" value="3">Neutral<br>

<input type=radio name="Variable101" value="4">Somewhat Unuseful<br>

<input type=radio name="Variable101" value="5">Unuseful<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">The standard and appropriateness of the selection and admission</font><br>

<input type=radio name="Variable102" value="1">Excellent<br>

<input type=radio name="Variable102" value="2">Very Good<br>

<input type=radio name="Variable102" value="3">Good<br>

<input type=radio name="Variable102" value="4">Fair<br>

<input type=radio name="Variable102" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Comradeship and collegiality in your programme</font><br>

<input type=radio name="Variable103" value="1">Excellent<br>

<input type=radio name="Variable103" value="2">Very Good<br>

<input type=radio name="Variable103" value="3">Good<br>

<input type=radio name="Variable103" value="4">Fair<br>

<input type=radio name="Variable103" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Environment at Short Street</font><br>

<input type=radio name="Variable104" value="1">Excellent<br>

<input type=radio name="Variable104" value="2">Very Good<br>

<input type=radio name="Variable104" value="3">Good<br>

<input type=radio name="Variable104" value="4">Fair<br>

<input type=radio name="Variable104" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Food</font><br>

<input type=radio name="Variable105" value="1">Excellent<br>

<input type=radio name="Variable105" value="2">Very Good<br>

<input type=radio name="Variable105" value="3">Good<br>

<input type=radio name="Variable105" value="4">Fair<br>

<input type=radio name="Variable105" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Parking</font><br>

<input type=radio name="Variable106" value="1">Excellent<br>

<input type=radio name="Variable106" value="2">Very Good<br>

<input type=radio name="Variable106" value="3">Good<br>

<input type=radio name="Variable106" value="4">Fair<br>

<input type=radio name="Variable106" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Safety</font><br>

<input type=radio name="Variable107" value="1">Excellent<br>

<input type=radio name="Variable107" value="2">Very Good<br>

<input type=radio name="Variable107" value="3">Good<br>

<input type=radio name="Variable107" value="4">Fair<br>

<input type=radio name="Variable107" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Class timing</font><br>

<input type=radio name="Variable108" value="1">Excellent<br>

<input type=radio name="Variable108" value="2">Very Good<br>

<input type=radio name="Variable108" value="3">Good<br>

<input type=radio name="Variable108" value="4">Fair<br>

<input type=radio name="Variable108" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Administration support from MBA team</font><br>

<input type=radio name="Variable109" value="1">Excellent<br>

<input type=radio name="Variable109" value="2">Very Good<br>

<input type=radio name="Variable109" value="3">Good<br>

<input type=radio name="Variable109" value="4">Fair<br>

<input type=radio name="Variable109" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Central administration at the Registry(enrolment etc)</font><br>

<input type=radio name="Variable110" value="1">Excellent<br>

<input type=radio name="Variable110" value="2">Very Good<br>

<input type=radio name="Variable110" value="3">Good<br>

<input type=radio name="Variable110" value="4">Fair<br>

<input type=radio name="Variable110" value="5">Poor<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Overall, how satisfied are you with the programme, based on your experience in the last trimester?</font><br>

<input type=radio name="Variable111" value="1">Significantly Better<br>

<input type=radio name="Variable111" value="2">Better<br>

<input type=radio name="Variable111" value="3">Neutral<br>

<input type=radio name="Variable111" value="4">Worse<br>

<input type=radio name="Variable111" value="5">Significantly Worse<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Whould you recommend The Auckland MBA to others?</font><br>

<input type=radio name="Variable112" value="1">Highly Likely<br>

<input type=radio name="Variable112" value="2">Likely<br>

<input type=radio name="Variable112" value="3">Neutral<br>

<input type=radio name="Variable112" value="4">Unlikely<br>

<input type=radio name="Variable112" value="5">Highly Unlikely<br>

<br>

<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Feedback or Suggestions</font><br>

<textarea name="Variable_113" cols=40 rows=3></textarea><br>

<br>
<font face="Arial, Helvetica" size=3 color="000000" style="color:000000;font-weight:bold;">Please record and feedback and suggestion regarding improvement of this Student Satisfaction Survey</font><br>

<textarea name="Variable_117" cols=40 rows=5></textarea><br>

<br>


<input type="submit" value="Submit"></form></cfoutput>
<br>
</td></tr></table>
