<!---
|| BEGIN FUSEDOC ||
	
|| Properties ||
Name: FormUrl2AttributesSearch.cfm
Author: m@secretagents.com

|| Responsibilities ||
Make form, url scoped variables into the attributes scope, using the search engine safe URLs
Instead of using index.cfm?variable=value you would use: index.cfm/variables/value.htm

Place this file in c:\cfusion\customtags\fusebox\

Call it in your Application.cfm or App_Globals.cfm like this: <cf_formurl2attributessearch>
If you use this tag you will not use <cf_formurl2attributes>
|| Attributes ||
--> attributes.displaybase: yes/no
--> attributes.createattributeslist: yes/no
<-- request.attributeslist: a string
<-- formurl2attributes_version: a float number
<-- request.formurl2attributessearch_version: a string
|| Database Objects ||

|| END FUSEDOC ||--->
<cfsetting enablecfoutputonly="yes">
<cfset request.formurl2attributessearch_version="1.0 beta 1">
<cfparam name="request.attributeslist" default="">
<cfparam name="attributes.displaybase" default="yes">
<cfparam name="attributes.createattributeslist" default="yes">
<cfif not isdefined("caller.attributes")>
	<cfset caller.attributes=structnew()>
</cfif>

<cfif isdefined("cgi.query_string") and isdefined("cgi.path_info")>
	<cfif not len(cgi.query_string)>
		<cfparam name="cleanpathinfo" default="#cgi.path_info#">
		
		<cfset findindex=findnocase("index.cfm",cleanpathinfo)>
		<cfif findindex>
			<cfset cleanpathinfo=RemoveChars(cleanpathinfo, 1, findindex+9)>
		</cfif>
		
		<cfif len(cleanpathinfo)>
			<cfif len(cleanpathinfo) gte 4 and right(cleanpathinfo,4) is ".htm">
				<cfset cleanpathinfo=RemoveChars(cleanpathinfo, len(cleanpathinfo)-3, 4)>
			</cfif>
			
			<cfset cleanpathinfo=replace(cleanpathinfo,"&","/","all")>
			<cfset cleanpathinfo=replace(cleanpathinfo,"=","/","all")>
			
			<cfloop index="i" from="1" to="#listlen(cleanpathinfo, "/")#" step="2"> 
				<cfset urlname = listgetat(cleanpathinfo, i, "/")>
				<cfif listlen(cleanpathinfo,"/") gte i+1>
					<cfset urlvalue = listgetat(cleanpathinfo, i + 1, "/")>
					<cfset urlvalue=replacenocase(urlvalue,"slash_","/","all")>
					<CFIF refindnocase("[[:alpha:]]",left(trim(urlname),1)) and NOT ISDEFINED( 'caller.ATTRIBUTES.' & urlname )>
						<cfswitch expression="#urlname#">
							<cfcase value="cfid">
								<cfparam name="url.cfid" default="#urlvalue#">
							</cfcase>
							<cfcase value="cftoken">
								<cfparam name="url.cftoken" default="#urlvalue#">
							</cfcase>
							<cfdefaultcase>
								<cfif urlvalue is "null">
									<cfset structinsert(caller.attributes,"#urlname#","")>
								<cfelse> 
									<cfset structinsert(caller.attributes,"#urlname#","#urlvalue#")>
								</cfif>
								<cfif attributes.createattributeslist>
									<cfset request.attributeslist = listappend(request.attributeslist,urlname,"&")>
									<cfset request.attributeslist = listappend(request.attributeslist,urlencodedformat(evaluate("caller.attributes.#urlname#")),"=")>	
								</cfif>
							</cfdefaultcase>
						</cfswitch>
					</cfif>
				</cfif>
			</cfloop>
		</cfif>
		
	<!--- This is for converting url fields to attributes scoped variables --->
	<cfelse>
		<cfloop list="#cgi.query_string#" delimiters="&" index="valuepair">
			<cfset URLName = "#ListGetAt(valuepair, 1, "=")#"> 
			<CFIF refindnocase("[[:alpha:]]",left(trim(urlname),1)) and NOT ISDEFINED( 'caller.ATTRIBUTES.' & urlname )>
				<!--- <cfset "caller.attributes.#urlname#" = "#evaluate("url."&"#urlname#")#"> --->
				<cfset structinsert(caller.attributes,"#urlname#","#evaluate("url."&"#urlname#")#")>
				<cfif attributes.createattributeslist>
					<cfset request.attributeslist = listappend(request.attributeslist,urlname,"&")>
					<cfset request.attributeslist = listappend(request.attributeslist,urlencodedformat(evaluate("url.#urlname#")),"=")>
				</cfif>
			</CFIF>
		</cfloop>
	</cfif>
</cfif>

<!--- This is for converting form fields to attributes scoped variables --->
<cfif isdefined("form.fieldnames")>
	<cfloop list="#form.fieldnames#" index="field">
		<CFIF refindnocase("[[:alpha:]]",left(trim(field),1)) and NOT ISDEFINED( 'Caller.ATTRIBUTES.' & trim(field) )>
			<cfset structinsert(caller.attributes,"#trim(field)#","#evaluate("form.#trim(field)#")#")>
			<cfif attributes.createattributeslist>
				<cfset request.attributeslist = listappend(request.attributeslist,trim(field),"&")>
				<cfset request.attributeslist = listappend(request.attributeslist,urlencodedformat(evaluate("form.#trim(field)#")),"=")>
			</cfif>
		</cfif>
	</cfloop>
</cfif>

<!--- this is so that your relative images will work, this is only needed if your using search engine urls --->
<cfif attributes.displaybase>
	<CFSET script = REReplace(CGI.SCRIPT_NAME, "[^/]+\.cfm.*", "")>
	<CFSET caller.Base= "http://#CGI.SERVER_NAME##script#/">
	<CFIF CGI.SERVER_PORT NEQ 80>
		<CFSET caller.Base= "https://#CGI.SERVER_NAME##script#/">
	</CFIF>
	<cfhtmlhead text="<base href=""#caller.Base#"">">
</cfif>
<cfsetting enablecfoutputonly="No">
