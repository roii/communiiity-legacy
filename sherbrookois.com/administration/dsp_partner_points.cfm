<cfoutput>

<script language="JavaScript">
	<!--
	function confirmPointsDelete(aURL) {
	    if(confirm('Are you sure you want to delete this points transaction?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>


<!--- GET ALL POINTS TRANSACTIONS --->
<cfquery name="AllPointsTransactions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SponsorPoints
WHERE SponsorID=#OrganisationID#
ORDER BY DatePurchased DESC
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:12px;" colspan="7"><a href="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=addpoints" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>ADD A POINTS TRANSACTION</strong></a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="7" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;"><strong>Date</strong></td>
<td style="font-size:11px;color:##444444;"><strong>Purchased</strong></td>
<td style="font-size:11px;color:##444444;"><strong>Remaining</strong></td>
<td style="font-size:11px;color:##444444;"><strong>Paid</strong></td>
<td style="font-size:11px;color:##444444;"><strong>Activities</strong></td>
<td style="font-size:11px;color:##444444;"><strong>Countries</strong></td>
<td></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="7"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<cfloop query="AllPointsTransactions">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" valign="top">#DateFormat(AllPointsTransactions.DatePurchased)#</td>
<td style="font-size:11px;color:##444444;" valign="top">#AllPointsTransactions.PointsPurchased#</td>
<td style="font-size:11px;color:##444444;" valign="top">#AllPointsTransactions.PointsRemaining#</td>
<td style="font-size:11px;color:##444444;" valign="top">#DollarFormat(AllPointsTransactions.PricePaid)# #TRIM(AllPointsTransactions.Currency)#</td>
<td style="font-size:11px;color:##444444;" valign="top"><cfloop list="#AllPointsTransactions.Activities#" delimiters="," index="loopitem"><cfquery name="ActivityStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">SELECT Name FROM Activity WHERE ActivityID=#loopitem#</cfquery>
<cfif ActivityStuff.RecordCount>#TRIM(ActivityStuff.name)#<br></cfif></cfloop></td>
<td style="font-size:11px;color:##444444;" valign="top">#AllPointsTransactions.Countries#</td>
<td width="40" align="right" valign="top"><a href="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=editpoints&SponsorPointsID=#AllPointsTransactions.SponsorPointsID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Points" border="0"></a>&nbsp;<a href="javascript:confirmPointsDelete('#request.webroot#/administration/act_delete_partner_points.cfm?OrganisationID=#OrganisationID#&SponsorPointsID=#AllPointsTransactions.SponsorPointsID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Points" border="0"></a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="7"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

</cfloop>


</table>

<div align="center"><input type="button" onclick="javascript:window.close();" value="CLOSE WINDOW >>" class="whitefield"></div><br>

</cfoutput>