<!--- INSERT Goal --->
		
		<cfquery name="Addbizidea" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO mylibtype(
		libtype
		)
		
		VALUES(
		'#trim(form.mylibtype)#'
		)
		</cfquery>
		

<cflocation url="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=docs&documentid=30">