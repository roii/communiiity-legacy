<!--- INSERT Goal --->
		
		<cfquery name="Addbizidea" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO bizidea_type(
		biz_type
		)
		
		VALUES(
		'#trim(form.biz_ideatype)#'
		)
		</cfquery>
		

<cflocation url="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=9&articleID=17">