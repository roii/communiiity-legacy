<cfoutput>

<cfquery name="TransDetails" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT *
FROM PurchasePoints
WHERE ContactID=#session.UserID#
ORDER BY StartDate DESC
</cfquery>


<html>

<head>
<style>
td {
font-size: 11px;
font-family: Arial, Verdana, Helvetica;
}
</style>
</head>

<body marginheight="10" marginwidth="10" leftmargin="10" topmargin="10" bgcolor="white" onload="window.print();">

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

</table><br>

<div align="center"><a href="javascript:window.print();" style="font-family:Arial;font-size:11px;">Print</a></div>

</body>
</html>
</cfoutput>