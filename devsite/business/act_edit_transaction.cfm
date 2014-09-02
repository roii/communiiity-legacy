<cfset tranDate = CreateDate(#mid(form.tranDate,7,4)#,#mid(form.tranDate,4,2)#,#mid(form.tranDate,1,2)#)>
<cfset tranDate = DateFormat(#tranDate#,"mm/dd/yyyy")>


<cfquery name="ClientStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT Contacts.FirstName, Contacts.LastName, Organisations.Organisation_Name
FROM Contacts, Organisations
WHERE Contacts.ContactID=#form.ClientID#
AND Contacts.OrganisationID=Organisations.OrganisationID
</cfquery>


<!--- SET THE TIME IN MINUTES --->
<cfif form.Time_Hour GT 0>
	<cfset hourMinutes = (form.Time_Hour*60)>
	<cfset insert_Time = (hourMinutes+form.Time_Minutes)>
<cfelse>
	<cfset insert_Time = form.Time_Minutes>
</cfif>


<cfquery name="EditTran" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
UPDATE bizTransaction 
SET description='#trim(form.description)#',
tranDate='#tranDate#',

<cfif IsNumeric("#val(REReplace(form.income1_amount,"[^0-9.]","","ALL"))#")>
	income1_amount=#val(REReplace(form.income1_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	income1_amount=0,
</cfif>

income1_details='#form.income1_details#',

<cfif IsNumeric("#val(REReplace(form.expense1_amount,"[^0-9.]","","ALL"))#")>
	expense1_amount=#val(REReplace(form.expense1_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	expense1_amount=0,
</cfif>

expense1_details='#form.expense1_details#',


<cfif IsNumeric("#insert_Time#")>
	hours=#insert_Time#,
<cfelse>
	hours=0,
</cfif>

clientid=#form.clientid#,
clientName='#ClientStuff.FirstName# #ClientStuff.LastName# (#ClientStuff.Organisation_Name#)',
JobNumber='#form.JobNumber#'
where transactionid = #form.transactionid#
</cfquery>


<cflocation url="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentid=47&BizMode=edit&bizkidslinkID=#bizkidslinkID#">