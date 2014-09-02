<cfsetting enablecfoutputonly="yes">
<!--- This tag will turn all 'Form' and 'URL' scoped variables into 
'Attributes' scoped variables.  This allows you to have a common scope 
of variables, thus allowing you to call the entire application i.e. index.cfm
as a CFMODULE or as a regular application.
Designed for: CF 4.01+
--->
<cfparam name="request.attributeslist" default="">
<cfparam name="setfuseaction" default="">
<cfparam name="attributes.displaybase" default="yes">
<cfparam name="caller.id" default="">

<!--- This will convert URL variables to attribute variables --->
<cfif isdefined("cgi.query_string") and isdefined("cgi.path_info")>
	<cfif not len(cgi.query_string)>
		<!--- This will support Search Engine capable URLs
			ex: http://127.0.0.1/index.cfm/fuseaction/shoppingcart/additems/127,88/myvar/hello+world --->
		<cfparam name="cleanpathinfo" default="#cgi.path_info#">
		
		<cfset findindex=findnocase("index.cfm",cleanpathinfo)>
		<cfif findindex>
			<cfset cleanpathinfo=RemoveChars(cleanpathinfo, 1, findindex+9)>
		</cfif>
		
		<cfif len(cleanpathinfo)>
			<!--- If you want to append .cfm onto the end of your URL, this will clean it 
				so it doesn't affect your variables --->
			<cfif len(cleanpathinfo) gte 4 and right(cleanpathinfo,4) is ".cfm">
				<cfset cleanpathinfo=RemoveChars(cleanpathinfo, len(cleanpathinfo)-3, 4)>
			</cfif>
			
			
			<cfloop index="i" from="1" to="#listlen(cleanpathinfo, "/")#" step="2"> 
				<cfset urlname = listgetat(cleanpathinfo, i, "/")>
				<cfif listlen(cleanpathinfo,"/") gte i+1>
					<cfset urlvalue = listgetat(cleanpathinfo, i + 1, "/")>
					<!--- This will allow you to pass slashes in your values, escape your / with a slash_ --->
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
								    <cfset "caller.attributes.#urlname#" = ""> 
								<cfelse> 
								    <cfset "caller.attributes.#urlname#" = urlvalue> 
								</cfif>
								<cfset request.attributeslist = listappend(request.attributeslist,urlname,"&")>
								<cfset request.attributeslist = listappend(request.attributeslist,urlencodedformat(evaluate("caller.attributes.#urlname#")),"=")>	
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
				<cfset "caller.attributes.#urlname#" = "#evaluate("url."&"#urlname#")#">
				
				<!--- Remove these next 2 lines if you don't want a list of all attributes... 
				it'll speed up processing by about .15 millisecond--->
				<cfset request.attributeslist = listappend(request.attributeslist,urlname,"&")>
				<cfset request.attributeslist = listappend(request.attributeslist,urlencodedformat(evaluate("url.#urlname#")),"=")>
			</CFIF>
		</cfloop>
	</cfif>
</cfif>

<!--- This is for converting form fields to attributes scoped variables --->
<cfif isdefined("form.fieldnames")>
	<cfloop list="#form.fieldnames#" index="field">
		<CFIF refindnocase("[[:alpha:]]",left(trim(field),1)) and NOT ISDEFINED( 'Caller.ATTRIBUTES.' & trim(field) )>
			<cfset "caller.attributes.#trim(field)#" = "#evaluate("form.#trim(field)#")#">
			<!--- This is so that you can have multiple type="image" buttons on the same page, if 
				you name the button name="fuseaction_[the value you want]" it will set the fuseaction
				to that value--->
			<cfif findnocase("fuseaction_",field) and findnocase(".x",field)>
				<cfset setfuseaction=replacenocase(field,"fuseaction_","")>
				<cfset setfuseaction=replacenocase(setfuseaction,".x","")>
				<cfif refind("[0-9]",setfuseaction)>
					<!--- This is so you can associate an "ID" with an image button (optional) like this:
						<INPUT type="Image" src="/IMAGES/MYIMAGE.GIF" NAME="fuseaction_addthisaddress56">
						it would return ID=56 That way you can a bunch of image buttons in the same form
						that do the same thing but each one has an ID associated with it.
						--->
					<cfset thisid=val(mid(setfuseaction,refind("[0-9]",setfuseaction),len(setfuseaction)))>
					<cfif thisid>
						<cfset caller.ID=thisid>
					</cfif>
				</cfif>
				
			</cfif>
			<!--- Remove these next 2 lines if you don't want a list of all attributes... 
			it'll speed up processing by about .15 millisecond--->
			<cfset request.attributeslist = listappend(request.attributeslist,trim(field),"&")>
			<cfset request.attributeslist = listappend(request.attributeslist,urlencodedformat(evaluate("form.#trim(field)#")),"=")>
		</cfif>
	</cfloop>
</cfif>
<cfif len(setfuseaction)>
	<cfset caller.attributes.fuseaction=setfuseaction>
	<cfif len(caller.id)>
		<cfset caller.attributes.fuseaction=replace(setfuseaction,caller.id,"")>
	</cfif>
</cfif>

<!--- this is so that your relative images will work, this is only needed if your using search engine urls --->
<cfif attributes.displaybase>
	<CFSET caller.Base = REReplace(CGI.SCRIPT_NAME, "[^/]+\.cfm.*", "")>
	<CFSET caller.Base= "http://" & CGI.SERVER_NAME & caller.Base>
	<cfoutput><base href="#caller.Base#"></cfoutput>
</cfif>
<cfsetting enablecfoutputonly="No">

