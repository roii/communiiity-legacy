
 <cfoutput>
<cfinclude template="qry_myLib.cfm">

	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT ITEM</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
			
			<cfform name="AddmyLib" action="#request.webroot#/administration/act_edit_myLib.cfm" method="post">
			<input type="hidden" name="myLibid" value=#attributes.myLibid#>
			<tr>
			<td style="color:404040;">Title</td>
			<td><cfinput type="text" required="Yes" value="#CurrentmyLib.title#" message="Please enter a title first" name="title" class="whitefield" style="width:350px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Type</td>
			<td>
			<select name="myLibTypeID" class="whitefield" size="1">
			<option value="0">Select a type
			<cfloop query="myLibType">
			  <cfif CurrentmyLib.myLibTypeID EQ myLibType.myLibTypeID>
			    <option value="#myLibType.myLibTypeID#" selected>#myLibType.libType#
			  <cfelse>
			    <option value="#myLibType.myLibTypeID#">#myLibType.libType#
			  </cfif>
			</cfloop>
			</select>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Ages</td>
			<td><cfinput type="text" required="Yes" value="#CurrentmyLib.ages#" message="Please enter minimum age first" name="ages" class="whitefield" style="width:350px; border-color:a0d8e0;"></td>
			</tr>
									
			<tr>
			<td style="color:404040;">Author First Name</td>
			<td><cfinput type="text" required="No" name="author_fn" value="#CurrentmyLib.author_fn#" class="whitefield" style="width:350px; border-color:a0d8e0;"></td>
			</tr>

			<tr>
			<td style="color:404040;">Author Last Name</td>
			<td><cfinput type="text" required="No" name="author_ln" value="#CurrentmyLib.author_ln#" class="whitefield" style="width:350px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Media Type</td>
			<td><cfinput type="text" required="No" name="media_type" value="#CurrentmyLib.media_type#" class="whitefield" style="width:350px; border-color:a0d8e0;"></td>
			</tr>

			<tr>
			<td style="color:404040;">Copies</td>
			<td><cfinput type="text" required="Yes" value="#CurrentmyLib.copies#" message="Please enter number of copies" name="copies" class="whitefield" style="width:350px; border-color:a0d8e0;"></td>
			</tr>
						
			<tr>
			<td style="color:404040;">Display</td>
			<td>
			  Yes <input type="Radio" name="display" value="1" <cfif CurrentmyLib.display EQ 1>checked</cfif>> No <input type="Radio" name="show" value="0" <cfif CurrentmyLib.display EQ 0>checked</cfif>>
			</td>
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