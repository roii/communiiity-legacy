<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ProjectCategories
ORDER BY Title
</cfquery>

<cfquery name="getCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM campaigns
ORDER BY CampaignsID ASC
</cfquery>

<cfquery name="getTasksPriorities" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM tasks_priorities 
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
<style>
.nicEdit-panel {
    background: none repeat scroll 0 0 ##FFFFFF;
}
.nicEdit-main {
    background: none repeat scroll 0 0 ##FFFFFF;
}
</style>
<!---<cfinclude template="../templates/set_language.cfm">--->
	<title>#TRIM(AllSettings.SiteName)# - #addprojecttitle#</title>
<script src="/administration/ckeditor.js"></script>
<!---<script src="/administration/sample.js"></script>
<script type="text/javascript" src="/js/nicEdit.js"></script>--->
<script type="text/javascript">
	//bkLib.onDomLoaded(function() { nicEditors.allTextAreas() });
</script>
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
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">
 
<cfif IsDefined("URL.pid") and URL.pid neq ''>  
  <cfset pid = URL.pid>
    <cfoutput> 
		<cfquery name="getProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT * FROM campaigns WHERE CampaignsID = #pid# 
		</cfquery>   
	</cfoutput>
    <cfif getProject.recordcount gt 0> 		 
	<cfoutput>
	     <cfset categoryID = #getProject.PROJECTCATEGORYID#> 
	     <cfquery name="getCategoryName" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Title FROM ProjectCategories WHERE ProjectCategoryID = '#categoryID#' 
		 </cfquery> 
		 
		  <cfquery name="getCategoryName" datasource="#dsn#" username="#request.username#" password="#request.password#">
			 SELECT PC.TITLE as ProjectCategory FROM campaigns as P INNER JOIN ProjectCategoryRelation as PCR ON P.CampaignsID = PCR.ProjectID INNER JOIN ProjectCategories as PC ON PCR.ProjectCategoryID = PC.ProjectCategoryID WHERE P.CampaignsID = #pid#
		  </cfquery>
		  <cfset projCat = "">
		  <cfloop query="getCategoryName">
				<cfif projCat eq "">
					  <cfset projCat &= getCategoryName.ProjectCategory> 
				<cfelse>
					  <cfset projCat &= ", " & getCategoryName.ProjectCategory> 
				</cfif> 
		  </cfloop>
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				 <td valign="top" width="10%" style="padding-right: 15px;"> 
						 <cfif getProject.CAMPAIGNSPIC neq ''>
							<img width="90" height="90" alt="Campaign Pic" title="Campaign Pic" class="fl rounded rounded-no-bottom" src="#request.webroot#/images/carcasses_new/#getProject.CAMPAIGNSPIC#">
						 <cfelse> 
							<img width="90" height="90" alt="Campaign Pic" title="Campaign Pic" class="fl rounded rounded-no-bottom" src="#request.webroot#/images/carcasses_new/no_image.png">
						 </cfif>  
				 </td> 
				 <td valign="top" width="60%" style="padding-left: 10px;">
						 <cfif session.UserType EQ 'Administrator'>
							<cfset allowTasks = 1>
						 <cfelse>
							<cfset allowTasks = 0> 
						 </cfif> 
						 <cfif allowTasks eq 1>  
							 <!--- <a href="#request.webroot#/admin/dsp_campaigns_edit.cfm?CampaignsID=#pid#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')">
								  <img src="#request.webroot#/icons/Edit-icon.png" height="20" width="20" alt="Edit this Project" border="0">
							  </a> 
							  <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_campaigns_delete.cfm?CampaignsID=#pid#&documentID=#documentID#')">
								  <img src="#request.webroot#/icons/delete.png" height="20" width="20" alt="Delete this Project" border="0">
							  </a>
							  <br />--->
						 <cfelse>  
							  <cfif IsDefined("session.userid") and session.UserIsAuthenticated EQ 'Yes'>
									<cfset MODERATORS = getProject.MODERATORS><!---#session.userid#--->
									<cfset moderaArr  = ArrayNew(1)>
									<cfif find(",", MODERATORS) gt 0>
										   <cfset moderaArr = ListToArray(MODERATORS,",")>
									<cfelse>
										   <cfset moderaArr[1] = MODERATORS>
									</cfif> 
									<cfif ArrayFind(moderaArr, #session.userid#) gt 0> 
										  <!---<a href="#request.webroot#/admin/dsp_campaigns_edit.cfm?CampaignsID=#pid#&documentID=#documentID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')">
									  <img src="#request.webroot#/icons/Edit-icon.png" height="20" width="20" alt="Edit this Project" border="0">
										  </a> 
										  <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_campaigns_delete.cfm?CampaignsID=#pid#&documentID=#documentID#')">
											  <img src="#request.webroot#/icons/delete.png" height="20" width="20" alt="Delete this Project" border="0">
										  </a>
										  <br /> --->
									</cfif>
							  </cfif>		
						 </cfif>
						<span style="font-size: 20pt;">
							#getProject.TITLE#
						</span><br />
						<span style="font-size: 12pt;">
							<!---#getProject.INTROTEXT#--->
							<cfset INTROTEXTNOHTML = ReReplaceNoCase(TRIM(getProject.INTROTEXT),"<[^>]*>","","ALL") />
							 <cfset INTROTEXTData = #ReReplace(TRIM(INTROTEXTNOHTML),"\b(\w)","\u\1","ALL")#>
								  #Mid(TRIM(INTROTEXTData),1, 400)#  
						</span> 
						<div>  
								<p class="blue_link location">
									<span id="project_location" style="font-size: 12pt;">
									   #projCat# <cfif #trim(getProject.location)# neq ''> - #trim(getProject.location)#</cfif> 
									</span>
								</p>	   
						</div> 
						<div style="margin: 10px;">
						    <a href="#request.webroot#/projects/#pid###tabs1-projects" style="text-decoration: none;">Go Back to Project</a> 
				        </div>
				 </td>
			</tr>
		   </table> 
		   
		</cfoutput>
	      
			<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr height="40">
			<td width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
			<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#addTaskTitle#</strong></span></td>
			</tr>
			
			
			<tr>
			<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
			<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			<td valign="top">
			<br>
			
			
				<form method="post" action="#request.webroot#/projects/act_cashproject_add_from_projects.cfm" name="addform" enctype="multipart/form-data" onSubmit="javascript:validate(addform); return false;">
				<input type="hidden" name="DocumentID" value="#DocumentID#">
			    <input type="hidden" name="http_ref" value="#CGI.HTTP_REFERER###tabs1-projects">
				<cfif IsDefined("session.userid")>
				        <input type="hidden" name="userid" value="#SESSION.userid#">
				<cfelse>
				        <input type="hidden" name="userid" value="0">
				</cfif> 
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<input type="hidden" name="ProjectCategoryID" value="#categoryID#">
				<input type="hidden" name="ProjectID" value="#pid#">
				<!---<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td class="normal" valign="top" width="110">#category#</td>
				<td class="normal" valign="top"><select name="ProjectCategoryID" class="whitefield"><cfloop query="allCats"><option value="#TRIM(AllCats.ProjectCategoryID)#">#TRIM(allCats.Title)#</cfloop></select>
				     <input type="hidden" name="ProjectCategoryID" value="1">
				</td>
				</tr>--->	
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td class="normal" valign="top" width="110">#currstatus#</td>
				<td class="normal" valign="top"><select name="CurrentStatus" class="whitefield">
				<option value="Being Planned">#beingplan#
				<option value="Available Now">#availnow#
				<option value="In progress">#inprog#
				<option value="All done">#alldone#
				</select></td>
				</tr>
				
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td class="normal" valign="top" width="110">#addprojtitlefield#</td>
				<td class="normal" valign="top"> 
				      <input type="text" name="Title" id="Title" class="whitefield" value="" />
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
				      #getProject.TITLE#
						  <input type="hidden" name="related_campaign" id="related_campaign" value="#pid#" />
				    <!--- <cfif session.UserType EQ 'Administrator'>
					      <select name="related_campaign" id="related_campaign" style="width:300px;">
							<option value="">#selectprojtxt#</option>
							<cfloop query="getCampaigns">
								<option value="#getCampaigns.CampaignsID#">#getCampaigns.Title#</option>
							</cfloop>
						  </select> 
					 <cfelse>
						  #getProject.TITLE#
						  <input type="hidden" name="related_campaign" id="related_campaign" value="#pid#" /> 
					 </cfif>--->	  
				</td>
				</tr>
				
				
				<!---<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td classe="normal" valign="top" width="110">#projpic#</td>
				<td class="normal" valign="top">
							 <input type="file" name="project_pic" id="project_pic" value="" />
						<strong style="color: blue;">#uploadwithvideotext#</strong> 
				</td>
				</tr>--->
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td> 
				<td class="normal" valign="top" colspan="2" style="color: rgb(88, 182, 204); font-size: 18px; text-align: left; padding: 10px 10px 10px 0px;">
					 <strong>Basic Info</strong>
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
						<textarea cols="80" id="IntroText" name="IntroText" rows="20" cols="60"></textarea> 
					 </p>
				 
				</td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">Description</td>
				<td Class="normal" valign="top">  
				<p>  
						<!--<textarea name="details" style="width: 100%;"></textarea> -->
						<textarea cols="80" id="details" name="details" rows="20" cols="60"></textarea>
						<script language="javascript">
						    CKEDITOR.replace( 'details', {
									uiColor: '##999999',
									toolbar: [
									[ 'Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink' ],
									[ 'FontSize', 'TextColor', 'BGColor' ]
									]
							 }); 
						</script> 
						<!---<script> 
							 CKEDITOR.replace( 'details', {
								extraPlugins: 'magicline',	// Ensure that magicline plugin, which is required for this sample, is loaded.
								allowedContent: true		// Switch off the ACF, so very complex content created to
															// show magicline's power isn't filtered.
							} ); 
						</script>--->
					 </p>
				<!---
				<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" 
				imagepath="#request.fileroot#\images\" 
				imageURL="#request.imageroot#/" width="445" height="420"
				toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="no" DEFAULTFONT="8pt Verdana"></cf_activedit>--->
				</td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td class="normal" valign="top">Skills needed</td>
				<td class="normal" valign="top">
					 <p>  
						<input type="text" name="skillsNeeded" id="skillsNeeded" class="whitefield" value="" />
					 </p>
				 
				</td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td> 
				<td class="normal" valign="top" colspan="2" style="color: rgb(88, 182, 204); font-size: 18px; text-align: left; padding: 10px 10px 10px 0px;">
					 <strong>More Info</strong>
				</td>
				</tr>
				
				<!---<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#agecrt#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="AgeShort"></td>
				</tr>		
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#agelng#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="AgeLong"></td>
				</tr>		
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#shorttime#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="ShortTime"></td>
				</tr>	
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#maxtime#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="MaxTime"></td>
				</tr>	--->	
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#assignedto#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="AssignedTo"></td>
				</tr>		
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>	
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#payment#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="15" name="CreditsOffered" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);"></td>
				</tr>		
				
				<!---<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#paymenttype#</td>
				<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="PaymentType" value="Money" checked> #money# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="PaymentType" value="Points"> #points#</td>
				</tr>	
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>	
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#paidin#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="15" name="PaidIn" value="NZ$"></td>
				</tr>--->		
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#percentcomp#</td>
				<td Class="normal" valign="top">
					  <input type="text" class="whitefield" size="15" name="PercentComplete" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);">%
			<!---	<select name="PercentComplete" class="whitefield">
						<option value="0">0
						<cfloop from="1" to="10" index="loopcount">
						   <option value="#loopcount#0">#loopcount#0%
						</cfloop>
					</select>
			--->	
				</td>
				</tr>		
				
				<!---<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#featureproj#</td>
				<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="FeatureProject" value="1" checked> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="FeatureProject" value="0"> #notitle#</td>
				</tr>	--->	
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<!---<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#location#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="location" value=""></td>
				</tr>--->
				<input type="hidden" name="location" value="">
				
				<!---<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#by#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="addedBy" value=""></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#projorder#</td>
				<td Class="normal" valign="top"><input type="text" Class="whitefield" size="10" maxlength="10" name="project_order" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);"></td>
				</tr>--->
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td Class="normal" valign="top">#dispTask#</td>
				<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="displayProject" value="1" checked> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="displayProject" value="0"> #notitle#</td>
				</tr>
				
				<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
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
			 <cfif #getTasksPriorities.id# eq 2>
			     <input type="radio" Class="whitefield" name="ProjectPriority" value="#getTasksPriorities.id#" checked="checked"> #dispValue# 
			 <cfelse>
			     <input type="radio" Class="whitefield" name="ProjectPriority" value="#getTasksPriorities.id#"> #dispValue# 
			 </cfif>	 
		</cfloop>
	   <!--- <input type="radio" Class="whitefield" name="ProjectPriority" value="1"> #high# 
		<input type="radio" Class="whitefield" name="ProjectPriority" value="2" checked="checked"> #normal# &nbsp;&nbsp;&nbsp;
		<input type="radio" Class="whitefield" name="ProjectPriority" value="3"> #low# &nbsp;&nbsp;&nbsp; --->
		<!---<input type="radio" Class="whitefield" name="ProjectPriority" value="Medium" checked="checked"> #Medium# --->
	</td>
	</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td colspan="2"><hr width="100%" size="1" color="silver"></td>
				</tr>
				
				<tr>
				<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
				<td> </td>
				<td Class="small"><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(addform); return false;" value="#addTaskTitle# >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript: window.location = '#CGI.HTTP_REFERER###tabs1-projects';" value="#cancelbttn# >>" class="whitefield"> </td>
				</tr>	
				
				</table>
				</form>	
				
				
				
			</td>
			</tr>
			
			</table> 
	<cfelse>
	        <p style="color: red; font-weight: bold;">
				  You are not authorized to access this page......
			</p>
	</cfif>		
<cfelse>
    <p style="color: red; font-weight: bold;">
	      You are not authorized to access this page......
	</p>
</cfif>

</body>
</html>

</cfoutput>

