<cfoutput>

<script>
<!--
function BizSwapView(d, n){ 

	var temp_0 = "TBL" + d;
	
	if (document.getElementById(temp_0).style.visibility == "hidden") { 
	document.getElementById(temp_0).style.visibility='visible'; 
	
		if (navigator.appName == 'Microsoft Internet Explorer') {
		document.getElementById(temp_0).style.position ='fixed';
		}
		
		else {
		document.getElementById(temp_0).style.position ='relative';
		}
		
		
		if (temp_0 == 'TBL1') {
		document.getElementById("TBL2").style.visibility='hidden';
		document.getElementById("TBL2").style.position='absolute';
		document.getElementById("BY1").style.fontWeight='bold';
		document.getElementById("BY1").style.textDecoration='none';
		document.getElementById("BY2").style.fontWeight='normal';
		document.getElementById("BY2").style.textDecoration='underline';
		}
		
		else {
		document.getElementById("TBL1").style.visibility='hidden';
		document.getElementById("TBL1").style.position='absolute';
		document.getElementById("BY1").style.fontWeight='normal';
		document.getElementById("BY1").style.textDecoration='underline';
		document.getElementById("BY2").style.fontWeight='bold';
		document.getElementById("BY2").style.textDecoration='none';
		}
		
	} 
	return 0;	
} 
// -->
</script>



<cfinclude template="qry_dash_businesses_popularity.cfm">
<cfinclude template="qry_dash_businesses_profits-hour.cfm">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><a name="dashBiz"><strong>Businesses - Top 3</strong></a></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/Businesses_sml.jpg" alt="Businesses" border="0"></td>
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
	<td style="color:Black; font-size:12px; padding-left:5px;">By: &nbsp;<a href="##dashBiz" onClick="javascript:BizSwapView('1', 0);" style="color:black;text-decoration:none;font-weight:bold;" id="BY1">Profit per hour</a> | <a href="##dashBiz" onClick="javascript:BizSwapView('2', 0);" style="color:black;text-decoration:none;font-weight:normal;text-decoration:underline;" id="BY2">Popularity</a></td>
	</tr>
	
	</table>
	

	<div id="TBL1" style="position:relative; border-style:none; Z-INDEX: TBL; visibility:visible;">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
		</tr>
		<cfloop query="topprofitbiz">
		
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;" width="200">#TRIM(topprofitbiz.biz_idea)#</td>
		<td style="color:Black;font-size:12px;padding-right:5px;" width="100%">#dollarFormat(topprofitbiz.avg_hr)# avg. per hour</td>
		</tr>
		
		<cfif topprofitbiz.currentrow NEQ 3>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<cfelse>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		</cfif>
		
		</cfloop>
		
		
		</table>

	</div>
	
	
	<div id="TBL2" style="position:absolute; border-style:none; Z-INDEX: TBL; visibility:hidden;">
	
		<table cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
		</tr>
		
		<cfloop query="toppopularbiz">
		<tr>
		<td style="color:Black;font-size:12px;padding-left:5px;" width="200">#TRIM(toppopularbiz.biz_idea)#</td>
		<td style="color:Black;font-size:12px;padding-right:5px;" width="100%"></td>
		</tr>
		
		<cfif toppopularbiz.currentrow NEQ 3>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<cfelse>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
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