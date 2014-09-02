<cfoutput>

<cftransaction action="BEGIN">

<!--- UPDATE GOAL INFO --->
<cfquery name="UpdateGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE bizidea_Type
SET 
biz_type='#TRIM(form.bizideatype)#'
WHERE bizideatypeid=#form.bizideaTypeID#
</cfquery>


</cftransaction>

<script>
alert("Biz Idea Type has been updated");
self.location="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=9&articleID=17";
</script>

</cfoutput>