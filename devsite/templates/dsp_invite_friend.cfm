<cfoutput>

<!--- GET TOP ROYALTY EARNERS --->
<cfquery name="qry_top_inviters" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="3">
SELECT SUM(Transaction_Amount) AS TotalRoyalties, ContactID
FROM contact_transactions
WHERE Related_Description LIKE '%Invitation Royalties%'
GROUP BY ContactID
ORDER BY TotalRoyalties DESC
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ###TRIM(AllSettings.BoxColour)#;">

<tr>
<td bgcolor="###TRIM(AllSettings.BoxColour)#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>INVITE-A-FRIEND</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td align="center"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"><br><img src="#request.imageroot#/invitefriend_top.gif" width="148" height="95" title="Earn up to 3000 points for each friend invited!" border="0"><br>

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<cfif session.UserIsAuthenticated EQ 'Yes'>
	<form method="post" action="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=53" name="invite_form">
	<cfelse>
	<form method="post" action="javascript:alert('Please register and login to invite your friends.');" name="invite_form">
	</cfif>
	
	<tr>
	<td align="center" colspan="2" style="height:5px;padding:2px;"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
	</tr>
	
	<tr>
	<td align="center" colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td align="center" style="font-size:11px;color:black;padding:4px;" valign="middle">Invite <select name="NumberToAdd" class="whitefield" onchange="javascript:invite_form.submit();"><option value="1"><cfloop from="1" to="10" index="loopcount"><option value="#loopcount#">#loopcount# friend<cfif loopcount GT 1>s</cfif></cfloop></select> now...</td>
	</tr>
	
	<tr>
	<td align="center" colspan="2" style="height:1px;border-top:solid 1px ###TRIM(AllSettings.BoxColour)#;padding:2px;"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>

	</form>
		
	<tr>
	<td align="center" colspan="2" style="font-size:11px;padding:2px;">
	
		<table cellpadding="0" cellspacing="0" border="0">
		
		<cfif qry_top_inviters.recordcount>
		
			<tr>
			<td colspan="2" style="font-size:11px;color:black;" align="center"><strong>Top 3 Royalty Earners</strong></td>
			</tr>
			
			<cfloop query="qry_top_inviters">			
			
			<cfquery name="WinnerDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT ContactID, FirstName, ScreenName 
			FROM Contacts 
			WHERE ContactID=#qry_top_inviters.ContactID#
			</cfquery>			
			<tr>
			<td width="15"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#WinnerDetails.ContactID#" title="View Profile"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle"></a></td>
			<td nowrap style="font-size:11px;padding-left:5px;"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#WinnerDetails.ContactID#" title="View Profile" style="color:###TRIM(AllSettings.BoxColour)#;">#TRIM(WinnerDetails.ScreenName)#</a></td>
			</tr>	
					
			</cfloop>
		
		</cfif>
		
		
		
		</table>
		
	</td>
	</tr>
	
	<tr>
	<td align="center" colspan="2" style="font-size:11px;padding:2px;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=Royalty_Points_Earned&showgraph=1">View Top 100 Royalty Earners</a><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</table>

</td>
</tr>

</table><br>


</cfoutput>