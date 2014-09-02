<cfif IsDefined("form.tidyContent")>
	<!--- <cftry> --->
		<CFX_JTidy
			content="#form.tidyContent#"
			xhtml="true"
			bodyonly="true"
			word2000="true"
			variable="tidyOutput">
		<cfset form.tidyContent = tidyOutput>
		<cfoutput>
		<script>
			function load() {
				alert(tidyForm.tidyContent.value);
				alert(window.opener.#form.jsvar#);
				window.opener.#form.jsvar# = tidyForm.tidyContent.value;
			}
		</script>	
		</cfoutput>	
		<!--- <cfcatch type="any">
			<script>
			function load() {
				window.close();
			}
			</script>
			<cfabort>
		</cfcatch> 
	</cftry>--->
<cfelse>
	<!--- load variable into form, submit form --->
	<cfoutput>
	<script>
		function load() {
			tidyForm.tidyContent.value = window.opener.#url.jsvar#;
			tidyForm.submit();
		}
	</script>
	</cfoutput>
</cfif>
<cfparam name="form.tidyContent" default="">
<cfparam name="url.jsvar" default="">
<html>
	<head><title>Cleaning HTML</title></head>
	<body onload="load()">
		<form name="tidyForm" action="tidy.cfm" method="post">
			<cfoutput><input type="hidden" name="jsvar" value="#url.jsvar#"></cfoutput>
			<textarea name="tidyContent" style="position:absolute; visibility:hidden;"><cfoutput>#form.tidyContent#</cfoutput>test</textarea>
		</form>
	</body>
</html>
