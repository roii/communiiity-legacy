<cfoutput>

<cftransaction action="BEGIN">

<!--- UPDATE myLib INFO --->
<cfquery name="UpdatemyLib" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE myLib
SET 
title='#TRIM(form.title)#',
author_fn='#TRIM(form.author_fn)#',
author_ln='#TRIM(form.author_ln)#',
myLibtypeid=#form.myLIbTypeID#,
ages='#trim(form.ages)#',
media_type='#trim(form.media_type)#',
copies=#trim(form.copies)#,
display=#trim(form.display)#
WHERE myLibid=#form.myLibid#
</cfquery>


</cftransaction>

<script>
alert("Item details have been updated");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_myLib";
</script>

</cfoutput>