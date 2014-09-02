<cfparam name="attributes.basepath" default="/null">
<cfparam name="attributes.subdir" default="/">
<cfset attributes.subdir = Replace(attributes.subdir, "//", "/", "ALL")>
<cfdirectory action="LIST"
	directory="#attributes.basepath##attributes.subdir#" name="dir">
<cfoutput><option>#attributes.subdir#</option></cfoutput>
<!--- removed for workaround for bluedragon...
<cfoutput query="dir">
	<cfif dir.name IS NOT "." AND dir.name IS NOT ".." AND type IS "dir">
		<cf_recursedir
			basepath="#basepath#"
			subdir="#subdir#/#dir.name#">
	</cfif>
</cfoutput>
--->
<cfset dirlist = "">
<cfoutput query="dir">
	<cfif dir.type IS "Dir" AND dir.name IS NOT "." AND dir.name IS NOT "..">
		<cfset dirlist = listappend( dirlist, dir.name )>
	</cfif>
</cfoutput> 

<cfloop index="i" list="#dirlist#">
	<cf_recursedir
		basepath="#attributes.basepath#"
		subdir="#attributes.subdir#/#i#">

</cfloop>

