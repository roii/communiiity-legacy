<cfparam name="urls" default="">
<!--- Pull all survey Information --->
<cfquery  name="PullFormInfo" datasource="#datasourceR#">
	select *
	from #tableforms#
	where vendorid = #vendorid# and formid = #formid#
</cfquery>
<cf_table width="400" title="HTML Preferences">	
<form action="default.cfm?at=8" method="post">
<cfoutput>
<input type="hidden" name="obj" value="013">
<input type="hidden" name="method" value="115">
<input type="hidden" name="formid" value="#formid#">
</cfoutput>
<cfoutput query="PullFormInfo">
<font #fontstyle1#>HTML header:</font><br>
<textarea name="header" cols="50" rows="4" wrap="VIRTUAL">
#header#
</textarea>
<p>
<table cellpadding="0" cellspacing="0" border="0">
<tr>
	<td valign="bottom"><input type="radio" name="report" value="1"<cfif report is 1> checked</cfif>></td>
	<td><font #fontstyle1#>Url for redirection:</font><br>
		<input type="text" value="#url#" name="urls" size="55" maxlength="250">
	</td>
</tr>
<tr>
	<td><input type="radio" name="report" value="0"<cfif report is 0> checked</cfif>></td>
	<td><font #fontstyle1#>Redirect to Survey report</font></td>
</tr>
</table>
<p>
<font #fontstyle1#>HTML footer:</font><br>
<textarea name="footer" cols="50" rows="4" wrap="VIRTUAL">
#footer#
</textarea>
</cfoutput>
<br>
<input type="submit" value="Update Information">
</form>
</cf_table>