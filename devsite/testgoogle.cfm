<cfif IsDefined("URL.q") and URL.q neq ''>
    <cfset qStr = URL.q> 
<cfelse>
    <cfset qStr = ""> 
</cfif>

<cfif IsDefined("URL.langpair") and URL.langpair neq ''>
    <cfset langpair = URL.langpair>
<cfelse>
    <cfset langpair = "">
</cfif>
 
<!---Hello  en|fr--->
<cfhttp method="Post" url="http://api.mymemory.translated.net/get">  
    <cfhttpparam type="URL" value="#qStr#" name="q">
    <cfhttpparam type="url" value="#langpair#" name="langpair"> 
</cfhttp>

<cfset theData = #cfhttp.filecontent#> 

<cfset cfData = DeserializeJSON(theData)>

<cfoutput>

#cfData.responseData.translatedText#

</cfoutput>
