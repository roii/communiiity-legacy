<cfif not isdefined("attributes.surveyID")>
<script>
alert("Please go to Add/Edit survey first!");
self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_survey&at=1";
</script>
</cfif>

<cfparam name="attributes.surveyid" default="">
<cfparam name="attributes.wizard" default="on">

<cfquery name="AllTerms" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * FROM surveyTerms where formid=#attributes.surveyid# order by termid asc
</cfquery>


<cfif AllTerms.recordcount GT 0>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0">
	<tr bgColor="a0d8e0">
         <td width="150"><b>Term Number</b></td>
	 <td width="150"><b>Term</b></td>
	 <td width="250"><b>Image</b></td>
	 <td width="150"><b>Action</b></td>
       </tr>
    <cfset i=1>
    <cfoutput query="AllTerms">
       <tr bgColor="e3f4f6">
         <td width="130">#i#</td>
	 <td width="130">#Term#</td>
	 <td width="230">
		<cfif imageLoc neq ''>
		  <img src="Images/#imageLoc#">
		</cfif>
	 </td>
	 <td width="130">
          [<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=edit_term&termid=#termId#&surveyid=#attributes.surveyid#&at=4">Edit</a>] |  
          [<a href="#request.webroot#/surveyengine/act_del_term.cfm?termid=#termId#&surveyID=#attributes.surveyid#">Delete</a>]</td>
       </tr>
	<cfset i=i+1>
    </cfoutput>
  </table>
</cfif>

 <cfoutput>
 
<br>
<cfif attributes.wizard eq 'on'>
<TABLE class="reg">
  <TR>
    <TD WIDTH="100%" CLASS="steps">
      <IMG BORDER="0" SRC="#request.webroot#/images/1off.gif" align="absmiddle">&nbsp;   
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_survey&at=1">Add Survey</a>&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp;            
      <IMG BORDER="0" SRC="#request.webroot#/images/2on.gif" align="absmiddle">&nbsp; 
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_term&surveyid=#attributes.surveyID#&at=4">Add Terms</a>&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/3off.gif" align="absmiddle">&nbsp;            
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_Q&surveyid=#attributes.surveyID#&at=5">Add Questions</a> &nbsp;
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/4off.gif" align="absmiddle">&nbsp;            
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=survey_page&surveyid=#attributes.surveyID#&at=1">Complete Survey</a>
      </TD>           
  </TR>
</table>
</cfif>
<br>
	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>Terms and Conditions</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	</tr>
	</table>
	
	<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<cfform name="AddTerm" action="#request.webroot#/surveyengine/act_add_terms.cfm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="wizard" value="#attributes.wizard#">

			<tr>
			<td style="color:404040;">Term</td>
			<td>
			<textarea name="Term" cols="30" rows="3"></textarea></td>
			</tr>
						
			<tr>
			<td style="color:404040;">Image</td>
			<td>
			<input type="file" name="termImage"></td>
			</tr>
			

			<tr>
			<td style="color:404040;"> </td>
			<td>
			<input type="hidden" name="surveyid" value="#attributes.surveyid#">
			<input type="submit" class="whitefield" style="border-color:a0d8e0;" value="Add Term"></td>
			</tr>
			</cfform>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>
</cfoutput>