<cfset bywhen = CREATEODBCDATE(form.dateCreated)>
<cfset bywhen = DateFormat(#bywhen#,"mm/dd/yyyy")>


<!--- UPDATE BUSINESS --->

<cfquery name="UpdateBiz" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
UPDATE Business
SET bizdescription='#form.bizdescription#',
bizName='#form.bizName#',

<cfif IsNumeric("#form.bizideaID#")>
	bizideaID=#form.bizideaID#,
<cfelse>
	bizideaID=0,
</cfif>

<cfif IsDefined("form.BizStatus")>
	BizStatus='#form.BizStatus#'
<cfelse>
	BizStatus='InActive'
</cfif>

WHERE BizID=#form.BizID#
</cfquery>

<cfquery name="UpdateKidsBiz" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
UPDATE bizkidsLink
SET datecreated='#bywhen#'
WHERE bizkidslinkID=#form.bizkidslinkID#
</cfquery>


<cflocation url="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentid=47">