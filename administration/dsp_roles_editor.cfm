<!--- AUTHORISATION REQUIRED - MANAGE ROLES AND PERMISSIONS --->
<cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>

	<cfoutput>
	
	
	<table border="0" cellpadding="0" cellspacing="2" width="100%">

	<tr>
	<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE ROLES AND PERMISSIONS</strong></td>
	<td align="right" width="30"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"><br>
	
	<a href="#request.webroot#/administration/dsp_role_add.cfm" target="AddRole" onclick="fdbackwindow=window.open ('','AddRole','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=200,top=10,left=10')" style="color:###TRIM(session.AllSettings_BoxColour)#; text-decoration:none;"><strong>ADD A ROLE &raquo;</strong></a><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"><br></td>
	</tr>
	
	</table>	
	
	</cfoutput>
	

	<!--- SET THE DEFAULT OPEN PURPOSE WHICH IS NONE --->
	<cfparam name="open_RoleID" default="0">
	
	<cfinclude template="qry_all_roles.cfm">
	
		
	<SCRIPT LANGUAGE="JavaScript">	
	<!--
	function confirmRoleDelete(aURL) {
	if(confirm('Are you sure you want to delete this role?')) {
	location.href = aURL;
	}
	}
	//-->	
	<!--
	function checkAll(permissionform) {
	    for (i=0,n=permissionform.elements.length;i<n;i++)
	        if (permissionform.elements[i].id.indexOf('Permission_') !=-1)
	            permissionform.elements[i].checked = true;
	}
	//-->
	<!--
	function uncheckAll(permissionform) {
	    for (i=0,n=permissionform.elements.length;i<n;i++)
	        if (permissionform.elements[i].id.indexOf('BigPermission_') !=-1)
	            permissionform.elements[i].checked = false;
	}
	//-->
	</script>	
	
	
	<table width="95%" cellpadding="1" cellspacing="1" border="0" align="center">			
	
	<cfloop query="qry_roles_all">
	
	<cfset this_roleID = qry_roles_all.RoleID>
	<cfset this_roleName = qry_roles_all.RoleName>
	<cfset this_roleDesc = qry_roles_all.Description>
	<cfset this_roleActive = qry_roles_all.Active>
	
	<cfif open_RoleID EQ this_roleID>
		<cfset thisBG = "#TRIM(AllSettings.BoxColour)#">
	<cfelse>
		<cfset thisBG = "b4b4b4">
	</cfif>
	
	<cfoutput>
	<tr height="20">
	<td bgcolor="#thisBG#" width="100%" style="padding-left:5px;"><img src="#request.imageroot#/transparent_spc.gif" width="250" height="1" border="0"><br>
	<span class="objectcopy"><cfif open_RoleID EQ this_RoleID><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_roles&open_roleID=0"  class="textlinks" style="color:white;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_roles&open_roleID=#this_roleID#"  class="textlinks" style="color:black;"></cfif><strong>#UCASE(TRIM(this_roleName))#</strong></a></td>
	<td align="right" bgcolor="#thisBG#" style="font-size:10px;color:white;"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"><br>
	<a href="#request.webroot#/administration/dsp_role_edit.cfm?roleID=#this_RoleID#" target="editrole" onclick="fdbackwindow=window.open ('','editrole','width=500,height=320,top=10,left=10,resizable=1,menubar=0,status=0,scrollbars=1,panel=0,addressbar=0')" class="textlinks" style="font-size:10px;color:black;">EDIT</a>&nbsp;|&nbsp;<a href="javascript:confirmRoleDelete('#request.webroot#/administration/act_role_delete.cfm?roleID=#this_RoleID#')" class="textlinks" style="font-size:10px;color:black;">DEL.</a>&nbsp;</td>
	</tr>
	
	</cfoutput>
	
	<cfif open_RoleID EQ this_RoleID>
	
		<cfset currentrow="0">
		
		<cfquery name="qry_permission_groups" datasource="#dsn#">
		SELECT PermissionGroup
		FROM Permissions
		ORDER BY PermissionGroup
		</cfquery>
		
		<tr>
		<td colspan="2" bgcolor="f4f4f4" style="padding-left:10px;padding-right:10px;">	
				
			
			<table cellpadding="0" width="100%" cellspacing="0" border="0">
			
			<cfoutput>
			
			<tr>
			<td colspan="7" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
			</tr>
			
			<form method="post" action="#request.webroot#/administration/act_role_permissions_update.cfm" name="permissionform">
			<input type="hidden" name="roleID" value="#this_RoleID#">
								
			<tr>
			<td width="20" class="listheadsbg" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
			<td width="100%" class="listheadsbg" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1" border="0"></td>
			<td width="75" height="1" align="center" style="color:333333;"><img src="#request.imageroot#/transparent_spc.gif" width="75" height="1" border="0"><br>View</td>
			<td width="75" height="1" align="center" style="color:333333;"><img src="#request.imageroot#/transparent_spc.gif" width="75" height="1" border="0"><br>Add</td>
			<td width="75" height="1" align="center" style="color:333333;"><img src="#request.imageroot#/transparent_spc.gif" width="75" height="1" border="0"><br>Edit</td>
			<td width="75" height="1" align="center" style="color:333333;"><img src="#request.imageroot#/transparent_spc.gif" width="75" height="1" border="0"><br>Delete</td>
			<td width="10" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
			
			</cfoutput>
			
			<cfset Grouplist = "">
			<cfoutput query="qry_permission_groups" group="PermissionGroup">
				<cfif NOT ListFind(GroupList, qry_permission_groups.PermissionGroup, ",")>
					<cfset Grouplist = ListAppend(Grouplist, qry_permission_groups.PermissionGroup, ",")>
				</cfif>
			</cfoutput>
			
			<cfoutput>
			
			<cfloop list="#Grouplist#" delimiters="," index="loopitem">		
			
			<cfset this_group = loopitem>
							
			<tr>
			<td colspan="7" style="font-size:12px; color:black;"><strong>#UCASE(this_group)#</strong></td>
			</tr>
			
							
			<cfquery name="qry_all_permissions" datasource="#dsn#">
			SELECT DisplayOrder, PermissionID, PermissionName, PermissionDescription, DisplaySingle, TopLevel, ShowView, ShowAdd, ShowEdit, ShowDelete
			FROM Permissions
			WHERE PermissionGroup = '#this_group#'
			ORDER BY DisplayOrder
			</cfquery>			
		
			<cfloop query="qry_all_permissions">
			
			<cfset currentrow=currentrow + 1>
			
			<cfset this_permissionID = qry_all_permissions.PermissionID>
			<cfset this_permission = qry_all_permissions.PermissionName>
			<cfset this_desc = qry_all_permissions.PermissionDescription>
			<cfset this_view = qry_all_permissions.ShowView>
			<cfset this_add = qry_all_permissions.ShowAdd>
			<cfset this_edit = qry_all_permissions.ShowEdit>
			<cfset this_delete = qry_all_permissions.ShowDelete>
			
			<cfquery name="qry_Permission_setting" datasource="#dsn#">
			SELECT *
			FROM RolePermissions
			WHERE RoleID=#this_RoleID#
			AND PermissionID=#this_permissionID#
			</cfquery>			
			
			<tr>
			<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
						
			<tr>
			<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
					
			<tr>
			<td style="color:ffffff;">#this_permissionID#</td>
			<td><span style="color:444444;"><strong>#TRIM(this_permission)#</strong></span><br>
			<span style="font-size:11px;">#TRIM(this_desc)#</span></td>
			<td align="center"><cfif this_view EQ 1><input type="checkbox" id="Permission_#this_permissionID#_view" value="1" name="Permission_#this_permissionID#_view"<cfif qry_Permission_setting.RecordCount AND qry_Permission_setting.AllowView EQ 1> checked</cfif>></cfif></td>
			<td align="center"><cfif this_add EQ 1><input type="checkbox" id="Permission_#this_permissionID#_add" value="1" name="Permission_#this_permissionID#_add"<cfif qry_Permission_setting.RecordCount AND qry_Permission_setting.AllowAdd EQ 1> checked</cfif>></cfif></td>
			<td align="center"><cfif this_edit EQ 1><input type="checkbox" id="Permission_#this_permissionID#_edit" value="1" name="Permission_#this_permissionID#_edit"<cfif qry_Permission_setting.RecordCount AND qry_Permission_setting.AllowEdit EQ 1> checked</cfif>></cfif></td>
			<td align="center"><cfif this_delete EQ 1><input type="checkbox" id="Permission_#this_permissionID#_delete" value="1" name="Permission_#this_permissionID#_delete"<cfif qry_Permission_setting.RecordCount AND qry_Permission_setting.AllowDelete EQ 1> checked</cfif>></cfif></td>
			<td></td>
			</tr>
			
			</cfloop>			
					
			
			<tr>
			<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
						
			<tr>
			<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="7" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
			</tr>
			
			</cfloop>
			
			
			<tr>
			<td colspan="7" align="center"><input type="submit" class="whitefield" value="UPDATE ROLE PERMISSIONS &raquo;"> <input type="button" class="whitefield" value="CANCEL" onclick="javascript:location='#request.webroot#/administration/dsp_roles_editor.cfm?open_RoleID=0';"></td>
			</tr>
			
			<tr>
			<td colspan="7" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
			</tr></cfoutput>
			
			</form>
			
			</table>
		
		
		</td>
		</tr>
	
	</cfif>
	
	</cfloop>
	
	</table><br>

	

<cfelse>

	<script type="text/javascript">
	alert("You don't have permission to access this page.");
	history.back();
	</script>
	<cfabort>
	
</cfif>