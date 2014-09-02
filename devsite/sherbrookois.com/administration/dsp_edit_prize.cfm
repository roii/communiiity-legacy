<cfinclude template="qry_prize.cfm">

<cfoutput>


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT PRIZE</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
			
					
			<cfform name="editPrize" action="#request.webroot#/administration/act_edit_prize.cfm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="prizeid" value="#attributes.prizeid#">
			<input type="hidden" name="prizepoolid" value="#attributes.prizepoolid#">
			<tr>
			<td style="color:404040;">Prize Name</td>
			<td><cfinput type="text" required="Yes" value="#CurrentPrize.name#" message="Please enter prize name first" name="name" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">External URL</td>
			<td><cfinput type="text" value="#CurrentPrize.external_url#" name="external_url" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
						
			<tr>
			<td style="color:404040;">Prize Description</td>
			<td>
			<textarea rows="5" cols="35" name="description">#CurrentPrize.description#</textarea>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Prize Image</td>
			<td>
			<cfif CurrentPrize.image neq ''>
			  <img src="#request.webroot#/images/prize/#CurrentPrize.image#">
			</cfif><br>
			<input type="file" name="PrizeImage"></td>
			</tr>

			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>			
			
			<tr>
			<td style="color:404040;"> </td>
			<td><input type="submit" class="whitefield" style="border-color:a0d8e0;" value="SAVE NOW!"></td>
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