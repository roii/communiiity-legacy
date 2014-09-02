<cfcomponent name="wikidiff" output="false">
<!--- 
PURPOSE:
Create a unified interface (?) to a diff routine so that it doesn't really matter
what the back-end diff is. This was initially created so I could test several
back-ends without changing my MG code...
--->

<cfset variables.instance=StructNew()>

<cffunction name="init" output="false" access="public" returntype="any">
	<cfargument name="string1" type="string" default="">
	<cfargument name="string2" type="string" default="">
	<cfset setString1(arguments.string1)>
	<cfset setString2(arguments.string2)>
	<cfset setResult("")>
	<cfset setDiffObj(CreateObject("component", "osbornediff"))><!--- use the Rick Osborne diff CFC --->
	<!--- expose public variables from osbornediff --->
	<cfset this.OPERATION_INSERT=getDiffObj().OPERATION_INSERT>
	<cfset this.OPERATION_UPDATE=getDiffObj().OPERATION_UPDATE>
	<cfset this.OPERATION_DELETE=getDiffObj().OPERATION_DELETE>
	<cfreturn this>
</cffunction>

<cffunction name="setString1" output="false" access="public" returntype="void">
	<cfargument name="string1" type="string" required="true">
	<cfset variables.instance.string1=arguments.string1>
	<cfreturn />
</cffunction>

<cffunction name="getString1" output="false" access="public" returntype="string">
	<cfreturn variables.instance.string1>
</cffunction>

<cffunction name="setString2" output="false" access="public" returntype="void">
	<cfargument name="string2" type="string" required="true">
	<cfset variables.instance.string2=arguments.string2>
	<cfreturn />
</cffunction>

<cffunction name="getString2" output="false" access="public" returntype="string">
	<cfreturn variables.instance.string2>
</cffunction>

<cffunction name="setResult" output="false" access="public" returntype="void">
	<cfargument name="result" type="any" required="true">
	<cfset variables.instance.result=arguments.result>
	<cfreturn />
</cffunction>

<cffunction name="getResult" output="false" access="public" returntype="any">
	<cfreturn variables.instance.result>
</cffunction>

<cffunction name="setDiffObj" output="false" access="public" returntype="void">
	<cfargument name="diffObj" type="any" required="true">
	<cfset variables.instance.diffObj=arguments.diffObj>
	<cfreturn />
</cffunction>

<cffunction name="getDiffObj" output="false" access="public" returntype="any">
	<cfreturn variables.instance.diffObj>
</cffunction>

<cffunction name="doDiff" output="false" access="public" returntype="void">
	<cfset var local=StructNew()>
	<cfset var EndOfLine="#Chr(13)##Chr(10)#" />
	<cfset local.diffObj=getDiffObj()>
	<!--- get differences (returned as a query) --->
	<cfset local.qDiff=local.diffObj.Diff(getString1(), getString2())>
	<!--- parallelize the differences to get a query usable for display --->
	<cfset local.qDiffP=local.diffObj.Parallelize(local.qDiff, ListToArray(getString1(), EndOfLine), ListToArray( getString2(), EndOfLine))>
	<!--- osborne diff object returns a query --->
	<cfset setResult(local.qDiffP)>
	<cfreturn />
</cffunction>

</cfcomponent>