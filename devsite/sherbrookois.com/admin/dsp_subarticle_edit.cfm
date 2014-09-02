<cfquery name="SubArticleStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SubArticles.*, ArticleSubArticle_Link.DisplayOrder
FROM SubArticles, ArticleSubArticle_Link
WHERE SubArticles.SubArticleID=#SubArticleID#
AND SubArticles.SubArticleID=ArticleSubArticle_Link.SubArticleID
</cfquery>



<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(addform) {    

if (addform.SubArticleTitle.value == "") {
	alert("You must enter a Title for this SubArticle.");
	addform.SubArticleTitle.focus();
	return;
	} 
	
else if (addform.DisplayOrder.value == "") {
	alert("You must enter a Display Order for this SubArticle.");
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
	<title>MyKidsBiz - Edit Level 4 Document</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Level 4 Document</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<form method="post" action="act_subarticle_edit.cfm" name="addform">
	<input type="hidden" name="NonMember" value="0">
	<input type="hidden" name="Member" value="0">
	<input type="hidden" name="SubArticleID" value="#SubArticleID#">
	<input type="hidden" name="DocumentID" value="#DocumentID#">
	<input type="hidden" name="ArticleID" value="#ArticleID#">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="subart">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Sub-Article Title</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="85" rows="2" name="subArticleTitle">#subarticleStuff.subArticleTitle#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Details</td>
	<td Class="normal" valign="top">
	<cf_fckeditor name="subdetails" value="#subarticleStuff.subdetails#" width="650" height="450" toolbarset="Default">
	<!---
	<cf_activedit name="subdetails" inc="#request.ActiveEditInc#" image="true" 
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="445" height="420"
	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="no" DEFAULTFONT="8pt Verdana">#subarticleStuff.subdetails#</cf_activedit>---></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Published Date</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="PubDate" value="#dateformat(subarticleStuff.pubdate, "d mmmm yyyy")#"> &nbsp; <a href="#request.webroot#/templates/dsp_pop_calendar.cfm?Field=PubDate&formName=addform&Enc=No" target="popcalendar" ONCLICK="fdbackwindow=window.open ('','popcalendar','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=160,height=140,top=50,left=50')" style="color:black; text-decoration:none;">Calendar >></a></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Expiry Date</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="SubExpireDate" value="#dateformat(subarticleStuff.SubExpireDate, "d mmmm yyyy")#"> &nbsp; <a href="#request.webroot#/templates/dsp_pop_calendar.cfm?Field=SubExpireDate&formName=addform&Enc=No" target="popcalendar" ONCLICK="fdbackwindow=window.open ('','popcalendar','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=160,height=140,top=50,left=50')" style="color:black; text-decoration:none;">Calendar >></a></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Author</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="85" name="Author" value="#subarticleStuff.author#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Allow to View</td>
	<td Class="normal" valign="top"><input type="checkbox" class="whitefield" name="UserType" value="all"<cfif #subarticlestuff.USerType# CONTAINS 'all'> checked</cfif>> Everyone<br>
	<input type="checkbox" Class="whitefield" name="UserType" value="kid"<cfif #subarticlestuff.USerType# CONTAINS 'kid'> checked</cfif>> Kids<br>
	<input type="checkbox" Class="whitefield" name="UserType" value="grownup"<cfif #subarticlestuff.USerType# CONTAINS 'grownup'> checked</cfif>> Grown-Ups<br>
	<input type="checkbox" Class="whitefield" name="UserType" value="shopper"<cfif #subarticlestuff.USerType# CONTAINS 'shopper'> checked</cfif>> Shoppers</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Display Order</td>
	<td Class="normal" valign="top"><input type="text" Class="small" size="15" name="DisplayOrder" value="#subarticleStuff.displayorder#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Released</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="Released" value="1"<cfif #subarticleStuff.subReleased# EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="Released" value="0"<cfif #subarticleStuff.subReleased# EQ 0> checked</cfif>> No</td>
	</tr>		
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(addform); return false;" value="UPDATE SUB-ARTICLE NOW >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</form>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>