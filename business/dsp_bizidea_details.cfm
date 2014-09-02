<cfoutput>

<script language="JavaScript">
<!--
function confirmSectionDelete(aURL) {
    if(confirm('Are you sure you want to delete this Section?')) {
      location.href = aURL;
    }
  }
//-->
<!--
function confirmBusinessDelete(aURL) {
    if(confirm('Are you sure you want to delete this Business?')) {
      location.href = aURL;
    }
  }
//-->
</script>


<cfinclude template="qry_bizidea.cfm">




<!--- GET ALL FEEDBACK --->
<cfquery name="AllFeedback" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT Feedback.*, Contacts.ScreenName
FROM Feedback, Contacts
WHERE Feedback.Feedback_Type LIKE '%BusinessTemplate%'
AND Feedback.LinkID=#bizideaid#
AND Feedback.ContactID=Contacts.ContactID
</cfquery>

<cfset totalrating = 0>

<cfif AllFeedback.RecordCount>

	<cfloop query="AllFeedback">
		<cfset totalrating = (totalrating + AllFeedback.Feedback_Rating)>
	</cfloop>

	<cfset feedback_average = (totalrating / AllFeedback.RecordCount)>
	<cfset feedback_average_int = INT(feedback_average)>
	
	<cfset average_third = "#feedback_average_int#.3">
	<cfset average_two_third = "#feedback_average_int#.7">
	
	
	<cfif feedback_average LT average_third>
		<cfset wholestars = feedback_average_int>
		<cfset halfstars = 0>
	<cfelseif feedback_average LT average_two_third>
		<cfset wholestars = feedback_average_int>
		<cfset halfstars = 1>
	<cfelse>
		<cfset wholestars = (feedback_average_int + 1)>
		<cfset halfstars = 0>
	</cfif>
	
	
</cfif>


<cfif isDefined("session.UserID")>

	<!--- CHECK FOR CURREN USER FEEDBACK --->
	<cfquery name="UserFeedbackCheck" dbtype="query">
	SELECT *
	FROM AllFeedback
	WHERE ContactID=#session.UserID#
	</cfquery>

</cfif>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(Currentbizidea.biz_idea))#</strong></td>
<td align="right" nowrap style="font-size:12px;color:red;" height="20"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/administration/dsp_bizidea_edit.cfm?bizideaID=#bizideaid#&fuseaction=#fuseaction#&documentID=#documentID#" target="editbusiness" onclick="fdbackwindow=window.open ('','editbusiness','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=850,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit" border="0"></a>&nbsp;<a href="javascript:confirmBusinessDelete('#request.webroot#/administration/act_remove_bizidea.cfm?bizideaid=#bizideaid#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Business" border="0"></a><cfelse><cfif session.UserIsAuthenticated EQ 'Yes'><cfif UserFeedbackCheck.recordcount><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&BizideaID=#BizideaID#&documentID=#documentID#" style="color:red;"><cfloop from="1" to="#wholestars#" index="loopcount"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Average Rating: #DecimalFormat(feedback_average)#" border="0" align="absmiddle"></cfloop><cfif halfstars EQ 1><img src="#request.imageroot#/feedback_half_redstar.gif" width="12" height="13" alt="Average Rating: #DecimalFormat(feedback_average)#" border="0" align="absmiddle"></cfif></a> <span title="Total Feedback: #AllFeedback.RecordCount#"><sup>(#AllFeedback.RecordCount#)</sup></span><cfelse><a href="#request.webroot#/index.cfm?fuseaction=feedback&fusesubaction=rate&type=BusinessTemplate&BizideaID=#bizideaID#&documentID=#documentID#" style="color:red;">Rate this business!</a></cfif></cfif></cfif></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

</table>



<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
<a href="#request.webroot#/business/dsp_add_section.cfm?bizideaID=#bizideaID#&documentID=#documentID#" target="AddSection" onclick="fdbackwindow=window.open ('','AddSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=600,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A SECTION &raquo;</strong></a><br><br>
</cfif>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td>| &nbsp;<cfloop query="bizidea_Sections"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&bizideaID=#bizideaID#&BizSectionID=#bizidea_Sections.SectionID#">#TRIM(bizidea_Sections.Title)#</a>&nbsp; | &nbsp;</cfloop></td>
</tr>

<tr>
<td><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

</table>



<cfif IsDefined("BizSectionID")>

	
	<cfquery name="BizSectionStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT * 
	FROM bizidea_sections
	WHERE sectionID = #BizSectionID#
	</cfquery>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">  
	
	<tr> 
	<td width="100%"><span style="font-size:14px;"><b>#TRIM(BizSectionStuff.title)#</b></span></td>
	<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/business/dsp_edit_section.cfm?bizideaID=#bizideaid#&sectionID=#BizSectionID#&documentID=#documentID#" target="editsection" onclick="fdbackwindow=window.open ('','editsection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=850,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit" border="0"></a>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/business/act_section_delete.cfm?bizideaid=#bizideaid#&sectionID=#BizSectionID#&documentID=#documentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Section" border="0"></a></cfif></td>
	</tr>
	
	<tr> 
	<td colspan="2"><br>#TRIM(BizSectionStuff.details)#</td>
	</tr>
	
	</table><br>
	
	

<cfelse>
	
	<table width="100%" cellpadding="2" cellspacing="2" border="0">  
	
	<tr> 
	<td><strong>#TRIM(Currentbizidea.biz_summary)#</strong></td>
	</tr>
	
	</table><br><br><br>
	
	
	<cfif session.UserIsAuthenticated AND UserFeedbackCheck.recordcount>
	
		<cfinclude template="../feedback/dsp_rating_table.cfm">
	
	</cfif>

</cfif>




</cfoutput>