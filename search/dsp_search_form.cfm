<cfoutput>

<table border="0" cellpadding="0" cellspacing="2" width="100%">
			
<tr>
<td class="section_header" width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#TRIM(sectiondetails.fuseaction)#" style="text-decoration:none; color:black;"><cfif #session.textonly# EQ 'yes'>#SectionDetails.Title#<cfelse><img src="#request.imageroot#/title_#TRIM(sectiondetails.fuseaction)#.gif" border="0"></cfif></a></td>
<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a></cfif></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>	

<tr>
<td bgcolor="676767" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>	

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<tr>
<td colspan="2"><cfif (#TRIM(sectiondetails.introduction)# NEQ '') AND (#sectiondetails.introduction# NEQ '<P>&nbsp;</P>')><span class="page_introduction"><strong>#sectiondetails.introduction#</strong></span><br><br></cfif>

<cfif (#TRIM(sectiondetails.details)# NEQ '') AND (#sectiondetails.details# NEQ '<P>&nbsp;</P>')><span class="normal">#sectiondetails.details#</span></cfif><br>



	<table width="600" border="0" cellpadding="0" cellspacing="0">

	<tr>
	<td colspan="7" height="1" bgcolor="black"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	
	
	
	<form method="post" action="#request.webroot#/index.cfm?fuseaction=search&fusesubaction=advancedresults">
	<tr>
	<td bgcolor="black" height="1" width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
	
	
		<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td colspan="2">&nbsp;</td>
		</tr>
		
		<tr>
		<td width="170"><strong>Search For:</strong></td>
		<td><select class="whitefield" name="SearchType" style="width:340px;">
		<option value="ALL" selected>ALL CONTENT
		<option value="Documents">Online Documents / Pages
		<option value="Events">Meetings / Events
		<option value="Downloads">Files for Download
		<option value="News">News Articles
		</select></td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>		
		
		<tr>
		<td width="170"><strong>Keyword 1:</strong></td>
		<td><input type="text" class="whitefield" name="keywords" style="width:340px;"></td>
		</tr>
		
		<tr>
		<td colspan="2" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td width="170"><strong>Keyword 2</strong></td>
		<td><select class="whitefield" name="Operator1" style="width:60px;"><option value="none">&ndash;<option value="AND"> AND<option value="OR"> OR<option value="NOT"> NOT</select> <input type="text" class="whitefield" name="keywords2" style="border: 1px solid black;" style="width:276px;" align="absmiddle"></td>
		</tr>
		
		<tr>
		<td colspan="2" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td width="170"><strong>Keyword 3</strong></td>
		<td><select class="whitefield" name="Operator2" style="width:60px;"><option value="none">&ndash;<option value="AND"> AND<option value="OR"> OR<option value="NOT"> NOT</select> <input type="text" class="whitefield" name="keywords3" style="border: 1px solid black;" style="width:276px;" align="absmiddle"></td>
		</tr>
			
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
		
		<tr>
		<td width="170"><strong>Published Between:</strong><br><em>Leave un-ticked for ANY</em></td>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
			<tr>
			<td valign="top"><input name="UsePubDate" type="Checkbox" value="1" class="whitefield"></td>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="4" border="0"></td>
			<td valign="top">
		
				<table cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td>From:&nbsp;&nbsp;</td>
				<td><select name="PublicationDate_startday" class="whitefield" style="width:40px;"><cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif 1 EQ #loopcount#> selected</cfif>>#loopcount#</cfloop></select> <select name="PublicationDate_startmonth" class="whitefield" style="width:120px;"><cfloop from="1" to="12" index="monthloopcount"><option value="#monthasstring(monthloopcount)#"<cfif 'January' EQ #monthasstring(monthloopcount)#> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="PublicationDate_startyear" class="whitefield" style="width:70px;"><cfloop from="1990" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif 1990 EQ #yearloopcount#> selected</cfif>>#yearloopcount#</cfloop></select></td>
				</tr>
				
				<tr>
				<td>To:&nbsp;&nbsp;</td>
				<td><select name="PublicationDate_endday" class="whitefield" style="width:40px;"><cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif #DateFormat(now(), "d")# EQ #loopcount#> selected</cfif>>#loopcount#</cfloop></select> <select name="PublicationDate_endmonth" class="whitefield" style="width:120px;"><cfloop from="1" to="12" index="monthloopcount"><option value="#monthasstring(monthloopcount)#"<cfif #DateFormat(now(), "mmmm")# EQ #monthasstring(monthloopcount)#> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="PublicationDate_endyear" class="whitefield" style="width:70px;"><cfloop from="1990" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif #DateFormat(now(), "yyyy")# EQ #yearloopcount#> selected</cfif>>#yearloopcount#</cfloop></select></td>
				</tr>
				
				</table>
		
			</td>
			</tr>
				
			</table>
		
		</td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>		
		
		<tr>
		<td width="170"><strong>Authored By:</strong><br><em>Leave un-ticked for ANY</em></td>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
			<tr>
			<td valign="top"><input name="UseAuthor" type="Checkbox" value="1" class="whitefield"></td>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="4" border="0"></td>
			<td valign="top">
		
				<table cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td><input type="text" class="whitefield" name="author" style="width:280px;"></td>
				</tr>
				
				</table>
		
			</td>
			</tr>
				
			</table>
		
		</td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
		
		
		<tr>
		<td valign="top"> </td>
		<td><cfif #session.textonly# EQ 'yes'><input type="submit" border="0" align="absmiddle" class="whitefield" value="SEARCH"><cfelse><input type="image" src="#request.imageroot#/search_butt.gif" border="0" align="absmiddle" style="width:74px; height:28px;"></cfif></td>
		</tr>
		
		<tr>
		<td colspan="2">&nbsp;</td>
		</tr>
		
		</table>
	
	
	
	</td>
	<td bgcolor="black" height="1" width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	</form>
	
	
	<tr>
	<td colspan="7" height="1" bgcolor="black"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>	

</table>

</cfoutput>