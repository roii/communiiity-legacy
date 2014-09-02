<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ProjectCategories
ORDER BY Title
</cfquery>

<cfquery name="CampaignDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM campaigns
WHERE CampaignsID=#CampaignsID#
</cfquery>

<cfquery name="qry_all_moderators" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName, Contacts.EmailAddress
FROM Contacts
WHERE Roles LIKE '2' OR Roles LIKE '2,%' OR Roles LIKE '%,2' OR Roles LIKE '%,2,%'
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
	<title>#TRIM(AllSettings.SiteName)# - #editcashheading#</title>
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
	
function validateForm(addform) {     
    if (addform.Title.value == "") {
		alert("You must enter a Title for this project.");
		addform.Title.focus();
		return false;
	} 
    else if(addform.Moderators.value == "" || addform.Moderators.value == 0 || addform.Moderators.value == "0") {
	    alert("Required: You must select the Moderator");
		addform.Moderators.focus();
		return false; 
	}	
    else {
	    return true;
		//ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
		//addform.submit(); //submit form
	}
}
</script>	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#editcashheading#</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<form method="post" action="#request.webroot#/admin/act_campaigns_edit.cfm" name="addform" enctype="multipart/form-data" onSubmit="return validateForm(this);">
	<input type="hidden" name="CampaignsID" value="#CampaignsID#">
	<input type="hidden" name="DocumentID" value="#DocumentID#">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#category#</td>
	<td class="normal" valign="top"><select name="ProjectCategoryID" class="whitefield"><cfloop query="allCats"><option value="#TRIM(AllCats.ProjectCategoryID)#"<cfif #CampaignDetails.ProjectCategoryID# EQ #TRIM(AllCats.ProjectCategoryID)#> selected</cfif>>#TRIM(allCats.Title)#</cfloop></select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#currstatus#</td>
	<td class="normal" valign="top"><select name="CurrentStatus" class="whitefield">
	<option value="Draft"<cfif TRIM(CampaignDetails.CurrentStatus) EQ 'Draft'> selected</cfif>>#Draft#
	<option value="Active"<cfif TRIM(CampaignDetails.CurrentStatus) EQ 'Active'> selected</cfif>>#active#
	<option value="Complete"<cfif TRIM(CampaignDetails.CurrentStatus) EQ 'Complete'> selected</cfif>>#complete# 
	</select></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#addprojtitlefield#</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="68" rows="2" name="Title" maxlength="60">#TRIM(CampaignDetails.title)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Campaign Video</td>
	<td class="normal" valign="top">
	       <input type="text" id="campaign_video" name="campaign_video" value="#TRIM(CampaignDetails.campaign_video)#" size="80" maxlength="100" />
			  <p style="color: red;">
					 Note: Please enter the video URL only of youtube or vimeo sites.<br>
				      1. Example of youtube URL:   http://www.youtube.com/watch?v={video-id} <br>
					  2. Example of vimeo   URL:   http://vimeo.com/{video-id}
			  </p>
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#camppics#</td>
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
	<td style="font-size:11px;" width="110" valign="top">Moderators</td>
	<td valign="top"><select multiple name="Moderators" class="whitefield" style="width:300px;" size="6"> 
	        <option value="0">--- Select a moderator ---</option>  
			<cfloop query="qry_all_moderators">
					<option value="#qry_all_moderators.contactID#"<cfif ListFind(CampaignDetails.Moderators, qry_all_moderators.contactID, ",")> selected</cfif>>
						  #TRIM(qry_all_moderators.Firstname)# #TRIM(qry_all_moderators.Lastname)# (#TRIM(qry_all_moderators.Screenname)#)
					</option>	  
			</cfloop>
	    </select>
    </td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">DashBoard Variables with Values</td>
	<td class="normal" valign="top">	           
			   <table width="100%" cellpadding="0" cellspacing="0" border="0">
			        <tr>
					      <td>
						        Label 1
						  </td>
						  <td>
						        Value 1
						  </td>
						  <td>
						        Percentage Value 1
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_1_label" id="dashboard_var_1_label" value="#TRIM(CampaignDetails.dashboard_var_1_label)#" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_1_value" id="dashboard_var_1_value" value="#TRIM(CampaignDetails.dashboard_var_1_value)#" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_1_percentage" id="dashboard_var_1_percentage" value="#TRIM(CampaignDetails.dashboard_var_1_percentage)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        Label 2
						  </td>
						  <td>
						        Value 2
						  </td>
						  <td>
						        Percentage Value 2
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_2_label" id="dashboard_var_2_label" value="#TRIM(CampaignDetails.dashboard_var_2_label)#" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_2_value" id="dashboard_var_2_value" value="#TRIM(CampaignDetails.dashboard_var_2_value)#" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_2_percentage" id="dashboard_var_2_percentage" value="#TRIM(CampaignDetails.dashboard_var_2_percentage)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        Label 3
						  </td>
						  <td>
						        Value 3
						  </td>
						  <td>
						        Percentage Value 3
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_3_label" id="dashboard_var_3_label" value="#TRIM(CampaignDetails.dashboard_var_3_label)#" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_3_value" id="dashboard_var_3_value" value="#TRIM(CampaignDetails.dashboard_var_3_value)#" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_3_percentage" id="dashboard_var_3_percentage" value="#TRIM(CampaignDetails.dashboard_var_3_percentage)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        Label 4
						  </td>
						  <td>
						        Value 4
						  </td>
						  <td>
						        Percentage Value 4
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_4_label" id="dashboard_var_4_label" value="#TRIM(CampaignDetails.dashboard_var_4_label)#" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_4_value" id="dashboard_var_4_value" value="#TRIM(CampaignDetails.dashboard_var_4_value)#" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_4_percentage" id="dashboard_var_4_percentage" value="#TRIM(CampaignDetails.dashboard_var_4_percentage)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        Label 5
						  </td>
						  <td>
						        Value 5
						  </td>
						  <td>
						        Percentage Value 5
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_5_label" id="dashboard_var_5_label" value="#TRIM(CampaignDetails.dashboard_var_5_label)#" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_5_value" id="dashboard_var_5_value" value="#TRIM(CampaignDetails.dashboard_var_5_value)#" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_5_percentage" id="dashboard_var_5_percentage" value="#TRIM(CampaignDetails.dashboard_var_5_percentage)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        Label 6
						  </td>
						  <td>
						        Value 6
						  </td>
						  <td>
						        Percentage Value 6
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_6_label" id="dashboard_var_6_label" value="#TRIM(CampaignDetails.dashboard_var_6_label)#" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_6_value" id="dashboard_var_6_value" value="#TRIM(CampaignDetails.dashboard_var_6_value)#" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_6_percentage" id="dashboard_var_6_percentage" value="#TRIM(CampaignDetails.dashboard_var_6_percentage)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
			   </table> 
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
			<textarea cols="80" id="IntroText" name="IntroText" rows="20" cols="60" maxlength="140">#TRIM(CampaignDetails.IntroText)#</textarea><!---
			<script> 
				 CKEDITOR.replace( 'IntroText', {
					extraPlugins: 'magicline',	// Ensure that magicline plugin, which is required for this sample, is loaded.
					allowedContent: true		// Switch off the ACF, so very complex content created to
												// show magicline's power isn't filtered.
				} ); 
			</script>--->
		 </p>
	<!---<cf_fckeditor name="IntroText" value="#TRIM(CampaignDetails.IntroText)#" width="650" height="450" toolbarset="Default">--->
	<!---
	<cf_activedit name="IntroText" inc="#request.ActiveEditInc#" image="true" 
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="420" height="220"
	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="no" DEFAULTFONT="8pt Verdana">#TRIM(CampaignDetails.IntroText)#</cf_activedit>--->
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#addprojdetails#</td>
	<td Class="normal" valign="top">
	<p> 
			<textarea cols="80" id="details" name="details" rows="20" cols="60">#TRIM(CampaignDetails.details)#</textarea>
			<script> 
				 CKEDITOR.replace( 'details', {
					extraPlugins: 'magicline',	// Ensure that magicline plugin, which is required for this sample, is loaded.
					allowedContent: true		// Switch off the ACF, so very complex content created to
												// show magicline's power isn't filtered.
				} ); 
			</script>
		 </p>
	<!----<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" 
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="420" height="420"
	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="no" DEFAULTFONT="8pt Verdana">#TRIM(CampaignDetails.details)#</cf_activedit>--->
	</td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<input type="hidden" size="68" name="AssignedTo" value="#TRIM(CampaignDetails.assignedto)#">
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#assignedto#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="AssignedTo" value="#TRIM(CampaignDetails.assignedto)#"></td>
	</tr>--->		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#fundinggoals#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="15" name="CreditsOffered" value="#TRIM(CampaignDetails.CreditsOffered)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#paymenttype#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="PaymentType" value="Money"<cfif TRIM(CampaignDetails.PaymentType) EQ 'Money'> checked</cfif>> #money# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="PaymentType" value="Points"<cfif TRIM(CampaignDetails.PaymentType) EQ 'Points'> checked</cfif>> #points#</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<input type="hidden" size="15" name="PaidIn" value="#TRIM(CampaignDetails.PaidIn)#">
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#paidin#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="15" name="PaidIn" value="#TRIM(CampaignDetails.PaidIn)#"></td>
	</tr>--->		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#percentcomp#</td>
	<td Class="normal" valign="top">
	    <input type="text" class="whitefield" size="15" name="PercentComplete" value="#CampaignDetails.percentcomplete#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);">%
	<!---<select name="PercentComplete" class="whitefield">
	<option value="0"<cfif #CampaignDetails.percentcomplete# EQ 0> selected</cfif>>0
	<cfloop from="1" to="10" index="loopcount">
	<option value="#loopcount#0"<cfif #CampaignDetails.percentcomplete# EQ "#loopcount#0"> selected</cfif>>#loopcount#0%
	</cfloop>
	</select>--->
	</td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#featurecamp#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="FeatureCampaigns" value="1"<cfif #CampaignDetails.FeatureCampaigns# EQ 1> checked</cfif>> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="FeatureCampaigns" value="0"<cfif #CampaignDetails.FeatureCampaigns# EQ 0> checked</cfif>> #notitle#</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#location#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="location" value="#TRIM(CampaignDetails.location)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#createdby#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="addedBy" value="#TRIM(CampaignDetails.addedby)#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#campaignorder#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="10" maxlength="10" name="campaigns_order" value="#TRIM(CampaignDetails.campaigns_order)#" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<input type="hidden" name="ProjectPriority" value="High">
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#projectprior#</td>
	<td Class="normal" valign="top">
		<input type="radio" Class="whitefield" name="ProjectPriority" value="Low"<cfif #CampaignDetails.Priority# EQ "Low"> checked</cfif>> #low# &nbsp;&nbsp;&nbsp;
		<input type="radio" Class="whitefield" name="ProjectPriority" value="Normal"<cfif #CampaignDetails.Priority# EQ "Normal"> checked</cfif>> #normal# &nbsp;&nbsp;&nbsp;
		<input type="radio" Class="whitefield" name="ProjectPriority" value="High"<cfif #CampaignDetails.Priority# EQ "High"> checked</cfif>> #high#
	</td>
	</tr>	--->
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#dispcamp#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="displaycampaigns" value="1"<cfif #CampaignDetails.displaycampaigns# EQ 1> checked</cfif>> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="displaycampaigns" value="0"<cfif #CampaignDetails.displaycampaigns# EQ 0> checked</cfif>> #notitle#
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(addform); return false;" value="#save# >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</form>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>