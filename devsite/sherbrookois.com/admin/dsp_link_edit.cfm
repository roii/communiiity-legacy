
<cfoutput>


<cfinclude template="../default_links/qry_link_cats.cfm">
<cfinclude template="../default_links/qry_link_details.cfm">

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Edit Link</title>
<cfinclude template="../templates/styles.cfm">
	
	
	
	
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(LinkAddForm) {    

if (LinkAddForm.Title.value == "") {
	alert("You must enter a Title for this Link.");
	LinkAddForm.Title.focus();
	return;
	} 
	
else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	LinkAddForm.submit(); //submit form
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
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit a Link</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>




	<cfform method="post" action="act_link_edit.cfm" name="LinkAddForm">
	<input type="hidden" name="NonMember" value="0">
	<input type="hidden" name="Member" value="0">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="linkID" value="#linkID#">
	
	<cfif IsDefined("fusesubaction")>
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	</cfif>
	
	<cfif IsDefined("ArticleID")>
	<input type="hidden" name="ArticleID" value="#ArticleID#">
	</cfif>
	
	<cfif IsDefined("DocumentID")>
	<input type="hidden" name="DocumentID" value="#DocumentID#">
	</cfif>
	
	<cfif IsDefined("CheckLinks")>
	<input type="hidden" name="CheckLinks" value="#CheckLinks#">
	</cfif>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Category</td>
	<td class="normal" valign="top"><cfselect name="LinkCatID" display="Title" query="LinkCats" value="LinkCatID" class="whitefield" selected="#LinkDetails.LinkCatID#"></cfselect></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Title</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="85" rows="2" name="Title">#linkdetails.title#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Link URL</td>
	<td class="normal" valign="top"><input type="text" Class="whitefield" size="85" name="LinkURL" value="#linkdetails.linkurl#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Details</td>
	<td class="normal" valign="top">
	<textarea name="details" rows="20" cols="40">#linkdetails.details#</textarea>
	<!---	
	<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" 
imagepath="#request.fileroot#\images\" 
imageURL="#request.imageroot#/" width="445" height="220" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck" tabview="no" DEFAULTFONT="8pt Verdana">#linkdetails.details#</cf_activedit>--->
	</td>
	</tr>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Allow to View</td>
	<td Class="normal" valign="top"><input type="checkbox" class="whitefield" name="NonMember" value="1"<cfif #linkdetails.NonMember# EQ 1> checked</cfif>> Non-member &nbsp;&nbsp;&nbsp;<input type="checkbox" Class="whitefield" name="Member" value="1"<cfif #linkdetails.Member# EQ 1> checked</cfif>> Member</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Released</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="Released" value="1"<cfif #linkdetails.Released# EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="Released" value="0"<cfif #linkdetails.Released# EQ 0> checked</cfif>> No</td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="UPDATE NOW >>>" onclick="javascript:ae_onSubmit(); validate(LinkAddForm); return false;"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	
	
	</table>
	</cfform>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


