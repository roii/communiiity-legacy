<cfcomponent output="false" displayName="Page DAO" hint="Does DAO for Pages">

	<cfset variables.dsn = "">
	<cfset variables.databaseType = "">
	<cfset variables.databaseTableName = "pages">
	
	<cffunction name="init" access="public" returnType="PageDAO" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="databaseType" type="string" required="true">
		<cfargument name="databaseTablePrefix" type="string" default="">
		<cfargument name="wiki" type="string" required="true">
		
		<cfset variables.dsn = arguments.dsn>
		<cfset variables.databaseType = arguments.databaseType>
		<cfset variables.databaseTableName = "#arguments.databaseTablePrefix#pages">
		<cfset variables.wiki = arguments.wiki>
		
		<cfreturn this>
	</cffunction>

	<cffunction name="create" access="public" returnType="PageBean" output="false">
		<cfargument name="pBean" type="PageBean" required="true">
		
		<cfquery datasource="#dsn#">
			insert into #variables.databaseTableName#
			(id, path,body,datetimecreated,author,version,summary,categories,authrolestoview,authrolestoedit,filename, filesize, filemimetype, imagewidth, imageheight,wiki)
			values(
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getID()#" maxlength="35">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getPath()#" maxlength="255">,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.pBean.getBody()#">,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.pBean.getDateTimeCreated()#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getAuthor()#" maxlength="255">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pBean.getVersion()#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getSummary()#" maxlength="255">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getCategoryList()#" maxlength="255">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getAuthRolesToViewList()#" maxlength="255">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getAuthRolesToEditList()#" maxlength="255">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getFileName()#" maxlength="255">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getFileSize()#" maxlength="255">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pBean.getFileMimeType()#" maxlength="255">,
				<cfif isnumeric(arguments.pBean.getImageWidth())>
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pBean.getImageWidth()#" maxlength="255">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pBean.getImageHeight()#" maxlength="255">,
				<cfelse>
					<cfqueryparam cfsqltype="cf_sql_integer" null="true" maxlength="255">,
					<cfqueryparam cfsqltype="cf_sql_integer" null="true" maxlength="255">,
				</cfif>
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.wiki#" maxlength="255">
				)
		</cfquery>

		<cfreturn pBean>
	</cffunction>

	<cffunction name="new" access="public" returnType="PageBean" output="false">
		<cfreturn createObject("component", "PageBean")>
	</cffunction>
		
	<cffunction name="read" access="public" returnType="PageBean" output="false">
		<cfargument name="id" type="uuid" required="true">
		<cfset var pBean = createObject("component", "PageBean")>
		<cfset var getit = "">
		
		<cfquery name="getit" datasource="#variables.dsn#">
			select 	id, path, body, datetimecreated, author, version, summary, categories,authrolestoview,authrolestoedit,filename, filesize, filemimetype, imagewidth, imageheight
			from	#variables.databaseTableName#
			where	id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.id#" maxlength="35">
		</cfquery>
		
		<cfif getit.recordCount>
			<cfset pBean.setID(getit.id)>
			<cfset pBean.setPath(getit.path)>
			<cfset pBean.setBody(getit.body)>
			<cfset pBean.setDateTimeCreated(getit.datetimecreated)>
			<cfset pBean.setAuthor(getit.author)>
			<cfset pBean.setVersion(getit.version)>
			<cfset pBean.setSummary(getit.summary)>
			<cfset pBean.setCategories(ListToArray(getit.categories))>
			<cfset pBean.setAuthRolesToView(ListToArray(getit.AuthRolesToView))>
			<cfset pBean.setAuthRolesToEdit(ListToArray(getit.AuthRolesToEdit))>
			<cfset pBean.setFileName(getit.FileName)>
			<cfset pBean.setFileSize(getit.FileSize)>
			<cfset pBean.setFileMimeType(getit.FileMimeType)>
			<cfset pBean.setImageWidth(getit.ImageWidth)>
			<cfset pBean.setImageHeight(getit.ImageHeight)>
		</cfif>
		
		<cfreturn pBean>
	</cffunction>

</cfcomponent>