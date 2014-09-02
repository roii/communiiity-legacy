<cfset deadline = CREATEDATE(#mid(form.deadline,7,4)#,#mid(form.deadline,4,2)#,#mid(form.deadline,1,2)#)>
<cfset deadline = DateFormat(#deadline#,"mm/dd/yyyy")>

<cfoutput>

<cfquery name="UpdateCom" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
UPDATE forms
SET 
title='#trim(form.surveyTitle)#',
description='#trim(form.description)#',
comID=#form.comID#,
noneeded=#form.noneeded#,
deadline='#deadline#',
online=#form.online#,
<cfif form.price neq ''>price=#form.price#,</cfif>
verified=#form.status#
WHERE formID=#form.formID#
</cfquery>



<script>
alert("Survey details have been updated");
self.location="#request.webroot#/surveyengine/default.cfm?fuseaction=add_survey&at=1";
</script>

</cfoutput>