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
    <td width="220"><img src="#request.imageroot#/transparent_spc.gif" width="220" height="1" border="0"><br>
	
      <a href="#request.webroot#/"><img src="#request.imageroot#/#TRIM(AllSettings.Logo_file)#" alt="#TRIM(AllSettings.SiteName)#" border="0"></a></td>
    <td align="right" valign="middle" style="font-size:12px;font-family:Trebuchet MS;">
      <!---<img src="#request.imageroot#/transparent_spc.gif" width="250" height="1" border="0"><br><strong><cfif fusesubaction NEQ 'step2'><cfif session.UserIsAuthenticated EQ 'Yes'><a href="#request.webroot#/act_logout.cfm" style="color:Black;">LOG-OUT</a><cfelse><!---<a href="#request.webroot#/index.cfm?fuseaction=login" style="color:Black;">LOGIN</a> --->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#request.webroot#/index.cfm?fuseaction=join" style="color:Black;">REGISTER FREE</a></cfif> &nbsp;&nbsp;&nbsp;&nbsp; <a href="#request.webroot#/index.cfm?fuseaction=help"><img src="#request.imageroot#/help_icon.gif" width="22" height="24" alt="HELP" align="absmiddle" border="0"></a> <a href="#request.webroot#/index.cfm?fuseaction=help" style="color:Black">HELP</a></strong></cfif>--->      <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="468" height="60" id="FlashID">
        <param name="movie" value="../images/3p_banner_1468x60.swf" />
        <param name="quality" value="high" />
        <param name="wmode" value="transparent" />
        <param name="swfversion" value="6.0.65.0" />
        <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don’t want users to see the prompt. -->
        <param name="expressinstall" value="../Scripts/expressInstall.swf" />
        <param name="SCALE" value="exactfit" />
        <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
        <!--[if !IE]>-->
        <object data="../images/3p_banner_1468x60.swf" type="application/x-shockwave-flash" width="468" height="60">
          <!--<![endif]-->
          <param name="quality" value="high" />
          <param name="wmode" value="transparent" />
          <param name="swfversion" value="6.0.65.0" />
          <param name="expressinstall" value="../Scripts/expressInstall.swf" />
          <param name="SCALE" value="exactfit" />
          <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
          <div>
            <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
            <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
            </div>
          <!--[if !IE]>-->
          </object>
        <!--<![endif]-->
        </object>&nbsp;&nbsp;&nbsp;&nbsp;
      
      
      <!---<table width="132" cellpadding="0" cellspacing="0" style="border:solid 0px ##e2e2e2;">
        
        <tr>
          <td align="center"><!---<img src="#request.imageroot#/my3p_time_icon.gif" width="132" height="25" alt="my3P Time" border="0">---></td>
          </tr>
        
        <tr>
          <td></td>
          </tr>
        
        <tr>
          <td align="center"><!---#DateFormat(localdatetime, "mmm dd, yyyy")#&nbsp;&nbsp;#TimeFormat(localdatetime, "H:MM TT")#---></td>
          </tr>
        
      </table>--->
    </td>
    </tr>
  
</table>
<script type="text/javascript">
swfobject.registerObject("FlashID");
</script>
</cfoutput>