<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ProjectCategories
ORDER BY Title
</cfquery>

<cfquery name="ProjectDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Projects
WHERE ProjectID=#ProjectID#
</cfquery>

<cfquery name="getTasksPriorities" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM tasks_priorities 
</cfquery>

<cfquery name="getCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM campaigns
ORDER BY CampaignsID ASC
</cfquery>

<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(addform) {    

if (addform.Title.value == "") {
	alert("You must enter a Title for this project.");
	addform.Title.focus();
	return;
	} 
	
else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	addform.submit(); //submit form
	}
}
// -->
</script>


<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfinclude template="../templates/set_language.cfm">
	<title>#TRIM(AllSettings.SiteName)# - #editTaskHeading#</title>
<script src="/administration/ckeditor.js"></script>
<script src="/administration/sample.js"></script>
<cfparam name="URL.fuseaction" default="administration">
<cfparam name="URL.fusesubaction" default="">
<cfparam name="URL.secti" default="">		
<cfinclude template="../templates/styles.cfm">
<script language="javascript" type="text/javascript">
	function intOnlyfn(i)
	{
		if(i.value.length>0)
		{
			 i.value = i.value.replace(/[^\d]+/g, '');
		}
	}
</script>

<script language="JavaScript">
	<!--  
	function validate(addform) {    	
	if (addform.Title.value == "") {
		alert("You must enter a Title for this Project.");
		addform.Title.focus();
		return;
		}
	else if (addform.related_campaign.value == "") {
		alert("You must select the Campaign for this Project.");
		addform.related_campaign.focus();
		return;
		}	    		
	else {
		addform.submit(); //submit form
		}
	}
	// -->
	</script>
<style>
.nicEdit-panel {
    background: none repeat scroll 0 0 ##FFFFFF;
}
.nicEdit-main {
    background: none repeat scroll 0 0 ##FFFFFF;
}
</style>
<script type="text/javascript" src="/js/nicEdit.js"></script>
<script type="text/javascript">
	bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });
</script>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40"> 
<td colspan="3" valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#editTaskHeading#</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr> 
<td valign="top" colspan="3">
<br> 
<cfif IsDefined("URL.maintask") and URL.maintask neq ''>
	<cfset maintask = URL.maintask>
<cfelse>
	<cfset maintask = 1>		
