 <cfoutput>
ddd
 
 <cfset newdetails = DocumentDetails.details>



		
<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmSectionDelete(aURL) {
	    if(confirm('Deleting a Section also deletes all linked Documents, Articles and SubArticles.\nAre you sure you want to delete this Section?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
	<script language="JavaScript">
	<!--
	function confirmDocumentDelete(aURL) {
	    if(confirm('Deleting a Document also deletes all linked Articles and SubArticles.\nAre you sure you want to delete this Document?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
</cfif>
 


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(DocumentDetails.Title))#</strong></td>
<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=550,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit" border="0"></a>&nbsp;<a href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete" border="0"></a></cfif></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>




<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<cfif TRIM(newdetails) NEQ '' AND TRIM(newdetails) NEQ '<P>&nbsp;</P>'>
	<tr>
	<td colspan="2">#newdetails#</td>
	</tr>
</cfif>


</table>

</cfoutput>