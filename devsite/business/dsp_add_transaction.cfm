<cfoutput>

<cfinclude template="qry_current_biz.cfm">
<cfinclude template="qry_current_clients.cfm">


<!--- GET ALL TRANSACTIONS TO CREATE THE NEXT JOBNUMBER --->
<cfquery name="AllTransactions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT bizTransaction.transactionID
FROM bizTransaction, bizkidslink
WHERE bizkidslink.kidsid=#session.UserID#
AND bizkidslink.bizkidslinkid=bizTransaction.bizkidslinkid
</cfquery>

<cfif AllTransactions.Recordcount>
	<cfset nextJobNumber = (AllTransactions.Recordcount+1)>
<cfelse>
	<cfset nextJobNumber= 1>
</cfif>

<script>
function ValidateTrans(AddTran){ 
if (document.AddTran.clientid.selectedIndex == "0") {
	alert("You must select a client.");
	document.AddTran.clientid.focus();
	return;
	}
	
else {
	AddTran.submit(); //submit form
	}
	
}
</script>

<strong>Add a Job to your:</strong><br>
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
			
			<form name="AddTran" action="#request.webroot#/business/act_add_transaction.cfm" method="post">			
			<input type="hidden" name="bizkidslinkid" value="#attributes.bizkidslinkid#">			
						
			<cfif CurrentClients.recordcount>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Current Client:</td>
			<td>
				 	
				<table cellpadding="0" cellspacing="0" border="0">				
				
				<tr>
				<td style="padding-right:5px;"><select name="clientid" size="1" style="width:250px;" class="whitefield">
				<option value="0">Select a Client...</option>
				<cfloop query="CurrentClients">
					<option value="#currentclients.clientid#"> #TRIM(currentclients.firstname)# #TRIM(currentclients.lastname)#</option>
				</cfloop>
				</select></td>
				</tr>
				</cfif>
				
				</table>				
				
			</td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>OR</strong></td>
			<td></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">New Client:</td>
			<td valign="top">
				 	
				<table cellpadding="0" cellspacing="0" border="0">				
				
				<tr>		
				<td style="padding-right:5px;"><input type="text" name="FirstName" class="whitefield" style="width:90px;" value="Name..." onfocus="if(this.value=='Name...'){this.value=''};"></td>
				<td style="padding-right:5px;"><input type="text" name="MobilePhone" class="whitefield" style="width:90px;" value="Mobile..." onfocus="if(this.value=='Mobile...'){this.value=''};"></td>
				<td style="font-size:10px;"></td>
				</tr>
				
				<tr>		
				<td style="padding-right:5px;" colspan="3"><input type="text" name="EmailAddress" class="whitefield" style="width:250px;" value="Email..." onfocus="if(this.value=='Email...'){this.value=''};"></td>
				</tr>
				
				</table>				
				
			</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Transaction Date</td>
			<td><input type="text" name="tranDate" class="whitefield" readonly style="width:250px;">
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.AddTran.tranDate);return false;" HIDEFOCUS><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0"></a></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<input type="hidden" name="JobNumber" value="#NumberFormat(nextJobNumber, "00000")#">

			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Job Number <em>(readonly)</em></td>
			<td><input type="text" class="whitefield" style="width:250px;" value="#NumberFormat(nextJobNumber, "00000")#" readonly></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Job Description</td>
			<td><input type="text" required="Yes" name="description" class="whitefield" style="width:250px;"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Income<br>
			<em>(amount/details)</em></td>
			<td><input type="text" name="income1_amount" class="whitefield" style="width:46px;" value="$"> <input type="text" name="income1_details" class="whitefield" style="width:200px;">
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
			<td><input type="text" name="expense1_amount" class="whitefield" style="width:46px;" value="$"> <input type="text" name="expense1_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="expense2_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="expense2_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="expense3_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="expense3_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="expense4_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="expense4_details" class="whitefield" style="width:200px;">
			<input type="hidden" name="expense5_amount" class="whitefield" style="width:46px;" value="$"> <input type="hidden" name="expense5_details" class="whitefield" style="width:200px;"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Time invested</td>
			<td><select name="Time_Hour" class="whitefield" style="width:50px;"><cfloop from="0" to="500" index="loopcount"><option value="#loopcount#">#loopcount#</option></cfloop></select> hr &nbsp;&nbsp;<select name="Time_Minutes" class="whitefield" style="width:50px;"><cfloop from="0" to="59" index="minloopcount"><option value="#minloopcount#">#minloopcount#</option></cfloop></select> min.</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/add_button.gif" title="ADD NOW!" onlick="ValidateTrans(AddTran); return false;"> <a href="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentid=47"><img src="#request.imageroot#/cancel_button.gif" width="86" height="19" alt="CANCEL" border="0"></a></td>
			</tr>
			</form>
			
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