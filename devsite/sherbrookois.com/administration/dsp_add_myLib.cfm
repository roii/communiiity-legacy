
 <cfoutput>
<cfinclude template="qry_myLib.cfm">

	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>ADD A NEW ITEM TO myLibrary</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
			
			<cfform name="AddmyLib" action="#request.webroot#/administration/act_add_myLib.cfm" method="post">
			
			<tr>
			<td style="color:404040;">Title</td>
			<td><cfinput type="text" required="Yes" message="Please enter a title first" name="title" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Type</td>
			<td>
			<select name="myLibTypeID" class="whitefield" size="1">
			<option value="0">Select a type
			<cfloop query="myLibType">
			  <option value="#myLibType.myLibTypeID#">#myLibType.libType#
			</cfloop>
			</select>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Ages</td>
			<td><cfinput type="text" required="Yes" message="Please enter minimum age first" name="ages" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
									
			<tr>
			<td style="color:404040;">Author First Name</td>
			<td><cfinput type="text" required="No" name="author_fn" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>

			<tr>
			<td style="color:404040;">Author Last Name</td>
			<td><cfinput type="text" required="No" name="author_ln" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Media Type</td>
			<td><cfinput type="text" required="No" name="media_type" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>

			<tr>
			<td style="color:404040;">Copies</td>
			<td><cfinput type="text" required="Yes" message="Please enter number of copies" name="copies" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
						
			<tr>
			<td style="color:404040;">Display</td>
			<td>
			  Yes <input type="Radio" name="display" value="1" checked> No <input type="Radio" name="show" value="0">
			</td>
			</tr>
			
			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
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