</cfif>	

	<form method="post" action="#request.webroot#/tasks/act_cashproject_edit.cfm" name="addform" enctype="multipart/form-data" onSubmit="javascript:validate(addform); return false;">
	<input type="hidden" name="projectID" value="#projectID#">
	<input type="hidden" name="DocumentID" value="#DocumentID#">
	<input type="hidden" name="ProjectCategoryID" value="#ProjectDetails.PROJECTCATEGORYID#">
	<input type="hidden" name="maintask" value="#maintask#">
	<input type="hidden" name="campaignID" value="#URL.campaignID#">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#category#</td>
	<td class="normal" valign="top"><select name="ProjectCategoryID" class="whitefield"><cfloop query="allCats"><option value="#TRIM(AllCats.ProjectCategoryID)#"<cfif #ProjectDetails.ProjectCategoryID# EQ #TRIM(AllCats.ProjectCategoryID)#> selected</cfif>>#TRIM(allCats.Title)#</cfloop></select></td>
	</tr>--->
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#currstatus#</td>
	<td class="normal" valign="top"><select name="CurrentStatus" class="whitefield">
	<option value="Being Planned"<cfif TRIM(ProjectDetails.CurrentStatus) EQ 'Being Planned'> selected</cfif>>#beingplan#
	<option value="Available Now"<cfif TRIM(ProjectDetails.CurrentStatus) EQ 'Available Now'> selected</cfif>>#availnow#
	<option value="In progress"<cfif TRIM(ProjectDetails.CurrentStatus) EQ 'In progress'> selected</cfif>>#inprog#
	<option value="All done"<cfif TRIM(ProjectDetails.CurrentStatus) EQ 'All done'> selected</cfif>>#alldone#
	</select></td>
	</tr>
	
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Hide or show Done tasks 
	</td>
	<td class="normal" valign="top">
	 <p style="color: red;">
		    Note: * This field will be implemented for this task only when it will be completed. Please select either yes or no value. By default no is selected. If you will make it yes then this task will be shown after user set its status to "Done" with completing it. If already no is selected then this task will not be shown if user set it status to "Done".
     </p>
	<select name="displaydonetask" class="whitefield">
	<option value="No"<cfif TRIM(ProjectDetails.displaydonetask) EQ 'No'> selected</cfif>>#notitle#
	<option value="Yes"<cfif TRIM(ProjectDetails.displaydonetask) EQ 'Yes'> selected</cfif>>#yestitle# 
	</select></td>
	</tr>--->
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#addprojtitlefield#</td>
	<td class="normal" valign="top"> 
	         <input type="text" name="Title" id="Title" class="whitefield" value="#TRIM(ProjectDetails.title)#" size="70" />
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#relatedprojtxt#</td>
	<td>
	    <cfquery name="getProjectName" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Title FROM campaigns
			WHERE CampaignsID = #URL.campaignID#
		</cfquery> 
		#getProjectName.Title#
	    <!---<select name="related_campaign" id="related_campaign" style="width:300px;">
		    <option value="">#selectprojtxt#</option>
		    <cfloop query="getCampaigns">
		        <option value="#getCampaigns.CampaignsID#" <cfif #ProjectDetails.related_campaign# eq #getCampaigns.CampaignsID#>selected="selected"</cfif>>#getCampaigns.Title#</option>
			</cfloop>
		</select> --->
	</td>
	</tr>
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#projpic#</td>
	<td class="normal" valign="top">
	             <input type="file" name="project_pic" id="project_pic" value="" />
			<strong style="color: blue;"><br>Note: * #addprojupmsg# <br>#uploadmsg2#</strong> 
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top">#projintro#</td>
	<td class="normal" valign="top"> 
	<p> 
			<textarea cols="80" id="IntroText" name="IntroText" rows="20" cols="60">#TRIM(ProjectDetails.IntroText)#</textarea> 
		 </p> 
	</td>
	</tr>--->
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#addprojdetails#</td>
	<td Class="normal" valign="top">
	<p>  
			<textarea name="details" id="details" style="width: 100%;">#TRIM(ProjectDetails.details)#</textarea> 
		 </p> 
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#agecrt#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="AgeShort" value="#TRIM(ProjectDetails.AgeShort)#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#agelng#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="AgeLong" value="#TRIM(ProjectDetails.AgeLong)#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#shorttime#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="ShortTime" value="#TRIM(ProjectDetails.ShortTime)#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#maxtime#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="MaxTime" value="#TRIM(ProjectDetails.MaxTime)#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>--->
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#assignedto#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="AssignedTo" value="#TRIM(ProjectDetails.assignedto)#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#payment#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="15" name="CreditsOffered" value="#TRIM(ProjectDetails.CreditsOffered)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#paymenttype#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="PaymentType" value="Money"<cfif TRIM(ProjectDetails.PaymentType) EQ 'Money'> checked</cfif>> #money# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="PaymentType" value="Points"<cfif TRIM(ProjectDetails.PaymentType) EQ 'Points'> checked</cfif>> #points#</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#paidin#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="15" name="PaidIn" value="#TRIM(ProjectDetails.PaidIn)#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	--->
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#percentcomp#</td>
	<td Class="normal" valign="top">
	    <input type="text" class="whitefield" size="15" name="PercentComplete" value="#projectdetails.percentcomplete#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);">%
	<!---<select name="PercentComplete" class="whitefield">
	<option value="0"<cfif #projectdetails.percentcomplete# EQ 0> selected</cfif>>0
	<cfloop from="1" to="10" index="loopcount">
	<option value="#loopcount#0"<cfif #projectdetails.percentcomplete# EQ "#loopcount#0"> selected</cfif>>#loopcount#0%
	</cfloop>
	</select>--->
	</td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#featureproj#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="FeatureProject" value="1"<cfif #ProjectDetails.FeatureProject# EQ 1> checked</cfif>> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="FeatureProject" value="0"<cfif #ProjectDetails.FeatureProject# EQ 0> checked</cfif>> #notitle#</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#location#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="location" value="#TRIM(ProjectDetails.location)#"></td>
	</tr>--->
	<input type="hidden" name="location" value="#TRIM(ProjectDetails.location)#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#dispTask#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="displayProject" value="1"<cfif #ProjectDetails.displayProject# EQ 1> checked</cfif>> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="displayProject" value="0"<cfif #ProjectDetails.displayProject# EQ 0> checked</cfif>> #notitle#
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#by#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="addedBy" value="#TRIM(ProjectDetails.addedby)#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#projorder#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="10" maxlength="10" name="project_order" value="#TRIM(ProjectDetails.project_order)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>--->
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#taskPriority#</td>
	<td Class="normal" valign="top">
	    <cfloop query="getTasksPriorities">
		     <cfif getTasksPriorities.id eq 1>
			     <cfset dispValue = "#high#">
			 <cfelseif getTasksPriorities.id eq 2>
			     <cfset dispValue = "#normal#">	 
			 <cfelseif getTasksPriorities.id eq 3>
			     <cfset dispValue = "#low#">	
			 <cfelse>
			     <cfset dispValue = "">	 	 
			 </cfif>
			 <input type="radio" Class="whitefield" name="ProjectPriority" value="#getTasksPriorities.id#"<cfif #ProjectDetails.Priority# EQ "#getTasksPriorities.id#"> checked</cfif>> #dispValue# 
		</cfloop>
		<!---<input type="radio" Class="whitefield" name="ProjectPriority" value="Low"<cfif #ProjectDetails.Priority# EQ "Low"> checked</cfif>> #low# &nbsp;&nbsp;&nbsp;
		<input type="radio" Class="whitefield" name="ProjectPriority" value="Normal"<cfif #ProjectDetails.Priority# EQ "Normal"> checked</cfif>> #normal# &nbsp;&nbsp;&nbsp;
		<input type="radio" Class="whitefield" name="ProjectPriority" value="Medium"<cfif #ProjectDetails.Priority# EQ "Medium"> checked</cfif>> #Medium#
		<input type="radio" Class="whitefield" name="ProjectPriority" value="High"<cfif #ProjectDetails.Priority# EQ "High"> checked</cfif>> #high#--->
	</td>
	</tr>	
	 
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(addform); return false;" value="#updateTaskNow# >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</form>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>