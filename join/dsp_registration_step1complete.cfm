<!--- 

	DJP - 06Oct11 - removed fields not required for new streamlined signup process.
	
 --->

<cfoutput>

<script language="JavaScript">

function validate(verifyform) {    


	verifyform.submit(); //submit form

}

</script>

<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT EmailAddress, MobilePhone
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>
  
<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#thanksText#</strong></td>
<td align="right" width="30" height="20"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<form name="verifyform" action="#request.webroot#/join/act_confirm_code.cfm" method="post" onsubmit="javascript:validate(verifyform); return false;">
<input type="hidden" name="EmailAddress" value="#TRIM(ContactDetails.EmailAddress)#">


</tr>
<tr>
	<td valign="middle"><img src="#request.imageroot#/reg_step2.gif" width="41" height="41" alt="Step 2" border="0">
	<span style="padding-left:20px;color:###TRIM(AllSettings.DkTextColor)#;"><strong>#checkEmailNote# <strong>#TRIM(ContactDetails.EmailAddress)#</strong> #forverilinktext#</strong></span><br><br>
</td>
	</tr>
</form>

</table>

</cfoutput>