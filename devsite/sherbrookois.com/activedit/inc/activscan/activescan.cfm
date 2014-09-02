<!-- cf_activescan v:1,0,0,1 (CFDEV.COM) -->
<cfsetting enablecfoutputonly="Yes">

<!---
	File: activescan.cfm (CF_ActiveScan)
	Author: Matt Finn
    Company: CFDEV.COM / NETDesign Inc.
	Description:
 		Java Script Library for ActiveScan ActiveX Control
    Date: June 2000
	Version: 1,0,0,1
--->


<!--- Gather Parameters --->
	<!--- Size of window --->
	<cfparam name="attributes.width" default="450">
	<cfparam name="attributes.height" default="250">

	<!--- http://mysite/activescan/inc/ --->
	<cfparam name="attributes.inc" default="">
	<!--- Path to save images --->
	<cfparam name="attributes.imagepath" default="">
	<!--- File system path to inc dir --->
	<cfparam name="attributes.license" default="">

	<!--- onSave = { 'alert', 'redirect', 'call' }
		alert:  onSaveAction is window message
		redirect: onSaveAction is page to redirect to
		call: onSaveAction is function to call as in 'myfunct();'
	--->
	<cfparam name="attributes.onsave" default="alert">
	<cfparam name="attributes.onsaveaction" default="The image has been saved.">

	<!--- Name for image on server... extension is automatically added
	      if this is blank (by default it is) then the user is prompted.
	--->
	<cfparam name="attributes.imagename" default="">

<!--- store upload paths in a server variable --->
<CFLOCK SCOPE="server" TIMEOUT="100" TYPE="Exclusive">
	<cfif not IsDefined("server.activescan_imagepath")>
		<cfset server.activescan_imagepath = StructNew()>
	</cfif>

	<cfset PathKey="">
	
	<cfloop list="#StructKeyList(server.activescan_imagepath)#" index="key">
		<cfif server.activescan_imagepath["#key#"] is attributes.imagepath>
			<cfset PathKey = key>
		</cfif>
	</cfloop>
	
	<cfif NOT Len(PathKey)>
		<cfset PathKey = RandRange(100,10000)>
		<cfset server.activescan_imagepath[PathKey] = attributes.imagepath>
	</cfif>

</cflock>

<!--- output control --->
<cfoutput>
	<style type="text/css">
		.btn {width:23;height:22;margin:0;padding:0;border-width:1px;border-color:buttonface;border-style:solid;}
	</style>
	<script language="JavaScript">
		var PathKey = #PathKey#;
		var onSave = "#attributes.onsave#";
		var onSaveAction = "#attributes.onsaveaction#";
		var ImageName="";
		var as_upscript = "#attributes.inc#imgup.cfm";
		var as_imagename = "#attributes.imagename#";
		var inc = "#attributes.inc#";
	</script>

    <SCRIPT LANGUAGE="JavaScript" src="#attributes.inc#lib.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript" FOR="activescanctrl" EVENT="OnPostComplete">
	<!--
		activescanctrl_OnPostComplete();
	//-->
    </SCRIPT>
	
	
	
<TABLE border=1 cellPadding=0 cellSpacing=0 borderColor="gray" borderColorDark="##a0a0a0" borderColorLight="##e0e0e0">
  <tr valign="middle" width="100%">
  	<td bgcolor="buttonface" ondragstart="event.returnValue=false;"
			onselectstart="event.returnValue=false;">
		&nbsp;
		

		
		<!--- Begin Toolbar --->
		<span name="tbar" onmouseover="as_m_over();" 
			onmousedown="as_m_down();"			
			onmouseup="as_m_up();"
			onmouseout="as_m_out();"
			ondragstart="event.returnValue=false;"
			onselectstart="event.returnValue=false;">
			
		<img src="#attributes.inc#images/space.gif" alt="" border=0>
		
