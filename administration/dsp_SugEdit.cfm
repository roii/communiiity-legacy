
<cfoutput>

<script language="javascript" type="text/javascript" src="datepicker/datetimepicker.js">
</script>


<cfinclude template="qry_manageSug.cfm">

<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">
	<tr>
	<td style="color:white;" width="230"><img src="images/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT SUGGESTION</strong><img src="images/transparent_spc.gif" width="12" height="1"  border="0"></td>
	</tr>
</table>

<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0">
	<tr>
		<td>
			<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
				<tr>
					<td>
						<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
							<tr>
								<td width="140" height="1"><img src="images/transparent_spc.gif" width="140" height="1"  border="0"></td>
								<td></td>			
							</tr>
							<form name="frmEditSug" action="#request.webroot#/administration/act_sugEdit.cfm" method="post">
								<input type="hidden" name="sugID" value="#sugID#">
				<input type="hidden" name="contactID" value="#CurrentSuggestion.contactID#">
							<tr>
								<td style="color:404040;">Date</td>
								<td><input  name="date" type="text" size="25"  value="#CurrentSuggestion.date#" disabled >
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Voting Close Date</td>
								<td><input name="closeDate" id="d#CurrentSuggestion.sugID#" type="text" size="25"  value="#CurrentSuggestion.voteCloseDate#">
								<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.frmEditSug.closeDate);return false;" HIDEFOCUS>
								<img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a>								</td>
							</tr>
							<tr>
								<td style="color:404040;">Rate</td>
								<td><input type="text"  size="25" value="#CurrentSuggestion.rate#" disabled></td>
							</tr>
							<tr>
								<td style="color:404040;">Vote Received</td>
								<td><input type="text"  size="25" value="#CurrentSuggestion.voteReceived#" disabled></td>		
							</tr>
							<tr>
								<td style="color:404040;">By</td>
								<td>
									<input type="text" name="by" value="#CurrentSuggestion.by#" size="25">
								</td>
							</tr>
								<tr>
								<td style="color:404040;">Email</td>
								<td>
									<input type="text" name="email" value="#CurrentSuggestion.email#" size="25">
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Authorise</td>
								<td>
									Yes <input type="Radio" name="authorise" value="yes" <cfif CurrentSuggestion.authorise contains('yes')>checked</cfif>>
									No  <input type="Radio" name="authorise" value="no" <cfif CurrentSuggestion.authorise contains('no')>checked</cfif>>
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Category</td>
								<td>
									<select name="category" size="1">
										<cfloop query="CurrentCategory">
										  <cfif CurrentCategory.CategoryID EQ CurrentSuggestion.CategoryID>
											<option value="#CurrentCategory.CategoryID#" selected>#CurrentCategory.Name# 
										  <cfelse>
											<option value="#CurrentCategory.CategoryID#">#CurrentCategory.Name# 
										  </cfif> 
										</cfloop>
									</select>
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Suggestion</td>
								<td><textarea rows="5" cols="40" name="suggestion">#CurrentSuggestion.suggestion#</textarea></td>
							</tr>
					                <tr>
								<td style="color:404040;">Comments</td>
								<td><textarea rows="5" cols="40" name="comments">#CurrentSuggestion.comments#</textarea></td>
							</tr>				<tr>
								<td colspan="2" style="color:404040;" height="5">
									<hr width="100%" size="1" color="a0d8e0">
								</td>
							</tr>
							<tr>
								<td style="color:404040;"> </td>
								<td><input type="submit" name="subSugEdit" value="SAVE NOW!" ></td>
							</tr>
							</form>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/kidzbiz/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>
</cfoutput>