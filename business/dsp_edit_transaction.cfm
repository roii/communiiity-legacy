<cfoutput>

<cfinclude template="qry_current_biz.cfm">
<cfinclude template="qry_current_clients.cfm">

<script>
function ValidateTrans(EditTran){ 


if (document.EditTran.clientid.selectedIndex == 0) { 

	alert("You must select a Client.");
	EditTran.clientid.focus();
	return;

}

else {
	EditTran.submit(); //submit form
	}
	
}
</script>


<strong>Edit a Job for your:</strong><br>
<strong style="color:###TRIM(AllSettings.BoxColour)#;font-size:12px;">#CurrentBizDetail.bizName# Business</strong><br><br>


<table cellSpacing="1" cellPadding="0" bgColor="##b4b4b4" border="0" width="100%">

	<tr>
	<td>
	
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>
		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<cfform name="EditTran" action="#request.webroot#/business/act_edit_transaction.cfm" method="post">
			
			<input type="hidden" name="bizkidslinkid" value="#attributes.bizkidslinkid#">
			<input type="hidden" name="transactionID" value="#transactionID#">
	
			<cfif IsDefined("DocumentID")>
				<input type="hidden" name="DocumentID" value="#DocumentID#">
			</cfif>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Client</td>
			<td><select name="clientid" size="1" style="width:250px;" class="whitefield">
			<option value="">Select a Client...</option>
			<cfif CurrentClients.recordcount>
			<cfloop query="CurrentClients">
				<option value="#currentclients.clientid#"<cfif TranDetail.ClientID EQ currentclients.clientid> selected</cfif>> #TRIM(currentclients.firstname)# #TRIM(currentclients.lastname)#</option>
			</cfloop>
			</cfif>
			</select></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Transaction Date</td>
			<td><cfinput type="text" name="tranDate" class="whitefield" required="yes" validate="eurodate" message="You didn't enter the correct date format" style="width:250px;" value="#DateFormat(TranDetail.tranDate, "dd/mm/yyyy")#">
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.AddTran.tranDate);return false;" HIDEFOCUS><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0"></a></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<input type="hidden" name="JobNumber" value="#NumberFormat(TranDetail.JobNumber, "00000")#">

			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Job Number <em>(readonly)</em></td>
			<td><input type="text" class="whitefield" style="width:250px;" value="#NumberFormat(TranDetail.JobNumber, "00000")#" readonly></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Job Description</td>
			<td><cfinput type="text" required="Yes" message="Please enter transaction description" name="description" class="whitefield" style="width:250px;" value="#TRIM(TranDetail.description)#"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Income<br>
			<em>(amount/details)</em></td>
			<td><input type="text" name="income1_amount" class="whitefield" style="width:46px;" value="$#DecimalFormat(TranDetail.income1_amount)#"> <input type="text" name="income1_details" class="whitefield" style="width:200px;" value="#TRIM(TranDetail.income1_details)#">
			<input type="hidden" name="income2_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="income2_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="income3_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="income3_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="income4_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="income4_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="income5_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="income5_details" class="whitefield" style="width:200px;"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Expenses<br>
			<em>(amount/details)</em></td>
			<td><input type="text" name="expense1_amount" class="whitefield" style="width:46px;" value="$#DecimalFormat(TranDetail.expense1_amount)#"> <input type="text" name="expense1_details" class="whitefield" style="width:200px;" value="#TRIM(TranDetail.expense1_details)#">
			<input type="hidden" name="expense2_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="expense2_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="expense3_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="expense3_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="expense4_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="expense4_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="expense5_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="expense5_details" class="whitefield" style="width:200px;"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<cfif IsNumeric("#TranDetail.hours#")>
				<cfset hours = Int(TranDetail.hours / 60)>
				<cfset minutes = TranDetail.hours mod 60>
			<cfelse>
				<cfset hours = 0>
				<cfset minutes = 0>
			</cfif>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Time invested</td>
			<td><select name="Time_Hour" class="whitefield" style="width:50px;"><cfloop from="0" to="500" index="loopcount"><option value="#loopcount#"<cfif hours EQ loopcount> selected</cfif>>#loopcount#</option></cfloop></select> hr &nbsp;&nbsp;<select name="Time_Minutes" class="whitefield" style="width:50px;"><cfloop from="0" to="59" index="minloopcount"><option value="#minloopcount#"<cfif minutes EQ minloopcount> selected</cfif>>#minloopcount#</option></cfloop></select> min.</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/update_button.gif" title="UPDATE NOW!" onclick="ValidateTrans(EditTran); return false;"> <a href="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentid=47"><img src="#request.imageroot#/cancel_button.gif" width="86" height="19" alt="CANCEL" border="0"></a></td>
			</tr>
			</cfform>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>
			
			

<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/business/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>
</cfoutput>