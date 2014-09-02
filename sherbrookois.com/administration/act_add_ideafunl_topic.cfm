<cfset dateExpires = DateFormat(form.WhenCategoryEnded, "d mmmm yyyy")>


<!--- INSERT TOPIC INFO --->

<cfquery name="AddTopic" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO SugCategory(
	MainCatID,
	Name,
	Description,
	WhenCategoryCreated,
	WhenCategoryEnded,
	Priority,
	PointsAllocated,
	PointsUsed,
	PointsCutOff,
	SponsorID,
	Active,
	Moderators,
	DisplayOrder
)
VALUES(
	#form.MainCatID#,
	'#form.Name#',
	'#form.description#',
	#createODBCDateTime(localdatetime)#,
	#createODBCDateTime(dateExpires)#,
	0,
	#form.PointsAllocated#,
	0,
	#form.PointsCutOff#,
	#form.SponsorID#,
	#form.Active#,
	'#form.Moderators#',
	<cfif IsNumeric("#form.DisplayOrder#")>
		#form.DisplayOrder#
	<cfelse>
		0
	</cfif>

)
</cfquery>


<cfquery name="LastTopic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT CategoryID
FROM SugCategory
ORDER BY CategoryID DESC
</cfquery>

<!--- INSERT SETTINGS INFO --->
<cfquery name="insertSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO idea_topic_settings 
		(
			TopicID, 
			Total_Pending, 
			Required_Pending, 
			Total_Stage_1, 
			Required_Stage_1, 
			Total_Stage_2, 
			Required_Stage_2, 
			Total_Stage_3, 
			Required_Stage_3, 
			Points_SubmitIdea, 
			Points_Vote, 
			Points_Feedback, 
			Points_Stage_1, 
			Points_Stage_2, 
			Points_Stage_3, 
			Points_Stage_4, 
			Prize_SubmitIdea, 
			Prize_Vote, 
			Prize_Feedback, 
			Prize_Stage_1, 
			Prize_Stage_2, 
			Prize_Stage_3, 
			Prize_Stage_4, 
			Use_Pending, 
			Use_Stage1, 
			Use_Stage2, 
			Use_Stage3, 
			Use_Stage4
		)
	VALUES
	(
		#LastTopic.CategoryID#, 
		<cfif IsNumeric("#form.Total_Pending#")>#form.Total_Pending#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Required_Pending#")>#form.Required_Pending#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Total_Stage_1#")>#form.Total_Stage_1#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Required_Stage_1#")>#form.Required_Stage_1#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Total_Stage_2#")>#form.Total_Stage_2#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Required_Stage_2#")>#form.Required_Stage_2#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Total_Stage_3#")>#form.Total_Stage_3#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Required_Stage_3#")>#form.Required_Stage_3#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Points_SubmitIdea#")>#form.Points_SubmitIdea#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Points_Vote#")>#form.Points_Vote#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Points_Feedback#")>#form.Points_Feedback#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Points_Stage_1#")>#form.Points_Stage_1#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Points_Stage_2#")>#form.Points_Stage_2#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Points_Stage_3#")>#form.Points_Stage_3#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Points_Stage_4#")>#form.Points_Stage_4#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Prize_SubmitIdea#")>#form.Prize_SubmitIdea#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Prize_Vote#")>#form.Prize_Vote#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Prize_Feedback#")>#form.Prize_Feedback#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Prize_Stage_1#")>#form.Prize_Stage_1#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Prize_Stage_2#")>#form.Prize_Stage_2#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Prize_Stage_3#")>#form.Prize_Stage_3#<cfelse>0</cfif>, 
		<cfif IsNumeric("#form.Prize_Stage_4#")>#form.Prize_Stage_4#<cfelse>0</cfif>, 
		<cfif IsDefined("form.Use_Pending") AND form.Use_Pending EQ 1>1,<cfelse>0,</cfif>
		<cfif IsDefined("form.Use_Stage1") AND form.Use_Stage1 EQ 1>1,<cfelse>0,</cfif>
		<cfif IsDefined("form.Use_Stage2") AND form.Use_Stage2 EQ 1>1,<cfelse>0,</cfif>
		<cfif IsDefined("form.Use_Stage3") AND form.Use_Stage3 EQ 1>1,<cfelse>0,</cfif>
		<cfif IsDefined("form.Use_Stage4") AND form.Use_Stage4 EQ 1>1<cfelse>0</cfif>
		)
</cfquery>

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
<cfoutput>


<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	alert("You have created the new IDEAfunL Topic.");
	self.close();
}

// -->
</script>

<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_SugCat')"></body>


</cfoutput>