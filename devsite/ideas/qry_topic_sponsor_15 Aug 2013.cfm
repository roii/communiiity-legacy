<cfquery name="qry_topic_sponsor" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT Organisation_Name, LogoFile
FROM Organisations

<cfif IsNumeric("#qry_current_topic.SponsorID#") AND qry_current_topic.SponsorID NEQ 0>
	WHERE OrganisationID=#qry_current_topic.SponsorID#
<cfelse>
	WHERE OrganisationID=10
</cfif>

</cfquery>
