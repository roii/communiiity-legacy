<cfoutput>

<cftransaction action="BEGIN">

<!--- UPDATE GOAL INFO --->
<cfquery name="UpdateGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE mylibtype
SET 
libtype='#TRIM(form.mylibtype)#'
WHERE mylibtypeid=#form.mylibTypeID#
</cfquery>


</cftransaction>

<script>
alert("myLibrary Type has been updated");
self.location="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=docs&documentid=30";
</script>

</cfoutput>