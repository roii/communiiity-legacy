<cfquery name="SearchInfo" datasource="#GuidelineDSN#">
SELECT *
FROM GuidelineSearchIndex
ORDER BY GuidelineID
</cfquery>


<table>
<cfoutput query="SearchInfo">
<tr>
<td valign="top">#GuidelineID#&nbsp;&nbsp;</td>
<td valign="top">#SearchDetails#</td>
</tr>

<tr>
<td colspan="2"><hr></td>
</tr>
</cfoutput>
</table>