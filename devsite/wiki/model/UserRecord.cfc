<cfcomponent hint="User Record">

<cfset variables.instance=StructNew()>
<cfset variables.instance.PASSWORD_HASH_ALGORITHM="SHA-256" />
<cfset variables.instance.SYSOP_ROLE="sysop" />

<cffunction name="init" output="false" returntype="any">
	<cfset variables.instance.username="anonymous">
	<cfset variables.instance.password="">
	<cfset variables.instance.firstName="">
	<cfset variables.instance.lastName="">
	<cfset variables.instance.uniqueId="">
	<cfset variables.instance.roles="">
	<cfset variables.instance.isLoggedIn=false>
	<cfset variables.instance.postLoginEvent="Main" />
	<cfreturn this />
</cffunction>

<cffunction name="load" output="false" returntype="numeric">
     <!---<cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT * FROM contacts WHERE contactid = #userID#
	 </cfquery>--->
    <cfset user = getUserName()>
	<cfset pass = getPassword()>  
	
	<cfquery name="getUserData" datasource="sherbrooke_dsn" username="sherbrookois" password="hjjk883_hfH" maxrows="1">
	    SELECT * FROM contacts WHERE EmailAddress = '#user#' and Password = '#pass#'
    </cfquery>  
	
	<cfif getUserData.recordcount gt 0>
	    <cfset setFirstName(#getUserData.FirstName#)>
		<cfset setLastName(#getUserData.LastName#)>
		<cfset setUniqueId(#getUserData.ContactID#)>
		<cfset setRoles("admin,user")>
		<cfset variables.instance.isLoggedIn=true>
		<cfset status = 1>
	<cfelse>
	    <cfset status = 0>
	</cfif>
	
	<!---<cfswitch expression="#getUserName()#">
		<cfcase value="sysop"> password:sysop 
			<cfset setFirstName("Wiki")>
			<cfset setLastName("Sysop")>
			<cfset setUniqueId("1111111")>
			<cfset setRoles("sysop,admin,user")>
		</cfcase>
		<cfcase value="admin"> password:admin 
			<cfset setFirstName("Wiki")>
			<cfset setLastName("Admin")>
			<cfset setUniqueId("2222222")>
			<cfset setRoles("admin,user")>
		</cfcase>
		<cfcase value="user"> password:user 
			<cfset setFirstName("John")>
			<cfset setLastName("Doe")>
			<cfset setUniqueId("9999999")>
			<cfset setRoles("user")>
		</cfcase>
		<cfdefaultcase><cfthrow message="Invalid User"></cfdefaultcase>
	</cfswitch>--->
	<cfreturn status />
</cffunction>

<cffunction name="login" access="public" hint="I log this user into the site" output="false" returntype="boolean"> 
	<!--- make this do some type of real authentication if desired--->
	<!--- you can find the plain-text passwords that match these users in the load() function --->
	<cfset variables.instance.username= "#FORM.username#">
	<cfset variables.instance.password="#FORM.password#"> 
	
	<cfif IsDefined("FORM.username") and #FORM.username# neq '' and IsDefined("FORM.password") and #FORM.password# neq ''>
		<!--- load() to set all the values for the current user --->
		<cfset status = load()>
		<cfif status eq 1>
		   <cfset setIsLoggedIn(true)>
		<cfelse>
		   <cfset setIsLoggedIn(false)>
		</cfif>   
	</cfif>
	<!---
	<cfoutput>
		getUserName()=#getUserName()#<br />
		getpasswordHash()=#getpasswordHash()#<br />
		getIsLoggedIn()=#getIsLoggedIn()#<br />
		#_toString()#
		<!--- <cfabort> --->
	</cfoutput>
	--->
	<cfreturn getIsLoggedIn() />
</cffunction>

<cffunction name="logout" access="public" output="false" returntype="void">
	<cfset init() >
	<cfreturn />
</cffunction>

<cffunction name="getFullName" access="public" hint="I return the user's full name." output="false" returntype="string">
	<cfreturn getFirstName() & " " & getLastName() />
</cffunction>

<!--- postLoginEvent --->
<cffunction name="setPostLoginEvent" access="public" output="false" returntype="void">
   <cfargument name="postLoginEvent" hint="I store where the user goes after logging in." required="yes" type="string" />
   <cfset variables.instance.postLoginEvent = arguments.postLoginEvent />
</cffunction>

<cffunction name="getPostLoginEvent" access="public" output="false" returntype="string">
   <cfreturn variables.instance.postLoginEvent />
</cffunction>
	
<!--- postLoginPath --->
<cffunction name="setPostLoginPath" access="public" output="false" returntype="void">
   <cfargument name="postLoginPath" hint="I store where the user goes after logging in." required="yes" type="string" />
   <cfset variables.instance.postLoginPath = arguments.postLoginPath />
</cffunction>

<cffunction name="getPostLoginPath" access="public" output="false" returntype="string">
   <cfif structKeyExists(variables.instance, "postLoginPath")>
	   <cfreturn variables.instance.postLoginPath />
   <cfelse>
	   <cfreturn "">
   </cfif>
</cffunction>
	
<!--- STUB OUT A GENERIC USER RECORD --->
<cffunction name="getUserName" output="false" returntype="string">
	<cfreturn variables.instance.userName />
</cffunction>

<cffunction name="setUserName" output="false" returntype="void">
	<cfargument name="userName" type="string">
	<cfset variables.instance.userName=arguments.userName>
	<cfreturn />
</cffunction>

<cffunction name="getPassword" output="false" returntype="string">
	<cfreturn variables.instance.password />
</cffunction>

<cffunction name="getPasswordHash" output="false" returntype="string">
	<cfreturn Hash(getPassword(), variables.instance.PASSWORD_HASH_ALGORITHM) />
</cffunction>

<cffunction name="setPassword" output="false" returntype="void">
	<cfargument name="password" type="string">
	<cfset variables.instance.password=arguments.password>
	<cfreturn />
</cffunction>

<cffunction name="getFirstName" output="false" returntype="string">
	<cfreturn variables.instance.firstName />
</cffunction>

<cffunction name="setFirstName" output="false" returntype="void">
	<cfargument name="firstName" type="string">
	<cfset variables.instance.firstName=arguments.firstName>
	<cfreturn />
</cffunction>

<cffunction name="getLastName" output="false" returntype="string">
	<cfreturn variables.instance.lastName />
</cffunction>

<cffunction name="setLastName" output="false" returntype="void">
	<cfargument name="lastName" type="string">
	<cfset variables.instance.lastName=arguments.lastName>
	<cfreturn />
</cffunction>

<cffunction name="getUniqueId" output="false" returntype="string">
	<cfreturn variables.instance.uniqueId />
</cffunction>

<cffunction name="setUniqueId" output="false" returntype="void">
	<cfargument name="uniqueId" type="string">
	<cfset variables.instance.uniqueId=arguments.uniqueId>
	<cfreturn />
</cffunction>

<cffunction name="getRoles" output="false" returntype="string">
	<cfreturn variables.instance.roles />
</cffunction>

<cffunction name="hasSysopRole" output="false" returntype="string">
	<cfreturn hasRole(variables.instance.SYSOP_ROLE)>
</cffunction>

<cffunction name="hasRole" output="false" returntype="boolean" hint="Pass in one or more roles (comma-delimited list) to see if user has that role">
	<!--- can pass either a single role or a list of roles --->
	<cfargument name="roles" type="string" required="yes"> 
	<!--- if a list of roles passed in, use this delimiter --->
	<cfargument name="Delimiter" type="string" default=","> 
	<cfset var returnBool=false>
	<cfset var currUserRoles=getRoles()>
	<cfset var roleToCheck="">
	<!--- put the extra check here so we don't get into an endless loop --->
	<cfif (NOT arguments.roles.equalsIgnoreCase(variables.instance.SYSOP_ROLE)) AND hasSysopRole()>
		<!--- sysop user have all access --->
		<cfset returnBool=true>
	<cfelse>
		<cfloop index="roleToCheck" list="#arguments.roles#" delimiters="#arguments.delimiter#">
			<cfif ListFindNoCase(currUserRoles, trim(roleToCheck)) or (trim(lcase(roleToCheck)) eq "all")>
				<cfset returnBool=true>
				<cfbreak>
			</cfif>
		</cfloop>
	</cfif>
	<cfreturn returnBool>
</cffunction>

<cffunction name="setRoles" output="false" returntype="void">
	<cfargument name="roles" type="string">
	<cfset variables.instance.roles=arguments.roles>
	<cfreturn />
</cffunction>

<cffunction name="getIsLoggedIn" output="true" returntype="boolean"> 
	<cfreturn variables.instance.isLoggedIn />
</cffunction>

<cffunction name="setIsLoggedIn" output="false" returntype="void">
	<cfargument name="isLoggedIn" type="boolean">
	<cfset variables.instance.isLoggedIn=arguments.isLoggedIn>
	<cfreturn />
</cffunction>

<cffunction name="_toString" output="false" returntype="string">
	<cfargument name="itemDelim" type="string" default="#CHR(13)#"><!--- pass in "<br />" for html output --->
	<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
	<cfset sb.append("[").append("UserName").append("=").append(getUserName()).append("]").append(arguments.itemDelim)>
	<cfset sb.append("[").append("FirstName").append("=").append(getFirstName()).append("]").append(arguments.itemDelim)>
	<cfset sb.append("[").append("LastName").append("=").append(getLastName()).append("]").append(arguments.itemDelim)>
	<cfset sb.append("[").append("Password").append("=").append(getPassword()).append("]").append(arguments.itemDelim)>
	<cfset sb.append("[").append("UniqueId").append("=").append(getUniqueId()).append("]").append(arguments.itemDelim)>
	<cfset sb.append("[").append("Roles").append("=").append(getRoles()).append("]").append(arguments.itemDelim)>
	<cfset sb.append("[").append("IsLoggedIn").append("=").append(getIsLoggedIn()).append("]").append(arguments.itemDelim)>
	<cfset sb.append("[").append("PostLoginEvent").append("=").append(getPostLoginEvent()).append("]").append(arguments.itemDelim)>
	<cfset sb.append("[").append("PostLoginPath").append("=").append(getPostLoginPath()).append("]").append(arguments.itemDelim)>
	<cfreturn sb.toString() />
</cffunction>

</cfcomponent>