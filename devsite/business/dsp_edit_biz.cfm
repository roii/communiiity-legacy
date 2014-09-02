<cfoutput>

<cfquery name="Allbizideas" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT bizideaID, biz_idea
FROM bizidea 
RIGHT JOIN bizidea_Type 
ON bizidea.biz_ideatypeID=bizidea_Type.bizideatypeID 
WHERE show = 1
</cfquery>

<cfquery name="BusinessDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT Business.*, bizKidsLink.DateCreated
FROM Business, bizKidsLink
WHERE bizKidsLink.bizkidslinkID=#bizkidslinkID#
AND bizKidsLink.bizid=business.bizID
</cfquery>



<strong>Edit Your Business</strong><br><br>


<table cellSpacing="1" cellPadding="0" bgColor="##b4b4b4" border="0" width="100%">

	<tr>
	<td>
	
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>
		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr> 

	
			<cfform name="AddBiz" action="#request.webroot#/business/act_edit_biz.cfm" method="post">
			
			<input type="hidden" name="BizID" value="#BusinessDetails.BizID#">
			<input type="hidden" name="bizkidslinkID" value="#bizkidslinkID#">
			
			<cfif IsDefined("DocumentID")>
				<input type="hidden" name="DocumentID" value="#DocumentID#">
			</cfif>
			
			<cfif BusinessDetails.BizIdeaID EQ 0>
				
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Link to a business template</td>
			<td><select name="bizIdeaID" style="width:250px;" class="whitefield">
			<option value="0">Select a template (if applicable)...
			<cfloop query="Allbizideas">
			<option value="#Allbizideas.BizIdeaID#">#TRIM(Allbizideas.biz_idea)#
			</cfloop>
			</select>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<cfelse>
			
				<input type="hidden" name="bizIdeaID" value="#BusinessDetails.BizIdeaID#">
			
			</cfif>
			
				
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Business Name<br>
			<em>(max 50 characters)</em></td>
			<td><input type="text" name="bizName" class="whitefield" style="width:250px;" value="#TRIM(BusinessDetails.bizName)#" maxlength="50"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
						
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Business Description<br>
			<em>(max 200 characters)</em></td>
			<td><textarea name="bizDescription" style="width:250px;" rows="6" class="whitefield">#TRIM(BusinessDetails.bizDescription)#</textarea>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Business Status</td>
			<td><input type="radio" name="bizStatus" class="whitefield" value="Active"<cfif TRIM(BusinessDetails.BizStatus) EQ 'Active'> checked</cfif>> Active &nbsp; <input type="radio" name="bizStatus" class="whitefield" value="InActive"<cfif TRIM(BusinessDetails.BizStatus) EQ 'InActive'> checked</cfif>> Inactive
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Date Created (dd/mm/yyyy)</td>
			<td><cfinput type="text" name="dateCreated" required="Yes" class="whitefield" validate="eurodate" message="You didn't enter the correct date format" style="width:250px;" value="#DateFormat(businessdetails.DateCreated, "dd/mm/yyyy")#"> <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.AddBiz.dateCreated);return false;" HIDEFOCUS><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0"></a></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>

			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/update_button.gif" title="ADD NOW!"> <a href="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentid=47"><img src="#request.imageroot#/cancel_button.gif" width="86" height="19" alt="CANCEL" border="0"></a></td>
			</tr>
			</cfform>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>
<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/business/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>
</cfoutput>