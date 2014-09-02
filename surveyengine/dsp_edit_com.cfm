<cfparam name="attributes.comid" default="">

<cfquery name="ComDetails" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT 	*	
	FROM 	surveyCom 
 	where surveycomid = #attributes.comid#
</cfquery>


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
			
			<cfform name="AddCom" action="#request.webroot#/surveyengine/act_edit_com.cfm" method="post" enctype="multipart/form-data">

			<tr>
			<td style="color:404040;">Company Name</td>
			<td>
			<cfinput type="text" required="Yes" value="#ComDetails.comname#" message="Please enter the company name first" name="comName" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
						
			<tr>
			<td style="color:404040;">Company Contact Number</td>
			<td>
			<cfinput type="text" name="comContact" value="#ComDetails.comcontact#" required="No" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Email</td>
			<td>
			<cfinput type="text" name="comEmail" value="#ComDetails.email#" required="No" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Company Logo</td>
			<td>
			<img src="images/#ComDetails.comLogo#" width="130" height="80"><br>
			<input type="file" name="comLogo">
			</td>
			</tr>

			<tr>
			<td style="color:404040;"> </td>
			<td>
			<input type="hidden" name="surveyComId" value="#ComDetails.surveyComId#">
			<input type="submit" class="whitefield" style="border-color:a0d8e0;" value="SAVE NOW!"></td>
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