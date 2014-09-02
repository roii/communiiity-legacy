
<cfoutput>


<cfinclude template="../download/qry_download_cats.cfm">

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Upload Library File</title>
<cfinclude template="../templates/styles.cfm">
	
	
	
	
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(FileAddForm) {    

if (FileAddForm.uploadfield.value == "") {
	alert("You must select a File to upload.");
	FileAddForm.uploadfield.focus();
	return;
	} 
	
else if (FileAddForm.Title.value == "") {
	alert("You must enter a File Title.");
	FileAddForm.Title.focus();
	return;
	} 
	
else if (FileAddForm.DisplayOrder.value == "") {
	alert("You must enter a numeric Display Order.");
	FileAddForm.DisplayOrder.focus();
	return;
	}
	
else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	FileAddForm.submit(); //submit form
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
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Upload a Library File</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>




	<cfform method="post" action="act_file_upload.cfm" name="FileAddForm" enctype="multipart/form-data">
	<input type="hidden" name="NonMember" value="0">
	<input type="hidden" name="Member" value="0">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	
	<cfif IsDefined("attributes.sectionID")>
	<input type="hidden" name="sectionID" value="#sectionID#">
	</cfif>
	
	<cfif IsDefined("attributes.documentID")>
	<input type="hidden" name="documentID" value="#documentID#">
	</cfif>
	
	<cfif IsDefined("attributes.articleID")>
	<input type="hidden" name="articleID" value="#articleID#">
	</cfif>
	
	<cfif IsDefined("attributes.subarticleID")>
	<input type="hidden" name="subarticleID" value="#subarticleID#">
	</cfif>
	
	<cfif IsDefined("attributes.newsID")>
	<input type="hidden" name="newsID" value="#newsID#">
	</cfif>
	
	<cfif IsDefined("attributes.eventID")>
	<input type="hidden" name="eventID" value="#eventID#">
	</cfif>
	
	<cfif IsDefined("attributes.LibraryID")>
	<input type="hidden" name="LibraryID" value="#LibraryID#">
	</cfif>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Category</td>
	<td class="normal" valign="top"><cfselect name="LibraryCatID" display="LibraryCatTitle" query="DownloadCats" value="LibraryCatID" class="whitefield"></cfselect></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Select File</td>
	<td class="normal" valign="top"><input type="file" class="whitefield" name="uploadfield" size="72"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">File Title</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="85" rows="2" name="Title"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Author</td>
	<td class="normal" valign="top"><input type="text" class="whitefield" size="85" name="Author"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">File Details</td>
	<td class="normal" valign="top">
	<textarea name="Details" rows="20" cols="40"></textarea>
	<!---
	<cf_activedit name="Details" inc="#request.ActiveEditInc#" image="true" 
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="445" height="220" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck" tabview="no" DEFAULTFONT="8pt Verdana"></cf_activedit>
	--->
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Expiry Date</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="DateExpires"> &nbsp; <a href="#request.webroot#/templates/dsp_pop_calendar.cfm?Field=DateExpires&formName=addform&Enc=No" target="popcalendar" ONCLICK="fdbackwindow=window.open ('','popcalendar','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=160,height=140,top=50,left=50')" style="color:black; text-decoration:none;">Calendar >></a></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Display Order</td>
	<td Class="normal" valign="top"><input type="text" Class="small" size="30" name="DisplayOrder"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Released</td>
	<td class="normal" valign="top"><input type="radio" name="Released" class="whitefield" value="1" checked> Yes &nbsp;&nbsp;&nbsp; <input type="radio" name="Released" class="whitefield" value="0"> No</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Allow to View</td>
	<td Class="normal" valign="top"><input type="checkbox" class="whitefield" name="NonMember" value="1" checked> Non-member &nbsp;&nbsp;&nbsp;<input type="checkbox" Class="whitefield" name="Member" value="1" checked> Member</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="ADD NOW >>>" onclick="javascript:ae_onSubmit(); validate(FileAddForm); return false;"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	
	
	</table>
	</cfform>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


