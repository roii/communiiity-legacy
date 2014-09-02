<cfcomponent displayname="UserController" output="false" hint="I am the controller for a User." extends="ModelGlue.Core.Controller">

	<!--- Constructor --->
	<cffunction name="Init" access="Public" returnType="UserController" output="false" hint="I build a new UserController">
		<cfargument name="ModelGlue" required="true" type="any" />
		<cfargument name="InstanceName" required="true" type="string" />
		<cfset super.Init(arguments.ModelGlue) />

		<!--- get the canvas setup config bean --->
		<cfset variables.CanvasConfig = GetModelGlue().GetConfigBean("CanvasConfig").GetConfig() />

		<cfreturn this />
	</cffunction>
	
	<!--- DoLogout --->
	<cffunction name="DoLogout" access="Public" returntype="void" output="false" hint="I log a user out.">
		<cfargument name="event" type="any" required="true">
		<cfset var ScopeFacade = CreateObject("Component", "#variables.canvasconfig.root#.model.util.ScopeFacade").init("session") />
		<cfset ScopeFacade.GetValue("UserRecord").logout() />
		<cfset arguments.event.setValue("UserRecord", ScopeFacade.getValue("UserRecord")) />
	</cffunction>
	
	<!--- GetUserCredentials --->
	<cffunction name="GetUserCredentials" access="Public" returntype="void" output="false" hint="I get a user's credentials.">
		<cfargument name="event" type="any" required="true">
		<cfset var UserRecord = arguments.event.getValue("UserRecord") />
		<!--- don't check to see if user is logged in b/c an anonymous user may have default roles --->
		<cfset arguments.event.setValue("userRoles", userRecord.getRoles())>
	</cffunction>
	
	<!--- DoValidateLogin --->
	<cffunction name="DoValidateLogin" access="Public" returntype="void" output="false" hint="I validate a login.">
		<cfargument name="event" type="any" required="true">
		<cfset var UserRecord = arguments.event.getValue("UserRecord") />
		<cfset arguments.event.makeEventBean(UserRecord) />
		<cfif UserRecord.login()>
			<!--- restore the user's event --->
			<cfset RestoreEventValues(arguments.event) />
			<cfif len(userRecord.getPostLoginPath())>
				<cfset arguments.event.setValue("path", UserRecord.getPostLoginPath())>
				<cfset arguments.event.forward(UserRecord.getPostLoginEvent(), "path") />
			<cfelse>
				<!--- go to default event. --->
				<!--- for right now, cheat and just go to index.cfm. Later switch to grabbing from the api the default event. --->
				<cflocation url="index.cfm" addToken="false">
			</cfif>
		<cfelse>
			<cfset arguments.event.addResult("invalid") />
		</cfif>
	</cffunction>
	
	<!--- DoCheckIfLoggedIn --->
	<cffunction name="DoCheckIfLoggedIn" access="Public" returntype="void" output="false" hint="I check if a user is logged in.">
		<cfargument name="event" type="any" required="true">
		<cfset var UserRecord = arguments.event.getValue("UserRecord") />
		<cfset var pageObj = arguments.event.getValue("page") />
		<cfset var returnToEvent = getModelGlue().getConfigSetting("defaultEvent") />
		<!--- determine the pageMode we are in: edit or view --->	
		<cfset var pageMode="VIEW">
		<cfset var loginRequired=false>
		<cfif arguments.event.ArgumentExists("pageMode")>
			<cfset pageMode=arguments.event.getArgument("pageMode")>
		</cfif>
		<cfswitch expression="#pageMode#">
			<cfcase value="EDIT">
				<cfset loginRequired=variables.CanvasConfig.LoginRequiredForEditing>
			</cfcase>
			<cfcase value="VIEW">
				<cfset loginRequired=variables.CanvasConfig.LoginRequiredForViewing>
			</cfcase>
		</cfswitch>
		<cfif arguments.event.argumentExists("returnToEvent")>
			<cfset returnToEvent = arguments.event.getArgument("returnToEvent") />
		</cfif>
		
		<cfif (LoginRequired AND NOT UserRecord.getIsLoggedIn())>
			<!--- save the current page path the user is viewing --->
			<cfset UserRecord.setPostLoginEvent(returnToEvent) />
			<cfset UserRecord.setPostLoginPath(pageObj.getPath()) />
			<cfset arguments.event.setValue("UserRecord", UserRecord) />
			<!--- save the current event --->
			<cfset SaveEventValues(arguments.event) />
			<cfset arguments.event.forward("LoginForm") />
		</cfif>
	</cffunction>
	
	<!--- SaveEventValues --->
	<cffunction name="SaveEventValues" access="private" returntype="void" output="false" hint="I save event arguments.">
		<cfargument name="event" type="any" required="true">
		<cfset var ScopeFacade = CreateObject("Component", "#variables.canvasconfig.root#.model.util.ScopeFacade").init("session") />
		<cfset ScopeFacade.SetValue("EventValues", arguments.event.getAllValues()) />		
	</cffunction>
	
	<!--- RestoreEventValues --->
	<cffunction name="RestoreEventValues" access="private" returntype="void" output="false" hint="I restore saved event arguments.">
		<cfargument name="event" type="any" required="true">
		<cfset var ScopeFacade = CreateObject("Component", "#variables.canvasconfig.root#.model.util.ScopeFacade").init("session") />
		<cfset var eventValues = ScopeFacade.getValue("EventValues", StructNew()) />
		<cfset var item = 0 />
		
		<cfloop collection="#eventValues#" item="item">
			<cfset arguments.event.setValue(item, eventValues[item]) />
		</cfloop>
		
		<cfset ScopeFacade.removeValue("EventValues") />
	</cffunction>
	
	<!--- Functions specified by <message-listener> tags --->
	<cffunction name="OnRequestStart" access="Public" returntype="void" output="false" hint="I am an event handler.">
		<cfargument name="event" type="any" required="true">
		<cfset var ScopeFacade = CreateObject("Component", "#variables.canvasconfig.root#.model.util.ScopeFacade").init("session") />

		
		<cfif NOT ScopeFacade.Exists("UserRecord")>
			<cfset ScopeFacade.SetValue("UserRecord", CreateObject("Component", "#variables.canvasconfig.root#.model.UserRecord").init()) /> 
		</cfif>

		<cfset arguments.event.setValue("UserRecord", ScopeFacade.getValue("UserRecord")) />
			
	</cffunction>

	<cffunction name="OnRequestEnd" access="Public" returntype="void" output="false" hint="I am an event handler.">
		<cfargument name="event" type="any" required="true">
	</cffunction>

</cfcomponent>
