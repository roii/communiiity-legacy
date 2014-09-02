<cfquery name="DocumentDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Documents.*, SectionDocuments_Link.DisplayOrder
FROM Documents, SectionDocuments_Link
WHERE Documents.DocumentID=#attributes.documentid#
AND Documents.DocumentID=SectionDocuments_Link.DocumentID
</cfquery>



<cfquery name="AllContactTypes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ContactTypes
ORDER BY ContactTypeID
</cfquery>



<SCRIPT LANGUAGE="JavaScript">
<!--

function validate(addform) {    

if (addform.Title.value == "") {
	alert("You must enter a Title for this document.");
	addform.Title.focus();
	return;
	} 
	
else if (addform.DisplayOrder.value == "") {
	alert("You must enter a Display Order for this document.");
	addform.DisplayOrder.focus();
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
	<title>#TRIM(AllSettings.SiteName)# - Edit Level 2 Document</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Level 2 Document</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<form method="post" action="act_document_edit.cfm" name="editform">
	<input type="hidden" name="DocumentID" value="#DocumentID#">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="NonMember" value="0">
	<input type="hidden" name="Member" value="0">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Document Title</td>
	<td><textarea class="whitefield" cols="85" rows="2" name="Title">#DocumentDetails.Title#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Details</td>
	<td>
	<cf_fckeditor name="details" value="#DocumentDetails.details#" width="650" height="450" toolbarset="Default">
	<!---
	<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true"
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="645" height="520"
	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="yes" DEFAULTFONT="8pt Verdana">#DocumentDetails.details#</cf_activedit>---></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Published Date</td>
	<td><!---<input type="text" Class="whitefield" size="68" name="PubDate" value="#dateformat(DocumentDetails.PubDate, "d mmmm yyyy")#"> &nbsp; <a href="#request.webroot#/templates/dsp_pop_calendar.cfm?Field=PubDate&formName=editform&Enc=No" target="popcalendar" ONCLICK="fdbackwindow=window.open ('','popcalendar','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=160,height=140,top=50,left=50')" style="color:black; text-decoration:none;">Calendar >></a>---> 
	<input type="text" name="PubDate" class="whitefield" size="68" style="width:300px;" readonly="readonly" value="#dateformat(DocumentDetails.PubDate, "d mmmm yyyy")#"><a href="javascript:void(0)" onClick="if(self.gfPop)gfPop.fPopCalendar(document.editform.PubDate);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a>
	
	</td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Expiry Date</td>
	<td><input type="text" Class="whitefield" size="68" name="DocExpireDate" value="#dateformat(DocumentDetails.DocExpireDate, "d mmmm yyyy")#"> &nbsp; <a href="#request.webroot#/templates/dsp_pop_calendar.cfm?Field=DocExpireDate&formName=editform&Enc=No" target="popcalendar" ONCLICK="fdbackwindow=window.open ('','popcalendar','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=160,height=140,top=50,left=50')" style="color:black; text-decoration:none;">Calendar >></a></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Author</td>
	<td><input type="text" Class="whitefield" size="85" value="#DocumentDetails.Author#" name="Author"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Allow to View</td>
	<td><input type="checkbox" class="whitefield" name="AdminView" value="1"<cfif DocumentDetails.AdminView CONTAINS 1> checked</cfif>> Administrators<br>
	
	<input type="checkbox" class="whitefield" name="PublicView" value="1"<cfif DocumentDetails.PublicView CONTAINS 1> checked</cfif>> Public<br>

	<cfloop query="AllContactTypes">
	
	<input type="checkbox" Class="whitefield" name="ContactTypeView" value="#AllContactTypes.ContactTypeID#"<cfif ListFind(TRIM(DocumentDetails.ContactTypeView), AllContactTypes.ContactTypeID)> checked</cfif>> #TRIM(AllContactTypes.ContactType)#<br>
	
	</cfloop>
	
	</td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120">Meta Title</td>
	<td><input type="text" name="PageTitle" style="width:600px;font-size:10px;font-family:Arial;" value="#TRIM(DocumentDetails.PageTitle)#" class="whitefield"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120" valign="top">Meta Description</td>
	<td><textarea name="MetaContent" style="width:600px;font-size:10px;font-family:Arial;" class="whitefield" rows="4">#TRIM(DocumentDetails.MetaContent)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120" valign="top">Meta Keywords<br>
	<em>Comma-delimited</em></td>
	<td><textarea name="MetaKeywords" style="width:600px;font-size:10px;font-family:Arial;" class="whitefield" rows="4">#TRIM(DocumentDetails.MetaKeywords)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Display Order</td>
	<td><input type="text" Class="whitefield" size="15" name="DisplayOrder" value="#DocumentDetails.DisplayOrder#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Released</td>
	<td><input type="radio" Class="whitefield" name="Released" value="1"<cfif #DocumentDetails.Released# EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="Released" value="0"<cfif #DocumentDetails.Released# EQ 0> checked</cfif>> No</td>
	</tr>		
	
	<cfif fuseaction EQ 'community_content'>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Show on Homepage</td>
	<td><input type="radio" Class="whitefield" name="HomePromote" value="1"<cfif DocumentDetails.HomePromote EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="HomePromote" value="0"<cfif DocumentDetails.HomePromote EQ 0> checked</cfif>> No</td>
	</tr>	
	
	</cfif>
	
	
	
	
	
	
	
	<cfif documentID EQ 100>
	
	<cfquery name="AnnounceStuff" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT *
	FROM Announcements
	ORDER BY AnnouncementDate DESC
	</cfquery>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120" valign="top">Announcement Box</td>
	<td><textarea name="AnnoucementShort" style="width:600px;font-size:10px;font-family:Arial;" class="whitefield" rows="4">#TRIM(AnnounceStuff.AnnoucementShort)#</textarea></td>
	</tr>
	
	</cfif>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(editform); return false;" value="UPDATE DOCUMENT NOW >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</form>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>