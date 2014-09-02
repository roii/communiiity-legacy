<cfset insert_Startdate = CreateDate(form.FromDate_year,  form.FromDate_month,  form.FromDate_day)>

<cfset insert_Enddate = CreateDate(form.ToDate_year,  form.ToDate_month,  form.ToDate_day)>


<cfquery name="qry_questionairre_edit" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE NewQuestionaires
SET Questionaire_Name='#form.Questionaire_Name#',
Questionaire_details='#form.Questionaire_details#',
Questionaire_endDetails='#form.Questionaire_endDetails#',
Questionaire_status='#form.Questionaire_status#',
Questionaire_startdate=#CreateODBCDate(insert_Startdate)#,
Questionaire_enddate=#CreateODBCDate(insert_Enddate)#,

<cfif IsNumeric("#form.Reward_Points#")>
	Reward_Points=#form.Reward_Points#,
<cfelse>
	Reward_Points=0,
</cfif>

<cfif IsNumeric("#form.Reward_Cash#")>
	Reward_Cash=#form.Reward_Cash#,
<cfelse>
	Reward_Cash=0,
</cfif>

<cfif IsNumeric("#form.Reward_Education#")>
	Reward_Education=#form.Reward_Education#,
<cfelse>
	Reward_Education=0,
</cfif>

<cfif IsNumeric("#form.Reward_PrizeEntries#")>
	Reward_PrizeEntries=#form.Reward_PrizeEntries#,
<cfelse>
	Reward_PrizeEntries=0,
</cfif>


Reward_Other='#form.Reward_Other#'


WHERE QuestionaireID=#form.QuestionaireID#
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?details_editmode=closed">		