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
		document.getElementById("PFT4").style.fontWeight='normal';
		}
		
		else {
		document.getElementById("PFT1").style.visibility='hidden';
		document.getElementById("PFT1").style.position='absolute';
		document.getElementById("PFT3").style.fontWeight='normal';
		document.getElementById("PFT4").style.fontWeight='bold';
		}
		
	} 
	return 0;	
} 
// -->
</script>

<cfinclude template="qry_dash_profits_user_most-profits-so-far.cfm">
<cfinclude template="qry_dash_profits_user_profits-hour.cfm">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;padding-left:5px;" height="20" colspan="3"><strong>Profits - Top 3</strong></td>
</tr>

<tr>
<td height="1" colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
	<tr>
	<td style="color:Black; font-size:12px; padding-left:5px;">By: &nbsp;<a href="##" onClick="javascript:ProfitSwapView('1', 0);" style="color:black;text-decoration:none;font-weight:bold;" id="PFT3">per hour</a> | <a href="##" onClick="javascript:ProfitSwapView('2', 0);" style="color:black;text-decoration:none;font-weight:normal;" id="PFT4">so far</a></td>
	</tr>
	
	</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
	

	<div id="PFT1" style="position:relative; border-style:none; Z-INDEX: PFT; visibility:visible;">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		<cfloop query="topprofituser">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;" title="#topprofituser.contactid#">#topprofituser.currentrow#. #TRIM(topprofituser.FirstName)#</td>
		</tr>
		
		<cfif topprofituser.currentrow NEQ 3>
		
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
		<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		<cfloop query="topmostprofituser">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#topmostprofituser.currentrow#. #TRIM(topmostprofituser.FirstName)#</td>
		</tr>
		
		<cfif topmostprofituser.currentrow NEQ 3>
		
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