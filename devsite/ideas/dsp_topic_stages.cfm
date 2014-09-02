<cfoutput>

<cfquery name="qry_category_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Name, Description
FROM SugCategory
WHERE CategoryID=#TopicID#
</cfquery>
	
<cfquery name="qry_stage_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM idea_topic_settings
WHERE TopicID=#TopicID#
</cfquery>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Idea Topic Stages &amp; Rewards</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="ffffff">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Idea Topic Stages &amp; Rewards</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top" style="padding-left:10px;padding-right:10px;">
<br>


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td><strong>#TRIM(qry_category_details.Name)#</strong></td>
	</tr>
	
	</table><hr width="100%" size="1" color="e2e2e2">      
       
    <span style="font-size:11px;">
    <li><u>Total Votes</u> - The total number of votes possible before idea moves forward or is dumped</li>       
    <li><u>Required Yes</u> - Number of YES vote required to make it through to the next stage</li>   
    <li><u>Rewards</u> - Points rewarded for making it through to this stage</li>   
    <li><u>Prize Entries</u> - Prize Entries rewarded for making it through to this stage</li><br><br><br>
    </span>
    
    <table cellpadding="0" cellspacing="0" border="0" width="100%">		
		
    <tr>
    <td style="font-size:11px;color:6c6c6c;padding-right:10px;">&nbsp;</td>
    <td style="font-size:11px;color:6c6c6c;padding-left:10px;padding-right:10px;" nowrap align="center"><strong>Total Votes</strong></td>
    <td style="font-size:11px;color:6c6c6c;padding-left:10px;padding-right:10px;" nowrap align="center"><strong>Required "Yes"</strong></td>
    <td style="font-size:11px;color:6c6c6c;padding-left:10px;padding-right:10px;" nowrap align="center"><strong>Rewards</strong></td>
    <td style="font-size:11px;color:6c6c6c;padding-left:10px;padding-right:10px;" nowrap align="center"><strong>Prize Entries</strong></td>
    </tr>
    
    <cfif qry_stage_details.Use_Pending EQ 1>
		<tr>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;"><strong>Pending Stage</strong></td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Total_Pending#</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Required_Pending#</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">0pts</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">0</td>
		</tr>
    </cfif>
        
    <cfif qry_stage_details.Use_Stage1 EQ 1>
		<tr>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap><strong>Stage 1</strong></td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Total_Stage_1#</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Required_Stage_1#</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Points_Stage_1#pts</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Prize_Stage_1#</td>
		</tr>
    </cfif>
        
    <cfif qry_stage_details.Use_Stage2 EQ 1>
		<tr>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap><strong>Stage 2</strong></td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Total_Stage_2#</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Required_Stage_2#</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Points_Stage_2#pts</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Prize_Stage_2#</td>
		</tr>
    </cfif>        
        
    <cfif qry_stage_details.Use_Stage3 EQ 1>    		
		<tr>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap><strong>Stage 3</strong></td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Total_Stage_3#</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Required_Stage_3#</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Points_Stage_3#pts</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Prize_Stage_3#</td>
		</tr>
    </cfif>       
        
    <cfif qry_stage_details.Use_Stage4 EQ 1>    		
		<tr>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;border-bottom:solid 1px ##d8d8d8;" nowrap><strong>Winner Stage</strong></td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;border-bottom:solid 1px ##d8d8d8;" nowrap align="center">-</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;border-bottom:solid 1px ##d8d8d8;" nowrap align="center">-</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;border-bottom:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Points_Stage_4#pts</td>
		<td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;border-bottom:solid 1px ##d8d8d8;" nowrap align="center">#qry_stage_details.Prize_Stage_4#</td>
		</tr>
    </cfif>
	
    <tr>
    <td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="20" border="0"></td>
    </tr>
    
    <tr>
    <td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;border-bottom:solid 1px ##d8d8d8;" colspan="3"><strong>What you earn for Voting:</strong></td>
    <td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;border-bottom:solid 1px ##d8d8d8;" align="center">#qry_stage_details.Points_Vote#pts</td>
    <td style="font-size:11px;color:6c6c6c;border-top:solid 1px ##d8d8d8;border-bottom:solid 1px ##d8d8d8;" align="center">#qry_stage_details.Prize_Vote#</td>
	</tr>
    
    <tr>
    <td style="font-size:11px;color:6c6c6c;border-bottom:solid 1px ##d8d8d8;" colspan="3"><strong>What you earn for giving Feedback:</strong></td>
    <td style="font-size:11px;color:6c6c6c;border-bottom:solid 1px ##d8d8d8;" align="center">#qry_stage_details.Points_Feedback#pts</td>
    <td style="font-size:11px;color:6c6c6c;border-bottom:solid 1px ##d8d8d8;" align="center">#qry_stage_details.Prize_Feedback#</td>
	</tr>
    
    </table><br>
    <br>
    <div align="center"><input type="button" value="CLOSE WINDOW" class="whitefield" onClick="javascript:window.close();"></div><br><br>
    
</td>
</tr>

</table>

</body>
</html>

</cfoutput>