<cfdirectory action="list" directory="#request.fileroot#\goal_reversals" name="users">

<cfoutput query="users">

<cfif users.type CONTAINS 'File'>
<cfset this_file = users.name>
<cfset this_contact = LEFT(users.name, 6)>

<cfquery name="contactDetails" datasource="#dsn#">
SELECT FirstName, EmailAddress
FROM Contacts
WHERE ContactID=#INT(this_contact)#
</cfquery>

<cfif contactDetails.RecordCount>
<cffile action="read" file="#request.fileroot#\goal_reversals\#this_file#" variable="GoalHistory">

<cfmail server="#application.emailserver#" to="#TRIM(ContactDetails.EmailAddress)#" from="team@my3p.com" subject="my3P.com Points Audit">Hi #TRIM(ContactDetails.FirstName)#,

my3P.com has been conducting an audit of the points earned by members.
During the course of this audit we discovered that members were able to earn points by taking advantage of a security hole in the Goals section. This hole has since been closed, however in the best interests of the community we have decided to reverse any points earned in this manner.

Below are the results of our audit into your points earned for goals.

If you have any questions please email them to... team@my3p.com
-------------------------------------------------

#TRIM(GoalHistory)#
</cfmail>
</cfif>

</cfif>	

</cfoutput>
