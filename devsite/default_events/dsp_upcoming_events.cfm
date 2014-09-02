<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To display specific article details from the qry_article_details recordset</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<in>
	<recordset name="articleDetails" format="CFML" Scope="variables" primarykeys="articleID">
</in>

</fusedoc>

 --->
 
 
 <cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
		<!--
	function confirmSectionDelete(aURL) {
	    if(confirm('Deleting a Section also deletes all linked Documents, Articles and SubArticles. Are you sure you want to delete this Section?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmEventDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Event?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmEventCatDelete(aURL) {
	    if(confirm('Deleting an Event Category also deletes any linked Events. Are you sure you want to delete this Event Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>


<table border="0" cellpadding="0" cellspacing="2" width="100%">
 <cfoutput>		
<tr>
<td class="section_header" width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#TRIM(sectiondetails.fuseaction)#" style="text-decoration:none; color:black;"><cfif #session.textonly# EQ 'yes'>#SectionDetails.Title#<cfelse><img src="#request.imageroot#/title_#TRIM(sectiondetails.fuseaction)#.gif" border="0"></cfif></a></td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a><cfif #sectionDetails.Admin# EQ 1>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/admin/act_section_delete.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&sectionType=documenthandling')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Section" border="0"></a></cfif></cfif></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>	

<tr>
<td bgcolor="676767" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>	

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>	


<tr>
<td class="page_header" width="100%">#UCASE(DocumentDetails.Title)#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Document" border="0"></a>&nbsp;<a 
	href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Document" border="0"></a></cfif></td>
</tr>



<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br> <a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>&eventmode=archive" style="color:blue;">>> Click here</a> to view archived events and event summaries
<hr width="100%" size="1" color="e2e2e2">
</td>
</tr>


</cfoutput>

<!--- DISPLAY EVENTS --->
<tr>
<td><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0">

	<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<cfoutput>
		<tr>
		<td class="small" colspan="2"><a href="#request.webroot#/admin/dsp_eventCat_add.cfm?fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="addEventCat" ONCLICK="fdbackwindow=window.open ('','addEventCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=235,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A CATEGORY »</strong></a> &nbsp;&nbsp;&nbsp; <a href="#request.webroot#/admin/dsp_event_add.cfm?fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="addEvent" ONCLICK="fdbackwindow=window.open ('','addEvent','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD AN EVENT »</strong></a><br><br></td>
		</tr>
		</cfoutput>
	</cfif>
	
	<cfoutput query="EventsReturn" group="EventCatID">

	<cfinclude template="../default_events/qry_upcoming_events.cfm">

	<cfif (#EventDetails.recordcount# GT 0) OR (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<tr>
		<td><ul class="normal"><cfif #session.textonly# EQ 'yes'><li class="normal" style="color:black;"><cfelse><li class="normal" style="color:FF3300;"></cfif><a href="###EventCatName#" style="color: gray; text-decoration: none;">#EventCatName#</a></td>
		<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<td align="right"><a href="#request.webroot#/admin/dsp_eventcat_edit.cfm?EventCatID=#EventCatID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="editEventCat" ONCLICK="fdbackwindow=window.open ('','editEventCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=230,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Category" border="0"></a> <a href="javascript:confirmEventCatDelete('#request.webroot#/admin/act_EventCat_delete.cfm?EventCatID=#EventCatID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></td>
		</cfif>
		</tr>

	</cfif>

	</cfoutput>

	</table><br>
	<cfoutput><img src="#request.imageroot#/transparent_spc.gif" width="5" height="6"  border="0"></cfoutput><br>




<cfoutput query="EventsReturn" group="EventCatID">

<cfinclude template="../default_events/qry_upcoming_events.cfm">

<cfif #EventDetails.RecordCount# GT 0>
<a name="#EventCatName#"> </a>

<table width="100%" cellpadding="0" cellspacing="2" border="0">

<tr>
<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="FF3300"</cfif> width="17">

	
	
	<table width="17" cellpadding="1" cellspacing="0" border="0">
	
	<tr>
	<td><font face="WebDings" size="2" color="White"><strong>4</strong></font></td>
	</tr>
	
	</table>
	
	
	
</td>
<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="#TRIM(sectionDetails.barColor)#"</cfif>>

		
	
	<table width="100%" cellpadding="1" cellspacing="0" border="0">
	
	<tr>
	<td width="5"><img src="#request.imageroot#/transparent_spc.gif" width="5" height="1"  border="0"></td>
	<td><span style="color:white; letter-spacing:.5em;"><b>#UCASE(EventCatName)#</b></span></td>
	</tr>
	
	</table>
	
	
	
</td>
</tr>
		
			
<tr>
<td>&nbsp;</td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="12" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
	<cfloop query="EventDetails" startrow="1">
	<tr>
	<td width="5"><img src="#request.imageroot#/transparent_spc.gif" width="5" height="1" border="0"></td>
	<td class="normal"><a name="#EventDetails.EventTitle#">&nbsp;</a><strong>#DateFormat(EventDetails.StartDate, "d mmmm")# <cfif EventDetails.enddate neq ''>- #DateFormat(EventDetails.EndDate, "d mmmm yyyy")#</cfif></strong><br>
	<cfif #TRIM(EventDetails.Venue)# NEQ ''>&nbsp;#TRIM(EventDetails.Venue)#</cfif><br>



&nbsp;<a href="#request.webroot#/default_events/dsp_event_details.cfm?EventID=#EventID#" target="feedback" ONCLICK="fdbackwindow=window.open ('','feedback','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=500,top=10,left=10')" style="color:blue;"><b>#EventDetails.EventTitle#</b></a></span><br><br>
	</td>
	<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
	<td width="28" align="center" class="normal" valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"><br><img src="#request.imageroot#/icon_permissions.gif" width="7" height="15" alt="<cfif #EventDetails.NonMember# EQ 1>Public</cfif> | <cfif #EventDetails.member# EQ 1>Member</cfif>" border="0"></td>
	<td align="right" valign="top" width="28"><a href="#request.webroot#/admin/dsp_event_edit.cfm?eventID=#EventDetails.eventID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="editNews" ONCLICK="fdbackwindow=window.open ('','editNews','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Event" border="0"></a> <a href="javascript:confirmEventDelete('#request.webroot#/admin/act_event_delete.cfm?EventID=#EventID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Event" border="0"></a><br><a href="#request.webroot#/admin/act_whatnew_add.cfm?type=event&fuseaction=#attributes.fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif><cfif IsDefined("attributes.SubArticleID")>&SubArticleID=#attributes.SubArticleID#</cfif>&EventID=#EventID#"><img src="#request.imageroot#/butt_whatnew_add.gif" width="24" height="10" alt="Add to Whats New" border="0"></a></td>
	</cfif>
	</tr>
	</cfloop>
		
		
	
	</table>

	
</td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
</tr>
	
</table>
</cfif>
</cfoutput>


</td>
</tr>

</table>




