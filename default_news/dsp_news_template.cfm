<cfoutput>

<script>

<!--
	function confirmNewsDelete(aURL) {
	    if(confirm('Are you sure you want to delete this News Article?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>


<cfset newdetails='#Headlines.details#'>


<table border="0" cellpadding="0" cellspacing="2" width="100%">
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
<td class="page_header" width="100%">#TRIM(Headlines.Title)#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_news_edit.cfm?newsID=#newsID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#" target="editNews" ONCLICK="fdbackwindow=window.open ('','editNews','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Article" border="0"></a>&nbsp;<a href="javascript:confirmNewsDelete('#request.webroot#/admin/act_news_delete.cfm?newsID=#newsID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></cfif></td>
</tr>


<tr>
<td colspan="2"><span class="small" style="color:gray;">Posted: #DateFormat(Headlines.ReleasedDate, "d mmmm yyyy")#</span><br><br>
<cfif #TRIM(Headlines.introduction)# NEQ ''>
<span class="page_introduction"><strong>#TRIM(Headlines.introduction)#</strong></span><br><br>
</cfif>

<cfif #TRIM(newdetails)# NEQ ''>
<span class="normal">#TRIM(newdetails)#</span>
</cfif></td>
</tr>

</table>

</cfoutput>