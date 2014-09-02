<cfparam name="fusesubaction" default="">
<cfset name = session.User_FirstName>
<script src="../Scripts/swfobject_modified.js" type="text/javascript"></script>
<cfoutput>
<cfinclude template="qry_sub_menu.cfm"> 
<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="##EEEEEE">
  <tr bgcolor="##999999">
    <td colspan="2" >
      <table width="100%">
        <tr>
          <td colspan="2"> 
		  <div style="float: right;">
		        <cfif fusesubaction NEQ 'step2'>
              <cfloop query="basenav">
			        <cfif session.UserIsAuthenticated EQ 'Yes'>
					        <cfif #TRIM(basenav.fuseaction)# neq "login">
							      <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(basenav.fuseaction)#" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small">
						             #menuTitle#
					              </a> 
							</cfif>
					<cfelse>
					       <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(basenav.fuseaction)#" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small">
						    #menuTitle#
					       </a> 
						   <cfif basenav.currentrow NEQ basenav.recordcount> &nbsp;|&nbsp;</cfif> 
					</cfif> 
              </cfloop>
              </cfif> 
                <cfif fusesubaction NEQ 'step2'>
              <cfif session.UserIsAuthenticated EQ 'Yes'>
                    &nbsp;|&nbsp; <a href="#request.webroot#/act_logout.cfm" style="color:##FFFFFF;">LOG-OUT</a>
                <cfelse>
                <!---<a href="#request.webroot#/index.cfm?fuseaction=login" style="color:Black;">LOGIN</a> ---> 
				&nbsp;|&nbsp;
                <a href="#request.webroot#/index.cfm?fuseaction=join" style="color:##FFFFFF;">REGISTER FREE</a>  
                </cfif> 
              &nbsp;&nbsp;&nbsp;&nbsp; 
              <!---<a href="#request.webroot#/index.cfm?fuseaction=help">
                                <img src="#request.imageroot#/help_icon.gif" width="22" height="24" alt="HELP" align="absmiddle" border="0">
                            </a> 
                            <a href="#request.webroot#/index.cfm?fuseaction=help" style="color:##FFFFFF">HELP</a>--->
              </cfif>
		  </div> 
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