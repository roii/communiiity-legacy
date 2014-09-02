<cfparam name="FORM.keywords" default="">

<cfquery name="AllQuotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM QuoteOfDay where quoteid > 1 <cfif FORM.keywords neq ''>and (quotedetails like '%#FORM.keywords#%' or quotecredit like '%#FORM.keywords#%')</cfif>
</cfquery>

<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Members_StartRow" default="1">
</cflock>

	<cfif isdefined("Members_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Members_StartRow = Members_StartRow>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Members_MaxRows" default="50">
</cflock>

	<cfif isdefined("Members_MaxRows")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Members_MaxRows = Members_MaxRows>
		</cflock>
	</cfif>

<cfif session.members_MaxRows NEQ 'ALL'>
	
		<cfif AllQuotes.RecordCount GT (session.members_StartRow+session.members_MaxRows)-1>
			<cfset members_endrow = session.members_StartRow+session.members_MaxRows-1>
		<cfelse>
			<cfset members_endrow = AllQuotes.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset members_endrow = AllQuotes.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.members_Startrow GT session.members_Maxrows>
		<cfset prev = session.members_Startrow-session.members_Maxrows>
	
	<cfelse>
		<cfset prev = session.members_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif members_endrow LT AllQuotes.RecordCount>
		<cfset next = (members_endrow+1)>
	
	<cfelse>
		<cfset next = session.members_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.members_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(AllQuotes.RecordCount/session.members_Maxrows)>
		<cfset membersNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset membersNumberCount=1>
		
	</cfif>	
<cfoutput>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="40%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE QUOTES</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>
<form action="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_quotes" method="post" name="search_quotes_form">
<tr>
<td align="left" width="40%"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_quote">Add A New Quote</a></td>
<td align="left" width="60%">Search Quotes: <input type="text" size="25" maxlength="25" name="keywords" <cfif FORM.keywords neq ''>value="#FORM.keywords#"</cfif>> <input type="submit" name="searchsubmit" value="GO"></td>
</tr>
</form>
<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<!--- display allow sorting column --->
	
	<tr>
	<td width="40%" style="padding-left:10px;font-size:11px;"><strong>Quote</strong></td>
	<td width="20%" style="padding-left:10px;font-size:11px;"><strong>Quote Credit</strong></td>
	<td width="25%" style="padding-left:10px;font-size:11px;"><strong>Who sees it</strong></td>
	<td width="25%" style="padding-left:10px;font-size:11px;"><strong>Show/Hide</strong></td>
	<td width="15%" style="padding-left:10px;font-size:11px;"><strong>Edit</strong></td>
	<td width="15%" style="padding-left:10px;font-size:11px;"><strong>Delete</strong></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	<form action="#request.webroot#/administration/act_manage_quotes.cfm" method="post" name="manage_quotes_form">
	<cfloop query="AllQuotes" startrow="#session.members_StartRow#" endrow="#members_endrow#">
	<cfif currentrow mod 2 eq 0><tr style="background-color:##CCCCCC;"><cfelse><tr></cfif>
	<td style="padding-left:10px;font-size:11px;">#AllQuotes.quotedetails#</td>
	<td style="padding-left:10px;font-size:11px;">#AllQuotes.quotecredit#</td>
	<td style="padding-left:10px;font-size:11px;"><input type="radio" name="whoseesit_#AllQuotes.quoteid#" <cfif AllQuotes.whoseesit eq 0>checked</cfif> value="0">All &nbsp;
	<input type="radio" name="whoseesit_#AllQuotes.quoteid#" <cfif AllQuotes.whoseesit eq 1>checked</cfif> value="1">Adult &nbsp;
	<input type="radio" name="whoseesit_#AllQuotes.quoteid#" <cfif AllQuotes.whoseesit eq 2>checked</cfif> value="2">Youth
	</td>
	<td style="padding-left:10px;font-size:11px;">
	<input type="radio" name="showhide_#AllQuotes.quoteid#" <cfif AllQuotes.display eq 1>checked</cfif> value="1">Show &nbsp;&nbsp;
	<input type="radio" name="showhide_#AllQuotes.quoteid#" <cfif AllQuotes.display eq 0>checked</cfif> value="0">Hide
	</td>
	<td style="padding-left:10px;font-size:11px;">
	<a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=edit_quote&quoteid=#AllQuotes.quoteid#">Edit</a>
	</td>
	<td align="center">
	<input type="checkbox" name="delete_#AllQuotes.quoteid#" title="tick to delete" value="1">
	</td>	
	</tr>
	
	</cfloop>	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
    <hr width="100%" size="1" color="e2e2e2">
	
	<div align="right"><cfif session.members_Startrow GT session.members_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_Startrow=#prev#">Prev Page</a> | </cfif><cfif members_endrow LT AllQuotes.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.members_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#membersNumberCount#" index="NumberCount"><cfset thisStartRow=(session.members_Maxrows*NumberCount-session.members_Maxrows+1)><cfif thisStartRow EQ session.members_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.members_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ membersNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>

</td>
</tr>
<tr><td colspan="4" align="center">
<cfif FORM.keywords neq ''><input type="hidden" name="keywords" value="#trim(FORM.keywords)#"></cfif>
<input type="hidden" name="startrow" value="#session.members_StartRow#">
<input type="hidden" name="endrow" value="#members_endrow#">
<input type="submit" name="submit" value="Submit Changes"></td></tr>
</table>
</form>
</cfoutput>