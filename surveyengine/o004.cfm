<CFSETTING ENABLECFOUTPUTONLY="YES">

	<cfinclude template="m#obj#.cfm">


<cfoutput>
	<cfset itemid1 = randrange(1,9999)>
	<cfset itemid2 = randrange(1,9999)>
	<form action="default.cfm" method="post">
	<input type="hidden" name="obj" value="005">
	<input type="hidden" name="formid" value="#formid#">
	<input type="hidden" name="itemid" value="#itemid1##itemid2#">
</cfoutput>

<cfloop query="BuildQuestion">

<cfif Questiontype neq "7">
	<cfoutput><font #fontstyle3#>#BuildQuestion.question#</font><br></cfoutput>
</cfif>	

	<cfif Questiontype is "1">
		<cfloop index="i" from="1" to="10">
			<cfif len(Evaluate("Option#i#"))><cfoutput><input type="radio" name="Variable#BuildQuestion.id#" value="#i#">#Evaluate("Option#i#")#<br></cfoutput></cfif>
		</cfloop>
	<cfelseif Questiontype is "2">
		<cfloop index="i" from="1" to="10">
			<cfif len(Evaluate("Option#i#"))><cfoutput><input type="checkbox" name="Variable#BuildQuestion.id#" value="#i#">#Evaluate("Option#i#")#<br></cfoutput></cfif>
		</cfloop>
	<cfelseif Questiontype is "3">
		<cfoutput><select name="Variable#BuildQuestion.id#">
		<option value="0">Please make your selection
		</cfoutput>
		<cfloop index="i" from="1" to="10">
			<cfif len(Evaluate("Option#i#"))><cfoutput><option value="#i#">#Evaluate("Option#i#")#</cfoutput></cfif>
		</cfloop>
		<cfoutput>
		</select>
		<br>
		</cfoutput>
	<cfelseif Questiontype is "4">
		<cfoutput><select name="Variable#BuildQuestion.id#" multiple></cfoutput>
		<cfloop index="i" from="1" to="10">
			<cfif len(Evaluate("Option#i#"))><cfoutput><option value="#i#">#Evaluate("Option#i#")#</cfoutput></cfif>
		</cfloop>
		<cfoutput>
		</select>
		<br>
		</cfoutput>
	<cfelseif Questiontype is "5">
		<cfoutput><input type="text" name="Variable_#BuildQuestion.id#" size=40><br></cfoutput>
	<cfelseif Questiontype is "6">
		<cfoutput><textarea name="Variable_#BuildQuestion.id#" cols=30 rows=3></textarea><br></cfoutput>
	</cfif>

		<cfoutput><br></cfoutput>		
		
</cfloop>

<cfoutput>
<cfif CheckArchive.library is 0>
	<input type="submit" value="Submit">
</cfif>	
	</form>
</cfoutput>


<CFSETTING ENABLECFOUTPUTONLY="NO">