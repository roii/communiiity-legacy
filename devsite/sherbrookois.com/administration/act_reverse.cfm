<cfoutput>


<cfif NOT IsDefined("type")>

	<script>
	alert("A problem occurred.");
	history.back();
	</script>
	<cfabort>
	
	
</cfif>


<!--- REVERSE A MEMBERSHIP --->
<cfif type EQ 'member'>


	<!--- GET MEMBER DETAILS --->
	<cfquery name="memberstuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM Contacts
	WHERE contactID=#contactID#
	</cfquery>
	
	
	<!--- CHECK FOR INVITATION --->
	<cfquery name="CheckInvitation" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName, Contacts.EmailAddress
	FROM Invitations, Contacts
	WHERE Invitations.InvitationTo=#contactID#
	AND Invitations.InvitationFrom=Contacts.ContactID
	</cfquery>
	
	<cfif CheckInvitation.recordcount>
		
		<cfloop query="CheckInvitation">
		
		<!--- delete invite points --->
		<cfquery name="removeInvitePoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM contact_transactions
		WHERE ContactID=#CheckInvitation.ContactID#
		AND Related_Description LIKE '%SuccessfulInvitation%'
		AND Related_Identifier=#ContactID#
		</cfquery>
		
		<!--- delete invite --->
		<cfquery name="DeleteInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE 
		FROM Invitations
		WHERE Invitations.InvitationTo=#contactID#		
		</cfquery>
		
		</cfloop>
		
	</cfif>
		
	<!--- DELETE MEMBER --->
	<cfquery name="DeleteContact" datasource="#DSN#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Contacts
	WHERE ContactID=#ContactID#
	</cfquery>
		
	<!--- DELETE MEMBER TRANSACTIONS --->
	<cfquery name="DeleteTransactions" datasource="#DSN#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Contact_Transactions
	WHERE ContactID=#ContactID#
	</cfquery>
		
	<!--- DELETE MEMBER IDEAS --->
	<cfquery name="DeleteSuggestions" datasource="#DSN#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Suggestion
	WHERE ContactID=#ContactID#
	</cfquery>
	
	<!--- DELETE MEMBER VOTES --->
	<cfquery name="DeleteVotes" datasource="#DSN#" username="#request.username#" password="#request.password#">
	DELETE
	FROM SugVote
	WHERE ContactID=#ContactID#
	</cfquery>
	
	<!--- DELETE REWARD TRANSACTIONS --->
	<cfquery name="DeleteRewards" datasource="#DSN#" username="#request.username#" password="#request.password#">
	DELETE
	FROM RewardTransactions
	WHERE ContactID=#ContactID#
	</cfquery>
	
	<!--- DELETE PRIZE ENTRY --->
	<cfquery name="DeletePrize" datasource="#DSN#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Prize_Entry
	WHERE ContactID=#ContactID#
	</cfquery>
	
	
	<!--- NOTIFY REFERRER ABOUT REVERSAL --->
	<cfif CheckInvitation.recordcount>
	
		<cfinclude template="dsp_reverse_reason.cfm">
	
	<cfelse>
	
		 <script language="JavaScript">
		<!--
		function showParentAndClose(givenURL) {
		    window.opener.document.location = givenURL;
			alert("You have reversed the membership.");
			self.close();
		}
		
		// -->
		</script>
		
			<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_members')"></body>
	
	</cfif>
	
	<cfabort>
	
	
	

<!--- REVERSE AN IDEA --->
<cfelseif type EQ 'idea'>






<!--- REVERSE REWARD TRANSACTION --->
<cfelseif type EQ 'reward'>



</cfif>


</cfoutput>