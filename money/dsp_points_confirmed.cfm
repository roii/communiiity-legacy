<cfoutput>

<cfquery name="TransDetails" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT *
FROM PurchasePoints
WHERE ContactID=#session.UserID#
ORDER BY StartDate DESC
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>PURCHASE POINTS - CONFIRMED</strong></td>
<td align="right" width="30"></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>


<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<tr>
<td colspan="2" style="color:##444444;">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="79"><img src="#request.imageroot#/confirm_icon.gif" width="79" height="99" alt="Confirmed!" border="0"></td>
	<td style="color:##444444;padding-left:8px;"><strong>You have confirmed your <span style="color:###TRIM(AllSettings.BoxColour)#;">#TransDetails.PointsAmount# point</span> purchase. This transaction will be removed from our system after 5 days if payment is not received.</strong><br><br>

Please use the details below to complete the payment transaction online or at any branch of the ASB bank...</td>
	</tr>
	
	</table>
	
	
	<div align="right"><a href="##" onclick="fdbackwindow=window.open('#request.webroot#/money/dsp_bank_deposit.cfm?Identifier=#TransDetails.Identifier#','DepositWindow','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=600,height=280,top=10,left=10')">Print Format</a><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></div>

	<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ##b4b4b4;">
	
	<tr>
	<td bgcolor="##e2e2e2">
	
		<table cellpadding="2" cellspacing="2" border="0">
	
		<tr>
		<td style="width:100px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
		<td></td>
		</tr>
		
		<tr>
		<td align="right" style="padding-right:5px;color:##444444;">Bank:</td>
		<td bgcolor="white" width="14" align="center">A</td>
		<td bgcolor="white" width="14" align="center">S</td>
		<td bgcolor="white" width="14" align="center">B</td>
		<td bgcolor="white" width="8" align="center">&nbsp;</td>
		<td bgcolor="white" width="14" align="center">B</td>
		<td bgcolor="white" width="14" align="center">A</td>
		<td bgcolor="white" width="14" align="center">N</td>
		<td bgcolor="white" width="14" align="center">K</td>
		</tr>
		
		<tr>
		<td style="width:100px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
		<td></td>
		</tr>
		
		</table>
		
		
	</td>
	</tr>
	
	<tr>
	<td bgcolor="##e2e2e2">
	
		<table cellpadding="2" cellspacing="2" border="0">
		
		<tr>
		<td align="right" style="padding-right:5px;color:##444444;">Acc. Num:</td>
		<td bgcolor="white" width="14" align="center">1</td>
		<td bgcolor="white" width="14" align="center">2</td>
		<td bgcolor="white" width="8" align="center">-</td>
		<td bgcolor="white" width="14" align="center">3</td>
		<td bgcolor="white" width="14" align="center">0</td>
		<td bgcolor="white" width="14" align="center">8</td>
		<td bgcolor="white" width="14" align="center">4</td>
		<td bgcolor="white" width="8" align="center">-</td>
		<td bgcolor="white" width="14" align="center">0</td>
		<td bgcolor="white" width="14" align="center">2</td>
		<td bgcolor="white" width="14" align="center">2</td>
		<td bgcolor="white" width="14" align="center">1</td>
		<td bgcolor="white" width="14" align="center">9</td>
		<td bgcolor="white" width="14" align="center">0</td>
		<td bgcolor="white" width="14" align="center">3</td>
		<td bgcolor="white" width="14" align="center">0</td>
		<td bgcolor="white" width="14" align="center">0</td>
		<td bgcolor="white" width="8" align="center">-</td>
		<td bgcolor="white" width="14" align="center">5</td>
		<td bgcolor="white" width="14" align="center">0</td>
		</tr>
		
		<tr>
		<td style="width:100px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
		<td></td>
		<td></td>
		<td></td>
		</tr>
		
		</table>
		
		
	</td>
	</tr>
	
	<tr>
	<td bgcolor="##e2e2e2">
	
		<table cellpadding="2" cellspacing="2" border="0">
		
		<tr>
		<td align="right" style="padding-right:5px;color:##444444;">Acc. Name:</td>
		<td bgcolor="white" width="14" align="center">3</td>
		<td bgcolor="white" width="14" align="center">P</td>
		<td bgcolor="white" width="8" align="center">&nbsp;</td>
		<td bgcolor="white" width="14" align="center">V</td>
		<td bgcolor="white" width="14" align="center">E</td>
		<td bgcolor="white" width="14" align="center">N</td>
		<td bgcolor="white" width="14" align="center">T</td>
		<td bgcolor="white" width="14" align="center">U</td>
		<td bgcolor="white" width="14" align="center">R</td>
		<td bgcolor="white" width="14" align="center">E</td>
		<td bgcolor="white" width="14" align="center">S</td>
		<td bgcolor="white" width="8" align="center">&nbsp;</td>
		<td bgcolor="white" width="14" align="center">L</td>
		<td bgcolor="white" width="14" align="center">I</td>
		<td bgcolor="white" width="14" align="center">M</td>
		<td bgcolor="white" width="14" align="center">I</td>
		<td bgcolor="white" width="14" align="center">T</td>
		<td bgcolor="white" width="14" align="center">E</td>
		<td bgcolor="white" width="14" align="center">D</td>
		</tr>
		
		<tr>
		<td style="width:100px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
		<td></td>
		</tr>
		
		</table>
		
		
	</td>
	</tr>
	
	<tr>
	<td bgcolor="##e2e2e2">
	
		<table cellpadding="2" cellspacing="2" border="0">
		
		<tr>
		<td align="right" style="padding-right:5px;color:##444444;">Particulars:</td>
		<td bgcolor="white" width="14" align="center">M</td>
		<td bgcolor="white" width="14" align="center">Y</td>
		<td bgcolor="white" width="14" align="center">3</td>
		<td bgcolor="white" width="14" align="center">P</td>
		<td bgcolor="white" width="8" align="center">.</td>
		<td bgcolor="white" width="14" align="center">C</td>
		<td bgcolor="white" width="14" align="center">O</td>
		<td bgcolor="white" width="14" align="center">M</td>
		</tr>
		
		<tr>
		<td style="width:100px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
		<td></td>
		</tr>
		
		</table>
		
		
	</td>
	</tr>
	
	<tr>
	<td bgcolor="##e2e2e2">
	
		<table cellpadding="2" cellspacing="2" border="0">
		
		<tr>
		<td align="right" style="padding-right:5px;color:##444444;">Code:</td>
		<td bgcolor="white" width="14" align="center">P</td>
		<td bgcolor="white" width="14" align="center">O</td>
		<td bgcolor="white" width="14" align="center">I</td>
		<td bgcolor="white" width="14" align="center">N</td>
		<td bgcolor="white" width="14" align="center">T</td>
		<td bgcolor="white" width="14" align="center">S</td>
		</tr>
		
		<tr>
		<td style="width:100px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
		<td></td>
		</tr>
		
		</table>
		
		
	</td>
	</tr>
	
	<tr>
	<td bgcolor="##e2e2e2">
	
		<table cellpadding="2" cellspacing="2" border="0">
		
		<tr>
		<td align="right" style="padding-right:5px;color:##444444;">Reference:</td>
		<cfloop from="1" to="#LEN(TRIM(TransDetails.Identifier))#" index="loopitem">
		<td bgcolor="white" width="14" align="center">#UCASE(MID(TransDetails.Identifier, loopitem, 1))#</td>
		</cfloop>
		
		</tr>
		
		<tr>
		<td style="width:100px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
		<td></td>
		</tr>
		
		</table>
		
		
	</td>
	</tr>
	
	<tr>
	<td bgcolor="##e2e2e2">
		
		<cfset loopstring = NumberFormat(TransDetails.DollarValue, "0.00")>
		
		<table cellpadding="2" cellspacing="2" border="0">
		
		<tr>
		<td align="right" style="padding-right:5px;color:##444444;">Amount:</td>
		<td bgcolor="white" width="14" align="center">$</td>
		<cfloop from="1" to="#len(loopstring)#" index="loopitem">
		
		<cfif MID(loopstring, loopitem, 1) EQ '.'>
			<td bgcolor="white" width="8" align="center">#MID(loopstring, loopitem, 1)#</td>
		<cfelse>
			<td bgcolor="white" width="14" align="center">#MID(loopstring, loopitem, 1)#</td>
		</cfif>
		
		</cfloop>
		</tr>
		
		<tr>
		<td style="width:100px;"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
		<td></td>
		</tr>
		
		</table>		
		
	</td>
	</tr>

	</table><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"><br>
		
	Transactions typically take between 24-72 hours to process before the points will be available in your my3P account depending on which day of the week and what time of day the deposit is made.</td>
</tr>


</table>
</cfoutput>