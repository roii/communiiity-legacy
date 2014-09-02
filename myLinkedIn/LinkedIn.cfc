<!--- 
###################  
LinkedIn.cfc by Derek Bowes http://whousescoldfusion.com/
Updates and info http://linkedin.riaforge.com

Make sure you get an API key from https://www.linkedin.com/secure/developer
LinkedIn developer API DOCS located here http://developer.linkedin.com/community/apis
#########################
 --->
<cfcomponent displayname="LinkedIn.cfc" hint="Functions to interact with LinkedIn API" output="yes">	
	<cfscript>
		variables.callback = "http://iii-coop.securec1.hostek.net/myLinkedIn/CallBack.cfm"; // SET THIS TO THE FULL URL OF YOUR CALLBACK  
		variables.apiKey = "52n8hjac9guk";
		variables.secretKey = "ExPsvFwfTkoeHk31";		
		//DO NOT CHANGE THESE
		variables.baseURI = "https://api.linkedin.com/uas/oauth/";
		variables.signMethod = "HMAC-SHA1";
		variables.javaSignMethod = "HmacSHA1";
		variables.encodeType = "UTF-8";
		variables.version = "1.0";
	</cfscript>			
	
	<cffunction name="init" access="public" returntype="any">
		<cfset session.linkedin = structNew() />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getRequestToken" access="public" output="true" returntype="void">
		<cfset var paramStr = "" />
		<cfset var signStr = "" />
		<cfset var signature = "" />
		<cfset var authHeader = "" />
		<cfset var fullURI = variables.baseURI />
		<cfset var timestamp = getTimeStamp() />
		<cfset var nonce = getNonce() />
		<cfset var retResult = "" />
					
		<cfset fullURI = variables.baseURI  & "requestToken" />
	
		<cfset paramsStr = "oauth_callback=" & encodeData(variables.callback) & "&" 
						& "oauth_consumer_key=" & variables.apiKey & "&"
						& "oauth_nonce=" & nonce & "&"
						& "oauth_signature_method=" & variables.signmethod & "&"
						& "oauth_timestamp=" & timestamp & "&"
						& "oauth_version=" & variables.version />
		<cfset signStr = "POST&" & encodeData(fullURI) & "&" & encodeData(paramsStr) />
		
		<cfset signature = computeHMACSignature(signStr, variables.secretKey & "&") />
		
		<cfset authHeader = "OAuth " &
						createHeaderElement("oauth_callback", variables.callback) & ", " &
						createHeaderElement("oauth_consumer_key", variables.apiKey) & ", " &
						createHeaderElement("oauth_nonce", nonce) & ", " &
						createHeaderElement("oauth_timestamp", timestamp) & ", " &
						createHeaderElement("oauth_signature_method", variables.signmethod) & ", " &
						createHeaderElement("oauth_version", variables.version) & ", " &
						createHeaderElement("oauth_signature", signature) />
			
		<cfset retResult = makeHttpCall(fullURI, authHeader) />
		<!---<cfoutput>
		  #retResult#
		</cfoutput>--->
		
	
		<cfif listFirst(retResult, "=") neq "oauth_token">
			<!--- Might want to add something more elegant here --->
			<cfabort showerror="Error retrieving token from LinkedIn - #retResult#" />
		</cfif>
		<cfset authTokenList = listToArray(retResult, "&") />
		
		<cfset session.linkedin.authTokenReq = listGetAt(authTokenList[1],2,"=")>
		<cfset session.linkedin.authTokenSecretReq = listGetAt(authTokenList[2],2,"=")>	
		<!---<br>
		<cfoutput>#variables.baseURI#authorize?oauth_token=#session.linkedin.authTokenReq#</cfoutput><br>
		<cfdump var="#session#">
		<cfabort>--->	
		<cflocation addtoken="no" url="#variables.baseURI#authorize?oauth_token=#session.linkedin.authTokenReq#" />		
	</cffunction>

	<cffunction name="getAccessToken" access="public" output="no" returntype="any">
		<cfargument name="authToken" required="yes" type="string" />
		<cfargument name="authVerifier" required="yes" type="string" />		
		
		<cfset var paramsStr = "" />
		<cfset var signStr = "" />
		<cfset var signature = "" />
		<cfset var authHeader = "" />
		<cfset var key = "" />
		<cfset var fullURI = variables.baseURI & "accessToken" />
		<cfset var timestamp = getTimeStamp() />
		<cfset var nonce = getNonce() />
		<cfset var authTokenList = "" />	
		<cfset var retResult = "" />
	
		<cfset paramsStr = "oauth_consumer_key=" & variables.apiKey & "&"
						& "oauth_nonce=" & nonce & "&"
						& "oauth_signature_method=" & variables.signmethod & "&"
						& "oauth_timestamp=" & timestamp & "&"
						& "oauth_token=" & arguments.authToken & "&"
						& "oauth_verifier=" & arguments.authVerifier & "&"						
						& "oauth_version=" & variables.version />
						
		<cfset signStr = "POST&" & encodeData(fullURI) & "&" & encodeData(paramsStr) />
		<cfset key = encodeData(variables.secretKey) & "&" & encodeData(session.linkedin.authTokenSecretReq) />
		<cfset signature = computeHMACSignature(signStr, key) />
		
		<cfset authHeader = "OAuth " &
						createHeaderElement("oauth_consumer_key", variables.apiKey) & ", " &
						createHeaderElement("oauth_nonce", nonce) & ", " &
						createHeaderElement("oauth_signature_method", variables.signmethod) & ", " &
						createHeaderElement("oauth_timestamp", timestamp) & ", " &
						createHeaderElement("oauth_token", arguments.authToken) & ", " & <!--- this is from the previous getRequestToken oauth_token --->
						createHeaderElement("oauth_verifier", arguments.authVerifier) & ", " &	<!--- this is the return from the previous getRequestToken oauth_verifier --->
						createHeaderElement("oauth_version", variables.version) & ", " &
						createHeaderElement("oauth_signature", signature) />

		<cfset retResult = makeHttpCall(fullURI, authHeader) />
		<cfif listFirst(retResult, "=") neq "oauth_token">
			<!--- Might want to add something more elegant here --->
			<cfabort showerror="Error retrieving token from LinkedIn - #retResult#" />
		</cfif>	
		<cfset authTokenList = listToArray(retResult, "&") />
		<!--- 
		need to store Access Token and Token Secret to use when signing Protected Resources requests
		oauth_token:
		    The Access Token. 
		oauth_token_secret:
		    The Token Secret. 
		 --->
		
		<!--- 
			Update with your user table, put in session or whatever u want.
			This inserts the linkedin Access Token and Token Secret so we can use when signing Protected Resources requests 
		--->
		
		<cfreturn retResult/>
	</cffunction>
	
	<cffunction name="getAccessTokenInDetails" access="public" output="true" returntype="any">
		<cfargument name="authToken" required="yes" type="string" />
		<cfargument name="authVerifier" required="yes" type="string" />	
		
		
		<cfset var paramsStr = "" />
		<cfset var signStr = "" />
		<cfset var signature = "" />
		<cfset var authHeader = "" />
		<cfset var key = "" />
		<cfset var fullURI = variables.baseURI & "accessToken" />
		<cfset var timestamp = getTimeStamp() />
		<cfset var nonce = getNonce() />
		<cfset var authTokenList = "" />	
		<cfset var retResult = "" />
	
		<cfset paramsStr = "oauth_consumer_key=" & variables.apiKey & "&"
						& "oauth_nonce=" & nonce & "&"
						& "oauth_signature_method=" & variables.signmethod & "&"
						& "oauth_timestamp=" & timestamp & "&"
						& "oauth_token=" & arguments.authToken & "&"
						& "oauth_verifier=" & arguments.authVerifier & "&"						
						& "oauth_version=" & variables.version />
		 		
		<cfset signStr = "POST&" & encodeData(fullURI) & "&" & encodeData(paramsStr) />
		<cfset key = encodeData(variables.secretKey) & "&" & encodeData(session.linkedin.authTokenSecretReq) />
		<cfset signature = computeHMACSignature(signStr, key) />
		
		<cfset authHeader = "OAuth " &
						createHeaderElement("oauth_consumer_key", variables.apiKey) & ", " &
						createHeaderElement("oauth_nonce", nonce) & ", " &
						createHeaderElement("oauth_signature_method", variables.signmethod) & ", " &
						createHeaderElement("oauth_timestamp", timestamp) & ", " &
						createHeaderElement("oauth_token", arguments.authToken) & ", " & <!--- this is from the previous getRequestToken oauth_token --->
						createHeaderElement("oauth_verifier", arguments.authVerifier) & ", " &	<!--- this is the return from the previous getRequestToken oauth_verifier --->
						createHeaderElement("oauth_version", variables.version) & ", " &
						createHeaderElement("oauth_signature", signature) />

		<cfset retResult = makeHttpCall(fullURI, authHeader) />
		
		<cfif listFirst(retResult, "=") neq "oauth_token">
			<!--- Might want to add something more elegant here --->
			<cfabort showerror="Error retrieving token from LinkedIn - #retResult#" />
		</cfif>	
		<cfset authTokenList = listToArray(retResult, "&") />
		<!--- 
		need to store Access Token and Token Secret to use when signing Protected Resources requests
		oauth_token:
		    The Access Token. 
		oauth_token_secret:
		    The Token Secret. 
		 --->
	 
		<!--- 
			Update with your user table, put in session or whatever u want.
			This inserts the linkedin Access Token and Token Secret so we can use when signing Protected Resources requests 
		--->
		
		<cfset resultStr = StructNew()>
		<cfset resultStr.linkedInToken = '#listGetAt(authTokenList[1],2,"=")#'>
		<cfset resultStr.linkedInTokenSecret = '#listGetAt(authTokenList[2],2,"=")#'>		
		
		<cfreturn resultStr/>
	</cffunction>

	<cffunction name="getConnections" access="public" output="no" returntype="any">
		<cfargument name="authToken" required="yes" type="string" />
		<cfargument name="authTokenSecret" required="yes" type="string" />
		<cfargument name="start" required="no" type="numeric" hint="Starting location within the result set for paginated returns. Ranges are specified with a starting index and a number of results (count) to return. The default value for this parameter is 1." />
		<cfargument name="count" required="no" type="numeric" hint="Ranges are specified with a starting index and a number of results to return. You may specify any number." />
		
		<cfset var result = "" />
		<cfset var qresult = "" />		
		<cfset var urlStr = "" />
		
		<cfif structKeyExists(arguments, "count")>
			<cfset urlStr = urlStr & "count=" & arguments.count />
		</cfif>		
		
		<cfif structKeyExists(arguments, "start")>
			<cfif structKeyExists(arguments, "count")>
				<cfset urlStr = urlStr & "&" />
			</cfif>
			<cfset urlStr = urlStr & "start=" & arguments.start />
		</cfif>				
		<cfif len(urlStr) gt 0>
			<cfset urlStr = "?" & urlStr />
		</cfif>		
		<cfset result = doLinkedInCommand(arguments.authToken, arguments.authTokenSecret, "http://api.linkedin.com/v1/people/~/connections#urlStr#") />
		<cfset qresult = XmlParse(result) />
		
		<cfreturn qresult />
	</cffunction>
	
	<cffunction name="getSearchResults" access="public" output="no" returntype="any">		
		<cfargument name="keywords" required="no" type="string" hint="Returns members who have keywords anywhere in their profile. Multiple words should be separated by a plus (+) sign. Boolean logic isn't supported in this parameter." />
		<cfargument name="name" required="no" type="string" hint="Returns all members with a name matching the one specified in the parameter. If only one name is provided, it's assumed to be the last name (surname). Multiple words must be separated by a plus (+) sign. Boolean logic isn't supported." />
		<cfargument name="company" required="no" type="string" hint="Returns members who have a particular company name on their profile. company works with the current-company parameter which specifies whether the company must be a current company or whether it can be anywhere on a profile." />
		<cfargument name="currentCompany" required="no" type="string" hint="Valid values are true or false. true returns members who currently work at the company specified in the company parameter. false returns all members who have ever worked at the company specified in the company parameter." />
		<cfargument name="title" required="no" type="string" hint="Returns members who have a particular title on their profile. title works with the current-title parameter, which specifies whether the title must be the current title or if it can be anywhere on a profile." />
		<cfargument name="currentTitle" required="no" type="string" hint="Valid values are true or false. true returns members who currently have the title specified in the title parameter. false returns all members who have had the title specified in the title parameter." />
		<cfargument name="industryCode" required="no" type="string" hint="Returns members within a specific industry.  Refer to the Industry Codes page for the full list of industry codes you can use. http://developer.linkedin.com/docs/DOC-1011" />
		<cfargument name="searchLocationType" required="no" type="string" hint="To search within a country or postal code, use I. To do a general search either leave this parameter off or use Y." />
		<cfargument name="countryCode" required="no" type="string" hint="Returns members within a specific country. You must also use search-location-type=I if you use the country-code parameter. Acceptable country codes are those that are defined in the ISO 3166 standards. http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2" />
		<cfargument name="postalCode" required="no" type="string" hint="Returns members within a specific postal code. Valid postal codes are those that are supported by the USPS. Using this parameter requires that you also use the country-code parameter and search-location-type=I." />
		<cfargument name="network" required="no" type="string" hint="Valid values are in or out. in searches within the currently logged in member's three degree network. out searches all profiles outside the network of the currently logged in member." />
		<cfargument name="start" required="no" type="string" hint="Starting location within the result set for paginated returns. Ranges are specified with a starting index and a number of results (count) to return. The default value for this parameter is 1." />
		<cfargument name="count" required="no" type="string" hint="Ranges are specified with a starting index and a number of results to return. The default value is 10 and that is tihe maximum number returned. Requesting more will return 10." />
		<cfargument name="sortCriteria" required="no" type="string" hint="Controls the order in which search results are presented: ctx, endorsers, distance, relevance" />
		
		<cfset var result = "" />
		<cfset var qresult = "" />		
		<cfset var urlStr = "" />
		
		<cfif structKeyExists(arguments, "keywords")>
			<cfset urlStr = listAppend(urlStr, "keywords=" & replaceNoCase(arguments.keywords, " ", "+", "all"), "&") />
		</cfif>
		<cfif structKeyExists(arguments, "name")>
			<cfset urlStr = listAppend(urlStr, "name=" & replaceNoCase(arguments.name, " ", "+", "all"), "&") />		
		</cfif>
		<cfif structKeyExists(arguments, "company")>
			<cfset urlStr = listAppend(urlStr, "company=" & arguments.company, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "currentCompany")>
			<cfset urlStr = listAppend(urlStr, "current-company=" & arguments.currentCompany, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "title")>
			<cfset urlStr = listAppend(urlStr, "title=" & arguments.title, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "current-title")>
			<cfset urlStr = listAppend(urlStr, "current-title=" & arguments.currentTitle, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "industryCode")>
			<cfset urlStr = listAppend(urlStr, "industry-code=" & arguments.industryCode, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "searchLocationType")>
			<cfset urlStr = listAppend(urlStr, "search-location-type=" & arguments.searchLocationType, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "countryCode")>
			<cfset urlStr = listAppend(urlStr, "country-code=" & arguments.countryCode, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "postalCode")>
			<cfset urlStr = listAppend(urlStr, "postal-code=" & arguments.postalCode, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "network")>
			<cfset urlStr = listAppend(urlStr, "network=" & arguments.network, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "start")>
			<cfset urlStr = listAppend(urlStr, "start=" & arguments.start, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "count")>
			<cfset urlStr = listAppend(urlStr, "count=" & arguments.count, "&") />
		</cfif>
		<cfif structKeyExists(arguments, "sortCriteria")>
			<cfset urlStr = listAppend(urlStr, "sort-criteria=" & arguments.sortCriteria, "&") />
		</cfif>
																												
		<cfif len(urlStr) gt 0>
			<cfset urlStr = "?" & urlStr />
		</cfif>		
		<cfset result = doLinkedInCommand(arguments.authToken, arguments.authTokenSecret, "http://api.linkedin.com/v1/people#urlStr#") />
		<cfset qresult = XmlParse(result) />
		
		<cfreturn qresult />
	</cffunction>
	
	<cffunction name="getNetworkUpdates" access="public" output="no" returntype="any">
		<cfargument name="authToken" required="yes" type="string" />
		<cfargument name="authTokenSecret" required="yes" type="string" />
		<cfargument name="type" required="no" type="string" hint="Any valid Network Update Type from this list: ANSW,APPS,CONN,JOBS,JGRP,PICT,RECU,PRFU,QSTN,STAT. Can be multiple, comma separated. http://developer.linkedin.com/docs/DOC-1006" />
		<cfargument name="count" required="no" type="numeric" hint="Maximum number of updates to return" />
		<cfargument name="start" required="no" type="numeric" hint="The offset by which to start Network Update pagination" />
		<cfargument name="after" required="no" type="numeric" hint="unix timestamp after which to retrieve updates for (Ex: 1243834824)" />
		<cfargument name="before" required="no" type="numeric" hint="unix timestamp before which to retrieve updates for (Ex: 1243834824)" />
		
		<cfset var urlStr = "" />
		<cfset var typeCnt = "" />
		<cfset var loopCnt = 0 />
		<cfset var result = "" />
		<cfset var qresult = "" />		
		
		<cfif structKeyExists(arguments, "type")>
			<cfset typeCnt = listLen(arguments.type) />		
			<cfloop index="thisType" list="#arguments.type#">
				<cfset loopCnt = loopCnt + 1 />
				<cfset urlStr = urlStr & "type=" & uCase(thisType) />
				<cfif typeCnt gt loopCnt>
					<cfset urlStr = urlStr & "&" />
				</cfif>
			</cfloop>
		</cfif>
		
		<cfif structKeyExists(arguments, "count")>
			<cfif len(urlStr) gt 1>
				<cfset urlStr = urlStr & "&" />
			</cfif>
			<cfset urlStr = urlStr & "count=" & arguments.count />
		</cfif>		
		
		<cfif structKeyExists(arguments, "start")>
			<cfif len(urlStr) gt 1>
				<cfset urlStr = urlStr & "&" />
			</cfif>		
			<cfset urlStr = urlStr & "start=" & arguments.start />
		</cfif>				
		
		<cfif structKeyExists(arguments, "after")>
			<cfif len(urlStr) gt 1>
				<cfset urlStr = urlStr & "&" />
			</cfif>		
			<cfset urlStr = urlStr & "after=" & arguments.after />
		</cfif>		
				
		<cfif structKeyExists(arguments, "before")>
			<cfif len(urlStr) gt 1>
				<cfset urlStr = urlStr & "&" />
			</cfif>		
			<cfset urlStr = urlStr & "before=" & arguments.before />
		</cfif>		
		<cfif len(urlStr) gt 0>
			<cfset urlStr = "?" & urlStr />
		</cfif>
		<cfset result = doLinkedInCommand(arguments.authToken, arguments.authTokenSecret, "http://api.linkedin.com/v1/people/~/network#urlStr#") />
        <cftry>
		<cfset qresult = XmlParse(result) />		
		<cfcatch type="any">
        	<cfset qresult = "">
        </cfcatch>
        </cftry>
		
		<cfreturn qresult />
	</cffunction>

	<cffunction name="getProfiles" access="public" output="no" returntype="any">
		<cfargument name="authToken" required="yes" type="string" />
		<cfargument name="authTokenSecret" required="yes" type="string" />
		<cfargument name="identifier" required="yes" type="string" default="~" hint="Send in either '12345' for a member id or a URL to public profile or do not send this attribute to get profile of current user." />
		<cfargument name="member_id" required="no" type="numeric" hint="If you know the member token of the profile you want to display, you can use it as the key value for this API call." />
		<cfargument name="public" required="no" type="boolean" default="0" hint="only used if requesting profile via profile url in identifier attribute." />
		
		<cfset var result = "" />
		<cfset var qresult = "" />		
		
		<cfif listFirst(arguments.identifier, ":") eq "http">
			<cfset arguments.identifier = arguments.identifier & "url=" />
			<cfif arguments.public>
				<cfset arguments.identifier = arguments.identifier & ":public" />
			</cfif>
		<cfelseif arguments.identifier neq "~">
			<cfset arguments.identifier = arguments.identifier & "id=" & arguments.identifier /> 
		</cfif>
		
		<cfset result = doLinkedInCommand(arguments.authToken, arguments.authTokenSecret, "http://api.linkedin.com/v1/people/#arguments.identifier#:(id,first-name,last-name,headline,picture-url,public-profile-url)", "GET") />
		 		 
		<cfset qresult = XmlParse(result) />
		
		<cfreturn qresult />
	</cffunction>

