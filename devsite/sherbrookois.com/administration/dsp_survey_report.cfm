<cfoutput>

<cfparam name="kids_sortby" default="kidsurvey.kidID">
<cfparam name="sortorder" default="ASC">
<cfparam name="deletedmode" default="hide">



<cfinclude template="qry_survey.cfm">


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>SURVEY REPORT</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">

<hr width="100%" size="1" color="b4b4b4">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=lastname&sortorder=<cfif sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Kids Name</strong></a></td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=emailaddress&sortorder=<cfif sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Email</strong></a></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=ClientCount&sortorder=<cfif sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>No. of Clients surveyed</strong></a></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=ClientCount&sortorder=<cfif sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"></a><strong>Total Confirmed</strong></td>	
	<td align="center"><strong>Confirm Rate</strong></td>	
	<td align="center"><strong>All Paid ?</strong></td>	
	<td align="right">&nbsp;</td>
	</tr>
	
	<tr>
	<td colspan="7"><hr width="100%" size="1" color="b4b4b4"></td>
	</tr>
	
	
        <cfset totalsurveyed = 0>
        <cfset totalconfirmed = 0>
        <cfset avgconfirmRate = 0>

	<cfloop query="AllKidSurvey">
	<cfquery name="didSurvey" datasource="#dsn#" username="#request.username#" password="#request.password#">
          select * from kidsurvey where kidid = #Allkidsurvey.kidid#
	</cfquery>

	<cfquery name="NoClientConfirmed" datasource="#dsn#" username="#request.username#" password="#request.password#">
          select kidsurvey.paid
	  from kidsurvey inner join kidclientlinks on kidclientlinks.clientid = kidsurvey.clientid
	  inner join contacts on contacts.contactid = kidsurvey.kidid
	  where kidclientlinks.clientstageid = 2 and kidsurvey.kidid = #Allkidsurvey.kidid#
        </cfquery>
        <cfset paidkid = "No">
	<cfloop query="NoClientConfirmed">
           <cfif NoClientConfirmed.paid EQ 0>
             <cfset paidkid = "No"><cfbreak>
           <cfelse>
             <cfset paidkid = "Yes">
           </cfif>
        </cfloop>

        <cfset totalsurveyed = totalsurveyed + didSurvey.recordcount>
	<cfset totalconfirmed = totalconfirmed + NoClientConfirmed.recordcount>
	<tr>
	<td><a href="#request.webroot#/admin/dsp_kid_edit.cfm?contactID=#kidid#&caller=survey_report" target="editContact" ONCLICK="fdbackwindow=window.open ('','editContact','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')">#LastName#, #FirstName#</a></td>
	<td><a href="mailto:#emailaddress#">#emailaddress#</a></td>
	<td align="center"><a href="#request.webroot#/administration/dsp_kid_surveyclients.cfm?kidsID=#kidID#&kids_sortby=#kids_sortby#&sortorder=#sortorder#" target="KidsClients" ONCLICK="fdbackwindow=window.open ('','KidsClients','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=550,top=10,left=10')">#didSurvey.recordcount#</a></td>
	<td align="center">#NoClientConfirmed.recordcount#</td>
        <cfif NoClientConfirmed.recordcount GT 0>
        <cfset rate = NoClientConfirmed.recordcount / AllKidSurvey.clientcount * 100>
        <cfelse>
        <cfset rate = 0>
        </cfif>
        <cfset avgconfirmRate = avgconfirmRate + rate>
	<td align="center">#decimalformat(rate)#%</td>
	<td align="center"><cfif NoClientConfirmed.recordcount GT 0><cfif paidkid EQ "No"><font color=red></cfif>#paidkid#</font></cfif></td>
	<td align="right"><a href="#request.webroot#/admin/dsp_kid_edit.cfm?contactID=#kidID#" target="editContact" ONCLICK="fdbackwindow=window.open ('','editContact','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Kid" border="0"></a></td>
	</tr>
	
	</cfloop>


	<tr>
	<td colspan="7"><hr width="100%" size="1" color="b4b4b4" noshade></td>
	</tr>

	<tr>
	<td><b>Total:</b></td>
	<td>&nbsp;</td>
	<td><b>#totalsurveyed#</b></td>
	<td><b>#totalconfirmed#</b></td>
	<cfset avgconfirmRate = totalconfirmed / totalsurveyed * 100>
	<td align="center"><b>#decimalformat(avgconfirmRate)#%</b></td>
	<td>&nbsp;</td>
	</tr>
	
	</table>
	
	<hr width="100%" size="1" color="b4b4b4">

</td>
</tr>

</table>


</cfoutput>