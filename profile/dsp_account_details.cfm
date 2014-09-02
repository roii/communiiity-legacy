<cfoutput>
<script>
function validateAccount(accForm) {
	
	
	if (accForm.acctno.value != accForm.confirmacctno.value) {
	alert("The two account numbers you entered do not match.");
	accForm.confirmacctno.focus();
	return;
	} 
	
else {
	accForm.submit(); //submit form
	}
	
}
</script>

 
<cfset newdetails=DocumentDetails.details>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(DocumentDetails.Title))#</strong></td>
<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=550,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit" border="0"></a>&nbsp;<a href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete" border="0"></a></cfif></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>


<form name="accForm" action="#request.webroot#/profile/act_account_details.cfm" method="post">


<tr>
<td colspan="2">

	

<cfparam name="decrypted" default="">

<cfquery name="bankdetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from bankacct where kidsid = #session.userid#
</cfquery>

<cfif bankdetails.recordcount GT 0>
  <cfif bankdetails.Acctno NEQ "">
    <CFSET decrypted = decrypt("#bankdetails.acctno#", "kidskids")>
  </cfif>
</cfif>

	
	<table cellSpacing="1" cellPadding="0" bgcolor="##b4b4b4" border="0" width="500">

	<tr>
	<td>
	
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="150" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1"  border="0"></td>
			<td></td>
			</tr>
						
			<tr title="It is very important that you get your account number correct, or else you will lose your money">
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Account Name</td>
			<td><input type="text" name="acctname" class="whitefield" style="width:250px;" value="#TRIM(bankdetails.acctname)#"></td>
			</tr>
			
			<tr>
			<td  height="5"> </td>
			<td> </td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Account Number</td>
			<td><input type="text" title="It is very important that you get your account number correct, or else you will lose your money" name="acctno" class="whitefield" style="width:250px;" value="#TRIM(decrypted)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Confirm Account Number</td>
			<td><input type="text" title="It is very important that you get your account number correct, or else you will lose your money" name="confirmacctno" class="whitefield" style="width:250px;" value="#TRIM(decrypted)#"></td>
			</tr>
			
			<tr>
			<td  height="5"> </td>
			<td> </td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Bank Name & Branch</td>
			<td><input type="text" name="branch" class="whitefield" style="width:250px;" value="#TRIM(bankdetails.branch)#"></td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/update_button.gif" onclick="validateAccount(accForm); return false;"></td>
			</tr>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>


</td>
</tr>
</form>

</table>

</cfoutput>