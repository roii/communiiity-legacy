<cfoutput>


<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;color:###TRIM(AllSettings.BoxColour)#;" colspan="3"><strong>Invite-a-Friend Winners</strong></td>
	</tr>
	
	<tr>
	<td colspan="3"><a href="##daily" style="color:###TRIM(AllSettings.BoxColour)#;">Daily Winners</a> | <a href="##weekly" style="color:###TRIM(AllSettings.BoxColour)#;">Weekly Winners</a> | <a href="##monthly" style="color:###TRIM(AllSettings.BoxColour)#;">Monthly Winners</a></strong></td>
	</tr>
	
	</table><br>
	
	<cfquery name="qry_invite_day" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM InviteFriendPrizes 
	WHERE type LIKE '%day%'
	AND status=1
	AND ShowWinner=1
	ORDER BY draw_date DESC
	</cfquery>
	
	<cfquery name="qry_invite_week" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM InviteFriendPrizes 
	WHERE type LIKE '%week%'
	AND status=1
	AND ShowWinner=1
	ORDER BY draw_date DESC
	</cfquery>
	
	<cfquery name="qry_invite_month" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM InviteFriendPrizes 
	WHERE type LIKE '%month%'
	AND status=1
	AND ShowWinner=1
	ORDER BY draw_date DESC
	</cfquery>
	
	<cfquery name="qry_invite_year" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM InviteFriendPrizes 
	WHERE type LIKE '%year%'
	AND status=1
	AND ShowWinner=1
	ORDER BY draw_date DESC
	</cfquery>
	
	<cfif qry_invite_day.RecordCount>
		<cfinclude template="dsp_invitefriend_won_day.cfm">
	</cfif>	
	
	<cfif qry_invite_week.RecordCount>
		<cfinclude template="dsp_invitefriend_won_week.cfm">
	</cfif>
	
	<cfif qry_invite_month.RecordCount>
		<cfinclude template="dsp_invitefriend_won_month.cfm">
	</cfif>
	
	<cfif qry_invite_year.RecordCount>
		<cfinclude template="dsp_invitefriend_won_year.cfm">
	</cfif>
	
</td>
</tr>

</table>



</cfoutput>