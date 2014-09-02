<cfparam name="attributes.termid" default="">

<cfquery name="TermDetails" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * FROM surveyTerms where formid=#attributes.surveyid# and termid = #attributes.termid#
</cfquery>


 <cfoutput>
 
<br>
<br>
	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>Edit Term</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
			
			<cfform name="AddTerm" action="#request.webroot#/surveyengine/act_edit_term.cfm" method="post" enctype="multipart/form-data">

			<tr>
			<td style="color:404040;">Term</td>
			<td>
			<textarea name="Term" cols="30" rows="3">#TermDetails.Term#</textarea></td>
			</tr>
						
			<tr>
			<td style="color:404040;">Image</td>
			<td>
			<cfif TermDetails.imageLoc neq ''>
			  <img src="images/#TermDetails.imageLoc#"><br>
			</cfif>
			<input type="file" name="termImage"></td>
			</tr>
			

			<tr>
			<td style="color:404040;"> </td>
			<td>
			<input type="hidden" name="surveyid" value="#attributes.surveyid#">
			<input type="hidden" name="termid" value="#attributes.termid#">
			<input type="submit" class="whitefield" style="border-color:a0d8e0;" value="Save Term"></td>
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