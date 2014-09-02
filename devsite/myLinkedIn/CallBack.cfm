<!---
This is the file that LinkedIn will call back to with the token. Make sure you update the path in the cfc to match your filename.
---> 		
<cfif structKeyExists(url, "oauth_token") and structKeyExists(url, "oauth_verifier")> 
		<cfset session.linkedin.oauth_verifier = url.oauth_verifier /> 
		
		<cfinvoke component="linkedIn" method="getAccessTokenInDetails" authToken="#url.oauth_token#" authVerifier="#url.oauth_verifier#" returnvariable="s" />
	
		LinkedIn Account verified. <!---<a href="getConnections.cfm">Click here to get your connections</a>--->
		 
		 <cftry>
		     <cfinvoke component="LinkedIn" method="getProfiles" authToken="#s.linkedInToken#" authTokenSecret="#s.linkedInTokenSecret#" identifier="~" returnvariable="results" />
             <cfdump var="#results#">   
			  <!---<cfset accountNum = #results.person.XmlAttributes.first-name.#>--->
		     <cfset idArray = xmlSearch(results,'/person/id')>
		     <cfset id = #idArray[1].XmlText#>
			 
			 <cfset firstNameArray = xmlSearch(results,'/person/first-name')>
		     <cfset firstName = #firstNameArray[1].XmlText#>
			 
			 <cfset lastNameArray = xmlSearch(results,'/person/last-name')>
		     <cfset lastName = #lastNameArray[1].XmlText#>
			 
			 <cfset headlineArray = xmlSearch(results,'/person/headline')>
		     <cfset headline = #headlineArray[1].XmlText#>
			 
			 <cfset publicProfileUrlArray = xmlSearch(results,'/person/public-profile-url')>
		     <cfset publicProfileUrl = #publicProfileUrlArray[1].XmlText#>
			 
			 <cfset data = #id# & ',' & #firstName# & ',' & #lastName# & ',' & #headline# & ',' & #publicProfileUrl#>
			 
			 <cfset strEncodedString = URLEncodedFormat(data)> 
			 
			 <script language="javascript">
			      window.opener.location.href = "displaydata.cfm?cid=<cfoutput>#strEncodedString#</cfoutput>";
				  window.close();
			 </script>			 
			  
			<cfcatch type="Any">
				 <cfoutput>
				     #cfcatch.Message#
				 </cfoutput>
			</cfcatch>
		 </cftry> 
		   
<cfelse>
	This page cannot be invoked directly.
</cfif>
 