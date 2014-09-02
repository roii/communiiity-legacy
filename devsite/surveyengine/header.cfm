<script language="JavaScript">
<!--
	function openWin( windowURL, windowName, windowFeatures ) { 
		return window.open( windowURL, windowName, windowFeatures ) ; 
	} 
// -->
</script>
<cfsetting enablecfoutputonly="yes">
<!--- <cfif cookie.pass is "business" and cookie.user is "siteadmin">
<cfset session.accesslevel = 4> 
<cfelse>
<cfset session.accesslevel = 1> 
</cfif> --->
	<cfset bgcolor2 = "99ccff">
	<cfset bgcolor1 = "333399">
	<!--- 
	at - tab switch parameter (assigned in application.cfm)
	bgcolor1 - Alternative Color (assigned in application.cfm)
	bgcolor2 - Alternative Color (assigned in application.cfm)
	tab1,tab2,tab3,tab4,tab5 - tab labels (assigned in application.cfm)	--->
	
	<!--- Cookie that preserves the title of the form --->
	<cfif isdefined("title")>
		<cfcookie name="title" value="#title#">
	</cfif>	
	
	<cfparam name="at" default="1">
	<cfparam name="tab1" default="Start Survey">
	<cfparam name="tab2" default="Edit Questions">
	<cfparam name="tab3" default="Chart Results">
	<cfparam name="tab4" default="Publish">
	<cfparam name="tab5" default="Library">
	<cfparam name="tab6" default="View Results">
	<cfparam name="tab7" default="Test Drive">
	<cfparam name="tab8" default="HTML Design">	
	
	<!--- Main Table (administrator menu) --->	
	<cfoutput>
	<table width="100%" cellpadding="1" cellspacing="0" border="0" bgcolor="#bgcolor1#">
	<tr><td valign="bottom">
	<cfif formid>
	<table width="#tablewidth#" cellpadding="0" cellspacing="0"  border="#tableborder#">
	<tr>
		<td <cfif at is 1>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;
				
			<a href="default.cfm?obj=001&at=1">
			<font #fontstyle#>
				<b>#tab1#</b>
			</font></a>
		</td>
		<!--- <td <cfif at is 2>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;
				
			<a href="default.cfm?obj=002&formid=#formid#&title=#urlencodedformat(title)#&at=2">
			<font #fontstyle#>
				<b>#tab2#</b>
			</font></a>
			
		</td> --->
		<td <cfif at is 5>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;
			
			<a href="default.cfm?obj=012&at=5&formid=#formid#&">
			<font #fontstyle#>
				<b>#tab5#</b>
			</font></a>
			
		</td>			
	<!--- End of restrictions --->
		
		<td <cfif at is 7>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;
				<a href="default.cfm?obj=004&formid=#formid#&title=#urlencodedformat(title)#&at=7">
			<font #fontstyle#>
				<b>#tab7#</b>
			</font></a>
		</td>		
		
	<cfif session.accesslevel gt 2>
	
		</td>		
		<td <cfif at is 4>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;

			<a href="default.cfm?obj=011&formid=#formid#&title=#urlencodedformat(title)#&at=4">
			<font #fontstyle#>
				<b>#tab4#</b>
			</font></a>
		</td>
	</cfif>		
		<td <cfif at is 6>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;
			
			<a href="default.cfm?obj=006&formid=#formid#&title=#urlencodedformat(title)#&at=6">
			<font #fontstyle#>
				<b>#tab6#</b>
			</font></a>
			
		</td>			
	<!--- Access level greater than 1 --->
	<cfif session.accesslevel gt 1>
	    <td <cfif at is 2>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;
				
			<a href="default.cfm?obj=002&formid=#formid#&title=#urlencodedformat(title)#&at=2">
			<font #fontstyle#>
				<b>#tab2#</b>
			</font></a>
			
		</td>
		<td <cfif at is 8>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;
				<a href="default.cfm?obj=013&formid=#formid#&title=#urlencodedformat(title)#&at=8">
			<font #fontstyle#>
				<b>#tab8#</b>
			</font></a>
		</td>		
		<td <cfif at is 3>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top" align="center">&nbsp;
			
			<a href="default.cfm?obj=009&formid=#formid#&title=#urlencodedformat(title)#&at=1">
			<font #fontstyle#>
				<b>#tab3#</b>
			</font></a>
	</cfif>	
	</tr>
	
	<tr>
		<td bgcolor="#bgcolor2#" height="30" colspan="9" width="#tablewidth#">
			&nbsp;&nbsp;&nbsp;&nbsp;<cfif isdefined("title")><font face="arial" size="2" color="#bgcolor1#"><b>Active Survey: #title#</b></font></cfif>
		</td>
	</tr>
	</table>
	<cfelse>
		<table width="#tablewidth#" cellpadding="0" cellspacing="0"  border="#tableborder#">
		<tr>
		<td <cfif at is 1>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top">&nbsp;
				
			<a href="default.cfm?fuseaction=add_survey&at=1">
			<font #fontstyle#>
				<b>Start Survey</b>
			</font></a>
			
		</td>
		<td <cfif at is 5>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top">&nbsp;
				
			<a href="default.cfm?fuseaction=add_Q&at=5">
			<font #fontstyle#>
				<b>Add/Edit Question</b>
			</font></a>
			
		</td>
		<td <cfif at is 2>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top">&nbsp;
				
			<a href="default.cfm?fuseaction=add_com&at=2">
			<font #fontstyle#>
				<b>Add/Edit Company</b>
			</font></a>
			
		</td>
<!---		<td <cfif at is 3>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top">&nbsp;
				
			<a href="default.cfm?fuseaction=add_survey&at=1">
			<font #fontstyle#>
				<b>Add/Edit Survey</b>
			</font></a>
			
		</td> --->
		<td <cfif at is 4>
				bgcolor="#bgcolor2#"
			<cfelse>
				bgcolor="#bgcolor1#"
			</cfif> height="12" valign="top">&nbsp;
				
			<a href="default.cfm?fuseaction=add_term&at=4">
			<font #fontstyle#>
				<b>Add/Edit Term</b>
			</font></a>
			
		</td>

		<tr>
		<td bgcolor="#bgcolor2#" colspan="5" height="30" width="#tablewidth#">
			&nbsp;	<font face="arial" size="2">
			<A href="http://www.my3p.com">This Survey Engine is managaged by Web Team of myKidsBiz. </a></font>
		</td></tr>
	</table>
	</cfif>
		</td></tr>
	</table>
	</td></tr></table>
	<br>
	</cfoutput>
	
<cfsetting enablecfoutputonly="no">	