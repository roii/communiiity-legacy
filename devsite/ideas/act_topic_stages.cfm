<!--- GET TOPIC SETTINGS --->
<cfquery name="qry_topic_settings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM idea_topic_settings
WHERE TopicID = #this_categoryID#
</cfquery>



<cfset thisTopic_Use_Pending = qry_topic_settings.Use_Pending>
<cfset thisTopic_Use_Stage1 = qry_topic_settings.Use_Stage1>
<cfset thisTopic_Use_Stage2 = qry_topic_settings.Use_Stage2>
<cfset thisTopic_Use_Stage3 = qry_topic_settings.Use_Stage3>
<cfset thisTopic_Use_Stage4 = qry_topic_settings.Use_Stage4>
 
<cfif thisTopic_Use_Pending EQ 1>
    <cfif IsNumeric("#qry_topic_settings.Total_Pending#")>
        <cfset thisTopic_Total_Pending = qry_topic_settings.Total_Pending>
    <cfelse>
        <cfset thisTopic_Total_Pending = 0>
    </cfif>    
    <cfif IsNumeric("#qry_topic_settings.Required_Pending#")>
        <cfset thisTopic_Required_Pending = qry_topic_settings.Required_Pending>
    <cfelse>
        <cfset thisTopic_Required_Pending = 0>
    </cfif>   
<cfelse>
    <cfset thisTopic_Total_Pending = 0>	 
	<cfset thisTopic_Required_Pending = 0>
</cfif>    
 

<cfif thisTopic_Use_Stage1 EQ 1>
    <cfif IsNumeric("#qry_topic_settings.Total_Stage_1#")>
        <cfset thisTopic_Total_Stage_1 = qry_topic_settings.Total_Stage_1>
    <cfelse>
        <cfset thisTopic_Total_Stage_1 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Required_Stage_1#")>
        <cfset thisTopic_Required_Stage_1 = qry_topic_settings.Required_Stage_1>
    <cfelse>
        <cfset thisTopic_Required_Stage_1 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Points_Stage_1#")>
        <cfset thisTopic_Points_Stage_1 = qry_topic_settings.Points_Stage_1>
    <cfelse>
        <cfset thisTopic_Points_Stage_1 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Prize_Stage_1#")>
        <cfset thisTopic_Prize_Stage_1 = qry_topic_settings.Prize_Stage_1>
    <cfelse>
        <cfset thisTopic_Prize_Stage_1 = 0>
    </cfif>
<cfelse>
    <cfset thisTopic_Total_Stage_1 = 0>	
	<cfset thisTopic_Required_Stage_1 = 0>
	<cfset thisTopic_Points_Stage_1 = 0>
	<cfset thisTopic_Prize_Stage_1 = 0>
</cfif>
 
<cfif thisTopic_Use_Stage2 EQ 1>
    <cfif IsNumeric("#qry_topic_settings.Total_Stage_2#")>
        <cfset thisTopic_Total_Stage_2 = qry_topic_settings.Total_Stage_2>
    <cfelse>
        <cfset thisTopic_Total_Stage_2 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Required_Stage_2#")>
        <cfset thisTopic_Required_Stage_2 = qry_topic_settings.Required_Stage_2>
    <cfelse>
        <cfset thisTopic_Required_Stage_2 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Points_Stage_2#")>
        <cfset thisTopic_Points_Stage_2 = qry_topic_settings.Points_Stage_2>
    <cfelse>
        <cfset thisTopic_Points_Stage_2 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Prize_Stage_2#")>
        <cfset thisTopic_Prize_Stage_2 = qry_topic_settings.Prize_Stage_2>
    <cfelse>
        <cfset thisTopic_Prize_Stage_2 = 0>
    </cfif>
<cfelse>
    <cfset thisTopic_Total_Stage_2 = 0>	
	<cfset thisTopic_Required_Stage_2 = 0>
	<cfset thisTopic_Points_Stage_2 = 0>
	<cfset thisTopic_Prize_Stage_2 = 0>
</cfif>
    
