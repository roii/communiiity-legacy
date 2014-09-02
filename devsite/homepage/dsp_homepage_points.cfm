<cfoutput>

<script>
<!--
function PointsSwapView(d, n){ 

	var temp_0 = "PTS" + d;
	
	if (document.getElementById(temp_0).style.visibility == "hidden") { 
	document.getElementById(temp_0).style.visibility='visible'; 
	
		if (navigator.appName == 'Microsoft Internet Explorer') {
		document.getElementById(temp_0).style.position ='fixed';
		}
		
		else {
		document.getElementById(temp_0).style.position ='relative';
		}
		
		
		if (temp_0 == 'PTS1') {
		document.getElementById("PTS2").style.visibility='hidden';
		document.getElementById("PTS2").style.position='absolute';
		document.getElementById("PTS3").style.fontWeight='bold';
		document.getElementById("PTS4").style.fontWeight='normal';
		}
		
		else {
		document.getElementById("PTS1").style.visibility='hidden';
		document.getElementById("PTS1").style.position='absolute';
		document.getElementById("PTS3").style.fontWeight='normal';
		document.getElementById("PTS4").style.fontWeight='bold';
		}
		
	} 
	return 0;	
} 
// -->
</script>


<cfinclude template="qry_dash_points_earned.cfm">
<cfinclude template="qry_dash_points_saved.cfm">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;padding-left:5px;" height="20" colspan="3"><strong>Points - Top 3</strong></td>
</tr>

<tr>
<td height="1" colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
	<tr>
	<td style="color:Black; font-size:12px; padding-left:5px;">By: &nbsp;<a href="##" onClick="javascript:PointsSwapView('1', 0);" style="color:black;text-decoration:none;font-weight:bold;" id="PTS3">Earned</a> | <a href="##" onClick="javascript:PointsSwapView('2', 0);" style="color:black;text-decoration:none;font-weight:normal;" id="PTS4">Saved</a></td>
	</tr>
	
	</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
	

	<div id="PTS1" style="position:relative; border-style:none; Z-INDEX: PTS; visibility:visible;">
	
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
		
		<cfloop query="toppointsearned">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#toppointsearned.currentrow#. #TRIM(toppointsearned.FirstName)#</td>
		</tr>
		
		<cfif toppointsearned.currentrow NEQ 3>
		
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
	
	
	<div id="PTS2" style="position:absolute; border-style:none; Z-INDEX: PTS; visibility:hidden;">
	
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
		
		<cfloop query="toppointssaved">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#toppointssaved.currentrow#. #TRIM(toppointssaved.FirstName)#</td>
		</tr>
		
		<cfif toppointssaved.currentrow NEQ 3>
		
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