<cfloop from="1" to="#form.TotalTrans#" index="loopcount">


<cfif isDefined("form.Exclude_#loopcount#")>


<cfquery name="updateTrans" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE bizTransaction
SET ExcludeBenchmark=1
WHERE transactionID=#Evaluate("form.transactionID_" & loopcount)#
</cfquery>



</cfif>



</cfloop>



<cfoutput>
<script>
alert("updated");
self.location="#request.webroot#/administration/dsp_biz_kids.cfm?BizIdeaID=#form.BizIdeaID#";
</script>
</cfoutput>