<cfif thisTopic_Use_Stage3 EQ 1>
    <cfif IsNumeric("#qry_topic_settings.Total_Stage_3#")>
        <cfset thisTopic_Total_Stage_3 = qry_topic_settings.Total_Stage_3>
    <cfelse>
        <cfset thisTopic_Total_Stage_3 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Required_Stage_3#")>
        <cfset thisTopic_Required_Stage_3 = qry_topic_settings.Required_Stage_3>
    <cfelse>
        <cfset thisTopic_Required_Stage_3 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Points_Stage_3#")>
        <cfset thisTopic_Points_Stage_3 = qry_topic_settings.Points_Stage_3>
    <cfelse>
        <cfset thisTopic_Points_Stage_3 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Prize_Stage_3#")>
        <cfset thisTopic_Prize_Stage_3 = qry_topic_settings.Prize_Stage_3>
    <cfelse>
        <cfset thisTopic_Prize_Stage_3 = 0>
    </cfif>
<cfelse>
    <cfset thisTopic_Total_Stage_3 = 0>	
	<cfset thisTopic_Required_Stage_3 = 0>
	<cfset thisTopic_Points_Stage_3 = 0>
	<cfset thisTopic_Prize_Stage_3 = 0>
</cfif>

<cfif thisTopic_Use_Stage4 EQ 1>
    <cfif IsNumeric("#qry_topic_settings.Points_Stage_4#")>
        <cfset thisTopic_Points_Stage_4 = qry_topic_settings.Points_Stage_4>
    <cfelse>
        <cfset thisTopic_Points_Stage_4 = 0>
    </cfif>
    <cfif IsNumeric("#qry_topic_settings.Prize_Stage_4#")>
        <cfset thisTopic_Prize_Stage_4 = qry_topic_settings.Prize_Stage_4>
    <cfelse>
        <cfset thisTopic_Prize_Stage_4 = 0>
    </cfif>
<cfelse>
    <cfset thisTopic_Points_Stage_4 = 0>
	<cfset thisTopic_Prize_Stage_4 = 0>	
</cfif>

<cfif IsNumeric("#qry_topic_settings.Points_SubmitIdea#")>
    <cfset thisTopic_Points_SubmitIdea = qry_topic_settings.Points_SubmitIdea>
<cfelse>
    <cfset thisTopic_Points_SubmitIdea = 0>
</cfif>

<cfif IsNumeric("#qry_topic_settings.Points_Vote#")>
    <cfset thisTopic_Points_Vote = qry_topic_settings.Points_Vote>
<cfelse>
    <cfset thisTopic_Points_Vote = 0>
</cfif>

<cfif IsNumeric("#qry_topic_settings.Points_Feedback#")>
    <cfset thisTopic_Points_Feedback = qry_topic_settings.Points_Feedback>
<cfelse>
    <cfset thisTopic_Points_Feedback = 0>
</cfif>

<cfif IsNumeric("#qry_topic_settings.Prize_SubmitIdea#")>
    <cfset thisTopic_Prize_SubmitIdea = qry_topic_settings.Prize_SubmitIdea>
<cfelse>
    <cfset thisTopic_Prize_SubmitIdea = 0>
</cfif>

<cfif IsNumeric("#qry_topic_settings.Prize_Vote#")>
    <cfset thisTopic_Prize_Vote = qry_topic_settings.Prize_Vote>
<cfelse>
    <cfset thisTopic_Prize_Vote = 0>
</cfif>

<cfif IsNumeric("#qry_topic_settings.Prize_Feedback#")>
    <cfset thisTopic_Prize_Feedback = qry_topic_settings.Prize_Feedback>
<cfelse>
    <cfset thisTopic_Prize_Feedback = 0>
</cfif>
  
<cfset thisTopic_ActiveStageList = "0">

<cfif thisTopic_Use_Stage1 EQ 1>
    <cfset thisTopic_ActiveStageList = ListAppend(thisTopic_ActiveStageList, 'Stage 1', ",")>
</cfif>
<cfif thisTopic_Use_Stage2 EQ 1>
    <cfset thisTopic_ActiveStageList = ListAppend(thisTopic_ActiveStageList, 'Stage 2', ",")>
</cfif>
<cfif thisTopic_Use_Stage3 EQ 1>
    <cfset thisTopic_ActiveStageList = ListAppend(thisTopic_ActiveStageList, 'Stage 3', ",")>
</cfif>