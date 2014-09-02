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
		document.getElementById("PTS3").style.textDecoration='none';
		document.getElementById("PTS4").style.fontWeight='normal';
		document.getElementById("PTS4").style.textDecoration='underline';
		}
		
		else {
		document.getElementById("PTS1").style.visibility='hidden';
		document.getElementById("PTS1").style.position='absolute';
		document.getElementById("PTS3").style.fontWeight='normal';
		document.getElementById("PTS3").style.textDecoration='underline';
		document.getElementById("PTS4").style.fontWeight='bold';
		document.getElementById("PTS4").style.textDecoration='none';
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
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><a name="DashPnts"><strong>Points - Top 3</strong></a></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/points_sml.jpg" alt="Points" border="0"></td>
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
	<td style="color:Black; font-size:12px; padding-left:5px;">By: &nbsp;<a href="##DashPnts" onClick="javascript:PointsSwapView('1', 0);" style="color:black;text-decoration:none;font-weight:bold;" id="PTS3">Earned</a> | <a href="##DashPnts" onClick="javascript:PointsSwapView('2', 0);" style="color:black;text-decoration:underline;font-weight:normal;" id="PTS4">Saved</a></td>
	</tr>
	
	</table>
	

	<div id="PTS1" style="position:relative; border-style:none; Z-INDEX: PTS; visibility:visible;">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		<cfloop query="qry_dash_points_earned">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#qry_dash_points_earned.currentrow#. <cfif TRIM(qry_dash_points_earned.ScreenName) NEQ ''>#TRIM(qry_dash_points_earned.ScreenName)#<cfelse>#TRIM(qry_dash_points_earned.FirstName)#</cfif></td>
		</tr>
		
		<cfif qry_dash_points_earned.currentrow NEQ 3>
		
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
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		<cfloop query="qry_dash_points_saved">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;">#qry_dash_points_saved.currentrow#. <cfif TRIM(qry_dash_points_saved.ScreenName) NEQ ''>#TRIM(qry_dash_points_saved.ScreenName)#<cfelse>#TRIM(qry_dash_points_saved.FirstName)#</cfif></td>
		</tr>
		
		<cfif qry_dash_points_saved.currentrow NEQ 3>
		
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