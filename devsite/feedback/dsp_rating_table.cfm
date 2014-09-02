<cfoutput>

<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Feedback_StartRow" default="1">
</cflock>

<cfif isdefined("Feedback_StartRow")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.Feedback_StartRow = Feedback_StartRow>
	</cflock>
</cfif>


<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Feedback_MaxRows" default="50">
</cflock>

<cfif isdefined("Feedback_MaxRows")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.Feedback_MaxRows = Feedback_MaxRows>
	</cflock>
</cfif>




<!--- SET THE Feedback_endrow VALUE --->
<cfif session.Feedback_MaxRows NEQ 'ALL'>

	<cfif AllFeedback.RecordCount GT (session.Feedback_StartRow + session.Feedback_MaxRows) - 1>
		<cfset Feedback_endrow = session.Feedback_StartRow + session.Feedback_MaxRows-1>
	<cfelse>
		<cfset Feedback_endrow = AllFeedback.RecordCount>
	</cfif>

<cfelse>
	<cfset Feedback_endrow = AllFeedback.RecordCount>

</cfif>


<!--- SET THE PREV VALUE --->
<cfif session.Feedback_Startrow GT session.Feedback_Maxrows>
	<cfset prev = session.Feedback_Startrow - session.Feedback_Maxrows>
<cfelse>
	<cfset prev = session.Feedback_StartRow>
</cfif>


<!--- SET THE NEXT VALUE --->
<cfif Feedback_endrow LT AllFeedback.RecordCount>
	<cfset next = (Feedback_endrow + 1)>
<cfelse>
	<cfset next = session.Feedback_StartRow>
</cfif>



<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.Feedback_MaxRows NEQ 'ALL'>
	<cfset NumberCount=(AllFeedback.RecordCount / session.Feedback_Maxrows)>
	<cfset FeedbackNumberCount = Ceiling(NumberCount)>
<cfelse>
	<cfset FeedbackNumberCount=1>
</cfif>

	
<table width="100%" cellspacing="0" cellpadding="0">

<tr>
<td height="1" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td style="padding:5px;">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="50%" style="font-size:14px;color:###TRIM(AllSettings.DkTextColor)#;"><strong>RATINGS AND FEEDBACK</strong></td>
	<td width="50%" align="right"><cfloop from="1" to="#wholestars#" index="loopcount"><img src="#request.imageroot#/feedback_redstar_large.gif" width="30" height="31" alt="Average Rating: #DecimalFormat(feedback_average)#" border="0" align="absmiddle"></cfloop><cfif halfstars EQ 1><img src="#request.imageroot#/feedback_half_redstar_large.gif" width="30" height="31" alt="Average Rating: #DecimalFormat(feedback_average)#" border="0" align="absmiddle"></cfif></td>
	</tr>
	
	</table>

</td>
</tr>

<tr>
<td height="1" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="25">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="50%" style="font-size:11px;color:###TRIM(AllSettings.DkTextColor)#;">Rated by <strong>#AllFeedback.RecordCount#</strong> members. &nbsp;&nbsp;&nbsp; Displaying #session.Feedback_Startrow# - #Feedback_endrow#</td>
	<td align="right" style="font-size:11px;color:###TRIM(AllSettings.DkTextColor)#;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Feedback_maxrows=20&Feedback_StartRow=1&BizideaID=#BizideaID#&documentID=#DocumentID#" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Feedback_maxrows=50&Feedback_StartRow=1&BizideaID=#BizideaID#&documentID=#DocumentID#" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Feedback_maxrows=100&Feedback_StartRow=1&BizideaID=#BizideaID#&documentID=#DocumentID#" style="color:###TRIM(AllSettings.BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Feedback_maxrows=ALL&Feedback_StartRow=1&BizideaID=#BizideaID#&documentID=#DocumentID#" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
	</td>
	</tr>
	
	</table>
	
</td>
</tr>

<tr>
<td height="1" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td style="padding:5px;">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td height="1" width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1"  border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1"  border="0"></td>
	<td width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1"  border="0"></td>
	</tr>
	
	<cfloop query="AllFeedback">
	<cfset this_ContactID = AllFeedback.ContactID>
	<cfset this_Contact = AllFeedback.Screenname>
	<cfset this_date = AllFeedback.Feedback_date>
	<cfset this_details = AllFeedback.Feedback_details>
	<cfset this_rating = AllFeedback.Feedback_rating>
	
	
	<tr>
	<td valign="top" align="center" style="padding-top:2px;"><cfloop from="1" to="#this_rating#" index="loopcount"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" border="0" align="absmiddle"></cfloop></td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(this_contactID)#" style="font-size:14px;color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(this_contact)#</strong></a></td>
	<td valign="top" align="right" style="font-size:12px;color:###TRIM(AllSettings.BoxColour)#;">#DateFormat(AllFeedback.Feedback_Date)#</td>
	</tr>
	
	<tr>
	<td></td>
	<td colspan="2">#TRIM(this_details)#</td>
	</tr>
	
	<tr>
	<td colspan="3" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="8"  border="0"></td>
	</tr>
	
	
	<cfif AllFeedback.CurrentRow NEQ AllFeedback.RecordCount>
	
		<tr>
		<td colspan="3" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1"  border="0"></td>
		</tr>
		
		<tr>
		<td colspan="3" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="8"  border="0"></td>
		</tr>
	
	</cfif>
	
	</cfloop>
	
	

	<tr>
	<td colspan="3" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="8"  border="0"></td>
	</tr>	

	<tr>
	<td height="1" bgcolor="###TRIM(AllSettings.DkTextColor)#" colspan="3" ><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="4"  border="0"></td>
	</tr>
	
	</table>
	
	<div align="right"><cfif session.Feedback_Startrow GT session.Feedback_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Feedback_Startrow=#prev#">Prev Page</a> | </cfif><cfif Feedback_endrow LT AllFeedback.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Feedback_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Feedback_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#FeedbackNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Feedback_Maxrows * NumberCount - session.Feedback_Maxrows + 1)><cfif thisStartRow EQ session.Feedback_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Feedback_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Feedback_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ FeedbackNumberCount> - </cfif></cfloop></cfif></div>

</td>
</tr>

</table>

</cfoutput>