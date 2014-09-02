<cfset insert_Startdate = CreateDate(form.FromDate_year,  form.FromDate_month,  form.FromDate_day)>
<cfset insert_Enddate = CreateDate(form.ToDate_year,  form.ToDate_month,  form.ToDate_day)>



<!--- INSERT THE RECORD --->

	<cfquery name="NextID" datasource="#DSN#" maxrows="1" username="#request.username#" password="#request.password#">
	SELECT QuestionaireID
	FROM NewQuestionaires
	ORDER BY QuestionaireID DESC
	</cfquery>
		
		
	<cfif NextID.recordcount>
		<cfset newID = (NextID.QuestionaireID + 1)>
	<cfelse>
		<cfset newID = 1>
	</cfif>


<cfquery name="qry_questionairre_edit" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO NewQuestionaires(QuestionaireID,
Questionaire_Name,
Questionaire_details,
Questionaire_endDetails,
Questionaire_status,
Questionaire_startdate,
Questionaire_enddate,
Reward_Points,
Reward_Cash,
Reward_Education,
Reward_PrizeEntries,
Reward_Other,
Deleted)
VALUES(#newID#,
'#form.Questionaire_Name#',
'#form.Questionaire_details#',
'#form.Questionaire_endDetails#',
'#form.Questionaire_status#',
#CreateODBCDate(insert_Startdate)#,
#CreateODBCDate(insert_Enddate)#,

<cfif IsNumeric("#form.Reward_Points#")>
	#form.Reward_Points#,
<cfelse>
	0,
</cfif>

<cfif IsNumeric("#form.Reward_Cash#")>
	#form.Reward_Cash#,
<cfelse>
	0,
</cfif>

<cfif IsNumeric("#form.Reward_Education#")>
	#form.Reward_Education#,
<cfelse>
	0,
</cfif>

<cfif IsNumeric("#form.Reward_Other#")>
	#form.Reward_Other#,
<cfelse>
	0,
</cfif>

'#form.Reward_Other#',
0)
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?details_editmode=closed&QuestionaireID=#newID#">		