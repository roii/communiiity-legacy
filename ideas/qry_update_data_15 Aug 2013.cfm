
<!--- GET ALL NON-ARCHIVED IDEAS THAT ARE NOT DRAFT IDEAS --->
<cfquery name="AllUnauthorised" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT SugID, ContactID
FROM suggestion
WHERE SugStage <> 'Draft'
AND archived=0
ORDER BY sugID
</cfquery>



<!--- LOOP IDEAS --->
<cfloop query="AllUnauthorised">

<cfset this_sugID = AllUnauthorised.SugID>
<cfset this_contactID = AllUnauthorised.ContactID>


<!--- GET ALL VOTES --->
<cfquery name="AllVotes" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM SugVote
WHERE sugID =#this_sugID#
</cfquery>


<!--- IF MORE 100 OR MORE VOTES - STAGE 3 TO STAGE 4 --->
<cfif AllVotes.RecordCount GTE 100>

	<!--- HOW MANY "YES" VOTES --->
	<cfquery name="AllYesVotes" dbtype="query">
	SELECT *
	FROM AllVotes
	WHERE Vote > 3
	</cfquery>
	
	<!--- IF MORE THAN 70 "YES" VOTES --->
	<cfif AllYesVotes.RecordCount GTE 70>	
	
		<!--- MARK AS STAGE 4 --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		UPDATE suggestion
		SET SugStage = 'Stage 4',
		Authorise='Yes'
		WHERE SugID = #this_sugID#
		</cfquery>
	
		<!--- ASSIGN POINTS FOR MAKING STAGE 1 --->		
		<cfset this_activity = 15>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 2 --->
		<cfset this_activity = 16>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 3 --->
		<cfset this_activity = 17>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 4 --->
		<cfset this_activity = 18>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
	<!--- ELSE IF LESS THAN 70 "YES" VOTES --->
	<cfelse>
		
		<!--- MARK AS STAGE 3 --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		UPDATE suggestion
		SET SugStage = 'Stage 3',
		Authorise='Yes'
		WHERE SugID = #this_sugID#
		</cfquery>
	
		<!--- ASSIGN POINTS FOR MAKING STAGE 1 --->		
		<cfset this_activity = 15>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 2 --->
		<cfset this_activity = 16>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 3 --->
		<cfset this_activity = 17>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
	
	
	</cfif>
		
		
<!--- IF MORE 50 OR MORE VOTES - STAGE 2 TO STAGE 3 --->
<cfelseif AllVotes.RecordCount GTE 50>

	<!--- HOW MANY "YES" VOTES --->
	<cfquery name="AllYesVotes" dbtype="query">
	SELECT *
	FROM AllVotes
	WHERE Vote > 3
	</cfquery>
	
	<!--- IF MORE THAN 70 "YES" VOTES --->
	<cfif AllYesVotes.RecordCount GTE 30>	
	
		<!--- MARK AS STAGE 3 --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		UPDATE suggestion
		SET SugStage = 'Stage 3',
		Authorise='Yes'
		WHERE SugID = #this_sugID#
		</cfquery>
	
		<!--- ASSIGN POINTS FOR MAKING STAGE 1 --->		
		<cfset this_activity = 15>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 2 --->
		<cfset this_activity = 16>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 3 --->
		<cfset this_activity = 17>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
	<!--- ELSE IF LESS THAN 30 "YES" VOTES --->
	<cfelse>
		
		<!--- MARK AS STAGE 2 --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		UPDATE suggestion
		SET SugStage = 'Stage 2',
		Authorise='Yes'
		WHERE SugID = #this_sugID#
		</cfquery>
	
		<!--- ASSIGN POINTS FOR MAKING STAGE 1 --->		
		<cfset this_activity = 15>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 2 --->
		<cfset this_activity = 16>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
	
	
	</cfif>



<!--- IF MORE 10 OR MORE VOTES - STAGE 1 TO STAGE 2 --->
<cfelseif AllVotes.RecordCount GTE 10>

	<!--- HOW MANY "YES" VOTES --->
	<cfquery name="AllYesVotes" dbtype="query">
	SELECT *
	FROM AllVotes
	WHERE Vote > 3
	</cfquery>
	
	<!--- IF MORE THAN 6 "YES" VOTES --->
	<cfif AllYesVotes.RecordCount GTE 6>	
	
		<!--- MARK AS STAGE 2 --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		UPDATE suggestion
		SET SugStage = 'Stage 2',
		Authorise='Yes'
		WHERE SugID = #this_sugID#
		</cfquery>
	
		<!--- ASSIGN POINTS FOR MAKING STAGE 1 --->		
		<cfset this_activity = 15>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		<!--- ASSIGN POINTS FOR MAKING STAGE 2 --->
		<cfset this_activity = 16>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		
	<!--- ELSE IF LESS THAN 6 "YES" VOTES --->
	<cfelse>
		
		<!--- MARK AS STAGE 1 --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		UPDATE suggestion
		SET SugStage = 'Stage 1',
		Authorise='Yes'
		WHERE SugID = #this_sugID#
		</cfquery>
	
		<!--- ASSIGN POINTS FOR MAKING STAGE 1 --->		
		<cfset this_activity = 15>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
	
	
	</cfif>



<!--- IF MORE 3 OR MORE VOTES - PENDING TO STAGE 1 --->
<cfelseif AllVotes.RecordCount GTE 3>

	<!--- HOW MANY "YES" VOTES --->
	<cfquery name="AllYesVotes" dbtype="query">
	SELECT *
	FROM AllVotes
	WHERE Vote > 3
	</cfquery>
	
	<!--- IF MORE THAN 2 "YES" VOTES --->
	<cfif AllYesVotes.RecordCount GTE 2>	
	
		<!--- MARK AS STAGE 2 --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		UPDATE suggestion
		SET SugStage = 'Stage 1',
		Authorise='Yes'
		WHERE SugID = #this_sugID#
		</cfquery>
	
		<!--- ASSIGN POINTS FOR MAKING STAGE 1 --->		
		<cfset this_activity = 15>
		<cfset this_contactID = this_contactID>
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		
	<!--- ELSE IF LESS THAN 2 "YES" VOTES --->
	<cfelse>
		
		<!--- MARK AS PENDING AND ARCHIVED --->
		<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		UPDATE suggestion
		SET SugStage = 'Pending',
		Authorise='No',
		archived=1		
		WHERE SugID = #this_sugID#
		</cfquery>
	
	
	</cfif>



<!--- IF LESS THAN 3 VOTES - PENDING --->
<cfelse>
		
	
	<!--- MARK AS PENDING --->
	<cfquery name="UpdateIdea" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	UPDATE suggestion
	SET SugStage = 'Pending',
	Authorise='No'
	WHERE SugID = #this_sugID#
	</cfquery>

		
		
</cfif>

</cfloop>

<script>
alert("Finsihed!");
self.location="http://www.my3p.com";
</script>
