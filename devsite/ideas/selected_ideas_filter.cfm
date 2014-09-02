<cfoutput>
<table width="100%" cellpadding="0" cellspacing="0" border="0">	
					
					<form action="#request.webroot#/index.cfm" method="post">
					<input type="hidden" name="fuseaction" value="#fuseaction#">
					<input type="hidden" name="fusesubaction" value="#fusesubaction#">
					<input type="hidden" name="DocumentID" value="#DocumentID#">	
					<tr>
					<td width="100%"><img src="#request.imageroot#/ideaFunL/01_select_cattopic.gif" width="162" height="52" alt="1. SELECT A CATEGORY &amp; TOPIC" border="0"></td>
					</tr>
					<tr> 
					<td align="left" style="padding-right:8px;" nowrap>
					<span style="color: grey; font-weight: bold; display: block; margin-top: 10px;">Select a Category: </span><br />
					<select name="MainCatID" class="whitefield" style="width: 242px;">
					<option value="ALL"> -- All Categories -- </option>
					<cfloop query="qry_all_maincats">
					<option value="#qry_all_maincats.MainCatID#"<cfif qry_all_maincats.MainCatID EQ session.MainCatID> selected</cfif>>#TRIM(qry_all_maincats.MainCatTitle)#</option>
					</cfloop>
					</select></td>
					</tr>
					<tr>
					<td><input type="submit" value="Change &raquo;" style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:black;font-weight:bold;font-size:11px;border:0px;" class="whitefield"></td>
					</tr>	
					</form>	
					
					</table><br>
</cfoutput>					