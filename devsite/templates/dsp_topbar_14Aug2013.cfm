<cfparam name="fusesubaction" default="">
<script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
<cfoutput>
<cfinclude template="qry_sub_menu.cfm">
<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="##EEEEEE">
  <tr bgcolor="##999999">
    <td colspan="2" >
      <table width="100%">
        <tr>
          <td align="left">
            <cfif fusesubaction NEQ 'step2'>
              <cfloop query="basenav">
                <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(basenav.fuseaction)#" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small">#menuTitle#</a><cfif basenav.currentrow NEQ basenav.recordcount> &nbsp;|&nbsp;</cfif>
                </cfloop>
              </cfif>
            </td>
          <td align="right" style="font-size:small;font-family:Verdana, Geneva, sans-serif;">
            <img src="#request.imageroot#/transparent_spc.gif" width="250" height="1" border="0"><br>
            <cfif fusesubaction NEQ 'step2'>
              <cfif session.UserIsAuthenticated EQ 'Yes'>
                <a href="#request.webroot#/act_logout.cfm" style="color:##FFFFFF;">LOG-OUT</a>
                <cfelse>
                <!---<a href="#request.webroot#/index.cfm?fuseaction=login" style="color:Black;">LOGIN</a> --->
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <a href="#request.webroot#/index.cfm?fuseaction=join" style="color:##FFFFFFF;">REGISTER FREE</a>
                </cfif> 
              &nbsp;&nbsp;&nbsp;&nbsp; 
              <!---<a href="#request.webroot#/index.cfm?fuseaction=help">
                                <img src="#request.imageroot#/help_icon.gif" width="22" height="24" alt="HELP" align="absmiddle" border="0">
                            </a> 
                            <a href="#request.webroot#/index.cfm?fuseaction=help" style="color:##FFFFFF">HELP</a>--->
              </cfif>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  <tr>
    <td width="220" style="font-size: 12px !important;"><img src="#request.imageroot#/transparent_spc.gif" width="220" height="1" border="0"><br>
	         <cfquery name="getContent" datasource="#dsn#" username="#request.username#" password="#request.password#">
			   SELECT * FROM site_section_contents_data WHERE section_id = 1
			 </cfquery>
			 #getContent.header#
    </td>
    </tr>
  
</table>
<script type="text/javascript">
swfobject.registerObject("FlashID");
</script>
</cfoutput>