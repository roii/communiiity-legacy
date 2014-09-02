<cfsetting enablecfoutputonly="yes">

<cfinclude template="m#obj#.cfm">

<!--- Verified Forms --->
<cfif NotActiveForms.recordcount gt 0>
	<cfoutput>
	<table border="#tableborder#" width="#tablewidth#" cellpadding="1" cellspacing="0">
		<tr>
		<td colspan="3" align="left" bgcolor="#bgcolor1#" valign="top">&nbsp;
			<font #fontstyle#>
				<b>List of Offline Forms:</b>
			</font>&nbsp;
		</td><td bgcolor="#bgcolor1#" valign="top">&nbsp;
			<font #fontstyle#>
				<b>Action</b>
			</font>&nbsp;
		</td></tr>
	</cfoutput>
	<cfoutput query="NotActiveForms">
		<cfif (NotActiveForms.currentrow mod 2)>
			<tr bgcolor="###bgcolor3#">
		<cfelse>
			<tr bgcolor="###bgcolor4#">
		</cfif>
			<td valign="top" width="10%" height="20">
				<a href="default.cfm?obj=004&formid=#formid#&title=#urlencodedformat(NotActiveForms.title)#&at=5"><font #fontstyle1#>#NotActiveForms.formid#</font></a>
			</td><td valign="top" width="60%">
				<a href="default.cfm?formid=#NotActiveForms.formid#&title=#urlencodedformat(NotActiveForms.title)#&obj=002"><font #fontstyle1#>#NotActiveForms.title#</font></a>
			</td><td valign="top" width="20%">
				<font #fontstyle2#>#NotActiveForms.datein#</font>
			</td><td valign="top" width="10%">
				<a href="default.cfm?formid=#NotActiveForms.formid#&obj=011&method=111&at=4&itemid=#itemid#" onclick="return confirm('Are you sure?')"><font #fontstyle1#"><b>Publish</b></font></a>
			</td></tr>
	</cfoutput>
	<cfoutput>
		</table>
	</cfoutput>
<cfelse>
	<cfoutput>
		<font face="Arial" size="2">
			<b>No Offline forms for this account.</b>
		</font>
	</cfoutput>
</cfif>
<!--- Separate Tables --->
<cfoutput><br><br></cfoutput>


<cfif ActiveForms.recordcount gt 0>
	<cfoutput>
	<table border="#tableborder#" width="#tablewidth#" cellpadding="1" cellspacing="0">
		<tr>
		<td colspan="2" align="left" bgcolor="#bgcolor1#" valign="top">&nbsp;
			<font #fontstyle#>
				<b>List of Verified Forms:</b>
			</font>&nbsp;
		</td>
		<td bgcolor="#bgcolor1#" valign="top">&nbsp;
			<font #fontstyle#>
				<b>By</b>
			</font>&nbsp;
		</td>
		<td bgcolor="#bgcolor1#" valign="top">&nbsp;
			<font #fontstyle#>
				<b>Verified date</b>
			</font>&nbsp;
		</td>
		<td bgcolor="#bgcolor1#" valign="top">&nbsp;
		
			<font #fontstyle#>
				<b>Action</b>
			</font>&nbsp;
		</td></tr>
	</cfoutput>
	<cfoutput query="ActiveForms">
		<cfif (ActiveForms.currentrow mod 2)>
			<tr bgcolor="###bgcolor3#">
		<cfelse>
			<tr bgcolor="###bgcolor4#">
		</cfif>
			<td valign="top" width="10%" height="20">
				<a href="default.cfm?obj=004&formid=#formid#&title=#urlencodedformat(ActiveForms.title)#&at=5"><font #fontstyle1#>#ActiveForms.formid#</font></a>
			</td><td valign="top" width="45%">
				<a href="default.cfm?formid=#ActiveForms.formid#&title=#urlencodedformat(ActiveForms.title)#&obj=002"><font #fontstyle1#>#ActiveForms.title#</font></a>
			</td><td valign="top" width="10%">
				<font #fontstyle2#>#ActiveForms.verifiedby#</font>
			</td><td valign="top" width="20%">
				<font #fontstyle2#>#ActiveForms.dateverified#</font>
			</td><td valign="top" width="15%">&nbsp;
				<cfif session.accesslevel gt 3>
				<a href="default.cfm?formid=#ActiveForms.formid#&obj=011&method=112&at=4&itemid=#itemid#" onclick="return confirm('Are you sure?')">
					<font #fontstyle1#"><b>Take offline</b></font>
				</a>
				<cfelse>
					<font #fontstyle1#"><b>Published</b></font>
				</cfif>
			</td></tr>
			<tr><td colspan="3"><font #fontstyle1#><a href="#livedir#/#itemid#/default.cfm">#livedir#/#itemid#/default.cfm</a></font></td><td colspan="2"><font #fontstyle1#">- refer your user to this url</font></td></tr>
	</cfoutput>
	<cfoutput>
		</table>
	</cfoutput>
<cfelse>
	<cfoutput>
		<font face="Arial" size="2">
			<b>No Verified forms for this account.</b>
		</font>
	</cfoutput>
</cfif>

<cfoutput><br><br></cfoutput>

<cfsetting enablecfoutputonly="no">