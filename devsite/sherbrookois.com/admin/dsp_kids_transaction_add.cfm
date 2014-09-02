
<cfoutput>

<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, LastName
FROM Contacts
WHERE ContactTypeID IN (1,2)
AND ContactStatus <> 'deleted'
ORDER BY LastName, FirstName
</cfquery>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Add Kids Transaction</title>
<cfinclude template="../templates/styles.cfm">
	
	
	
	
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(AddForm) {    

if (AddForm.Transaction_Date.value == "") {
	alert("You must enter the Transaction Date.");
	AddForm.Transaction_Date.focus();
	return;
	} 
	
else if (AddForm.Transaction_Amount.value == "") {
	alert("You must enter a valid Amount.");
	AddForm.Transaction_Amount.focus();
	return;
	}
	
else if (AddForm.Transaction_Description.value == "") {
	alert("Please enter a Description.");
	AddForm.Transaction_Description.focus();
	return;
	}
	
else {
	AddForm.submit(); //submit form
	}
}
// -->
</script>



</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add Kids Transaction</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>




	<form method="post" action="#request.webroot#/admin/act_kids_transaction_add.cfm" name="AddForm">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="130">Kid</td>
	<td class="normal" ><select name="ContactID"class="whitefield">
	<cfloop query="AllKids">
	<option value="#AllKids.ContactID#">#UCASE(TRIM(AllKids.LastName))#,  #TRIM(AllKids.FirstName)#</cfloop>
	</select></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="130">Transaction Date</td>
	<td class="normal"><input type="text" class="whitefield" name="Transaction_Date" value="#DateFormat(localDateTime, "d-mmm-yyyy")#" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="130">Account</td>
	<td class="normal"><input type="radio" class="whitefield" name="Transaction_Account" value="Personal" checked> Cash &nbsp;&nbsp;&nbsp; <input type="radio" class="whitefield" name="Transaction_Account" value="Education"> Education &nbsp;&nbsp;&nbsp; <input type="radio" class="whitefield" name="Transaction_Account" value="Points" checked> Points</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="130">Transaction Type</td>
	<td class="normal"><input type="radio" class="whitefield" name="Transaction_Type" value="Credit" checked> Money In &nbsp;&nbsp;&nbsp; <input type="radio" class="whitefield" name="Transaction_Type" value="Debit"> Money Out</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="130">Transaction Amount</td>
	<td class="normal"><input type="text" class="whitefield" name="Transaction_Amount" value="0" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="130">Description</td>
	<td class="normal" valign="top"><textarea name="Transaction_Description" class="whitefield" style="width:300px;" rows="4"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="ADD NOW >>>" onclick="validate(AddForm); return false;"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	
	
	</table>
	</form>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