<cffunction name="parseParamsString" access="private" output="no" returntype="string">
	<cfargument name="paramsStr" required="yes" type="string" />
	
	<cfset var paramsStrNew = "" />
	<cfset var keyValPairCnt = listLen(arguments.paramsStr, "&") />
	<cfset var cnt = 0 />
	<cfset var value = "" />
	
	<cfloop index="thisPair" list="#arguments.paramsStr#" delimiters="&">
		<cfset cnt = cnt + 1 />
		<cfset key = encodeData(listGetAt(thisPair, 1, "=")) />
		<cfset value = encodeData(listGetAt(thisPair, 2, "=")) />
		
		<cfset paramsStrNew = key & "=" & value />
		<cfif keyValPairCnt gt cnt>
			<cfset paramsStrNew = listAppend(paramsStrNew, thisStr) />
		</cfif>
	</cfloop>

	<cfreturn paramsStrNew />
</cffunction>

	<cffunction name="doLinkedInCommand" access="public" output="no" returntype="any">
		<cfargument name="authToken" required="yes" type="string" />
		<cfargument name="authTokenSecret" required="yes" type="string" />
		<cfargument name="fullURI" required="yes" type="string" />
		<cfargument name="http_method" required="no" default="POST" type="string" />
		<cfargument name="http_body" required="no" default="" type="string" />
		<cfargument name="content_type" required="no" type="string" default="application/x-www-form-urlencoded" />
	
		<cfset var signStr = "" />
		<cfset var signature = "" />
		<cfset var authHeader = "" />
		<cfset var paramsStr = "" />
		<cfset var key = "" />
		<cfset var retResult = "" />	
		<cfset var querystring = "" />	
		<cfset var timestamp = getTimeStamp() />
		<cfset var nonce = getNonce() />
        <cfset var paramArr = ArrayNew(1)>
        
        <cfset ArrayAppend(paramArr,"oauth_consumer_key=" & variables.apiKey)>
        <cfset ArrayAppend(paramArr,"oauth_nonce=" & nonce)>
        <cfset ArrayAppend(paramArr,"oauth_signature_method=" & variables.signmethod)>
        <cfset ArrayAppend(paramArr,"oauth_timestamp=" & timestamp)>
        <cfset ArrayAppend(paramArr,"oauth_token=" & arguments.authToken)>
        <cfset ArrayAppend(paramArr,"oauth_version=" & variables.version)>
        <cfif Find("?",arguments.fulluri)>
        	<cfset querystring = ListLast(arguments.fulluri,"?")>
            <cfloop list="#querystring#" delimiters="&" index="q">
		        <cfset ArrayAppend(paramArr,q)>
            </cfloop>
		</cfif>
		<cfset signStr = "GET&"&encodeData(ListFirst(arguments.fullURI,"?"))&"&"/>
        <cfset ArraySort(paramArr,"textnocase")>
        <cfset paramsStr = ArrayToList(paramArr,"&")>
		
		<cfset signStr = signStr & encodeData(paramsStr) />
        
		<cfset key = encodeData(variables.secretKey) & "&" & encodeData(arguments.authTokenSecret) />
		<cfset signature = computeHMACSignature(signStr, key) />		

		<cfset authHeader = "OAuth " &
						createHeaderElement("oauth_consumer_key", variables.apiKey) & ", " &
						createHeaderElement("oauth_token", arguments.authToken) & ", " &
						createHeaderElement("oauth_signature_method", variables.signmethod) & ", " &						
						createHeaderElement("oauth_signature", signature) & ", " &
						createHeaderElement("oauth_timestamp", timestamp) & ", " &
						createHeaderElement("oauth_nonce", nonce) & ", " &
						createHeaderElement("oauth_version", variables.version) />	 

		<cfset retResult = makeHttpCall(arguments.fullURI, authHeader, arguments.http_method,arguments.http_body,arguments.content_type) />
 
		<cfreturn retResult />
	</cffunction>

	<cffunction name="makeHttpCall" access="public" output="no" returntype="any">
		<cfargument name="fullURI" required="yes" type="string" />
		<cfargument name="authHeader" required="yes" type="string" />
		<cfargument name="http_method" required="yes" type="string" default="POST" />
		<cfargument name="http_body" required="no" type="string" default="" />
		<cfargument name="content_type" required="no" type="string" default="application/x-www-form-urlencoded" />

		<cfscript>
			var header = "";
			var result = "";			
					
			//comment from here to 
			/*var urlObj = createObject("java", "java.net.URL");
			var sysObj = createObject("java", "java.lang.System");
			var conObj = createObject("java", "java.net.URLConnection");
			var osObj = createObject("java", "java.io.OutputStream");
			var oswObj = createObject("java", "java.io.OutputStreamWriter");
			var isrObj = createObject("java", "java.io.InputStreamReader");
			var brObj = createObject("java", "java.io.BufferedReader");	
			var isObj  = "";*/
			// here if using cfx_http5
			
    		header = header & "Content-Type: #arguments.content_type##Chr(13)##Chr(10)#";
	        header = header & "Authorization: #arguments.authheader##Chr(13)##Chr(10)#";			
		</cfscript>	
		 	

		<!---
			If you have cfx_http5 installed you can use this instead of the java classes/methods below
			also comment out the relvant section above --->	 			
			<cfx_http5 url="#arguments.fullURI#" method="#arguments.http_method#" headers="#header#" body="#arguments.http_body#" out="result">
			
		<!---  <cftry>			 
				  <cfhttp url="#arguments.fullURI#" method="#arguments.http_method#" useragent="Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.7 (KHTML, like Gecko) Chrome/5.0.391.0 Safari/533.7" resolveurl="yes" throwonerror="yes">
					    <cfhttpparam type="body" value="#arguments.http_body#" encoded="no" />
					    <cfhttpparam type="header" name="Content-Type" value="#arguments.content_type#" />
					    <cfhttpparam type="header" name="Authorization" value="#arguments.authheader#" />
                        <cfhttpparam type="Header" name="TE" value="deflate;q=0"> 
						<cfhttpparam type="header" name="Accept-Encoding" value="gzip,deflate,sdch" >
						<cfhttpparam type="header" name="Proxy-Connection" value="keep-alive" >
						<cfhttpparam type="header" name="Accept" value="application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/p/*;q=0.5">
						<cfhttpparam type="header" name="Accept-Language" value="en-US,en;q=0.8">
						<cfhttpparam type="header" name="Accept-Charset" value="ISO-8859-1,utf-8;q=0.7,*;q=0.3">
						<cfhttpparam type="cookie" name="some-cookie" value="1">  
				  </cfhttp> 
				  <cfset result = cfhttp.FileContent />
				  
		  <cfcatch type = "any">
		        <cfoutput> #cfcatch.message# </cfoutput>
				<cfabort>
		  </cfcatch>		  
		  </cftry>--->  
		
