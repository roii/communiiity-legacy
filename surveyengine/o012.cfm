<CFSETTING ENABLECFOUTPUTONLY="YES">

<cfinclude template="m#obj#.cfm">

<!--- Cold Fusion specific parameters --->
<cfset temppath = gettemplatepath()>

<cfparam name="templatename" default="#listlast(temppath, chr(92))#">
<cfparam name="startrow" default="1">
<cfparam name="endrow" default="1">
<cfparam name="orderby" default="asc">
<cfparam name="orderbycolumn" default="">

<!--- Design specific parameters --->
<cfparam name="recordsperscreen" default="50">
<cfparam name="tableborder" default="border=0">
<cfparam name="tablecellpadding" default="cellpadding=0">
<cfparam name="tablecellspacing" default="cellspacing=0">
<cfparam name="tablebgcolor1" default="##dedede">
<cfparam name="tablebgcolor2" default="##f0f0f0">

<cfset table=tableresponses>

<cfif val(startrow) eq 0>
	<cfset startrow = 1>
</cfif>

<!--- Set the direction of recordset --->
<cfif isdefined("action")>
	<cfif action is " |< ">
		<cfset startrow = 1>
	<cfelseif action is " < ">
		<cfset startrow = startrow - recordsperscreen>
	<cfelseif action is " >| ">
		<cfset startrow = recordset.recordcount -  recordsperscreen + 1>
	</cfif>
</cfif>

<!--- Adjust display records on screen limit --->	
<cfif (startrow le 0) or (not len(startrow))>
	<cfset startrow = 1>
</cfif>		
<cfset endrow = startrow + recordsperscreen>

<cfif endrow gt recordset.recordcount>
	<cfset endrow = recordset.recordcount>
</cfif>

<cfif orderby is "asc">
	<cfset neworderby = "desc">
<cfelse>
	<cfset neworderby = "asc">
</cfif>

<cfset fid = formid>
<cf_table title="Online Form Library">
<cfoutput>
<table width="#tablewidth#" cellpadding=0 cellspacing=0 border="#tableborder#">
<tr><td colspan="5">
<table cellpadding="0" cellspacing="0" width="400">
<tr>
<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">
	<input type="hidden" name="obj" value="012">
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="formid" value="#formid#">
	<input type="hidden" name="columns" value="#columns#">
	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="1">
	<input type="submit" name="action" value=" |< ">
</td>
</form>
<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">	
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#startrow#">
	<input type="submit" name="action" value=" < ">
</td>
</form>
<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">	
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="columns" value="#columns#">
	
	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="text" name="startrow" value="#startrow#" size="3">
</td>
</form>
<cfif endrow lt recordset.recordcount>
	<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">	
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">
	<input type="hidden" name="title" value="#title#">	
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#endrow#">
	<input type="submit" name="action" value=" > ">
</td>
	</form>
</cfif>
<cfif endrow lt recordset.recordcount>
	<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">
	<input type="hidden" name="title" value="#title#">		
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#endrow#">
	<input type="submit" name="action" value=" >| ">
</td>
	</form>
</cfif>	
<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">	
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="columns" value="#columns#">
	
	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<select name="keyword">
		<option value="">ALL</option>	
		<option value="BUSINESS">BUSINESS</option>
	   	<option value="EDUCATION">EDUCATION</option>
	   	<option value="MARKETING RESEARCH">MARKETING RESEARCH</option>
	   	<option value="INTRANET">INTRANET</option>
	   	<option value="HUMAN RESOURCES">HUMAN RESOURCES</option>
		<option value="MEETINGS">MEETINGS</option> 
		<option value="SATISFACTION">SATISFACTION</option> 
	</select>
	<input type="submit" name="action" value=" Go ">
</td>
</form>

</tr>
</table>
</td></tr>
<tr bgcolor="#bgcolor3#">
<td>&nbsp;</td>
</cfoutput>
	<cfloop index="Index_Column" list="#columns#">
		<cfoutput><td><b><font face="Arial" size="2" style="color:##000000; text-decoration:none">#Index_Column#</font></b></td></cfoutput>	
	</cfloop>
<cfoutput>	
<td><b><font #fontstyle1#>Action</font></b></td>	
</tr>
</cfoutput>

<cfloop query="recordset" startrow="#startrow#" endrow="#endrow#">
        <cfif (recordset.CurrentRow mod 2)>
                <cfoutput><tr bgcolor = "#bgcolor3#"></cfoutput>
        <cfelse>
                <cfoutput><tr bgcolor = "#bgcolor4#"></cfoutput>
        </cfif>
        <cfoutput>
        <form action="default.cfm" method="post">
        	<td width="30">
			<input type="hidden" name="at" value="5">		
			<input type="hidden" name="obj" value="004">
			<input type="hidden" name="method" value="204">				
			<input type="hidden" name="itemid" value="#itemid#">
			<input type="hidden" name="formid" value="#formid#">			
			<input type="Submit" value="   ">
			</td>
        </form>
        </cfoutput>
		<cfloop index="Index_Column" list="#columns#">
			<cfoutput><td><font face="Arial" size="2">#evaluate("recordset.#Index_Column#")#</font></b>&nbsp;</td></cfoutput>	
		</cfloop>
		<cfoutput><td><a href="default.cfm?obj=002&formid=#formid#&method=114&fid=#fid#" alt="Install the form" onclick="return confirm('Are you sure?')"><b><font #fontstyle1#>Install</font></b></a></td></cfoutput>
</cfloop>     
  
<cfoutput>
<tr>
<td bgcolor = "#bgcolor4#" colspan="#evaluate(listlen(columns)+2)#">
<cfif endrow lt recordset.recordcount>
<table bgcolor = "#bgcolor4#">
<tr>
	<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">
	<input type="hidden" name="obj" value="012">
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="formid" value="#formid#">
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">
	
	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="1">
	<input type="submit" name="action" value=" |< ">
</td>
	</form>
	<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">	
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#startrow#">
	<input type="submit" name="action" value=" < ">
</td>
	</form>
	<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">	
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">
	
	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="text" name="startrow" value="#startrow#" size="3">
</td>
	</form>
	<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">	
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">
	<input type="hidden" name="title" value="#title#">	
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#endrow#">
	<input type="submit" name="action" value=" > ">
</td>
	</form>
	<form action="default.cfm" method="POST">
<td>
	<input type="hidden" name="at" value="5">
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="012">
	<input type="hidden" name="title" value="#title#">		
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#endrow#">
	<input type="submit" name="action" value=" >| ">
</td>
	</form>
</tr></table>
</cfif>
</td>
</tr>
</table>
</cfoutput>
</cf_table>

<CFSETTING ENABLECFOUTPUTONLY="NO">

