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

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>  
      <cfset userTypeIsAdmin = "yes">
<cfelse>
      <cfset userTypeIsAdmin = "no">
</cfif>

<SCRIPT LANGUAGE="JavaScript">
 var userTypeIsAdmin = "<cfoutput>#userTypeIsAdmin#</cfoutput>";
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
    else if(userTypeIsAdmin == "yes" && (addform.Moderators.value == "" || addform.Moderators.value == 0 || addform.Moderators.value == "0")) {
	    alert("Required: You must select the Moderator");
		addform.Moderators.focus();
		return false; 
	}	
	/*else if(addform.gallery_pics_1.value == "") {
	    alert("Required: You must select the Gallery Pic 1");
		addform.gallery_pics_1.focus();
		return false; 
	}	
	else if(addform.gallery_pics_2.value == "") {
			alert("Required: You must select the Gallery Pic 2");
			addform.gallery_pics_2.focus();
			return false; 
		}	
	else if(addform.gallery_pics_3.value == "") {
			alert("Required: You must select the Gallery Pic 3");
			addform.gallery_pics_3.focus();
			return false; 
		}	
	else if(addform.gallery_pics_4.value == "") {
			alert("Required: You must select the Gallery Pic 4");
			addform.gallery_pics_4.focus();
			return false; 
		}	
	else if(addform.gallery_pics_5.value == "") {
			alert("Required: You must select the Gallery Pic 5");
			addform.gallery_pics_5.focus();
			return false; 
		}*/
    else {
	    return true;
		//ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
		//addform.submit(); //submit form
	}
}

