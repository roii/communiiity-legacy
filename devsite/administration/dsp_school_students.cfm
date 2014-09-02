<cfoutput>

<cfparam name="StudentSortField" default="FirstName">
<cfparam name="StudentSortOrder" default="ASC">

<cfif StudentSortField EQ 'Points'>

	<cfquery name="qry_all_students" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress, Contacts.ScreenName, Contacts.mobilePhone, SUM(contact_transactions.Transaction_Amount) AS TotalPointsIn
	FROM Contacts, contact_transactions
	WHERE Contacts.SchoolID=#SchoolID#
	AND Contacts.ContactTypeID IN (1,2)
	AND Contacts.ContactID=contact_transactions.ContactID
	AND contact_transactions.Transaction_Type LIKE '%credit%'
	AND contact_transactions.Transaction_Account LIKE '%Points%'
	GROUP BY Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress, Contacts.ScreenName, Contacts.mobilePhone
	ORDER BY TotalPointsIn #StudentSortOrder#
	</cfquery>
	
	
<cfelseif StudentSortField EQ 'Ideas'>

	<cfquery name="qry_all_students" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress, Contacts.ScreenName, Contacts.mobilePhone, COUNT(suggestion.SugID) AS TotalIdeas
	FROM Contacts, suggestion
	WHERE Contacts.SchoolID=#SchoolID#
	AND Contacts.ContactTypeID IN (1,2)
	AND Contacts.ContactID=suggestion.ContactID
	GROUP BY Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress, Contacts.ScreenName, Contacts.mobilePhone
	ORDER BY TotalIdeas #StudentSortOrder#
	</cfquery> 

<cfelse>

	<cfquery name="qry_all_students" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress, Contacts.ScreenName, Contacts.mobilePhone
	FROM Contacts
	WHERE Contacts.SchoolID=#SchoolID#
	AND Contacts.ContactTypeID IN (1,2)
	ORDER BY #StudentSortField# #StudentSortOrder#
	</cfquery> 

</cfif>

