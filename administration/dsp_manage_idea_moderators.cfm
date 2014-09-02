<cfoutput>

<script language="JavaScript">
	<!--
	function confirmIdeaModeratorDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Idea Moderator?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfquery name="qry_all_moderators" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName, Contacts.EmailAddress
FROM Contacts
WHERE Roles LIKE '2' OR Roles LIKE '2,%' OR Roles LIKE '%,2' OR Roles LIKE '%,2,%'
</cfquery>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE IDEA MODERATORS</strong></td>
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
<td class="small"><a href="#request.webroot#/administration/dsp_ideaModerator_add.cfm" target="addMod" ONCLICK="fdbackwindow=window.open ('','addMod','toolbar=0,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,width=900,height=600,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A MODERATOR »</strong></a>

<hr width="100%" size="1" color="e2e2e2">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="150"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1" border="0"><br><b>Screen Name</b></td>
	<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"><br><b>Name</b></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"><br><b>Topics</b></td>
	<td width="25"><img src="#request.imageroot#/transparent_spc.gif" width="25" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<cfloop query="qry_all_moderators">
	
	<cfset this_moderator = qry_all_moderators.contactID>
	
	<cfquery name="ModeratorTopics" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Name
	FROM SugCategory
	WHERE Moderators LIKE '#this_moderator#' 
	OR Moderators LIKE '#this_moderator#,%' 
	OR Moderators LIKE '%,#this_moderator#' 
	OR Moderators LIKE '%,#this_moderator#,%'
	</cfquery>
	
	<tr>
	<td valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_moderator#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_moderator#">#TRIM(qry_all_moderators.ScreenName)#</a></td>
	<td valign="top">#TRIM(qry_all_moderators.FirstName)# #TRIM(qry_all_moderators.LastName)#</td>
	<td valign="top"><cfloop query="ModeratorTopics">
	#TRIM(ModeratorTopics.Name)#<br>
	</cfloop></td>	
	<td align="right" valign="top"><a 
	href="javascript:confirmIdeaModeratorDelete('#request.webroot#/administration/act_ideaModerator_delete.cfm?ContactID=#qry_all_moderators.ContactID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Remove Moderator" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	


</td>
</tr>

</table>


</cfoutput>