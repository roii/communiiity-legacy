<cfsetting enablecfoutputonly="yes">

<cfparam name="dealerid" default="">

<cfquery  name="BuildQuestion" datasource="#datasourceR#">
	SELECT id,questiontype,question,option1,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,vendorid,validation
	FROM #tablequestions#
	WHERE formid = #formid#
</cfquery>

<cfset fontst = "<font #fontstyle3#>">
<cfset mainstring = "
	<cfoutput>
	<form action=""#livedir#/default.cfm"" method=""post"">
	<input type=""hidden"" name=""formid"" value=""#formid#"">
	<input type=""hidden"" name=""vendorid"" value=""#vendorid#"">
	<input type=""hidden"" name=""itemid"" value=""##itemid##""> ">
	
<cfloop query="BuildQuestion">

	<cfset mainstring=mainstring & chr(10) & chr(13) & "<font #fontstyle3#>#BuildQuestion.question#</font><br>">
		
	<cfif Questiontype is "1">
		<cfloop index="i" from="1" to="10">
			<cfif len(Evaluate("Option#i#"))>

				<cfset mainstring= mainstring & chr(10) & chr(13) &  "<input type=radio name=""Variable#BuildQuestion.id#"" value=""#i#"">#Evaluate("Option#i#")#<br>">

			</cfif>
		</cfloop>
	<cfelseif Questiontype is "2">
		<cfloop index="i" from="1" to="10">
			<cfif len(Evaluate("Option#i#"))>
			
				<cfset mainstring=mainstring & chr(10) & chr(13) &  "<input type=""checkbox"" name=""Variable#BuildQuestion.id#"" value=""#i#"">#Evaluate("Option#i#")#<br>">

			</cfif>
		</cfloop>
	<cfelseif Questiontype is "3">
	
		<cfset mainstring=mainstring & chr(10) & chr(13) &  "<select name=""Variable#BuildQuestion.id#""> 
		<option value=""0"">Please make your selection">
		
		<cfloop index="i" from="1" to="10">
			<cfif len(Evaluate("Option#i#"))>
						
			<cfset mainstring=mainstring & chr(10) & chr(13) &  "<option value=""#i#"">" & Evaluate("Option#i#")>
			
			</cfif>
		</cfloop>

		<cfset mainstring=mainstring & chr(10) & chr(13) &  "</select><br>">
		

	<cfelseif Questiontype is "4">
	
		<cfset mainstring= mainstring & chr(10) & chr(13) & " <select name=""Variable#BuildQuestion.id#"" multiple>">

		<cfloop index="i" from="1" to="10">
			<cfif len(Evaluate("Option#i#"))>
			
				<cfset mainstring= mainstring & chr(10) & chr(13) &  "<option value=""#i#"">" & Evaluate("Option#i#")>
				
			</cfif>
		</cfloop>
		
		<cfset mainstring=mainstring & chr(10) & chr(13) &  "</select><br>">
		
	<cfelseif Questiontype is "5">
		
		<cfset mainstring= mainstring & chr(10) & chr(13) &  "<input type=""text"" name=""Variable_#BuildQuestion.id#"" size=40><br>">
		
	<cfelseif Questiontype is "6">
	
		<cfset mainstring= mainstring & chr(10) & chr(13) &  "<textarea name=""Variable_#BuildQuestion.id#"" cols=40 rows=3></textarea><br>">
		
	</cfif>

		<cfset mainstring= mainstring & chr(10) & chr(13) &  "<br>">	
		
</cfloop>

<cfset mainstring = mainstring & chr(10) & chr(13) &  "<input type=""submit"" value=""Submit""></form></cfoutput>">

<cffile action="APPEND" file="#publishdir#\#itemid#\default.cfm" output="#mainstring#">


<CFSETTING ENABLECFOUTPUTONLY="NO">