function openbox(boxtouse, boxtohide)
{
	  document.getElementById(boxtohide).style.display = "none"; 
	  document.getElementById(boxtouse).style.display  = "";
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
	    <td class="normal" valign="top" width="10">#projmedtitle#</td>
		<td class="normal" valign="top">
		      <table cellpadding="0" cellspacing="0" border="0" width="100%">
			            <tr> 
							<td class="normal" valign="top">
							           <div class="radio-option clearfix">
									      <cfif CampaignDetails.campaign_video neq ''>
											  <input type="radio" value="MDIA_PVID" name="media_type" id="media_proj_video" class="fl field" checked="checked" onClick="openbox('project_pitchmedia_link', 'project_pitchmedia_primary_picture');">
										  <cfelse>
										      <input type="radio" value="MDIA_PVID" name="media_type" id="media_proj_video" class="fl field" onClick="openbox('project_pitchmedia_link', 'project_pitchmedia_primary_picture');">	  
										  </cfif>	  
											<label for="project_pitchmedia_attributes_media_type_mdia_pvid" class="fl auto-width">#campaignVid#  
											</label> 
											<cfif CampaignDetails.campaign_video neq ''>
												<div id="project_pitchmedia_link" class="input-item-text clearfix hilight" style="display: block; margin-left: 40px;">  
														#campvidnote1# <br>
														#campvidnote2# <br>
														#campvidnote3# <br> 
												  <input type="text" id="link" name="campaign_video" value="#TRIM(CampaignDetails.campaign_video)#" size="80" maxlength="100" />
												</div> 
											<cfelse>
											    <div id="project_pitchmedia_link" class="input-item-text clearfix hilight" style="display: none; margin-left: 40px;">  
														#campvidnote1# <br>
														#campvidnote2# <br>
														#campvidnote3# <br> 
												  <input type="text" id="link" name="campaign_video" value="" size="80" maxlength="100" />
												</div> 	 
											</cfif>	
									  </div> 
									  <div class="radio-option clearfix">
									     <cfif CampaignDetails.project_media_image neq ''>
											<input type="radio" value="MDIA_PIMG" name="media_type" id="media_proj_img" checked="checked" class="fl field" onClick="openbox('project_pitchmedia_primary_picture', 'project_pitchmedia_link');">
										 <cfelse>
										    <input type="radio" value="MDIA_PIMG" name="media_type" id="media_proj_img" class="fl field" onClick="openbox('project_pitchmedia_primary_picture', 'project_pitchmedia_link');">
										 </cfif>	
											<label for="project_pitchmedia_attributes_media_type_mdia_pimg" class="fl auto-width">
											      Image <span class="mini-text">(PNG, JPG, or GIF - 565 x 281 pixels)</span>
										    </label> 
										 <cfif CampaignDetails.project_media_image neq ''>	
												<div id="project_pitchmedia_primary_picture" class="clearfix hilight" style="display: block;  margin-left: 40px;">
													  <div class="fl submit-container">
														<label class="fl cabinet grey new-image" id="pitchmedia_picture_upload">
									
														  <input type="file" style="top: -15.5px; left: -183px;" name="primary_picture" id="primary_picture" class="file pitchmedia-file-field"><br>
							                               #CampaignDetails.project_media_image#							   
														  <div class="spinner-container" id="pitchmedia_picture_saving">
														  </div>
														</label>
													  </div> <!-- End submit-container -->
												</div> <!-- End clearfix hilight --> 
										 <cfelse>
										        <div id="project_pitchmedia_primary_picture" class="clearfix hilight" style="display: none;  margin-left: 40px;">
												  <div class="fl submit-container">
													<label class="fl cabinet grey new-image" id="pitchmedia_picture_upload">
								
													  <input type="file" style="top: -15.5px; left: -183px;" name="primary_picture" id="primary_picture" class="file pitchmedia-file-field">
													  <div class="spinner-container" id="pitchmedia_picture_saving">
													  </div>
													</label>
												  </div> <!-- End submit-container -->
											    </div> <!-- End clearfix hilight -->
										 </cfif>		   
                                     </div> <!-- End radio-option clearfix --> 
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
	<td class="normal" valign="top" width="110">#camppics#</td>
	<td class="normal" valign="top">
	             <input type="file" name="project_pic" id="project_pic" value="" />
			<strong style="color: blue;">#upload2text#.</strong>  
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
		<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
		<td class="normal" valign="top" width="110">#galleryimg#</td>
		<td class="normal" valign="top">
				<input type="file" name="gallery_pics_1" id="gallery_pics_1" value="" />
				<strong style="color: blue;">#uploadtext#.</strong> <br>
				<input type="file" name="gallery_pics_2" id="gallery_pics_2" value="" />
				<strong style="color: blue;">#uploadtext#.</strong><br>
				<input type="file" name="gallery_pics_3" id="gallery_pics_3" value="" />
				<strong style="color: blue;">#uploadtext#.</strong><br>
				<input type="file" name="gallery_pics_4" id="gallery_pics_4" value="" />
				<strong style="color: blue;">#uploadtext#.</strong><br>
				<input type="file" name="gallery_pics_5" id="gallery_pics_5" value="" />
				<strong style="color: blue;">#uploadtext#.</strong>
		</td>
	</tr>
	
	<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
		<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td colspan="2"><hr width="100%" size="1" color="silver"></td>
		</tr> 
		<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td style="font-size:11px;" width="110" valign="top">#moderators#</td>
			<td valign="top"><select multiple name="Moderators" class="whitefield" style="width:300px;" size="6"> 
					<option value="0">--- #selmoderator# ---</option>  
					<cfloop query="qry_all_moderators">
							<option value="#qry_all_moderators.contactID#"<cfif ListFind(CampaignDetails.Moderators, qry_all_moderators.contactID, ",")> selected</cfif>>
								  #TRIM(qry_all_moderators.Firstname)# #TRIM(qry_all_moderators.Lastname)# (#TRIM(qry_all_moderators.Screenname)#)
							</option>	  
					</cfloop>
				</select>
			</td>
		</tr>
	<cfelse> 
	    <input type="hidden" name="Moderators" value="#session.userid#">	
	</cfif>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#dashvarval#</td>
	<td class="normal" valign="top">	           
			   <table width="100%" cellpadding="0" cellspacing="0" border="0">
			        <tr>
					      <td>
						        #labeltxt# 1
						  </td>
						  <td>
						        #valtxt# 1
						  </td>
						  <td>
						        #percentvaltxt# 1
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
						        #labeltxt# 2
						  </td>
						  <td>
						        #valtxt# 2
						  </td>
						  <td>
						        #percentvaltxt# 2
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
						        #labeltxt# 3
						  </td>
						  <td>
						        #valtxt# 3
						  </td>
						  <td>
						        #percentvaltxt# 3
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
						        #labeltxt# 4
						  </td>
						  <td>
						        #valtxt# 4
						  </td>
						  <td>
						        #percentvaltxt# 4
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
						        #labeltxt# 5
						  </td>
						  <td>
						        #valtxt# 5
						  </td>
						  <td>
						        #percentvaltxt# 5
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
						        #labeltxt# 6
						  </td>
						  <td>
						        #valtxt# 6
						  </td>
						  <td>
						        #percentvaltxt# 6
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