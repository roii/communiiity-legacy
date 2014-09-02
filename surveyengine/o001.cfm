<cfsetting enablecfoutputonly="yes">
<cfinclude template="m#obj#.cfm">
<cfif PullFormInfo.recordcount gt 0>	

<cf_table title="List of Active Forms:">
	<cfoutput>
	<table border="#tableborder#" width="#tablewidth#" cellpadding="1" cellspacing="0" bgcolor="#bgcolor1#">
	</cfoutput>
	
	<cfoutput query="PullFormInfo">
	

		<cfif (PullFormInfo.currentrow mod 2)>
			<tr bgcolor="###bgcolor3#">
		<cfelse>
			<tr bgcolor="###bgcolor4#">
		</cfif>
			<td valign="top" width="10%" height="20">
				<a href="default.cfm?obj=004&formid=#formid#&title=#urlencodedformat(PullFormInfo.title)#&at=7"><font #fontstyle1#>#PullFormInfo.formid#</font></a>
			</td><td valign="top" width="50%">
			<cfif PullFormInfo.verified is 1>
				<a href="default.cfm?formid=#PullFormInfo.formid#&title=#urlencodedformat(PullFormInfo.title)#&obj=009&at=3"><font #fontstyle1#>#PullFormInfo.title#</font></a>
			<cfelse>
				<a href="default.cfm?formid=#PullFormInfo.formid#&title=#urlencodedformat(PullFormInfo.title)#&obj=002"><font #fontstyle1#>#PullFormInfo.title#</font></a>
			</cfif>			
			</td><td valign="top" width="20%">
				<font #fontstyle2#>#PullFormInfo.datein#</font>
			</td>
			<td valign="top" width="10%">
				<cfif PullFormInfo.verified is 1>
					<font #fontstyle2#">ONLINE</font>
				<cfelse>
					<a href="default.cfm?formid=#PullFormInfo.formid#&method=102&at=1&requesttimeout=600" onclick="return confirm('Warning!!! You are  about to remove your entire survey from the system!!! You will lose all your data after this transaction!!! Are you sure???')"><font #fontstyle2#">remove survey</font></a>
				</cfif>
			</td></tr>
	</cfoutput>
	
<!---<cfelse>

	<cfoutput query="PullFormInfo">
	<cfif #PullFormInfo.owner# eq session.upi> 




		<cfif (PullFormInfo.currentrow mod 2)>
			<tr bgcolor="###bgcolor3#">
		<cfelse>
			<tr bgcolor="###bgcolor4#">
		</cfif>
			<td valign="top" width="10%" height="20">
				<a href="default.cfm?obj=004&formid=#formid#&title=#urlencodedformat(PullFormInfo.title)#&at=7"><font #fontstyle1#>#PullFormInfo.formid#</font></a>
			</td><td valign="top" width="50%">
			<cfif PullFormInfo.verified is 1>
				<a href="default.cfm?formid=#PullFormInfo.formid#&title=#urlencodedformat(PullFormInfo.title)#&obj=009&at=3"><font #fontstyle1#>#PullFormInfo.title#</font></a>
			<cfelse>
				<a href="default.cfm?formid=#PullFormInfo.formid#&title=#urlencodedformat(PullFormInfo.title)#&obj=002"><font #fontstyle1#>#PullFormInfo.title#</font></a>
			</cfif>			
			</td><td valign="top" width="20%">
				<font #fontstyle2#>#PullFormInfo.datein#</font>
			</td>
			<td valign="top" width="10%">
				<cfif PullFormInfo.verified is 1>
					<font #fontstyle2#">ONLINE</font>
				<cfelse>
					<a href="default.cfm?formid=#PullFormInfo.formid#&method=102&at=1&requesttimeout=600" onclick="return confirm('Warning!!! You are  about to remove your entire survey from the system!!! You will lose all your data after this transaction!!! Are you sure???')"><font #fontstyle2#">remove survey</font></a>
				</cfif>
			</td></tr>
	</cfif>
	</cfoutput>
</cfif>
    <cfoutput>
		</table>
	</cfoutput>
	</cf_table>
<cfelse>
	<cfoutput>
		<font face="Arial" size="2">
			<b>No forms has been installed.</b><br>
		</font>
	</cfoutput>--->
</cfif>


<!---
<cfoutput><br></cfoutput>
<cf_table title="Enter your Survey Title:">
<cfif PullFormInfo.recordcount lt 35>
	<cfoutput>
	<cfset itemid = randrange(1,99999999)>
	<form action="default.cfm" method="POST">
		<input type="hidden" name="method" value="101">
		<input type="hidden" name="itemid" value="#itemid#">
		<input type="hidden" name="vendorid" value="#vendorid#">
		<font #fontstyle1#>Enter your Survey Title:</font>
		<input type="Text" name="title" size="45" maxlength="255">
		<input type="Submit" name="action" value="add new survey">
	</form>
	</cfoutput>
<cfelse>
	<cfoutput><font face="Arial" size="2"><a href="mailto:cb.wang@auckland.ac.nz">Too many online form</a></font></cfoutput>
</cfif>
</cf_table> --->
<cfsetting enablecfoutputonly="no">