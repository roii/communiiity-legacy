<cfwddx action="wddx2cfml" input="#urls#" output="allLinks">



<cfimport taglib="/cf_tags/httpagent" prefix="h"/>



<h:agent threadCount="5" timeout="10" returnVariable="results">
    
	<cfset i = 0/>
	
	<cfloop query="#allLinks#">
	
		<h:request key="url-#i#" url="#allLinks.DocumentURL#" method="Head" userAgent ="">
        <cfset i = i + 1/>
		
    </cfloop>
	
</h:agent>


<html>
    <head>
        <title>CF Get -- Results</title>
    </head>

    <body>
        <h1>CF Get -- Results</h1>

        <table>
            
			<cfset i = 1/>
            <cfloop index = "k" list=#structKeyList(results)#>
                
				<cfoutput>
                    <tr>
                        <td>#i#</td>
                        <td>[#results[k].getResponseCode()#]
                            #results[k].getResponseMessage()#</td>
                        <td>
							
                            <cfset u = results[k].getRequest().getUrl()/>
                            <a href="#u#">#u#</a>
                        </td>
                        <cfif #results[k].isOk()#>
                            <td>
                                [<a href="cfgetDetail.cfm?type=source&page=#urlEncodedFormat(u)#">source</a>|<a href="cfgetDetail.cfm?type=rendered&page=#urlEncodedFormat(u)#">rendered</a>]
                           </td>
                        <cfelse>
                            <td>&nbsp;</td>
                        </cfif>
                    </tr>
                </cfoutput>
                <cfset i = i + 1/>
            </cfloop>
        </table>
    </body>
</html>