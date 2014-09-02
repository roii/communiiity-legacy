<cfoutput>

<cfif attributes.DocumentID EQ 61>
	<cfset prizemode="PrizeDraw">
<cfelse>
	<cfset prizemode="Rewards">
</cfif>

	


<cfif prizemode EQ 'PrizeDraw'>

	<cfinclude template="dsp_prize_draws.cfm">

<cfelse>

	<cfinclude template="dsp_rewards.cfm">

</cfif>



</cfoutput>