<cfoutput>

<script>
function validatePoints(AddPoints) {
 


if (AddPoints.PointsPurchased.value == "") {
	alert("You must enter the number of points.");
	AddPoints.PointsPurchased.focus();
	return;
	} 
	
	
else {
	AddPoints.submit(); //submit form
	}
	
}
</script>
			
			
<cfquery name="AllActivities" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ActivityID, Name, Points
FROM Activity
ORDER BY ActivityID
</cfquery>	
			
			
			
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<form name="AddPoints" action="#request.webroot#/administration/act_add_partner_points.cfm" method="post">

<input type="hidden" name="OrganisationID" value="#OrganisationID#">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Number of Points</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="PointsPurchased" class="whitefield" style="width:100px;"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Price Paid</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="PricePaid" class="whitefield" style="width:100px;"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Currency</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="Currency" class="whitefield" style="width:100px;"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Activites</strong></td>
<td style="font-size:11px;color:##444444;">
	
<cfloop query="AllActivities">
<input type="checkbox" value="#AllActivities.ActivityID#" name="Activities" class="whitefield"> #TRIM(AllActivities.Name)# - [#INT(AllActivities.Points)#]<br>

</cfloop>


</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td> </td>
<td style="font-size:11px;color:##444444;"><input type="submit" onclick="javascript:validatePoints(AddPoints); return false;" value="ADD NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:history.back(-1);" value="CANCEL >>" class="whitefield"></td>
</tr>

</form>

</table><br><br>


</cfoutput>