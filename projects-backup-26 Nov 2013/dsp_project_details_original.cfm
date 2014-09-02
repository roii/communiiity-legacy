
<cfoutput>
<cfif  session.UserIsAuthenticated EQ 'no'>
 
 <script>
alert("You must be a #TRIM(AllSettings.SiteName)# member and logged-in to access this part of the website.");
self.location="javascript:history.back();";
</script>
<cfabort>

</cfif>

<table width="100%" cellpadding="0" cellspacing="0" border="0">



<tr> 
<td><span style="font-size:14px;color:###TRIM(AllSettings.DkTextColor)#"><b>#TRIM(projectdetails.title)#</b></span><br><br>


	<table cellpadding="0" cellspacing="0" border="0" width="90%">
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Category:</strong></td>
	<td>#TRIM(ProjectDetails.CategoryTitle)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Brief:</strong></td>
	<td>#TRIM(ProjectDetails.IntroText)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Status:</strong></td>
	<td><cfif TRIM(projectdetails.currentstatus) NEQ ''>#TRIM(projectdetails.currentstatus)#<cfelse> &ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Being done by:</strong></td>
	<td><cfif TRIM(projectdetails.assignedto) NEQ ''>#TRIM(projectdetails.assignedto)#<cfelse> &nbsp;&nbsp;&ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	</table>


	<br><br>
	<table width="90%" border="0" cellspacing="2" cellpadding="2">
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#">
	<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="25%"><b>Minimum Age:</b></td>
	<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="25%"><b>Estimated Time:</b></td>
	<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="25%"><b><cfif projectdetails.paymenttype contains 'money'>Cash<cfelse>Points</cfif> Offered:</b></td>
	<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="25%"><b>Percent Complete:</b></td>
	</tr>
	
	<tr>
	<td align="center"><cfif TRIM(projectdetails.AgeLong) NEQ ''>#projectdetails.AgeLong#<cfelse>&ndash;</cfif></td>
	<td align="center"><cfif TRIM(projectdetails.MaxTime) NEQ ''>#projectdetails.MaxTime#<cfelse>&ndash;</cfif></td>
	<td align="center"><cfif TRIM(projectdetails.CreditsOffered) NEQ ''><cfif projectdetails.paymenttype contains 'money'>#TRIM(projectDetails.PaidIn)##DecimalFormat(projectdetails.CreditsOffered)#<cfelse>#INT(projectdetails.CreditsOffered)# pts</cfif><cfelse>&ndash;</cfif></td>
	<td align="center"><cfif IsNumeric("#projectdetails.percentcomplete#")>#projectdetails.percentcomplete#%<cfelse>&ndash;</cfif></td>
	</tr>
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#" height=2>
	<td colspan=4> </td>
	</tr>
	
	</table><br><br>
	
	
	#TRIM(projectDetails.details)#<br>
	
	
</td>
</tr>


</table><br><br>


</cfoutput>