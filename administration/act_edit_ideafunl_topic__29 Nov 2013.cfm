<cfset dateExpires = DateFormat(form.WhenCategoryEnded, "d mmmm yyyy")>

<!--- UPDATE TOPIC INFO --->
<cfquery name="UpdateTopic" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE SugCategory
SET MainCatID=#form.MainCatID#,
Name='#form.Name#',
related_campaign = #form.related_campaign#,
Description='#form.description#',
WhenCategoryEnded=#createODBCDateTime(dateExpires)#,
PointsAllocated=#form.PointsAllocated#,
SponsorID=#form.SponsorID#,
Active=#form.Active#,
Moderators='#form.Moderators#',

<cfif IsNumeric("#form.DisplayOrder#")>
	DisplayOrder=#form.DisplayOrder#,
<cfelse>
	DisplayOrder=0,
</cfif>

<cfif IsDefined("form.ShowAdd") AND form.ShowAdd EQ 1>
	ShowAdd=1
<cfelse>
	ShowAdd=0
</cfif>

WHERE CategoryID=#form.CategoryID#
</cfquery>



<!--- UPDATE SETTINGS INFO --->
<cfquery name="UpdateSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE idea_topic_settings
SET Total_Pending=<cfif IsNumeric("#form.Total_Pending#")>#form.Total_Pending#<cfelse>0</cfif>,
Required_Pending=<cfif IsNumeric("#form.Required_Pending#")>#form.Required_Pending#<cfelse>0</cfif>,
Total_Stage_1=<cfif IsNumeric("#form.Total_Stage_1#")>#form.Total_Stage_1#<cfelse>0</cfif>,
Required_Stage_1=<cfif IsNumeric("#form.Required_Stage_1#")>#form.Required_Stage_1#<cfelse>0</cfif>,
Total_Stage_2=<cfif IsNumeric("#form.Total_Stage_2#")>#form.Total_Stage_2#<cfelse>0</cfif>,
Required_Stage_2=<cfif IsNumeric("#form.Required_Stage_2#")>#form.Required_Stage_2#<cfelse>0</cfif>,
Total_Stage_3=<cfif IsNumeric("#form.Total_Stage_3#")>#form.Total_Stage_3#<cfelse>0</cfif>,
Required_Stage_3=<cfif IsNumeric("#form.Required_Stage_3#")>#form.Required_Stage_3#<cfelse>0</cfif>,
Points_SubmitIdea=<cfif IsNumeric("#form.Points_SubmitIdea#")>#form.Points_SubmitIdea#<cfelse>0</cfif>,
Points_Vote=<cfif IsNumeric("#form.Points_Vote#")>#form.Points_Vote#<cfelse>0</cfif>,
Points_Feedback=<cfif IsNumeric("#form.Points_Feedback#")>#form.Points_Feedback#<cfelse>0</cfif>,
Points_Stage_1=<cfif IsNumeric("#form.Points_Stage_1#")>#form.Points_Stage_1#<cfelse>0</cfif>,
Points_Stage_2=<cfif IsNumeric("#form.Points_Stage_2#")>#form.Points_Stage_2#<cfelse>0</cfif>,
Points_Stage_3=<cfif IsNumeric("#form.Points_Stage_3#")>#form.Points_Stage_3#<cfelse>0</cfif>,
Points_Stage_4=<cfif IsNumeric("#form.Points_Stage_4#")>#form.Points_Stage_4#<cfelse>0</cfif>,
Prize_SubmitIdea=<cfif IsNumeric("#form.Prize_SubmitIdea#")>#form.Prize_SubmitIdea#<cfelse>0</cfif>,
Prize_Vote=<cfif IsNumeric("#form.Prize_Vote#")>#form.Prize_Vote#<cfelse>0</cfif>,
Prize_Feedback=<cfif IsNumeric("#form.Prize_Feedback#")>#form.Prize_Feedback#<cfelse>0</cfif>,
Prize_Stage_1=<cfif IsNumeric("#form.Prize_Stage_1#")>#form.Prize_Stage_1#<cfelse>0</cfif>,
Prize_Stage_2=<cfif IsNumeric("#form.Prize_Stage_2#")>#form.Prize_Stage_2#<cfelse>0</cfif>,
Prize_Stage_3=<cfif IsNumeric("#form.Prize_Stage_3#")>#form.Prize_Stage_3#<cfelse>0</cfif>,
Prize_Stage_4=<cfif IsNumeric("#form.Prize_Stage_4#")>#form.Prize_Stage_4#<cfelse>0</cfif>,

<cfif IsDefined("form.Use_Pending") AND form.Use_Pending EQ 1>
    Use_Pending=1,
<cfelse>
    Use_Pending=0,
</cfif>

<cfif IsDefined("form.Use_Stage1") AND form.Use_Stage1 EQ 1>
    Use_Stage1=1,
<cfelse>
    Use_Stage1=0,
</cfif>

<cfif IsDefined("form.Use_Stage2") AND form.Use_Stage2 EQ 1>
    Use_Stage2=1,
<cfelse>
    Use_Stage2=0,
</cfif>

<cfif IsDefined("form.Use_Stage3") AND form.Use_Stage3 EQ 1>
    Use_Stage3=1,
<cfelse>
    Use_Stage3=0,
</cfif>

<cfif IsDefined("form.Use_Stage4") AND form.Use_Stage4 EQ 1>
    Use_Stage4=1
<cfelse>
    Use_Stage4=0
</cfif>

WHERE TopicID=#form.CategoryID#
</cfquery>

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->	
<cfoutput>

<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	alert("You have updated the IDEAfunL Topic.");
	self.close();
}

// -->
</script>

<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_SugCat')"></body>


</cfoutput>