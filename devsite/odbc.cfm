<!--- set this to the location of your cfusion directory --->
  <cfset cfusionHome="D:\CFusionMX7">
<!--- install sequelink --->
  <cftry>
  <cfexecute
     name="#cfusionHome#\db\SequeLink Setup\Setup.exe"
     arguments='!TargetDir="#cfusionHome#" !DoDNS=true'>
</cfexecute>
<cfregistry
   action="set"
   branch ="HKEY_LOCAL_MACHINE\SOFTWARE\Macromedia\Install Data\ColdFusion MX"
   entry="SqlLink"
   type="String"
   value="#cfusionHome#\db\slserver54">
<cfcatch type="Any">
  <cfoutput><font color="red">Error Occurred:</font> 
  #cfcatch.message#<br>#cfcatch.detail#<p></cfoutput>
</cfcatch>
</cftry> 

