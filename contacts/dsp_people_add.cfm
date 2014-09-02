<cfoutput>

<cfparam name="NumberToAdd" default="1">

<br>
	


<table cellpadding="0" cellspacing="0" border="0">

<tr>
<td style="color:##444444;padding-right:10px;"><strong>Import and invite your contacts from...</strong></td>
<td><a href="#request.webroot#/contacts/import/import.php" target="InviteContacts" onclick="fdbackwindow=window.open ('','InviteContacts','toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=730,height=500,top=10,left=10')"><img src="#request.imageroot#/contacts/invite_contacts_sml.gif" width="369" height="27" alt="Hotmail, Yahoo, Gmail, AOL, MSN" border="0" align="absmiddle"></a></td>
</tr>

</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"><br>

	
<table width="100%" cellpadding="4" cellspacing="0" border="0">	
	
<form method="post" action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&AddContact=1" name="AddForm">

<tr bgcolor="##e2e2e2">
<td style="color:##333333;padding-left:5px;font-size:11px;border-left:solid 1px ##b4b4b4;border-top:solid 1px ##b4b4b4;">Changing this number will refresh the screen without saving your current entries!...<img src="#request.imageroot#/transparent_spc.gif" width="1" height="16" border="0"></td>
<td style="color:##333333;padding-right:5px;font-size:11px;border-right:solid 1px ##b4b4b4;border-top:solid 1px ##b4b4b4;" align="right"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="16" border="0">Add/Invite <select name="NumberToAdd" class="whitefield" onchange="javascript:AddForm.submit();"><option value="1"><cfloop from="1" to="10" index="loopcount"><option value="#loopcount#"<cfif NumberToAdd EQ loopcount> selected</cfif>>#loopcount# friend<cfif loopcount GT 1>s</cfif></cfloop></select></td>
</tr>

</form>

</table>	
	
	
<table width="100%" cellpadding="6" cellspacing="0" style="border:solid 1px ##b4b4b4;">

<tr>
<td>
		
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
		
	<tr>
	<td colspan="6" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>	
	
	<tr>
	<td width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" width="80" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1"  border="0"><br>
	Send Invite</td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" width="150"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1"  border="0"><br>
	First Name</td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" width="210"><img src="#request.imageroot#/transparent_spc.gif" width="210" height="1"  border="0"><br>
	Email Address</td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" width="110"><img src="#request.imageroot#/transparent_spc.gif" width="110" height="1"  border="0"><br>
	Mobile Phone <a href="#request.webroot#/templates/dsp_sms_numbers.cfm" target="smsnum" onclick="fdbackwindow=window.open ('','smsnum','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=350,top=10,left=10')" style="font-size:11px;text-decoration:none;">(?)</a></td>
	<td width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>

	<tr>
	<td colspan="6" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	<form name="AddPeople" action="#request.webroot#/contacts/act_people_add.cfm" method="post">			
	<input type="hidden" name="NumberToAdd" value="#NumberToAdd#">
	
	<cfloop from="1" to="#NumberToAdd#" index="loopcount">
	
	<tr>
	<td width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td align="center"><input type="checkbox" name="SendInvite_#loopcount#" class="whitefield" checked></td>
	<td><input type="text" name="FirstName_#loopcount#" class="whitefield" style="width:140px;"></td>
	<td><input type="text" name="EmailAddress_#loopcount#" class="whitefield" style="width:200px;"></td>
	<td><input type="text" name="MobilePhone_#loopcount#" class="whitefield" style="width:100px;"></td>
	<td width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<cfif loopcount NEQ NumberToAdd>
	
		<tr>
		<td colspan="6" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="6" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="6" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
	</cfif>
	
	</cfloop>	

	<tr>
	<td colspan="6" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" align="center"><input type="submit" value="Add/Invite Friends &raquo;" onclick="validatePeople(AddPeople); return false;" style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:black;font-weight:bold;font-size:11px;border:0px;" class="whitefield"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</form>
	
	</table>
	
</td>
</tr>
	
</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"><br>

	
<table width="100%" cellpadding="4" cellspacing="0" border="0">	

<tr>
<td style="color:##666666;padding-left:5px;font-size:11px;">* Fields with blank "First Name" or "Email Address" will not be processed.<img src="#request.imageroot#/transparent_spc.gif" width="1" height="16" border="0"></td>
</tr>

</table>

</cfoutput>