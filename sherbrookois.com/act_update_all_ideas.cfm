<cfloop from="1" to="#form.TotalRecs#" index="loopcount">

<cfset this_SugID = Evaluate("form.SugID_" & loopcount)>
<cfset this_TopicID = Evaluate("form.TopicID_" & loopcount)>


<cfif IsDefined("form.Delete_#loopcount#") AND Evaluate("form.Delete_" & loopcount) EQ 1>

	<!--- DELETE IDEA --->
	<cfquery name="RemoveSug" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">>
	DELETE
	FROM Suggestion
	WHERE SugID=#this_SugID#
	</cfquery>


<cfelse>


	<cfquery name="moveidea" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">>
	UPDATE Suggestion
	SET CategoryID=#this_TopicID#
	WHERE SugID=#this_SugID#
	</cfquery>


</cfif>


</cfloop>


<cflocation url="dsp_update_all_ideas.cfm">