<cfoutput>

<cfparam name="sortOrder" default="desc">


<cfquery name="qry_all_categories" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugCategory
ORDER BY Active DESC, DisplayOrder
</cfquery>

<script language="JavaScript">
<!--
function confirmCatDelete(aURL) {
    if(confirm('Are you sure you want to delete this Category?')) {
      location.href = aURL;
    }
  }
//-->
</script>

	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE IDEA TOPICS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><a href="#request.webroot#/administration/dsp_IdeafunL_topic_add.cfm" target="editsection" onclick="fdbackwindow=window.open ('','editsection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=600,height=550,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A TOPIC &raquo;</strong></a>

	<hr width="100%" size="1" color="e2e2e2">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>	
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<td width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
	<td width="70"><img src="#request.imageroot#/transparent_spc.gif" width="70" height="1" border="0"></td>	
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
	</tr>	
	
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><b>Order</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><b>Name</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Active</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Add Idea</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Sponsor</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>End Date</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="qry_all_categories">
	
	<cfset this_categoryID = qry_all_categories.categoryID>
	
	<cfquery name="SponsorStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Organisation_Name, LogoFile
	FROM Organisations
	WHERE OrganisationID=#qry_all_categories.SponsorID#
	</cfquery>
	
	<cfquery name="qry_stage_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM idea_topic_settings
	WHERE TopicID=#this_categoryID#
	</cfquery>
	
	<tr>
	<td style="font-size:11px;" valign="top">#DecimalFormat(qry_all_categories.DisplayOrder)#</td>
	<td style="font-size:11px;" valign="top"><a href="#request.webroot#/administration/dsp_ideaTopic_points.cfm?CategoryID=#this_categoryID#" target="catpoints" onclick="fdbackwindow=window.open ('','catpoints','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=350,top=10,left=10')"><strong>#TRIM(qry_all_categories.Name)#</strong></a></td>
	<td style="font-size:11px;" valign="top" align="center">#YesNoFormat(qry_all_categories.Active)#</td>
	<td style="font-size:11px;" valign="top" align="center">#YesNoFormat(qry_all_categories.ShowAdd)#</td>
	<td style="font-size:11px;" valign="top" align="center">#TRIM(SponsorStuff.Organisation_Name)#</td>
	<td style="font-size:11px;" valign="top" align="center">#dateFormat(qry_all_categories.WhenCategoryEnded)#</td>
	<td align="right" style="font-size:11px;" valign="top"><a href="#request.webroot#/administration/dsp_IdeafunL_topic_edit.cfm?CategoryID=#this_CategoryID#" target="editcat" onclick="fdbackwindow=window.open ('','editcat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=600,height=550,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Category" border="0"></a>&nbsp;<a href="javascript:confirmCatDelete('#request.webroot#/administration/act_removeSugCategory.cfm?categoryID=#qry_all_categories.categoryID#')"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Category" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="7" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td></td>
	<td style="font-size:11px;border-top:solid 1px ##e2e2e2;" valign="top"><br>#TRIM(qry_all_categories.Description)#<br><br></td>
	<td colspan="5" valign="top" style="font-size:11px;border-top:solid 1px ##e2e2e2;padding-left:20px;"><br>
		
		<table cellpadding="0" cellspacing="0" border="0">		
		
		<tr>
		<td style="font-size:10px;color:6c6c6c;padding-right:10px;border-top:solid 1px ##e2e2e2;"><strong>Stage</strong></td>
		<td style="font-size:10px;color:6c6c6c;padding-left:10px;padding-right:10px;border-top:solid 1px ##e2e2e2;" nowrap align="center"><strong>Total Votes</strong></td>
		<td style="font-size:10px;color:6c6c6c;padding-left:10px;padding-right:10px;border-top:solid 1px ##e2e2e2;" nowrap align="center"><strong>Reqd Yes</strong></td>
		<td style="font-size:10px;color:6c6c6c;padding-left:10px;padding-right:10px;border-top:solid 1px ##e2e2e2;" nowrap align="center"><strong>Reward</strong></td>
		<td style="font-size:10px;color:6c6c6c;padding-left:10px;padding-right:10px;border-top:solid 1px ##e2e2e2;" nowrap align="center"><strong>Prize Entries</strong></td>
		</tr>
		
        <cfif qry_stage_details.Use_Pending EQ 1>
    		<tr>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;">Pending</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Total_Pending#</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Required_Pending#</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">0pts</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">0</td>
    		</tr>
		</cfif>
        
        <cfif qry_stage_details.Use_Stage1 EQ 1>
    		<tr>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap>1</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Total_Stage_1#</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Required_Stage_1#</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Points_Stage_1#pts</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Prize_Stage_1#</td>
    		</tr>
		</cfif>
        
        <cfif qry_stage_details.Use_Stage2 EQ 1>
    		<tr>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap>2</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Total_Stage_2#</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Required_Stage_2#</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Points_Stage_2#pts</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Prize_Stage_2#</td>
    		</tr>
		</cfif>        
        
        <cfif qry_stage_details.Use_Stage3 EQ 1>    		
    		<tr>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap>3</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Total_Stage_3#</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Required_Stage_3#</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Points_Stage_3#pts</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Prize_Stage_3#</td>
    		</tr>
		</cfif>       
        
        <cfif qry_stage_details.Use_Stage4 EQ 1>    		
    		<tr>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;" nowrap>Winner</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">-</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">-</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Points_Stage_4#pts</td>
    		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Prize_Stage_4#</td>
    		</tr>
		</cfif>
	
    	<tr>
    	<td colspan="5" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
    	</tr>
        
        <tr>
		<td colspan="3" style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;" nowrap>Voting</td>
		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Points_Vote#pts</td>
		<td style="font-size:10px;color:b4b4b4;border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Prize_Vote#</td>
		</tr>
        
        <tr>
		<td colspan="3" style="font-size:10px;color:b4b4b4;border-bottom:solid 1px ##e2e2e2;" nowrap>Feedback</td>
		<td style="font-size:10px;color:b4b4b4;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Points_Feedback#pts</td>
		<td style="font-size:10px;color:b4b4b4;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Prize_Feedback#</td>
		</tr>
        
        <tr>
		<td colspan="3" style="font-size:10px;color:b4b4b4;border-bottom:solid 1px ##e2e2e2;" nowrap>Submit Idea</td>
		<td style="font-size:10px;color:b4b4b4;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Points_SubmitIdea#pts</td>
		<td style="font-size:10px;color:b4b4b4;border-bottom:solid 1px ##e2e2e2;" nowrap align="center">#qry_stage_details.Prize_SubmitIdea#</td>
		</tr>
		</table>
		
	
	</td>
	</tr>
	
	<tr>
	<td colspan="7" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
	</tr>
	
	<tr>
	<td></td>
	<td colspan="6" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;border-top:solid 1px ##e2e2e2;"><strong>Moderators:</strong> <cfloop list="#qry_all_categories.Moderators#" delimiters="," index="loopitem"><cfquery name="qry_contact_details" datasource="#dsn#" username="#request.username#" password="#request.password#">SELECT FirstName, LastName FROM Contacts
WHERE ContactID=#loopitem#</cfquery>#qry_contact_details.FirstName# #qry_contact_details.Lastname#,&nbsp;</cfloop></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	</cfloop>	
	
	</table>

</td>
</tr>

</table>

</cfoutput>