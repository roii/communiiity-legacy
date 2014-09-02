<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>Survey Results Report</title>

<cfquery  name="Questions" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * from questions where formid = #trim(attributes.surveyid)# order by displayorder
</cfquery>

<cfoutput>	
<cfquery name="SurveyDetails" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * FROM forms,surveycom where forms.comid = surveycom.surveycomID and formid=#attributes.surveyid#
</cfquery>

<cfif surveyDetails.comlogo neq ''>
  <p><img src="#request.webroot#/surveyengine/images/#surveyDetails.comlogo#" border=0></p>
<cfelse>
  <h3>#surveyDetails.comName#</h3>
</cfif>
<h3>#surveyDetails.title#</h3>
<br>
<hr>
<br>
		<!--- Table Header --->
<cfloop query="Questions">
		<cfset qid = #Questions.id#>
		<table  border="#tableborder#" width="#tablewidth#" cellpadding="3" cellspacing="0">
		<tr><td>
			&nbsp;<b><font face="Arial" size="2" color="##000000">#Questions.question#</font></b><br>
		</td></tr></table>
		
		<!--- If the question type is not Open Question than display Graphs --->
		<cfif ((Questions.questiontype is not "5") AND (Questions.questiontype is not "6"))>
		
			<cfquery  name="Choices" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
				SELECT * FROM surveyChoice where QId = #qid#
			</cfquery>
            
			<table width="100%" border="0"><tr><td>
				<!--- Dynamic Chart --->
				<table border="0"  border="#tableborder#" width="#tablewidth#" cellpadding="3" cellspacing="0">
				<tr>
					<td border="#tableborder#">
						<b><font face="Arial, Helvetica" size=2 color="##FFFFFF" style="color:##FFFFFF; text-decoration:none">Bar Chart</font></b>
					</td>
				</tr>
				<tr>
				<td valign="top" align="center">
				<APPLET CODE="BarChart.class" CODEBASE="CFGraphs/" WIDTH="#chartwidth#" HEIGHT="#chartheight#">
				<PARAM NAME="ChartData.Columns" VALUE="Items,Values"> 
				<PARAM NAME="ChartData.Items" VALUE="<cfloop query="Choices">#Choices.Choice#,</cfloop>"> 
				<PARAM NAME="ChartData.Values" VALUE="
				<cfloop query="Choices">
				   <cfquery  name="responses" datasource="#datasourceR#" username="mykidsbizcomi" password="u+67eNfJ">
				      SELECT * FROM surveyResponse where QId = #qid# and choiceID = #Choices.surveyChoiceId#
			       </cfquery>
				   #responses.recordcount#,
				</cfloop>"> 
				<PARAM NAME="Title" VALUE="Bar Chart"> 
				<PARAM NAME="TitleFontName" VALUE="Arial">
				<PARAM NAME="TitleFontHeight" VALUE="15">
				<PARAM NAME="DebugInfoEnabled" VALUE="yes">
				<PARAM NAME="Orientation" VALUE="horizontal">
				<PARAM NAME="BackgroundColor" VALUE="FFFFFF">
				This template displays Java based graph.<br>
				If you see this message it means that:<br>
				<H2> Your Browser Does Not Support JAVA!</H2> 
				</APPLET>
				</td></tr></table>
				
				</td>
				<td>
				<table  border="#tableborder#" width="#tablewidth#" cellpadding="3" cellspacing="0">
				<tr>
					<td  border="#tableborder#">
						<b><font face="Arial, Helvetica" size=2 color="##FFFFFF" style="color:##FFFFFF; text-decoration:none">Pie Chart</font></b>
					</td>
				</tr>
				<tr>
				<td valign="top" align="center">
				<APPLET CODE="PieChart.class" CODEBASE="CFGraphs/" WIDTH="#chartwidth#" HEIGHT="#chartheight#">
				<PARAM NAME="ChartData.Columns" VALUE="Items,Values"> 
				<PARAM NAME="ChartData.Items" VALUE="<cfloop query="Choices">#Choices.Choice#,</cfloop>"> 
				<PARAM NAME="ChartData.Values" VALUE="
				<cfloop query="Choices">
				   <cfquery  name="responses" datasource="#datasourceR#" username="mykidsbizcomi" password="u+67eNfJ">
				      SELECT * FROM surveyResponse where QId = #qid# and choiceID = #Choices.surveyChoiceId#
			       </cfquery>
				   #responses.recordcount#,
				</cfloop>">
				<PARAM NAME="Title" VALUE="Pie Chart"> 
				<PARAM NAME="TitleFontName" VALUE="Arial">
				<PARAM NAME="TitleFontHeight" VALUE="15">
				<PARAM NAME="DebugInfoEnabled" VALUE="yes">
				<PARAM NAME="Showlegend" VALUE="no">
				<PARAM NAME="Orientation" VALUE="horizontal">
				<PARAM NAME="BackgroundColor" VALUE="FFFFFF">
				This template displays Java based graph.<br>
				If you see this message it means that:<br>
				<H2> Your Browser Does Not Support JAVA!</H2> 
				</APPLET>
				</td>
				</tr></table>
			
		<cfelse>
		 <!---For open question type display grap 
		
			<cfinclude template="o010.cfm">	--->		
			<cfquery  name="OpenQ" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
				SELECT * FROM surveyResponse where QId = #qid#
			</cfquery>
			<cfif OpenQ.recordcount>
			  <table cellpadding="0" cellspacing="0" width="100%" border="1">
			  <cfloop query="OpenQ">
			     <cfif OpenQ.response neq ''>
				   <tr><td style="padding-left:15px;" bordercolordark="Black">
				    #OpenQ.response#
				   </td></tr>
				 </cfif>
			  </cfloop>
			  </table>
			</cfif>
		</td></cfif>
		</tr>
		</table>
	</cfloop>
</cfoutput>		
</html>

	