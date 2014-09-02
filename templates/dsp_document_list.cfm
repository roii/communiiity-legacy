<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To display all records retreived from the qry_linked_documents query</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<in>
	<recordset name="AllDocuments" format="CFML" Scope="variables" primarykeys="DocumentID" onCondition="alldocuments.recordcount GT 0">
</in>

</fusedoc>

 --->

<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmDocumentDelete(aURL) {
	    if(confirm('<cfoutput>#alertdoclist1#</cfoutput>\n<cfoutput>#alertdoclist2#</cfoutput>')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>
 
	 

<cfif IsDefined("AllDocuments")> 
   <cfif (AllDocuments.recordcount) OR ((session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator'))>
	
	
		
		<cfoutput>
		<br>
		<table width="100%" cellpadding="0" cellspacing="2" border="0">
		
		
		<tr>
		<td bgcolor="###TRIM(AllSettings.BoxColour)#">
			
			<table width="100%" cellpadding="2" cellspacing="0" border="0">
		
			<tr>
			<td height="22" style="color:###TRIM(AllSettings.BoxTextColour)#;font-face:Trebuchet MS;font-size:12px;">&nbsp;<b>#futherInf#</b></td>
			</tr>
			
			</table>
		
		</td>
		</tr>
		
		</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	
	
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
	<!--- IF LOGGED IN AS ADMINISTRATOR --->	
		
		<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
		<tr class="searchresults" onmouseover="this.className='searchresultson';" onmouseout="this.className='searchresults';">
		<td class="normal" valign="top" align="right" width="20"><li style="color:###TRIM(AllSettings.BoxColour)#;"></td>
		<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		<td class="small" valign="top"><a href="#request.webroot#/admin/dsp_document_add.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="addDoc" ONCLICK="fdbackwindow=window.open ('','addDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>#addlevel2doctxt# »</strong></a></td>
		<td width="40"> </td>
		<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
		</tr>
		</cfif>	
		
		<cfloop query="AllDocuments">
		<tr class="searchresults" onmouseover="this.className='searchresultson';" onmouseout="this.className='searchresults';">
		<td class="normal" valign="top" align="right" width="20"><li></td>
		<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		<td class="normal" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=docs&documentid=#documentID#"  style="color:666666; text-decoration:none;">
		        <cfset repTitle = replace(#Title#, " ", "", "ALL")>
		        <cfif #repTitle# eq "myPointsaccount">
				       #myPointsaccount#
				<cfelseif #repTitle# eq "myCashaccount">
				       #myCashaccount#
				<cfelseif #repTitle# eq "myEducationaccount">
				       #myEducationaccount#
				<cfelseif #repTitle# eq "Moneymanagement">
				       #Moneymanagement#
				<cfelseif #repTitle# eq "Howitworks">
				       #Howitworks#
				<cfelseif #repTitle# eq "PurchasePoints">
				       #purchasepts#
				<cfelse>
				       #Title#	   	   	   	   	   	   
				</cfif>
		</a></td>
		<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
		<td width="40" class="small" align="right"><cfif (#TRIM(AllDocuments.DocExpireDate)# NEQ '') AND (#DateCompare(AllDocuments.DocExpireDate, localDateTime)# EQ -1)>Expired</cfif></td>
		<td width="40" class="small" align="right"><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#" target="editDoc" onclick="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Document" border="0"></a> <!---<cfif #alldocuments.allowdelete# EQ 1><a 
		href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Document" border="0"></a></cfif>---></td>
		</cfif>
		</tr>
		</cfloop>
	
		</table><br>
		
		</cfoutput>
	
	</cfif> 
<cfelse> 
      <table width="100%" cellpadding="0" cellspacing="2" border="0">
	      <tr>
		       <td>
			         <strong>No Records found</strong>
			   </td>
		  </tr>
	  </table> 
</cfif> 	 