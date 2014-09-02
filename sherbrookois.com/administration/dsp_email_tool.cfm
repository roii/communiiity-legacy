<cfoutput>

<cfquery name="AllContactTypes" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactTypeID, ContactType
	FROM contacttypes
	WHERE ContactType = 'Kids'
	ORDER BY DisplayOrder
</cfquery>	

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>EMAIL TOOL</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td>

	<table cellSpacing="1" cellPadding="0" bgColor="##b4b4b4" border="0">

	<tr>
	<td>
	
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>

			<form action="#request.webroot#/administration/act_sendmail.cfm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="Personalise" value="0">
			<input type="hidden" name="LoginDetails" value="0">
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="120" valign="top">From Email</td>
			<td valign="top">
			<select name="fromemail" size="1" class="whitefield" style="width:350px;">
			<option value="">Select an email address</option>		
			<option value="theTeam@my3p.com" selected>theTeam@my3p.com</option>
			<option value="news@my3p.com">news@my3p.com</option>
			<option value="theTeam@3PVentures.com">theTeam@3PVentures.com</option>
			<option value="news@3PVentures.com">news@3PVentures.com</option>
			</select></td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			
			
			<tr>
			<td width="120" valign="top">Filter Type</td>
			<td valign="top"><input type="Radio" class="whitefield" name="Filter" value="All">&nbsp;<strong>ALL MEMBERS</strong>
			<hr width="100%" size="1" color="##b4b4b4">
			<input type="Radio" class="whitefield" name="Filter" value="Individual" checked>&nbsp;<strong>Selected Members</strong> - Use the 'Shift' and 'Ctrl' keys to modify your selection below
			<hr width="100%" size="1" color="##b4b4b4">
			<select name="MemberType" class="whitefield" size="1" style="width:350px;">
				<cfloop query="AllContactTypes">
					<option value="#ContactTypeID#">#ContactType#</option>
				</cfloop>
			</select><BR>	
			<select name="Member" class="whitefield" multiple="Yes" size="12" style="width:350px;">
			
			<!---<cfloop query="AllContactTypes">--->
			
			<cfquery name="AllMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT contactid, contactTypeID, contactstatus, datejoined, firstname, lastname, mobilephone, emailaddress, dateofbirth, ScreenName, referralcode, CountryID, DateVerified
				FROM Contacts
				--WHERE ContactTypeID IN (1,2)
				--AND ContactStatus <> 'deleted'		
				--AND ContactStatus <> 'pending'
				WHERE     (EmailConfirmed = 1) OR
		                      (EmailConfirmed = 'True')
				order by lastname		
			</cfquery>
		
			<cfif AllMembers.Recordcount>
				
				<optgroup label="#UCASE(TRIM(AllContactTypes.ContactType))#">
				
				<cfloop query="AllMembers">
				<option value="#allmembers.ContactID#"<cfif IsDefined("ExportList") AND ListFind(ExportList, allmembers.ContactID, ",")> selected</cfif>>#TRIM(UCASE(allmembers.LastName))#, #TRIM(allmembers.FirstName)# [#TRIM(allmembers.emailaddress)#]
				</cfloop>
				<option value="0">
				
			 </cfif>
			 
			 <!---</cfloop>	--->
			</select></td>
			</tr>
			
			
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>	
			
			<tr>
			<td width="120" valign="top">Options</td>
			<td valign="top"><input type="Checkbox" class="whitefield" name="Personalise" value="1" checked>&nbsp;Personalise with "Hi <i>FirstName</i>"
			<hr width="100%" size="1" color="##b4b4b4">
			<input type="Checkbox" class="whitefield" name="LoginDetails" value="1">&nbsp;Send login details</td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>	
			
			<tr>
			<td width="120" valign="top">Subject</td>
			<td valign="top"><textarea name="MessageSubject" style="width:350px;" rows="2" class="whitefield"></textarea></td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>	
			
			<tr>
			<td width="120" valign="top">Bcc</td>
			<td valign="top"><textarea name="Bcc" style="width:350px;" rows="2" class="whitefield"></textarea></td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>	
			
			<tr>
			<td width="120" valign="top">Message</td>
			<td valign="top"><textarea class="whitefield" name="message" style="width:350px;" rows="10"></textarea></td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>	
			
			<tr>
			<td width="120">Attachment</td>
			<td><input type="file" class="whitefield" style="width:350px;" name="Attachment"></td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>	
			
			<tr>
			<td width="120" valign="top">Format</td>
			<td valign="top"><input type="Checkbox" class="whitefield" name="Format" value="Plain" checked>&nbsp;Plain Text
			<hr width="100%" size="1" color="##b4b4b4">
			<input type="Checkbox" class="whitefield" name="Format" value="HTML">&nbsp;HTML</td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>	
			
			<tr>
			<td width="120"> </td>
			<td>
			<input type="submit" name="submit" class="whitefield" value="SEND NOW >>"> &nbsp; 
			<input type="submit" name="sendtest" class="whitefield" value="SEND TEST EMAIL >>"> &nbsp; 
			<input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
			</tr>
			
			
			</table>
				
			</form>	
			

		</td>
		</tr>
				
		</table>
		
	
	</td>
	</tr>
	
	</table>
	

</td>
</tr>

</table>

</cfoutput>