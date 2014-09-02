<!---<cfif #defaultlang# eq "fr">
    <cfset filename = langFilesStr.fr>
<cfelse>
    <cfset filename = langFilesStr.eng>	
</cfif> --->
<cfset filename = langFilesStr[1]["#defaultlang#"]>

<cfhttp method="get" url="#request.webroot#/langCSVs/#filename#" name="csvData"> 
<cfset langArray = ArrayNew(1)>
<cfset ctr = 1>

<cfset totalRows = csvdata.recordcount>
 
<cfoutput> 
 
<cfloop query="csvdata">
   <cfset structData = StructNew()>
   <cfset structData.VARIABLE = #csvdata.VARIABLE#>
   <cfset structData.VALUE = #csvdata.VALUE#>
   <cfsavecontent variable="#csvdata.VARIABLE#">#csvdata.VALUE#</cfsavecontent>
   <cfset langArray[ctr] = structData>
   <cfset ctr = ctr + 1>
</cfloop>
  
</cfoutput> 

