<cfinclude template="qry_quote.cfm">

<cfoutput>


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="350"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT QUOTE</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
			
					
			<cfform name="editQuote" action="#request.webroot#/administration/act_edit_quote.cfm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="quoteid" value="#attributes.quoteid#">
			<tr>
			<td style="color:404040;">Quote Credit</td>
			<td><cfinput type="text" value="#CurrentQuote.quotecredit#" name="quotecredit" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
						
			<tr>
			<td style="color:404040;">Quote Details</td>
			<td>
			<textarea rows="5" cols="35" name="quotedetails">#CurrentQuote.quotedetails#</textarea>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Who sees it</td>
			<td>
			<input type="radio" name="whoseesit" <cfif CurrentQuote.whoseesit eq 0>checked</cfif> value="0">All&nbsp;&nbsp;
	        <input type="radio" name="whoseesit" <cfif CurrentQuote.whoseesit eq 1>checked</cfif> value="1">Adult&nbsp;&nbsp;
			<input type="radio" name="whoseesit" <cfif CurrentQuote.whoseesit eq 2>checked</cfif> value="2">Youth
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Show/Hide</td>
			<td>
			<input type="radio" name="showhide" <cfif CurrentQuote.display eq 1>checked</cfif> value="1">Show&nbsp;&nbsp;
			<input type="radio" name="showhide" <cfif CurrentQuote.display eq 0>checked</cfif> value="0">Hide
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