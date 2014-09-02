<cfoutput>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<style type="text/css">
td {font-family:Arial; font-size:11px;}
</style>


<cfquery name="qry_all_topics" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM SugCategory
ORDER BY Active DESC, DisplayOrder
</cfquery>

<cfquery name="AllIdeas" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT Suggestion.sugID, Suggestion.suggestion, Suggestion.details, Suggestion.CategoryID
FROM Suggestion, SugCategory, SugMainCategory
WHERE Suggestion.Archived=1
AND Suggestion.CategoryID=SugCategory.CategoryID
AND SugCategory.MainCatID=1
GROUP BY Suggestion.sugID, Suggestion.suggestion, Suggestion.details, Suggestion.CategoryID
</cfquery>




<table border="0" cellspacing="0" cellpadding="0">

<form name="updateAllIdeas" action="act_update_allideas.cfm" method="post">
<input type="hidden" name="TotalRecs" value="#AllIdeas.recordcount#">
<tr>
<td><strong>Idea</strong></td>
<td><strong>Move To</strong></td>
<td><strong>Del.</strong></td>
</tr>

<tr>
<td colspan="3"><hr size="1" color="b4b4b4"></td>
</tr>

<cfloop query="AllIdeas">

<cfset this_idea = AllIdeas.SugID>
<cfset this_Suggestion = AllIdeas.Suggestion>
<cfset this_desc = AllIdeas.Details>
<cfset this_CategoryID = AllIdeas.CategoryID>


<input type="hidden" name="SugID_#AllIdeas.CurrentRow#" value="#this_idea#">
<tr>
<td><strong>#TRIM(this_Suggestion)#</strong><br>#this_desc#</td>
<td><select style="font-size:10px;" name="TopicID_#AllIdeas.CurrentRow#" class="whitefield" style="width:300px;"> 
<cfloop query="qry_all_topics">
<option value="#qry_all_topics.CategoryID#"<cfif this_CategoryID EQ qry_all_topics.CategoryID> selected</cfif>>#TRIM(qry_all_topics.Name)#</option>
</cfloop>
</select></td>
<td><input type="checkbox" name="Delete_#AllIdeas.CurrentRow#" value="1"></td>
</tr>

<tr>
<td colspan="3"><hr size="1" color="b4b4b4"></td>
</tr>

</cfloop>

<tr>
<td colspan="3"><input type="submit" value="update now"></td>
</tr>

</form>

</table>

</body>
</html>
</cfoutput>