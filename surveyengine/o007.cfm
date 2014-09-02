<CFSETTING ENABLECFOUTPUTONLY="YES">

<cfinclude template="m#obj#.cfm"> 

<cfoutput>
	<cfset itemid1 = randrange(1,9999)>
	<cfset itemid2 = randrange(1,9999)>
	<form action="#setupdir#default.cfm" method="post">
	<input type="hidden" name="obj" value="005">
	<input type="hidden" name="formid" value="#formid#">
	<input type="hidden" name="itemid" value="#itemid1##itemid2#">
</cfoutput>

<cfloop query="BuildResponses">
	<cfoutput>
		<font #fontstyle1#>
			<b>#question#</b><br>
			<cfif r1 is 1>#a1#<br></cfif>
			<cfif r2 is 1>#a2#<br></cfif>
			<cfif r3 is 1>#a3#<br></cfif>
			<cfif r4 is 1>#a4#<br></cfif>
			<cfif r5 is 1>#a5#<br></cfif>
			<cfif r6 is 1>#a6#<br></cfif>
			<cfif r7 is 1>#a7#<br></cfif>
			<cfif r8 is 1>#a8#<br></cfif>							
			<cfif r9 is 1>#a9#<br></cfif>
			<cfif r10 is 1>#a10#<br></cfif>	
			<cfif len(openquestion) gt 1>#openquestion#<br></cfif>
			<br>
		</font>
	</cfoutput>
</cfloop>

<CFSETTING ENABLECFOUTPUTONLY="NO">