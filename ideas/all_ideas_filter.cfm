<script language="javascript">
function setvalues(cateallObj)
{
	 if(cateallObj.checked == true)
	 {
			arrChecks = document.filterform.categoryselected;
			for (i=0; i<arrChecks.length; i++)
			 {
				  arrChecks[i].checked = true;
			 } 
	 }
	 else
	 {
			arrChecks = document.filterform.categoryselected;
			for (i=0; i<arrChecks.length; i++)
			 {
				  arrChecks[i].checked = false;
			 }
	 }
}
</script>
<cfif IsDefined("FORM.MainCatID") and FORM.MainCatID neq ''>
	 <cfset MainCatID2 = #FORM.MainCatID#>
<cfelse>
	 <cfset MainCatID2 = 'All'>	 
</cfif> 
<cfoutput> 
<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<form action="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75" method="post" name="filterform" onsubmit="return checkform();">
		<input type="hidden" name="fuseaction" value="#fuseaction#">
		<input type="hidden" name="fusesubaction" value="#fusesubaction#">
		<input type="hidden" name="DocumentID" value="#DocumentID#">	
		
		<input type="hidden" name="MainCatID" id="MainCatID" value="" />
		<!---<tr>
			<td width="100%">
			   <img src="#request.imageroot#/ideaFunL/01_select_cattopic.gif" width="162" height="52" alt="1. SELECT A CATEGORY &amp; TOPIC" border="0">
			</td>
		</tr>--->
		<tr>
			<td align="left" style="padding-right:8px;" nowrap>
			     <input type="submit" value="#search# &gt;&gt;" class="buttonControl" style="cursor: pointer;"><br /> <br /> 
				 <div>
					  <span>#searchkeywordtext#</span><br />
					  <span> 
							<input type="text" maxlength="50" size="30" name="search_keyword" id="search_keyword" value="<cfif IsDefined("FORM.search_keyword") and FORM.search_keyword neq ''>#FORM.search_keyword#</cfif>">
					  </span>
				 </div>
				 <br />
				 <span style="font-size: 17px; font-weight: bold;">
			        <cfoutput>#category#</cfoutput>
			     </span><br /> 
				  
			       <a href="javascript: void(0);" onclick="showhideBoxesAgain('categoryBoxID', 'catimgID');" style="font-weight: bold; text-decoration:none; color: ##91AE4E;"> 
				      <img id="catimgID" src="#request.webroot#/images/toogle-panel-expand.gif" border="0" /> 
				   </a>
			       <cfif isDefined("FORM.MainCatID") and #FORM.MainCatID# eq 'All'>
				        <input type="checkbox" name="categoryallselected" id="categoryallselected" value="All" checked="checked" onclick="setvalues(this);" /> 
				          &nbsp;#allCatTitle#
				   <cfelse>
				        <input type="checkbox" name="categoryallselected" id="categoryallselected" value="All" onclick="setvalues(this);" /> 
				          &nbsp;#allCatTitle#
				   </cfif> 
			      <br />
			    <div style="margin-left: 40px;" id="categoryBoxID">
					 <cfloop query="qry_all_maincats"> 
						<input type="checkbox" name="categoryselected" checked="checked" id="cat_#qry_all_maincats.MainCatID#" value="#qry_all_maincats.MainCatID#" />
						 &nbsp;#TRIM(qry_all_maincats.MainCatTitle)#<br />
		             </cfloop>
				</div>
				 
				 <br /> 
				 
				 <!---<select name="MainCatID" class="whitefield" style="width: 242px;">
					<option value="ALL" selected> -- All Categories -- </option>
					<cfloop query="qry_all_maincats">
						<option value="#qry_all_maincats.MainCatID#">#TRIM(qry_all_maincats.MainCatTitle)#</option>
					</cfloop>
				 </select>--->
			</td>
		</tr>
		<tr>	
			<td>
			   <!--- style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:black;font-weight:bold;font-size:11px;border:0px;"--->
				 <input type="submit" value="#search# &gt;&gt;" class="buttonControl" style="cursor: pointer;">
			</td>
		</tr>	
		</form> 
</table>
</cfoutput>