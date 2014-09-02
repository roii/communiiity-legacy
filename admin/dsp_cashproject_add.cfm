<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ProjectCategories
ORDER BY Title
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
	<title>#TRIM(AllSettings.SiteName)# - #addTaskTitle#</title>
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
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#addTaskTitle#</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<form method="post" action="#request.webroot#/admin/act_cashproject_add.cfm" name="addform" enctype="multipart/form-data" onSubmit="javascript:validate(addform); return false;">
	<input type="hidden" name="DocumentID" value="#DocumentID#">
    <!---<input type="hidden" name="ProjectCategoryID" value="1">--->
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#category#</td>
	<td class="normal" valign="top"><select name="ProjectCategoryID" class="whitefield"><cfloop query="allCats"><option value="#TRIM(AllCats.ProjectCategoryID)#">#TRIM(allCats.Title)#</cfloop></select></td>
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
	<td class="normal" valign="top"><textarea class="whitefield" cols="68" rows="2" name="Title"></textarea></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#relatedprojtxt#</td>
	<td><select name="related_campaign" id="related_campaign" style="width:300px;">
		    <option value="">#selectprojtxt#</option>
		    <cfloop query="getCampaigns">
		        <option value="#getCampaigns.CampaignsID#">#getCampaigns.Title#</option>
			</cfloop>
		</select> 
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
			<strong style="color: blue;">Note: * Please upload only 200x200 size image.</strong> 
	</td>
	</tr>--->
	
	<!---<tr>
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
			<textarea cols="80" id="details" name="details" rows="20" cols="60"></textarea>
			<script> 
				 CKEDITOR.replace( 'details', {
					extraPlugins: 'magicline',	// Ensure that magicline plugin, which is required for this sample, is loaded.
					allowedContent: true		// Switch off the ACF, so very complex content created to
												// show magicline's power isn't filtered.
				} ); 
			</script>
		 </p>
	<!---
	<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" 
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="445" height="420"
	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="no" DEFAULTFONT="8pt Verdana"></cf_activedit>--->
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
	</tr>--->		
	
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
	
	<tr>
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
	</tr>		
	
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
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#featureproj#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="FeatureProject" value="1" checked> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="FeatureProject" value="0"> #notitle#</td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#location#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="location" value=""></td>
	</tr>
	
	<tr>
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
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#disproj#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="displayProject" value="1" checked> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="displayProject" value="0"> #notitle#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(addform); return false;" value="#addTaskBtnTitle# >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</form>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>