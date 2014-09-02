<cfsetting enablecfoutputonly="yes">

<cfinclude template="m#obj#.cfm">

<cfoutput>
<table cellpadding="1" cellspacing="0" width="#tablewidth#" border="#tableborder#">
	<tr>
	<td bgcolor="#bgcolor1#">
	
<table cellpadding="2" cellspacing="0" width="#tablewidth#" border="#tableborder#">
	<tr bgcolor="#bgcolor1#">
		<th><font #fontstyle#>N</font></th>
		<cfif isdefined("title")>
			<th><font #fontstyle#>Form Title: #REReplace(title, "<[^>]*>", "", "All")#</font></th>
		<cfelse>
			<th><font #fontstyle#>Question</font></th>
		</cfif>
		<th><font #fontstyle#>Copy</font></th>
		<th><font #fontstyle#>Remove</font></th>
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
		<cfset no_htmlquestion = ReReplace(question, "<[^>]*>", "", "ALL")>
		<td width="5%" align="center"><a href="default.cfm?id=#id#&obj=003&formid=#formid#&title=#urlencodedformat(title)#&at=#at#"><font #fontstyle1#>#i#</font></a></td>
		<td width="75%">&nbsp;&nbsp;<a href="default.cfm?id=#id#&obj=003&formid=#formid#&title=#urlencodedformat(title)#&at=#at#"><font #fontstyle1#>#no_htmlquestion#</font></a></td>
		<td width="10%" align="center"><a href="default.cfm?formid=#formid#&id=#id#&c=1&obj=002&title=#urlencodedformat(title)#&at=#at#"><font #fontstyle1#><b>X</b></font></a></td>
		<td width="10%" align="center"><a href="default.cfm?formid=#formid#&id=#id#&d=1&obj=002&title=#urlencodedformat(title)#&at=#at#" onclick="return confirm('Are you sure?')"><font #fontstyle1#><b>X</b></font></a></td>
		</tr>
	</cfoutput>
	<!--- Display warning if there is no questions in this form --->
	<cfif GetForm.recordcount is 0>
		<cfoutput>
		<tr><td colspan="4" bgcolor="#bgcolor2#">
			<font #fontstyle1#>There are no installed questions in this survey. If you would like to add a question please use the options below.</font>
		</td></tr>
		</cfoutput>
	</cfif>
<cfoutput>
</table>
	<table width="#tablewidth#" cellpadding=0 cellspacing=0 border="#tableborder#">
	<form action="default.cfm" method="POST">
	<input type="hidden" name="obj" value="003">
	<input type="hidden" name="id" value="0">
	<input type="hidden" name="formid" value="#formid#">
	<input type="hidden" name="title" value="#title#">
	<tr bgcolor="#bgcolor2#">
	<td>
		<center><input type="submit" value="Add Question"></center>
	</td>
	</form>
	</tr>
	</table>
</td></tr></table>
</cfoutput>

<cfsetting enablecfoutputonly="no">