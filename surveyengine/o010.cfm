<CFSETTING ENABLECFOUTPUTONLY="YES">

<cfinclude template="m010.cfm">

<!--- Cold Fusion specific parameters --->
<cfset temppath = gettemplatepath()>

<cfparam name="templatename" default="#listlast(temppath, chr(92))#">
<cfparam name="startrow" default="1">
<cfparam name="endrow" default="1">
<cfparam name="orderby" default="asc">
<cfparam name="orderbycolumn" default="">

<!--- Design specific parameters --->
<cfparam name="recordsperscreen" default="49">
<cfparam name="tableborder" default="border=0">
<cfparam name="tablecellpadding" default="cellpadding=0">
<cfparam name="tablecellspacing" default="cellspacing=0">
<cfparam name="tablebgcolor1" default="##dedede">
<cfparam name="tablebgcolor2" default="##f0f0f0">

<cfset table=tableresponses>

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

<cfoutput>
<font #fontstyle1#>Displaying Record #startrow# - #endrow#. Total number of records: #recordset.recordcount#</font>
<table width="#tablewidth#" cellpadding=0 cellspacing=0 border="#tableborder#">
<tr bgcolor="#bgcolor1#">
<td>&nbsp;</td>
</cfoutput>
	<cfloop index="Index_Column" list="#columns#">
		<cfoutput><td><b><font face="Arial" size="2" style="color:##FFFFFF; text-decoration:none">#Index_Column#</font></b></td></cfoutput>	
	</cfloop>
<cfoutput>
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
		<td width="25">
		<input type="hidden" name="at" value="6">	
		<input type="hidden" name="obj" value="007">
		<input type="hidden" name="id" value="#id#">		
		<input type="hidden" name="itemid" value="#itemid#">
		<input type="hidden" name="formid" value="#formid#">		
       	<input type="Submit" value="   "></td>
        </form>
        </cfoutput>
		<cfloop index="Index_Column" list="#columns#">
			<cfoutput><td><font face="Arial" size="2">#evaluate("recordset.#Index_Column#")#</font></b>&nbsp;</td></cfoutput>	
		</cfloop>
</cfloop>     
  
<cfoutput>
<tr>
<td bgcolor = "#bgcolor4#" colspan="#evaluate(listlen(columns)+1)#">

<table bgcolor = "#bgcolor4#">
<tr>
<td>
	<form action="default.cfm" method="POST">
	<input type="hidden" name="at" value="3">	
	<input type="hidden" name="obj" value="008">
	<input type="hidden" name="id" value="#id#">
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="formid" value="#formid#">
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">
	
	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="1">
	<input type="submit" name="action" value=" |< ">
	</form>
</td>
<td>
	<form action="default.cfm" method="POST">
	<input type="hidden" name="at" value="3">
	<input type="hidden" name="id" value="#id#">		
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="008">
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#startrow#">
	<input type="submit" name="action" value=" < ">
	</form>
</td>
<td>
	<form action="default.cfm" method="POST">
	<input type="hidden" name="at" value="3">	
	<input type="hidden" name="id" value="#id#">	
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="008">	
	<input type="hidden" name="title" value="#title#">
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">
	
	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="text" name="startrow" value="#startrow#" size="3">
	</form>
</td>
<td>
<cfif endrow lt recordset.recordcount>
	<form action="default.cfm" method="POST">
	<input type="hidden" name="at" value="3">	
	<input type="hidden" name="id" value="#id#">	
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="008">
	<input type="hidden" name="title" value="#title#">	
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#endrow#">
	<input type="submit" name="action" value=" > ">
	</form>
</cfif>	
</td>
<td>
<cfif endrow lt recordset.recordcount>
	<form action="default.cfm" method="POST">
	<input type="hidden" name="at" value="3">	
	<input type="hidden" name="id" value="#id#">	
	<input type="hidden" name="formid" value="#formid#">	
	<input type="hidden" name="obj" value="008">
	<input type="hidden" name="title" value="#title#">		
	<input type="hidden" name="datasourceR" value="#datasourceR#">
	<input type="hidden" name="table" value="#table#">
	<input type="hidden" name="columns" value="#columns#">

	<input type="hidden" name="orderbycolumn" value="#orderbycolumn#">
	<input type="hidden" name="orderby" value="#orderby#">
	<input type="hidden" name="startrow" value="#endrow#">
	<input type="submit" name="action" value=" >| ">
	</form>
</cfif>
</td>
</tr></table>

</td>
</tr>
</table>
</cfoutput>

<CFSETTING ENABLECFOUTPUTONLY="NO">

