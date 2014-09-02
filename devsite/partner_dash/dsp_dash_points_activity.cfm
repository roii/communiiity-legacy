<cfoutput>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Points usage by activity</strong></td>
	<td align="right" valign="bottom"><!--- <img src="#request.imageroot#/SiteIcons/Community_sml.jpg" alt="Community" border="0"> ---></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>

</cfoutput>

	
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	
	<cfoutput query="qry_all_sponsored_points" group="Related_Description">
	<cfset this_description = TRIM(qry_all_sponsored_points.Related_Description)>
	
	<cfif this_description NEQ ''>
		
		
		
		<cfquery name="qry_activity_points" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SUM(Transaction_Amount) AS TotalActivityPoints
		FROM contact_transactions
		WHERE Transaction_SponsorID=#this_organisationID#
		AND Transaction_Account LIKE '%Points%'
		AND Transaction_Type LIKE '%Credit%'
		AND Related_Description LIKE '#TRIM(this_description)#'
		</cfquery>
		
		<cfquery name="DescriptionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Dash_Description
		FROM Activity
		WHERE Related_Description LIKE '%#this_description#%'
		</cfquery>
	
		<tr>
		<td style="color:Black;font-size:11px;padding-left:5px;"><cfif DescriptionStuff.RecordCount>#TRIM(DescriptionStuff.Dash_Description)#<cfelseif TRIM(this_description) CONTAINS 'RegisterPromoCode'>Registered with Promo-code<cfelse>#TRIM(this_description)#</cfif></td>
		<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#qry_activity_points.TotalActivityPoints#</td>
		</tr>
		
		
		<cfif qry_all_sponsored_points.CurrentRow NEQ qry_all_sponsored_points.RecordCount>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		</cfif>
		
	
	</cfif>
	
	</cfoutput>
	
	</table>
	
	


<cfoutput>

</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>