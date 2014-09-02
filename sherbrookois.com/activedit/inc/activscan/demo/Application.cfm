<!---
	File: application.cfm
	Author: Matt Finn
    Company: CFDEV.COM / NETDesign Inc.
	Description:
 		This sets all the parameters for the Activescan demo application.
		To run the demo, change these paths to your actual paths.
    Date: August 2000
	Version: 1,0,0,1
--->

<cfapplication name="activescandemo" >

<cflock scope="Application" timeout="100">
  <cfparam name="application.imageno" default="0">
  <cfscript>
  application.inc ="http://localhost/activescan/inc/";
  application.imagepath ="c:\inetpub\wwwroot\activescan\demo\uploads\";
  application.imageurl ="http://localhost/activescan/demo/uploads/";
  application.license ="";
  </cfscript>
</cflock>

