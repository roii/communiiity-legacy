<cffunction name="makeRandomString" returnType="string" output="false">
	<cfset var chars = "23456789ABCDEFGHJKMNPQRS">
	<cfset var length = randRange(4,7)>
	<cfset var result = "">
	<cfset var i = "">
	<cfset var char = "">
	
	<cfscript>
	for(i=1; i <= length; i++) {
		char = mid(chars, randRange(1, len(chars)),1);
		result&=char;
	}
	</cfscript>
		
	<cfreturn result>
</cffunction>

<cfset session.captcha = makeRandomString()>
<cfimage action="captcha" text="#session.captcha#" width="300" height="75">