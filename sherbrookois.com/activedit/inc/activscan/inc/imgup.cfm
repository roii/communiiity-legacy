<cftry>

<CFLOCK SCOPE="server" TIMEOUT="100" TYPE="Exclusive">
	<cfloop list="#StructKeyList(server.activescan_imagepath)#" index="idx">
		<cfif form.key IS idx>
			<cfset attributes.imagepath = server.activescan_imagepath["#idx#"]>
		</cfif>
	</cfloop>
</cflock>

<cfif NOT IsDefined("attributes.imagepath")>
	Error: Path not defined
	<cfabort>
</cfif>

<cffile action="UPLOAD" 
		destination="#attributes.imagepath#"
		nameconflict="MAKEUNIQUE" 
		accept="image/gif,image/jpg,image/jpeg,image/pjpeg"
		filefield="image"
		MODE="664">

<CFLOCATION url="activescan:filename=#FILE.ServerFile#;">

<cfcatch>
<CFLOCK SCOPE="server" TIMEOUT="100" TYPE="Exclusive">
	<cfset server.activescan_errormsg = "imagepath=#attributes.imagepath#<br><br>#cfcatch.Detail# #cfcatch.Message#">
</cflock>

<cfoutput>
	<CFLOCATION url="activescan:error">
</cfoutput>

</cfcatch>
</cftry>