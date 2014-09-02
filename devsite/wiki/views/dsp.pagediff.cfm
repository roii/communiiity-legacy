<!---
	Name         : dsp.pagediff.cfm
	Author       : Mark Mazelin
	Created      : 10/04/06
	Last Updated : 
	History      : 
--->

<cfset page = viewState.getValue("page")>
<cfset pageToDiff = viewState.getValue("pageToDiff")>
<cfset diffQuery = viewState.getValue("diffQuery")>
<cfset WikiDiffOperationClassStruct = viewState.getValue("WikiDiffOperationClassStruct")>
<cfset WikiDiffOperations = viewState.getValue("WikiDiffOperations")>
<cfset webpath = viewState.getValue("webpath")>
<cfset viewState.setValue("title","Version Differences: #page.getPath()#")>
<cfset operations=WikiDiffOperationClassStruct.operations>

<cfoutput>
<h1>Version Differences: #page.getTitle()#</h1>
<table class="wiki_diff" cellspacing="0">
	<tr>
		<th colspan="2">#dateFormat(page.getDateTimeCreated(), "m/d/yy")# at #timeFormat(page.getDateTimeCreated(), "h:mm tt")# (v. #page.getVersion()#)</th>
		<th colspan="2">#dateFormat(pageToDiff.getDateTimeCreated(), "m/d/yy")# at #timeFormat(pageToDiff.getDateTimeCreated(), "h:mm tt")# (v. #pageToDiff.getVersion()#)</th>
	</tr>
	<cfloop query="diffQuery">
		<tr>
			<td class="wiki_diff_linenum"><cfif IsNumeric(AtFirst)>#NumberFormat(AtFirst)#<cfelse>&nbsp;</cfif></td>
			<td class="wiki_diff_code<cfif Operation NEQ operations.OPERATION_INSERT> #WikiDiffOperationClassStruct[Operation].class#</cfif>"><div>#Replace(HTMLEditFormat(ValueFirst),Chr(9),"&nbsp;&nbsp;&nbsp;","ALL")#</div></td>
			<td class="wiki_diff_linenum"><cfif IsNumeric(AtSecond)>#NumberFormat(AtSecond)#<cfelse>&nbsp;</cfif></td>
			<td class="wiki_diff_code<cfif Operation NEQ operations.OPERATION_DELETE> #WikiDiffOperationClassStruct[Operation].class#</cfif>"><div>#Replace(HTMLEditFormat(ValueSecond),Chr(9),"&nbsp;&nbsp;&nbsp;","ALL")#</div></td>
		</tr>
	</cfloop>
	<!--- output a blank row to set our column widths --->
	<tr>
		<td width="2%"></td>
		<td width="48%"></td>
		<td width="2%"></td>
		<td width="48%"></td>
	</tr>
</table>
<!--- legend --->
<div class="wiki_diff_legend">
	<h3>Color Legend</h3>
	<table cellspacing="0" cellpadding="3">
		<cfloop list="#WikiDiffOperationClassStruct.legendsortorder#" index="currKey">
			<cfset currItem=WikiDiffOperationClassStruct[currKey]>
			<cfif isStruct(currItem) and StructKeyExists(currItem, "legend") and len(currItem.legend)>
				<tr>
					<th class="#currItem.class#">#currItem.legend#</th>
				</tr>
			</cfif>
		</cfloop>
	</table>
</div>
</cfoutput>