<!---		<cfscript>
			urlObj.init(arguments.fullURI);	
			conObj = urlObj.openConnection();		
			conObj.setRequestMethod(arguments.http_method);
			conObj.setDoInput(true);
			conObj.setDoOutput(true);
			conObj.setUseCaches(false); //Set custom http headers...
			conObj.setRequestProperty("Content-Type", arguments.content_type);
			conObj.setRequestProperty("Authorization", arguments.authHeader);
			osObj = conObj.getOutputStream(); //Initialize java.io.OutputStreamWriter with OutputStream object
			oswObj.init(osObj);
			oswObj.flush();
			oswObj.close(); //Get response Returns java.io.InputStream 
			isObj = conObj.getInputStream(); //  Initialize java.io.InputStreamReader with InputStream object 
			isrObj.init(isObj);
			brObj.init(isrObj);
			result = brObj.readLine().toString();
			conObj.disconnect();
		</cfscript>--->

		<cfreturn result />
	</cffunction>
		

	<cffunction name="getTimeStamp" access="private" output="no" returntype="numeric">
		<cfset var tc = "" />
		<cfset var timestamp = "" />
		
		<cfset tc = CreateObject("java", "java.util.Date").getTime() />
		<cfset timestamp = Int(tc / 1000) />
		
		<cfreturn timestamp />
	</cffunction>
	
	<cffunction name="getNonce" access="private" output="no" returntype="numeric">
		<cfset var ts = getTimeStamp() />
		<cfreturn int(ts*89) />
	</cffunction>
	
	<cffunction name="encodeData" access="private" output="no" returntype="string">
		<cfargument name="data" required="yes" type="string" />
		<cfset var result = "" />
		<cfset var encoder = "" />
		
		<cfset arguments.data = JavaCast("string", arguments.data) />
		<cfset encoder = createObject("java", "java.net.URLEncoder") />
		<cfset result = encoder.encode(arguments.data, variables.encodeType) />
		<cfset result = replaceNoCase(result, "%7E", "~", "all") />
		<cfreturn result />
	</cffunction>

	<cffunction name="computeHMACSignature" access="private" output="no" returntype="string">
		<cfargument name="data" required="yes" type="string" />
		<cfargument name="key" required="yes" type="string" />
		
		<cfset var result = "" />
		<cfset var signingKey = "" />
		<cfset var mac = "" />
		<cfset var rawHmac = "" />

		<cfset signingKey = createObject("java", "javax.crypto.spec.SecretKeySpec").Init(arguments.key.getBytes(), variables.javaSignMethod) />
		<cfset mac = createObject("java", "javax.crypto.Mac") />
		<cfset mac = mac.getInstance(variables.javaSignMethod) />
		<cfset mac.init(signingKey) />
		<cfset rawHmac = mac.doFinal(arguments.data.getBytes(variables.encodeType)) />
		<cfset result = toBase64(rawHmac) />
		
		<cfreturn result />
	</cffunction>
		
	<cffunction name="createHeaderElement" access="private" output="no" returntype="string">
		<cfargument name="name" required="yes" type="string" />
		<cfargument name="value" required="yes" type="string" />
		
		<cfreturn encodeData(arguments.name) & "=" & """" & encodeData(arguments.value) & """" />
	</cffunction>
</cfcomponent>