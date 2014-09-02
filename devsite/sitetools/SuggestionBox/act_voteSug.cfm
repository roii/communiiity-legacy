

<cfif isdefined("Form.subVote")>

	<cftransaction>
		<cfquery name="updVoteSug" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
			UPDATE Suggestion
			SET voteNumReceived = voteNumReceived + 1,
			totalVote = totalVote + #Form.rate#
			WHERE sugID = #Form.sugID#	
		</cfquery>
	</cftransaction>
	
	<script>
		alert("Thank you for your vote!");
		self.location="dsp_votingSug.cfm";
	</script>
</cfif>