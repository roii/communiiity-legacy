<cfoutput>

<cfinclude template="qry_current_biz.cfm">
<cfinclude template="qry_current_clients.cfm">

Edit a biz transaction for:<br>
<strong style="color:###TRIM(AllSettings.BoxColour)#;font-size:12px;">#CurrentBizDetail.bizName# Business</strong><br><br>


<table cellSpacing="1" cellPadding="0" bgColor="###TRIM(AllSettings.DkBoxColour)#" border="0" width="100%">

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
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Transaction Type</td>
			<td><input type="radio" name="TranType" value="Income"<cfif TranDetail.income> checked</cfif>> Income &nbsp; <input type="radio" name="TranType" value="Expense"<cfif TranDetail.income CONTAINS 0> checked</cfif>> Expense</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="###TRIM(AllSettings.DkBoxColour)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Client</td>
			<td><select name="clientid" size="1" style="width:250px;" class="whitefield">
			<option value="">Select a Client...</option>
			<cfif CurrentClients.recordcount>
			<cfloop query="CurrentClients">
				<option value="#currentclients.clientid#"<cfif TranDetail.ClientID EQ currentclients.clientid> selected</cfif>> #TRIM(currentclients.firstname)# #TRIM(currentclients.lastname)#</option>
			</cfloop>
			</cfif></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="###TRIM(AllSettings.DkBoxColour)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Casual Customer <br>(Only if not found in the list)</td>
			<td><input type="text" name="clientName" class="whitefield" style="width:250px;" value="#TRIM(TranDetail.ClientName)#"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="###TRIM(AllSettings.DkBoxColour)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Description</td>
			<td><cfinput type="text" required="Yes" message="Please enter transaction description" name="description" class="whitefield" style="width:250px;" value="#TRIM(TranDetail.description)#"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="###TRIM(AllSettings.DkBoxColour)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Transaction Date</td>
			<td><cfinput type="text" name="tranDate" class="whitefield" required="yes" validate="eurodate" message="You didn't enter the correct date format" style="width:250px;" value="#DateFormat(TranDetail.TranDate, "dd/mm/yyyy")#">
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.EditTran.tranDate);return false;" HIDEFOCUS><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0"></a></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Amount $</td>
			<td><input type="text" name="amount" class="whitefield" style="width:250px;" value="#DecimalFormat(TranDetail.amount)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Time invested(<b>in minutes</b>)</td>
			<td><input type="text" name="hours" class="whitefield" style="width:250px;" value="#TranDetail.hours#"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="###TRIM(AllSettings.DkBoxColour)#"></td>
			</tr>
			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/update_button.gif" title="UPDATE NOW!"></td>
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