<cfoutput>
<link rel="stylesheet" type="text/css" href="#request.webroot#/templates/#session.textsize#.css">
<cfquery name="Clients" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT * from contacts,Kidsurvey,kidclientlinks where contacts.contactid = Kidsurvey.clientid
  and kidclientlinks.clientid = contacts.contactid
  and Kidsurvey.kidid = #attributes.kidsid#
  order by clientstageid desc
</cfquery>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
<form action="#request.webroot#/administration/act_paysurvey.cfm" method="post">	
  <input type="hidden" name="kidid" value="#attributes.kidsid#">
	<tr>
	<td><span class="normal"><b>Name</b></span></td>
	<td><span class="normal"><b>Email</b></span></td>
	<td><span class="normal"><b>Confirmed</b></span></td>
	<td><span class="normal"><b>Paid</b></span></td>
	<td><span class="normal"><b>Pay Now</b></span></td>
	</tr>

	<tr>
	<td colspan="6"><hr width="100%" size="1" color="e2e2e2" noshade></td>
	</tr>
	<cfset i = 0>
	<cfloop query="Clients">	
	
	<tr>
	<td><span class="normal">#FirstName# #LastName#</td>
	<td><span class="normal"><a href="mailto:#EmailAddress#">#EmailAddress#</a></td>
	<td><span class="normal"><cfif clientstageid GT 1>Yes<cfelse>NO</cfif></td>
	<td><span class="normal">
        <cfif clientstageid GT 1>
          <cfif paid EQ 1>Yes<cfelse><font color=red>NO</font>
          </cfif>
        </cfif></td>
	<td align="center"><span class="normal">
	<cfif clientstageid GT 1>
          <cfif paid EQ 0>
            <cfset i = i + 1>
            <input type="checkbox" name="pay#surveyid#" value="1">
          </cfif>
        </cfif>
	</span>
	</td>
	</tr>
	</cfloop>

	<tr>
	<td colspan="6"><hr width="100%" size="1" color="e2e2e2" noshade></td>
	</tr>
	<tr><td colspan="6" align="right">
        <input type="hidden" name="totalunpaid" value="#i#">
	<input type="hidden" name="kids_sortby" value="#attributes.kids_sortby#">
	<input type="hidden" name="sortorder" value="#attributes.sortorder#">
	<input type="submit" name="submit" value="Save Changes">
	</td></tr>
</form>	
	</table>
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>

</table>


</cfoutput>