<cfoutput>

<hr width="100%" size="1" color="##b4b4b4">
	
<table width="100%" cellpadding="1" cellspacing="0" border="0">

<form method="post" action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=45" name="AddForm">

<tr>
<td width="171"><img src="#request.imageroot#/contacts/icon_key.gif" width="171" height="16" alt="Icon key" border="0"></td>
<td align="right" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;">Add/Invite <select name="NumberToAdd" class="whitefield" onchange="javascript:AddForm.submit();"><option value="1"><cfloop from="1" to="10" index="loopcount"><option value="#loopcount#">#loopcount# friend<cfif loopcount GT 1>s</cfif></cfloop></select> Now!</td>
</tr>

</form>


</table>		
		
</cfoutput>