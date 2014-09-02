<cfquery name="AllCompanies" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT 	*	
	FROM 	surveyCom 
	order by comName
</cfquery>


<cfif AllCompanies.recordcount GT 0>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0">
	<tr bgColor="a0d8e0">
         <td width="150"><b>Company Name</b></td>
	 <td width="150"><b>Company Contact</b></td>
	 <td width="250"><b>Company Logo</b></td>
	 <td width="250"><b>Email</b></td>
	 <td width="150"><b>Action</b></td>
       </tr>

    <cfoutput query="AllCompanies">
       <tr bgColor="e3f4f6">
         <td width="130">#comname#</td>
	 <td width="130">#comContact#</td>
	 <td width="230"><cfif comlogo neq''><img src="images/#comlogo#"></cfif></td>
	 <td width="230"><a href="mailto:#email#">#email#</a></td>
	 <td width="130">
          [<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=edit_com&comid=#surveyComId#">Edit</a>] |  
          [<a href="#request.webroot#/surveyengine/act_del_com.cfm?comid=#surveyComId#" onclick="return confirm('Are you sure you want to delete this company?')">Delete</a>]</td>
       </tr>
    </cfoutput>
  </table>
</cfif>

 <cfoutput>
 
<br>
<br>
	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>Add New Survey Company</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
			
			<cfform name="AddCom" action="#request.webroot#/surveyengine/act_add_com.cfm" method="post" enctype="multipart/form-data">

			<tr>
			<td style="color:404040;">Company Name</td>
			<td>
			<cfinput type="text" required="Yes" message="Please enter the company name first" name="comName" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
						
			<tr>
			<td style="color:404040;">Company Contact Number</td>
			<td>
			<cfinput type="text" name="comContact" required="No" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Email</td>
			<td>
			<cfinput type="text" name="comEmail" required="No" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Company Logo</td>
			<td>
			<input type="file" name="comLogo">
			</td>
			</tr>

			<tr>
			<td style="color:404040;"> </td>
			<td><input type="submit" class="whitefield" style="border-color:a0d8e0;" value="ADD NOW!"></td>
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