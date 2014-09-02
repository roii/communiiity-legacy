
<!--- INSERT myLib --->
		
		<cfquery name="Addbizidea" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO myLib(
		myLibTypeID,
		title,
		author_fn,
		author_ln,
		ages,
		media_type,
		copies,
		display
		)
		
		VALUES(
		#form.myLibTypeID#, 
		'#form.title#',
		'#form.author_fn#',
		'#form.author_ln#',
		'#form.ages#',
		'#form.media_type#',
		#form.copies#,
		#form.display#
		)
		</cfquery>
		

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_myLib">