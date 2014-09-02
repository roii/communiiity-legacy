<cfoutput>

<script>
<!--
function ProfitSwapView(d, n){ 

	var temp_0 = "PFT" + d;
	
	if (document.getElementById(temp_0).style.visibility == "hidden") { 
	document.getElementById(temp_0).style.visibility='visible'; 
	
		if (navigator.appName == 'Microsoft Internet Explorer') {
		document.getElementById(temp_0).style.position ='fixed';
		}
		
		else {
		document.getElementById(temp_0).style.position ='relative';
		}
		
		
		if (temp_0 == 'PFT1') {
		document.getElementById("PFT2").style.visibility='hidden';
		document.getElementById("PFT2").style.position='absolute';
		document.getElementById("PFT3").style.fontWeight='bold';
		document.getElementById("PFT3").style.textDecoration='none';
		document.getElementById("PFT4").style.fontWeight='normal';
		document.getElementById("PFT4").style.textDecoration='underline';
		}
		
		else {
		document.getElementById("PFT1").style.visibility='hidden';
		document.getElementById("PFT1").style.position='absolute';
		document.getElementById("PFT3").style.fontWeight='normal';
		document.getElementById("PFT3").style.textDecoration='underline';
		document.getElementById("PFT4").style.fontWeight='bold';
		document.getElementById("PFT4").style.textDecoration='none';
		}
		
	} 
	return 0;	
} 
// -->
</script>

<cfinclude template="qry_dash_most_profits.cfm">
<cfinclude template="qry_dash_profits_hour.cfm">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><a name="dashPrft"><strong>Profits - Top 3</strong></a></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/Profits_sml.jpg" alt="Cash Account" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
	<tr bgcolor="e2e2e2" height="22">
	<td style="color:Black; font-size:12px; padding-left:5px;">By: &nbsp;<a href="##dashPrft" onClick="javascript:ProfitSwapView('1', 0);" style="color:black;text-decoration:none;font-weight:bold;" id="PFT3">Per hour</a> | <a href="##dashPrft" onClick="javascript:ProfitSwapView('2', 0);" style="color:black;text-decoration:underline;font-weight:normal;" id="PFT4">So far</a></td>
	</tr>
	
	</table>

	<div id="PFT1" style="position:relative; border-style:none; Z-INDEX: PFT; visibility:visible;">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		<cfloop query="qry_dash_profits_hour">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#qry_dash_profits_hour.currentrow#. <cfif TRIM(qry_dash_profits_hour.ScreenName) NEQ ''>#TRIM(qry_dash_profits_hour.ScreenName)#<cfelse>#TRIM(qry_dash_profits_hour.FirstName)#</cfif></td>
		</tr>
		
		<cfif qry_dash_profits_hour.currentrow NEQ 3>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<cfelse>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		</cfif>
		
		</cfloop>
		
		
		</table>

	</div>
	
	
	<div id="PFT2" style="position:absolute; border-style:none; Z-INDEX: PFT; visibility:hidden;">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		<cfloop query="qry_dash_most_profits">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#qry_dash_most_profits.currentrow#. <cfif TRIM(qry_dash_most_profits.ScreenName) NEQ ''>#TRIM(qry_dash_most_profits.ScreenName)#<cfelse>#TRIM(qry_dash_most_profits.FirstName)#</cfif></td>
		</tr>
		
		<cfif qry_dash_most_profits.currentrow NEQ 3>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<cfelse>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		</cfif>
		
		</cfloop>
		
		
		</table>

	</div>
	
</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>
	
	



</cfoutput>