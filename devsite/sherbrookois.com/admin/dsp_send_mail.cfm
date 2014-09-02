
<cfquery name="AllMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactStatus<>'Deleted' and receiveEmail = 1
ORDER BY ContactType, LastName, FirstName
</cfquery>



<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>MyKidsBiz - Send Member Email</title>
<cfoutput><cfinclude template="../templates/styles.cfm"></cfoutput>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<cfoutput><tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Send Member Email</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br></cfoutput>




	<form action="act_sendmail.cfm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="Personalise" value="0">
	<input type="hidden" name="LoginDetails" value="0">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<cfoutput>
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr></cfoutput>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="120" valign="top">From Email</td>
	<td class="normal" valign="top">
	<select name="fromemail" size="1">
	<option value="">Select an email address</option>
	<option value="theTeam@mykidsbiz.com">theTeam@mykidsbiz.com</option>
	<option value="news@mykidsbiz.com">news@mykidsbiz.com</option>
	</select>
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="120" valign="top">Filter Type</td>
	<td class="normal" valign="top"><input type="Radio" class="whitefield" name="Filter" value="All">&nbsp;<strong>ALL MEMBERS</strong>
	<hr width="100%" size="1" color="silver">
	<input type="Radio" class="whitefield" name="Filter" value="Individual" checked>&nbsp;<strong>Selected Members</strong> - Use the 'Shift' and 'Ctrl' keys to modify your selection below
	<hr width="100%" size="1" color="silver">
	<select name="Member" class="whitefield" multiple="Yes" size="12" style="width:500px;">
	<cfoutput query="AllMembers" group="ContactType">
	<option value="0" style="background-color:silver;color:white;">#UCASE(TRIM(allmembers.ContactType))#
	<cfoutput><option value="#allmembers.ContactID#">#TRIM(UCASE(allmembers.LastName))#, #TRIM(allmembers.FirstName)#</cfoutput>
	<option value="0">
 	</cfoutput>
	</select></td>
	</tr>
	
	<cfoutput>
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="120" valign="top">Options</td>
	<td class="normal" valign="top"><input type="Checkbox" class="whitefield" name="Personalise" value="1" checked>&nbsp;Personalise with "Dear <i>FirstName</i>"
	<hr width="100%" size="1" color="silver">
	<input type="Checkbox" class="whitefield" name="LoginDetails" value="1">&nbsp;Send login details</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="120" valign="top">Subject</td>
	<td class="normal" valign="top"><textarea name="MessageSubject" style="width:500px;" rows="2" class="whitefield"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="120" valign="top">Bcc</td>
	<td class="normal" valign="top"><textarea name="Bcc" style="width:500px;" rows="2" class="whitefield"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="120" valign="top">Message</td>
	<td class="normal" valign="top">
		<textarea name="message" rows="25" cols="40"></textarea>
		<!--- <cf_activedit name="message" inc="#request.ActiveEditInc#" image="false" width="500" height="200" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,spellcheck" tabview="no" DEFAULTFONT="8pt Verdana"></cf_activedit> --->
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="120">Attachment</td>
	<td class="normal"><input type="file" class="whitefield" style="width:500px;" name="Attachment"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="120"> </td>
	<td class="normal">
	<input type="submit" name="submit" class="whitefield" value="SEND NOW >>"> &nbsp; 
	<input type="submit" name="sendtest" class="whitefield" value="SEND TEST EMAIL >>"> &nbsp; 
	<input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	</cfoutput>
	
	</table>
		
	</form>	
		
	
	
	
</td>
</tr>

</table>

</body>
</html>