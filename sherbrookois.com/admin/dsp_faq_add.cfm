
<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Add FAQ</title>
<cfinclude template="../templates/styles.cfm">	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Add Level 2 Document</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add a FAQ</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function validate(NewsAddForm) {    
	
	if (NewsAddForm.FaqTitle.value == "") {
		alert("You must enter a Question for this FAQ.");
		NewsAddForm.FaqTitle.focus();
		return;
		} 
		
	else if (NewsAddForm.FaqDetails.value == "") {
		alert("You must enter an Answer for this FAQ.");
		NewsAddForm.FaqDetails.focus();
		return;
		}
		
	else {
		NewsAddForm.submit(); //submit form
		}
	}
	// -->
	</script>
	
	<form method="post" action="act_faq_add.cfm" name="NewsAddForm">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	
	<cfif IsDefined("fusesubaction")>
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<cfelse>
	<input type="hidden" name="fusesubaction" value="">
	</cfif>
	
	<cfif IsDefined("DocumentID")>
	<input type="hidden" name="DocumentID" value="#DocumentID#">
	<cfelse>
	<input type="hidden" name="DocumentID" value="0">
	</cfif>
	
	<cfif IsDefined("ArticleID")>
	<input type="hidden" name="ArticleID" value="#ArticleID#">
	<cfelse>
	<input type="hidden" name="ArticleID" value="0">
	</cfif>
	
	<cfif IsDefined("ArticleID")>
	<input type="hidden" name="SubArticleID" value="#SubArticleID#">
	<cfelse>
	<input type="hidden" name="SubArticleID" value="0">
	</cfif>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" colspan="2" style="font-size:14;"><strong>ENTER A NEW FAQ</strong></td>
	</tr>
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Question</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="85" rows="5" name="FaqTitle"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Answer</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="85" rows="5" name="FaqDetails"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Display Order</td>
	<td class="normal" valign="top"><input type="text" name="DisplayOrder" class="whitefield" size="20"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="ADD NOW >>>" onclick="validate(NewsAddForm); return false;"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	
	
	</table>
	</form>

	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


