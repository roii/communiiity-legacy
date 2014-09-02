<cfoutput>

<cfquery name="notedetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from kidsnote where noteid = #attributes.noteid#
</cfquery>
		
<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Add Kids Note</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add Note</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
			<form method="post" action="#request.webroot#/admin/act_edit_note.cfm">
			<input type="hidden" name="contactID" value="#contactID#">
			<input type="hidden" name="noteID" value="#noteID#">
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td>Note</td>
			<td><textarea name="kidsnote" rows="5" cols="35">#notedetails.note#</textarea></td>
			</tr>
 			
						
			<tr>
			<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td > </td>
			<td><input type="submit" class="whitefield" style="" value="UPDATE NOW"> <input type="button" class="whitefield" value="CANCEL" onclick="window.close();"></td>
			</tr>
			

	</form>	

	</table><br><br>
	
</td>
</tr>
</table>

</body>
</html>

</cfoutput>