<cfquery name="ArticleStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Articles.*, DocumentArticles_Link.DisplayOrder
FROM Articles, DocumentArticles_Link
WHERE Articles.ArticleID=#ArticleID#
AND Articles.ArticleID=DocumentArticles_Link.ArticleID
</cfquery>


<cfquery name="AllContactTypes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ContactTypes
ORDER BY ContactTypeID
</cfquery>


<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(addform) {    

if (addform.ArticleTitle.value == "") {
	alert("You must enter a Title for this article.");
	addform.ArticleTitle.focus();
	return;
	} 
	
else if (addform.DisplayOrder.value == "") {
	alert("You must enter a Display Order for this article.");
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
	<title>#TRIM(AllSettings.SiteName)# - #editlevel3doc#</title>
<cfinclude template="../templates/styles.cfm">
	<cfinclude template="../templates/set_language.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#editlevel3doc#</strong></span></td>
</tr>



<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<form method="post" action="act_article_edit.cfm" name="addform">
	<input type="hidden" name="NonMember" value="0">
	<input type="hidden" name="Member" value="0">
	<input type="hidden" name="ArticleID" value="#ArticleID#">
	<input type="hidden" name="DocumentID" value="#DocumentID#">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="art">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#articleTitle#</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="85" rows="2" name="ArticleTitle">#articleStuff.ArticleTitle#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#addprojdetails#</td>
	<td Class="normal" valign="top">
	<cf_fckeditor name="details" value="#articleStuff.details#" width="650" height="450" toolbarset="Default">
	<!---
	<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" 
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="445" height="420"
	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="yes" DEFAULTFONT="8pt Verdana">#articleStuff.details#</cf_activedit>---></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#pubDate#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="PubDate" value="#dateformat(articleStuff.pubdate, "d mmmm yyyy")#"> &nbsp; <a href="#request.webroot#/templates/dsp_pop_calendar.cfm?Field=PubDate&formName=addform&Enc=No" target="popcalendar" ONCLICK="fdbackwindow=window.open ('','popcalendar','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=160,height=140,top=50,left=50')" style="color:black; text-decoration:none;">#Calendar# >></a></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#expiryDate#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="ExpireDate" value="#dateformat(articleStuff.ExpireDate, "d mmmm yyyy")#"> &nbsp; <a href="#request.webroot#/templates/dsp_pop_calendar.cfm?Field=ExpireDate&formName=addform&Enc=No" target="popcalendar" ONCLICK="fdbackwindow=window.open ('','popcalendar','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=160,height=140,top=50,left=50')" style="color:black; text-decoration:none;">#Calendar# >></a></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#Author#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="85" name="Author" value="#articleStuff.author#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>#allowtoview#</td>
	<td><input type="checkbox" class="whitefield" name="AdminView" value="1"<cfif articleStuff.AdminView CONTAINS 1> checked</cfif>> #Administrators#<br>
	
	<input type="checkbox" class="whitefield" name="PublicView" value="1"<cfif articleStuff.PublicView CONTAINS 1> checked</cfif>> #Public#<br>

	<cfloop query="AllContactTypes">
	
	<input type="checkbox" Class="whitefield" name="ContactTypeView" value="#AllContactTypes.ContactTypeID#"<cfif ListFind(articleStuff.ContactTypeView, AllContactTypes.ContactTypeID)> checked</cfif>> #TRIM(AllContactTypes.ContactType)#<br>
	
	</cfloop>
	
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120">#metatitle#</td>
	<td><input type="text" name="PageTitle" style="width:600px;font-size:10px;font-family:Arial;" value="#TRIM(articleStuff.PageTitle)#" class="whitefield"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120" valign="top">#metadesc#</td>
	<td><textarea name="MetaContent" style="width:600px;font-size:10px;font-family:Arial;" class="whitefield" rows="4">#TRIM(articleStuff.MetaContent)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120" valign="top">#metakey#<br>
	<em>#commadeli#</em></td>
	<td><textarea name="MetaKeywords" style="width:600px;font-size:10px;font-family:Arial;" class="whitefield" rows="4">#TRIM(articleStuff.MetaKeywords)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#disporder#</td>
	<td Class="normal" valign="top"><input type="text" Class="small" size="15" name="DisplayOrder" value="#articleStuff.displayorder#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#released#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="Released" value="1"<cfif #articleStuff.Released# EQ 1> checked</cfif>> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="Released" value="0"<cfif #articleStuff.Released# EQ 0> checked</cfif>> #notitle#</td>
	</tr>		
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(addform); return false;" value="#updateartnow# >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</form>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>