<table width="100%" cellpadding="0" cellspacing="0" border="0">


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:12px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool&ExportList=#ValueList(qry_all_students.contactID)#" target="mymainwindow">Email All Students</a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:11px;color:##333333;" width="120"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"><br><strong><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#schoolID#&updatemode=students&StudentSortOrder=<cfif StudentSortOrder EQ 'ASC'>DESC<cfelse>ASC</cfif>&StudentSortField=FirstName">Name</a></strong></td>
	<td style="font-size:11px;color:##333333;" width="140"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1" border="0"><br><strong><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#schoolID#&updatemode=students&StudentSortOrder=<cfif StudentSortOrder EQ 'ASC'>DESC<cfelse>ASC</cfif>&StudentSortField=ScreenName">Screen Name</a></strong></td>
	<td style="font-size:11px;color:##333333;" width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"><br><strong><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#schoolID#&updatemode=students&StudentSortOrder=<cfif StudentSortOrder EQ 'ASC'>DESC<cfelse>ASC</cfif>&StudentSortField=EmailAddress">Email</a></strong></td>
	<td style="font-size:11px;color:##333333;" width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"><br><strong><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#schoolID#&updatemode=students&StudentSortOrder=<cfif StudentSortOrder EQ 'ASC'>DESC<cfelse>ASC</cfif>&StudentSortField=MobilePhone">Mobile</a></strong></td>
	<td style="font-size:11px;color:##333333;" width="80" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"><br><strong><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#schoolID#&updatemode=students&StudentSortOrder=<cfif StudentSortOrder EQ 'ASC'>DESC<cfelse>ASC</cfif>&StudentSortField=Points">Points</a></strong></td>
	<td style="font-size:11px;color:##333333;" width="80" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"><br><strong><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#schoolID#&updatemode=students&StudentSortOrder=<cfif StudentSortOrder EQ 'ASC'>DESC<cfelse>ASC</cfif>&StudentSortField=Ideas">Ideas</a></strong></td>
	<td style="font-size:11px;color:##333333;" width="80" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"><br><strong>Sent Invites</strong></td>
	<td style="font-size:11px;color:##333333;" width="80" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"><br><strong>Successful</strong></td>
	</tr>
	
	<tr>
	<td colspan="8"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" bgcolor="##eaeaea"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
	</tr>

	<cfloop query="qry_all_students">
	
	<cfset this_contactID = qry_all_students.contactID>
	<cfset this_FirstName = qry_all_students.FirstName>
	<cfset this_LastName = qry_all_students.LastName>
	<cfset this_emailaddress = qry_all_students.emailaddress>
	<cfset this_mobilephone = qry_all_students.mobilephone>
	<cfset this_Screenname = qry_all_students.Screenname>
	
	
	<!--- GET ALL POINTS EARNED FOR THIS STUDENT --->
	<cfquery name="qry_student_points" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalPointsIn
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%credit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#qry_student_points.TotalPointsIn#")>
		<cfset TotalUserPointsIn = INT(qry_student_points.TotalPointsIn)>
	<cfelse>
		<cfset TotalUserPointsIn = 0>
	</cfif>
	
	<!--- GET ALL IDEAS FOR THIS STUDENT --->
	<cfquery name="qry_student_ideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID
	FROM suggestion
	WHERE ContactID=#this_contactID#
	</cfquery>	
	
	
	<cfset Invite_List = "">	
	
	<cfif TRIM(this_Screenname) NEQ ''>
		
		<cfquery name="qry_all_successful_invites" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID
		FROM Contacts
		WHERE ReferralCode LIKE '%#this_Screenname#%'
		AND ReferralCode <> ''
		</cfquery>
	
		<cfif qry_all_successful_invites.RecordCount>
			<cfloop query="qry_all_successful_invites">
			<cfset this_unique = "SI#qry_all_successful_invites.ContactID#">		
			<cfif NOT ListFind(Invite_List, this_unique, ",")>
				<cfset Invite_List = ListAppend(Invite_List, this_unique, ",")>
			</cfif>
			</cfloop>
		</cfif>	
			
	</cfif>
	
	
	<cfquery name="qry_all_invites" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT InvitationID
	FROM Invitations
	WHERE InvitationFrom = #this_contactID#
	</cfquery>
	
	<cfif qry_all_invites.RecordCount>
		<cfloop query="qry_all_invites">
		<cfset this_unique = "AI#qry_all_invites.InvitationID#">		
		<cfif NOT ListFind(Invite_List, this_unique, ",")>
			<cfset Invite_List = ListAppend(Invite_List, this_unique, ",")>
		</cfif>
		</cfloop>
	</cfif>	
	
	
	
	<tr>
	<td style="font-size:11px;color:##444444;"><strong>#TRIM(this_FirstName)# #TRIM(this_LastName)#</strong></td>
	<td style="font-size:11px;color:##444444;">#TRIM(this_Screenname)#</td>
	<td style="font-size:11px;color:##444444;"><a href="mailto:#TRIM(this_emailaddress)#">#TRIM(this_emailaddress)#</a></td>
	<td style="font-size:11px;color:##444444;">#TRIM(this_mobilephone)#</td>
	<td style="font-size:11px;color:##444444;" align="center">#TotalUserPointsIn#pts</td>
	<td style="font-size:11px;color:##444444;" align="center">#qry_student_ideas.recordcount#</td>
	<td style="font-size:11px;color:##444444;" align="center">#ListLen(Invite_List, ",")#</td>
	<td style="font-size:11px;color:##444444;" align="center"><cfif TRIM(this_Screenname) NEQ ''>#qry_all_successful_invites.RecordCount#<cfelse>0</cfif></td>
	</tr>
	
	<tr>
	<td colspan="8"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" bgcolor="##eaeaea"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
	</tr>
	
	</cfloop>

	</table>

</td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>


</table><br><br>


</cfoutput>