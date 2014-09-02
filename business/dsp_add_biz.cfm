<cfoutput>

<cfquery name="Allbizideas" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT bizideaID, biz_idea
FROM bizidea 
RIGHT JOIN bizidea_Type 
ON bizidea.biz_ideatypeID=bizidea_Type.bizideatypeID 
WHERE show = 1 
ORDER BY bizOrder
</cfquery>

<script>
function ShowHideView(AddBiz){ 

var temp_0 = "FL1";

if (document.AddBiz.bizIdeaID.selectedIndex == 0) { 

	alert("You must select a business type.");
	AddBiz.bizIdeaID.focus();
	return;
	

}
else if (document.AddBiz.bizIdeaID.selectedIndex == 1) { 
	
	document.getElementById(temp_0).style.visibility='visible'; 

	if (navigator.appName == 'Microsoft Internet Explorer') {
	document.getElementById(temp_0).style.position ='fixed'; 
	}
	else {
	document.getElementById(temp_0).style.position ='relative'; 
	}			

} 
else { 

document.getElementById(temp_0).style.visibility='hidden'; 
document.getElementById(temp_0).style.position ='absolute'; 
} 

} 
</script>

<strong>Add a New Business</strong><br><br>


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

	
			<form name="AddBiz" action="#request.webroot#/business/act_add_biz.cfm" method="post">
	
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Type Of Business</td>
			<td><select name="bizIdeaID" style="width:250px;" class="whitefield" onchange="javascript:ShowHideView(AddBiz);">
			<option value="0">Select a business type...
			<option value="0">Other / Custom
			<cfloop query="Allbizideas">
			<option value="#Allbizideas.BizIdeaID#">#TRIM(Allbizideas.biz_idea)#
			</cfloop>
			</select>
			</tr>
			
			</table>
			
			
		<div id="FL1" style="position:absolute; border-style:none; Z-INDEX: FL; visibility:hidden;">	
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Business Name<br>
			<em>(max 25 characters)</em></td>
			<td><input type="text" name="bizName" class="whitefield" style="width:250px;"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
						
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Business Description<br>
			<em>(max 200 characters)</em></td>
			<td><textarea name="bizDescription" style="width:250px;" rows="6"></textarea>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			</table>
			
		</div>
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Date Created</td>
			<td><input type="text" name="dateCreated" required="Yes" class="whitefield" validate="eurodate" message="You didn't enter the correct date format" style="width:250px;" value="#DateFormat(localDateTime, "dd/mm/yyyy")#"> <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.AddBiz.dateCreated);return false;" HIDEFOCUS><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0"></a></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>

			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/add_button.gif" title="ADD NOW!"> <a href="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentid=47"><img src="#request.imageroot#/cancel_button.gif" width="86" height="19" alt="CANCEL" border="0"></a></td>
			</tr>
			</form>
			
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