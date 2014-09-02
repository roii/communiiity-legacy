<cfif form.VerifyInvite EQ 1>

	<!--- UPDATE INVITATION STATUS --->
	<cfquery name="UpdateParentInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE ParentInvites
	SET Status='Verified',
	DateActivated=#CreateODBCDateTime(localdatetime)#
	WHERE ParentInviteID=#form.ParentInviteID#
	</cfquery>
	
	
	<!--- UPDATE PARENT CONTACT RECORD STATUS --->
	<cfquery name="UpdateParentContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET ContactStatus='Active',
	WHERE ContactID=#form.ParentID#
	</cfquery>
	
	
	<!--- SEND EMAIL TO PARENT --->	
	
	<cfset this_contactID = form.ParentID>
	<cfinclude template="act_email_parent_verified.cfm">
	
	<cfoutput>
	<script type="text/javascript">
	alert("You have successfully verified the invitation.\n\nYour parent has been sent an email with their login details and\nthey can now access the site and participate in the community.");
	self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=45";
	</script>
	</cfoutput>
	<cfabort>
		
		
<cfelse>
	
	<!--- UPDATE INVITATION STATUS --->
	<cfquery name="UpdateParentInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE ParentInvites
	SET Status='Deleted'
	WHERE ParentInviteID=#form.ParentInviteID#
	</cfquery>
	
	
	<!--- DELETE PARENT CONTACT RECORD --->
	<cfquery name="DeleteParentContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET ContactStatus='deleted'
	WHERE ContactID=#form.ParentID#
	</cfquery>
	
	
	<!--- GET IP ADDRESS --->
	<cfquery name="ParentInviteStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ParentIP
	FROM ParentInvites
	WHERE ParentInviteID=#form.ParentInviteID#
	</cfquery>
	<!--- SEND EMAIL TO ADMINISTRATORS --->	
	
	<cfset this_contactID = form.ParentID>
	<cfset this_ip = ParentInviteStuff.ParentIP>
	<cfinclude template="act_email_parent_notverified.cfm">
	
	<cfoutput>
	<script type="text/javascript">
	alert("You have removed the invitation.\n\n#TRIM(AllSettings.SiteName)# administrators have been notified and they may\ncontact you for further information regarding this bogus activation attempt.\nYou can now send a new invitation to your parent or guardian");
	self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=45";
	</script>
	</cfoutput>
	
	<cfabort>

</cfif>