<cfif CGI.HTTP_USER_AGENT contains "MSIE">
		
		<img alt="Select Scanner" class="btn" 
			src="#attributes.inc#images/scanner.gif"
			onclick="as_selsource();">
		<img alt="Start Scan" class="btn" 
			src="#attributes.inc#images/scan.gif"
			onClick="as_OnScan();">		
		
		<img src="#attributes.inc#images/space.gif" alt="" border=0>
		
		<img alt="Zoom Out" class="btn" 
			src="#attributes.inc#images/minus.gif" 
			onMouseDown="as_setztimer(1, 'zo');" 
			onMouseUp="as_setztimer(0, 'zo');"			
			onMouseOut="as_setztimer(0, '');">
	<!--	<img alt="Zoom 100 Percent" class="btn" 
			src="#attributes.inc#images/dot.gif" 
			onClick="as_zoomfull();">	
		-->
		<img alt="Zoom In" class="btn"
			src="#attributes.inc#images/plus.gif"
			onMouseDown="as_setztimer(1, 'zi');"
			onMouseUp="as_setztimer(0, 'zi');"			
			onMouseOut="as_setztimer(0, '');">
			
		<img alt="Zoom Full" class="btn" 
			src="#attributes.inc#images/move.gif"
			onClick="as_zoomfull();" >
		
		<font face="arial" size=3>
		<sup>
		<b>
		<span id="zoomtext">
		&nbsp;100%&nbsp; 
		</span>
		</b>
		</sup>
		</font>

		<img src="#attributes.inc#images/space.gif" alt="" border=0>

		<img alt="Select" class="btn" 
			src="#attributes.inc#images/select.gif" 
			onClick="activescanctrl.MouseBehavior=2;">
		<img alt="Drag" class="btn" 
			src="#attributes.inc#images/drag.gif" 
			onClick="activescanctrl.MouseBehavior=1;">
		<img alt="Crop Image" class="btn"
			src="#attributes.inc#images/crop.gif" 
			onClick="activescanctrl.Crop();">
		<img alt="Scale Image" class="btn"
			src="#attributes.inc#images/resize2res.gif"
			onClick="as_resize();">
			
		<img src="#attributes.inc#images/space.gif" alt="" border=0>
		
		<img alt="Save This Image On The Server" class="btn"
			src="#attributes.inc#images/save.gif"
			onClick="as_postbutton();">
			
		<img src="#attributes.inc#images/space.gif" alt="" border=0>

		<img alt="Help" class="btn"
			src="#attributes.inc#images/help.gif"
			onClick="as_help();">
		
</cfif>
		</span>
		<!--- End Toolbar --->

	</td>
  </tr>
  <TR>
    <TD WIDTH=#attributes.width# HEIGHT=#attributes.height#>
	    <OBJECT ID="activescanctrl" WIDTH=#attributes.width# HEIGHT=#attributes.height#
		  CLASSID="clsid:753721B0-8338-4434-BF6D-189521EA4C74"
		  CODEBASE="#attributes.inc#actvscan.cab##Version=1,0,0,1" title="ActiveScan">
			  <PARAM NAME="_ExtentX" VALUE="10314">
			  <PARAM NAME="_ExtentY" VALUE="4410">
			  <PARAM NAME="MouseBehavior" VALUE="1">
			  <PARAM NAME="License" VALUE=" #attributes.license# 56D9Jy9x IFUeXNX. ">
						
						&nbsp;&nbsp;&nbsp;ERROR: <br>
						&nbsp;&nbsp;&nbsp;Browser not supported. <br><br>
						&nbsp;&nbsp;&nbsp;<i>This page requires Microsoft Internet Explorer 4 or greater.</i>
						<br><br>&nbsp;&nbsp;&nbsp;<a href="http://www.microsoft.com/">Click Here</a> to obtain the latest copy.

			  
		</OBJECT>
	</TD>
  </TR>
</TABLE>
</cfoutput>
<cfsetting enablecfoutputonly="No">
<!-- /cf_activescan Version: 1,0,0,1 (CFDEV.COM) -->


