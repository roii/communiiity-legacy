<cfsetting enablecfoutputonly="yes">

<cfinclude template="m002.cfm">

<cfoutput>
<table cellpadding="3" cellspacing="0" width="#tablewidth#" border="#tableborder#">
	<tr bgcolor="#bgcolor1#">
		<th><font #fontstyle#>N</font></th>
		<cfif isdefined("title")>
		<th><font #fontstyle#>Form Title: #Title#</font></th>
		<cfelse>
		<th><font #fontstyle#>Question</font></th>
		</cfif>
	</tr>
</cfoutput>

<!--- Output questions for this form --->
<cfset i = 0>
<cfoutput query="GetForm">
	<cfset i = i + 1>
	<cfif (GetForm.Currentrow mod 2)>
		<tr bgcolor = "#bgcolor3#">
	<cfelse>
		<tr bgcolor = "#bgcolor4#">
	</cfif>
		<cfset no_htmlquestion = ReReplace(question, "<[^>]*>", " (html)", "ALL")>
		<td width="5%" align="center"><a href="default.cfm?id=#id#&obj=008&formid=#formid#&title=#urlencodedformat(title)#&at=#at#"><font #fontstyle1#>#i#</font></a></td>
		<td width="95%">&nbsp;&nbsp;
		<cfif questiontype gt 0>
			<a href="default.cfm?id=#id#&obj=008&formid=#formid#&title=#urlencodedformat(title)#&at=#at#"><font #fontstyle1#>#no_htmlquestion#</font></a>
		<cfelse>
			<font #fontstyle1#>#no_htmlquestion#</font>
		</cfif></td>
		</tr>
	</cfoutput>
	<!--- Display warning if there is no questions in this form --->
	<cfif GetForm.recordcount is 0>
		<cfoutput>
		<tr><td colspan="2">
			<font #fontstyle1#>There is no installed questions in this survey. If you would like to add a question please use the options below.</font>
		</td></tr>
		</cfoutput>
	</cfif>
<cfoutput>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="no">

