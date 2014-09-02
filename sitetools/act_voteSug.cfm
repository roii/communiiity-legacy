<cfif isdefined("Form.subVote")>

	<cftransaction>
		
		<!--- loop thru the number of suggestion available for voting --->
		<cfloop index="index" from="1" to="#Form.NumOfSuggestion#" step="1">
			
			<cfif isdefined('form.rate' & index)>
				<cfif evaluate('form.rate' & index) NEQ 0>
					<cfquery name="updVoteSug" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
						INSERT INTO SugVote(sugID,ContactID,vote)
						VALUES(#evaluate("form.sugID" & index)#,#Session.UserID#,#evaluate("form.rate" & index)#)	
					</cfquery>
					<cfset activityid = 1>
					<cfset showconfirm = "false">
					<cfinclude template="../administration/act_add_entry.cfm">
					
					
					<!--- get the suggestion status --->
					<cfquery name="SuggestionStatus" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
					SELECT Authorise
					FROM Suggestion
					WHERE sugID=#evaluate("form.sugID" & index)#
					</cfquery>
					
					<!--- check if this is an un-authorised suggestion --->
					<cfif SuggestionStatus.Authorise EQ 'No'>
					
						<!--- get the total votes for this suggestion --->
						<cfquery name="TotalVotes" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
						SELECT vote
						FROM SugVote
						WHERE sugID=#evaluate("form.sugID" & index)#
						</cfquery>
						
						<!--- check if this is the third vote for it --->
						<cfif TotalVotes.recordcount EQ 3>
						
							<!--- If it is, get the vote average --->
							<cfset voteaverage = 0>
							
							<cfloop query="TotalVotes">
								<cfset voteaverage = voteaverage+TotalVotes.vote>
							</cfloop>
						
							<cfset voteaverage = (voteaverage/3)>
							
							
							<!--- if the vote average is YES then approve it --->
							<cfif voteaverage GTE 3>
								
								<cfquery name="updateSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
								UPDATE Suggestion
								SET Authorise='Yes'
								WHERE sugID=#evaluate("form.sugID" & index)#
								</cfquery>	
							
							<!--- if the vote average is NO dump it --->
							<cfelse>
							
								<cfquery name="updateSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
								UPDATE Suggestion
								SET archived=1
								WHERE sugID=#evaluate("form.sugID" & index)#
								</cfquery>	
							
							</cfif>
							
						
						</cfif>
					
					
					
					</cfif>
					
					
				</cfif>
			</cfif>			
		
		</cfloop>
	</cftransaction>
	
	<cfoutput>
	
	
	<cftry>
	
		<cfquery name="PathStuff" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
		SELECT Path
		FROM Suggestion
		WHERE sugID=#evaluate("form.sugID" & index)#
		</cfquery>
		
		
		<script>
		alert('Many thanks for your vote!');
		self.location="http://www.mykidsbiz.com/index.cfm?#PathStuff.Path#";
		</script>
		
	
	<cfcatch>
		
		<script>
		alert('Many thanks for your vote!');
		self.location="http://www.mykidsbiz.com/index.cfm?fuseaction=sitetools&fusesubaction=docs&documentID=31";
		</script>
	
	</cfcatch>
	</cftry>
	
	</cfoutput>

</cfif>
