<cfoutput>

<script>
<!--
function SchoolSwapView(d, n){ 

	var temp_0 = "SCH" + d;
	
	if (document.getElementById(temp_0).style.visibility == "hidden") { 
	document.getElementById(temp_0).style.visibility='visible'; 
	
		if (navigator.appName == 'Microsoft Internet Explorer') {
		document.getElementById(temp_0).style.position ='fixed';
		}
		
		else {
		document.getElementById(temp_0).style.position ='relative';
		}
		
		
		if (temp_0 == 'SCH1') {
		document.getElementById("SCH2").style.visibility='hidden';
		document.getElementById("SCH2").style.position='absolute';
		document.getElementById("SCH3").style.fontWeight='bold';
		document.getElementById("SCH3").style.textDecoration='none';
		document.getElementById("SCH4").style.fontWeight='normal';
		document.getElementById("SCH4").style.textDecoration='underline';
		}
		
		else {
		document.getElementById("SCH1").style.visibility='hidden';
		document.getElementById("SCH1").style.position='absolute';
		document.getElementById("SCH3").style.fontWeight='normal';
		document.getElementById("SCH3").style.textDecoration='underline';
		document.getElementById("SCH4").style.fontWeight='bold';
		document.getElementById("SCH4").style.textDecoration='none';
		}
		
	} 
	return 0;	
} 
// -->
</script>

<cfinclude template="qry_dash_schools-percent-uptake.cfm">
<cfinclude template="qry_dash_schools-points-earned.cfm">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><a name="dashSch"><strong>Schools - Top 3</strong></a></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/schools_sml.jpg" alt="Schools" border="0"></td>
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
	<td style="color:Black; font-size:12px; padding-left:5px;">By: &nbsp;<a href="##dashSch" onClick="javascript:SchoolSwapView('1', 0);" style="color:black;text-decoration:none;font-weight:bold;" id="SCH3">Uptake</a> | <a href="##dashSch" onClick="javascript:SchoolSwapView('2', 0);" style="color:black;text-decoration:underline;font-weight:normal;" id="SCH4">Points</a></td>
	</tr>
	
	</table>
	

	<div id="SCH1" style="position:relative; border-style:none; Z-INDEX: SCH; visibility:visible;">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		<cfloop query="topschools" startrow="1" endrow="3">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#TRIM(topschools.SchoolName)# - #DecimalFormat(topschools.BM_studentreg)#%</td>
		</tr>
		
		<cfif topschools.currentrow NEQ 3>
		
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
	
	
	<div id="SCH2" style="position:absolute; border-style:none; Z-INDEX: SCH; visibility:hidden;">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		<cfloop query="topschoolearners">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#TRIM(topschoolearners.SchoolName)#</td>
		</tr>
		
		<cfif topschoolearners.currentrow NEQ 3>
		
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