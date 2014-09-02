<!---
	Name         : dsp.edit.cfm
	Author       : Raymond Camden 
	Created      : 09/07/05
	Last Updated : 2/23/06
	History      : Use htmleditformat to preserve proper text (rkc 2/23/06)
--->

<cfset newToggle = viewState.getValue("new", false)>
<cfset UserRecord = viewstate.getvalue("UserRecord", "") />
<cfset webpath = viewstate.getvalue("webpath") />
<cfset CanvasConfig = viewstate.getvalue("CanvasConfig") />
<cfset ROLE_LIST=Replace(CanvasConfig.RoleList, ",", ", ", "ALL")>

<cfif not newToggle>
	<cfset page = viewState.getValue("page")>
	<cfset viewState.setValue("title","Edit Page: #page.getTitle()#")>
	<cfparam name="form.body" default="#page.getBody()#">
	<cfparam name="form.authRolesToView" default="#page.getAuthRolesToViewList()#">
	<cfparam name="form.authRolesToEdit" default="#page.getAuthRolesToEditList()#">
	<cfset cancelPage=page.getPath()>
<cfelse>
	<cfset viewState.setValue("title","Add Page")>
	<cfparam name="form.body" default="">
	<cfparam name="form.path" default="">
	<cfparam name="form.authRolesToView" default="">
	<cfparam name="form.authRolesToEdit" default="">
	<cfset cancelPage="Main">
</cfif>

<cfset errors = viewState.getValue("errors")>
<cfset editInstructions = viewState.getValue("editinstructions")>

<!--- param author and summary if editing old version --->
<cfif viewState.getValue("version") neq "0">
	<cfparam name="form.author" default="#page.getAuthor()#">
	<cfparam name="form.summary" default="#page.getSummary()#">
<cfelse>
	<cfparam name="form.author" default="">
	<cfparam name="form.summary" default="">
</cfif>
<cfoutput>
<h1>#viewState.getValue("title")#</h1>

<cfif isArray(errors) and arrayLen(errors)>
	<p>
	<b>Please correct the following error(s):
	<ul>
	<cfloop index="x" from="1" to="#arrayLen(errors)#">
	<li>#errors[x]#</li>	
	</cfloop>
	</ul>
	</b>
	</p>
</cfif>

<p>
<cfif not newToggle>
	<form id="wiki_editform" action="#webpath#/index.cfm?path=#page.getPath()#&event=commitPage" method="post">
<cfelse>
	<form id="wiki_editform" action="#webpath#/index.cfm?event=commitPage&new=true" method="post">
</cfif>
<table>
<cfif newToggle>
<tr>
	<td>
	<label for="path">Page Title:</label>
	</td>
	<td><input type="text" name="path" id="path" value="#form.path#" size="35" /></td>
</tr>
<tr>
	<td colspan="2"><i>Please follow the Wiki scheme of naming pages. All letters or numbers and "dot" syntax for sections.<br>
	So for example, here are some valid page names: Foo, Moo, SectionA.Introduction.</i></td>
</tr>
</cfif>
<tr>
	<td colspan="2">
	<textarea name="body" id="body" style="width: 500px; height: 300px;">#htmlEditFormat(form.body)#</textarea>
	</td>
</tr>
<tr>
	<td>
	<label for="author">Author:</label>
	</td>
	<td>
		<cfif UserRecord.getIsLoggedIn()>
			#UserRecord.getFullName()# [#UserRecord.getUniqueId()#]
		<cfelse>
			<input type="text" name="author" id="author" value="#form.author#" size="35" />
		</cfif>
	</td>
</tr>
<tr>
	<td>
	<label for="summary">Summary:</label>
	</td>
	<td><input type="text" name="summary" id="summary" value="#form.summary#" size="35" /></td>
</tr>
<cfif CanvasConfig.AllowRolesForEditing or CanvasConfig.AllowRolesForViewing>
	<tr><td colspan="2"><strong>Use one or more of these roles: #ROLE_LIST#</strong></td></tr>
</cfif>
<cfif CanvasConfig.AllowRolesForEditing>
	<tr>
		<td valign="top">
		<label for="authRolesToEdit">Required Role(s) for Editing Page: </label>
		</td><td valign="top">
		<input type="text" name="authRolesToEdit" size="35" id="authRolesToEdit" value="#form.authRolesToEdit#" />
		</td>
	</tr>
	<tr><td class="wiki_formfieldcomment">&nbsp;</td><td valign="top" class="wiki_formfieldcomment"><em>Default: #CanvasConfig.defaultAuthRolesToEdit#</em></td></tr>
</cfif>
<cfif CanvasConfig.AllowRolesForViewing>
	<tr>
		<td valign="top">
		<label for="authRolesToView">Required Role(s) for Viewing Page: </label>
		</td><td valign="top">
		<input type="text" name="authRolesToView" size="35" id="authRolesToView" value="#form.authRolesToView#" />
		</td>
	</tr>
	<tr><td class="wiki_formfieldcomment">&nbsp;</td><td valign="top" class="wiki_formfieldcomment"><em>Default: #CanvasConfig.defaultAuthRolesToView#</em></td></tr>
</cfif>
<tr>
	<td>&nbsp;</td>
	<td><input type="submit" value="Save" /><input type="button" value="Cancel" onclick="javascript:window.location.href='#webpath#/index.cfm/#cancelPage#';" /></td>
</tr>
</table>
</form>
</p>

<p>
<h3>Editing Instructions</h3>
#editInstructions#
</p>
</cfoutput>

