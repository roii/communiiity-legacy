<!--- 

DJP - 29Oct11 -	Added centPerPoint variable on line 49
				Added variable as modifier on line 52
 --->

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(DocumentDetails.Title))#</strong></td>
<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=550,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit" border="0"></a>&nbsp;<a href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete" border="0"></a></cfif></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>




<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0">

	<br>
	<table width="100%" cellpadding="2" cellspacing="0" style="border:solid 2px ##b4b4b4;">
	
	<tr>
	<td bgcolor="##e2e2e2">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td valign="top" width="42"><img src="#request.imageroot#/points_purchase_icon.gif" width="42" height="42" border="0"></td>
		<td valign="top" style="color:##444444;"><img src="#request.imageroot#/points_purchase_title.gif" width="120" height="26" alt="Purchase Points" border="0"><br><strong>Select the number of points you want to purchase and your preferred payment method...<br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" alt="" border="0"><br></strong>
	
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<form name="PurchaseForm" action="#request.webroot#/money/act_purchase_points.cfm" method="post" onsubmit="validatePurchase(PurchaseForm); return false;">
			<input type="hidden" name="action" value="bank">
			
			<tr>
			<td style="color:##444444;">
	
				<table cellpadding="0" cellspacing="0" border="0">
								
				<tr>		
				<td style="padding-right:3px;"><select class="whitefield" style="width:150px;" name="PointsAmount">
				<cfset centPerPoint = 3> <!--- Variable to charge cost per point for purchasing points ---> <!--- Added 29Oct11 DJP --->
				<option value="100">100 pts - ($3.00)</option> <!--- Added 29Oct11 DJP --->
				<option value="300">300 pts - ($9.00)</option> <!--- Added 29Oct11 DJP --->
				<cfloop from="500" to="100000" step="500" index="loopcount">
				<cfset dollarvalue = (loopcount/100*centPerPoint)> <!--- Modified 29Oct11 DJP --->
				<option value="#loopcount#">#numberformat(loopcount,"999,999")# pts - (#dollarformat(dollarvalue)#)</option>
				</cfloop>
				</select></td>
				<td style="padding-right:3px;"><input type="image" src="#request.imageroot#/but_pointspurchase_paypal.gif" border="0" onclick="javascript: document.PurchaseForm.action.value='paypal';"></td>
				<!--- <td style="padding-right:3px;"><input type="image" src="#request.imageroot#/but_pointspurchase_bank.gif" border="0" onclick="javascript: document.PurchaseForm.action.value='bank';"></td> --->
				</tr>
				
				</table>
					
					
			</td>
			</tr>		
			</form>
			
			</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" alt="" border="0"><br>
			
	
		</td>
		</tr>
			
		</table>
			
			
	</td>
	</tr>
	
	</table><br>
	
	
	
</td>
</tr>

<cfif TRIM(newdetails) NEQ '' AND TRIM(newdetails) NEQ '<P>&nbsp;</P>'>
	<tr>
	<td colspan="2">#newdetails#</td>
	</tr>
</cfif>


</table>

</cfoutput>