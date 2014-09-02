<cfcomponent name="Diff" displayname="Diff" hint="Text file differencing engine" namespace="org.rickosborne">
<!--- REV. 13 (4-OCT-2006) --->
	<!--- 
	diff.cfc
	Original coding by Rick Osborne
	Based on various differencing engines found on the intarweb
	
	License: Mozilla Public License (MPL) version 1.1 - http://www.mozilla.org/MPL/
	READ THE LICENSE BEFORE YOU USE OR MODIFY THIS CODE
	 --->
	<cfset this.OPERATION_INSERT="+">
	<cfset this.OPERATION_UPDATE="!">
	<cfset this.OPERATION_DELETE="-">
	
	<cffunction name="ResultColumnList" hint="Return the list of columns present in any result query" access="public" output="false" returntype="string">
		<cfreturn "Operation,AtFirst,AtSecond,Count">
	</cffunction>
	
	<cffunction name="AddDifference" hint="Given a result query, add the new difference to it" access="public" output="false">
		<cfargument name="Result" type="query" required="true">
		<cfargument name="Operation" type="string" required="true">
		<cfargument name="AtFirst" type="string" required="true">
		<cfargument name="AtSecond" type="string" required="true">
		<cfargument name="Count" type="numeric" required="false">
		<cfset var ColName="">
		<cfif (Result.RecordCount GT 0) AND (Arguments.Operation EQ this.OPERATION_INSERT) AND (Arguments.Count EQ 1) AND (Result.Count[Result.RecordCount] EQ 1) AND (Arguments.AtSecond EQ Result.AtSecond[Result.RecordCount]) AND (Arguments.AtFirst EQ IncrementValue(Result.AtFirst[Result.RecordCount]))>
			<!---
			This is a special case for when the last line was a one-line 
			delete and this is a one-line insert, in other words, an update
			--->
			<cfset QuerySetCell(Result, "Operation", this.OPERATION_UPDATE, Result.RecordCount)>
		<cfelse>
			<cfset QueryAddRow(Result)>
			<!--- We can cheat instead of setting these by hand --->
			<cfloop collection="#Arguments#" item="ColName">
				<cfif ColName NEQ "Result">
					<cfset QuerySetCell(Result, ColName, Arguments[ColName], Result.RecordCount)>
				</cfif>
			</cfloop>
		</cfif>
		<!--- We don't need to return anything because queries are passed by reference --->
	</cffunction>
	
	<cffunction name="DiffArrays" hint="Compute the difference between two arrays" access="public" output="false" returntype="query">
		<cfargument name="First" type="array" required="true" />
		<cfargument name="Second" type="array" required="true" />
		<cfset var Result=QueryNew(this.ResultColumnList())>
		<cfset var i=0>
		<cfset var j=0>
		<cfset var k=0>
		<cfset var OneLen=ArrayLen(Arguments.First)>
		<cfset var TwoLen=ArrayLen(Arguments.Second)>
		<!--- We are actually only going to compare hashes, so that string comparisons will be fast --->
		<cfset var One=ArrayNew(1)>
		<cfset var Two=ArrayNew(1)>
		<cfset var LCS=ArrayNew(2)>
		<cfset var OneStart=1>
		<cfset var TwoStart=1>
		<cfset var OneStop=OneLen>
		<cfset var TwoStop=TwoLen>
		<cfset var ValIndexes=StructNew()>
		<cfset var NextIndex=1>
		<cfif OneLen GT 0><cfset ArrayResize(One,OneLen)></cfif>
		<cfif TwoLen GT 0><cfset ArrayResize(Two,TwoLen)></cfif>
		<!--- 
		Comparing lines is really slow because string comparisons are slow.
		Instead, we take either the line or the hash of the line (whichever is shorter).
		Then we give each unique line a unique identifier (index).
		Comparing indexes (integers) is therefore much faster.
		--->
		<cfloop from="1" to="#OneLen#" index="i">
			<cfset k=Arguments.First[i]>
			<cfif Len(k) GT 32><cfset k=Hash(k)></cfif>
			<cfif NOT StructKeyExists(ValIndexes,k)>
				<cfset ValIndexes[k]=NextIndex>
				<cfset NextIndex=NextIndex+1>
			</cfif>
			<cfset One[i]=ValIndexes[k]>
			<!--- Allocate our LCS array as we go --->
		</cfloop>
		<!--- Add in the extra array --->
		<cfset ArrayResize(LCS[OneLen+1],TwoLen+1)>
		<cfloop from="1" to="#TwoLen#" index="j">
			<cfset k=Arguments.Second[j]>
			<cfif Len(k) GT 32><cfset k=Hash(k)></cfif>
			<cfif NOT StructKeyExists(ValIndexes,k)>
				<cfset ValIndexes[k]=NextIndex>
				<cfset NextIndex=NextIndex+1>
			</cfif>
			<cfset Two[j]=ValIndexes[k]>
		</cfloop>
		<!--- Let's skip past the part at the frint that is the same, if any --->
		<cfloop condition="(OneStart LTE OneLen) AND (TwoStart LTE TwoLen) AND (One[OneStart] EQ Two[TwoStart])">
			<cfset OneStart=OneStart+1>
			<cfset TwoStart=TwoStart+1>
		</cfloop>
		<!--- Then do the same in reverse --->
		<cfloop condition="(OneStop GTE OneStart) AND (TwoStop GTE TwoStart) AND (One[OneStop] EQ Two[TwoStop])">
			<cfset OneStop=OneStop-1>
			<cfset TwoStop=TwoStop-1>
		</cfloop>
		<!--- Now we do a bit of mojo to only compare the portions of the arrays that are different --->
		<cfset OneLen=1+OneStop-OneStart>
		<cfset TwoLen=1+TwoStop-TwoStart>
		<cfset ArrayResize(LCS,OneLen+1)>
		<!--- But first, we need to initialize our LCS array --->
		<cfloop from="1" to="#IncrementValue(OneLen)#" index="i">
			<cfset ArrayResize(LCS[i],TwoLen+1)>
			<cfset LCS[i][TwoLen+1]=0>
		</cfloop>
		<cfloop from="1" to="#IncrementValue(TwoLen)#" index="j">
			<cfset LCS[OneLen+1][j]=0>
		</cfloop>
		<cfset LCS[OneLen+1][TwoLen+1]=0>
		<cfset OneStart=OneStart-1>
		<cfset TwoStart=TwoStart-1>
		<!--- 
		Worst algorithm ever!
		TODO: Get a better algorithm!
		Basically, walk backwards through both arrays, building a ranking of common substrings.
		--->
		<cfloop from="#OneLen#" to="1" index="i" step="-1">
			<cfloop from="#TwoLen#" to="1" index="j" step="-1">
				<cfif One[i+OneStart] EQ Two[j+TwoStart]>
					<cfset LCS[i][j]=LCS[i+1][j+1] + 1>
				<cfelse>
					<cfset LCS[i][j]=Max(LCS[i+1][j],LCS[i][j+1])>
				</cfif>
			</cfloop>
		</cfloop>
		<cfset i=1>
		<cfset j=1>
		<!--- 
		Now we walk back through the arrays, looking for the path with the maximum values (longest common substrings)
		--->
		<cfloop condition="(i LTE OneLen) AND (j LTE TwoLen)">
			<cfif One[i+OneStart] EQ Two[j+TwoStart]>
				<cfset i=i+1>
				<cfset j=j+1>
			<cfelseif LCS[i+1][j] GTE LCS[i][j+1]>
				<cfset k=i>
				<!--- Try to find additional deletions --->
				<cfloop condition="(i LTE OneLen) AND (LCS[i+1][j] GTE LCS[i][j+1]) AND (One[i+OneStart] NEQ Two[j+TwoStart])">
					<cfset i=i+1>
				</cfloop>
				<cfset AddDifference(Result, this.OPERATION_DELETE, k+OneStart, j+TwoStart, i-k)>
			<cfelse>
				<cfset k=j>
				<!--- Try to find additional deletions --->
				<cfloop condition="(j LTE TwoLen) AND (LCS[i+1][j] LT LCS[i][j+1]) AND (One[i+OneStart] NEQ Two[j+TwoStart])">
					<cfset j=j+1>
				</cfloop>
				<cfset AddDifference(Result, this.OPERATION_INSERT, i+OneStart, k+TwoStart, j-k)>
			</cfif>
		</cfloop>
		<!--- Catch any stragglers --->
		<cfif (i LTE OneLen)>
			<cfset AddDifference(Result, this.OPERATION_DELETE, i+OneStart, j+TwoStart, OneLen - i + 1)>
		<cfelseif (j LTE TwoLen)>
			<cfset AddDifference(Result, this.OPERATION_INSERT, i+OneStart, j+TwoStart, TwoLen - j + 1)>
		</cfif>
		<cfreturn Result>
	</cffunction>

	<cffunction name="DiffFiles" hint="Compute the differences between two files, given the specified line terminator" access="public" output="false" returntype="query">
		<cfargument name="First" type="string" required="true" />
		<cfargument name="Second" type="string" required="true" />
		<cfargument name="EndOfLine" type="string" default="#Chr(10)#" required="false" />
		<cfset var Result="">
		<cfset var FirstFile="">
		<cfset var SecondFile="">
		<cfif FileExists(Arguments.First) AND FileExists(Arguments.Second)>
			<cffile action="read" file="#Arguments.First#" variable="FirstFile">
			<cffile action="read" file="#Arguments.Second#" variable="SecondFile">
			<cfset Result=this.DiffArrays(ListToArray(FirstFile, Arguments.EndOfLine), ListToArray(SecondFile, Arguments.EndOfLine))>
		</cfif>
		<cfif NOT IsQuery(Result)>
			<cfset Result=QueryNew(this.ResultColumnList())>
		</cfif>
		<cfreturn Result>
	</cffunction>

	<cffunction name="DiffStrings" hint="Compute the differences between two strings, given the specified line terminator" access="public" output="false" returntype="query">
		<cfargument name="First" type="string" required="true" />
		<cfargument name="Second" type="string" required="true" />
		<cfargument name="EndOfLine" type="string" default="#Chr(13)##Chr(10)#" required="false" />
		<cfreturn this.DiffArrays(ListToArray(Arguments.First, Arguments.EndOfLine), ListToArray(Arguments.Second, Arguments.EndOfLine))>
	</cffunction>

	<cffunction name="DiffStructs" hint="Compute the differences between two structures" access="public" output="false" returntype="query">
		<cfargument name="First" type="struct" required="true" />
		<cfargument name="Second" type="struct" required="true" />
		<cfargument name="IncludeContent" type="boolean" required="false" default="false" />
		<cfset var Result=QueryNew(this.ResultColumnList())>
		<cfset var Keys=StructNew()>
		<cfset var KeyName="">
		<cfloop collection="#Arguments.First#" item="KeyName">
			<cfset Keys[KeyName]=1>
		</cfloop>
		<cfloop collection="#Arguments.Second#" item="KeyName">
			<cfset Keys[KeyName]=1>
		</cfloop>
		<cfloop collection="#Keys#" item="KeyName">
			<cfif NOT StructKeyExists(Arguments.First, KeyName)>
				<!--- It must have been in the second, therefore was added --->
				<cfset AddDifference(Result, this.OPERATION_INSERT, KeyName, 1, "", "", "", "")>
			<cfelseif NOT StructKeyExists(Arguments.Second, KeyName)>
				<!--- It must have been in the first, therefore was deleted --->
				<cfset AddDifference(Result, this.OPERATION_DELETE, KeyName, 1, "", "", "", "")>
			<cfelseif Arguments.First[KeyName] NEQ Arguments.Second[KeyName]>
				<!--- TODO: Do we want to try harder to ensure we are comparing objects of the same type? --->
				<cfset AddDifference(Result, this.OPERATION_UPDATE, KeyName, 1, "", "", "", "")>
			</cfif>
		</cfloop>
		<cfreturn Result>
	</cffunction>

	<cffunction name="DiffQueries" hint="Compute the difference between two queries" access="public" output="false" returntype="query">
		<cfargument name="First" type="query" required="true" />
		<cfargument name="Second" type="query" required="true" />
		<cfargument name="ColumnList" type="string" required="false" />
		<!--- TODO: Implement DiffQueries Method --->
		<cfreturn />
	</cffunction>

	<cffunction name="Diff" access="public" output="false" returntype="query">
		<cfargument name="First" type="any" required="true" />
		<cfargument name="Second" type="any" required="true" />
		<cfset var Result="">
		<cfif IsArray(Arguments.First) AND IsArray(Arguments.Second)>
			<cfreturn this.DiffArrays(Arguments.First, Arguments.Second)>
		<cfelseif IsStruct(Arguments.First) AND IsStruct(Arguments.Second)>
			<cfreturn this.DiffStructs(Arguments.First, Arguments.Second)>
		<cfelseif IsQuery(Arguments.First) AND IsQuery(Arguments.Second)>
			<cfreturn this.DiffQueries(Arguments.First, Arguments.Second)>
		<cfelseif IsSimpleValue(Arguments.First) AND IsSimpleValue(Arguments.Second)>
			<cfif FileExists(Arguments.First) AND FileExists(Arguments.Second)>
				<cfreturn this.DiffFiles(Arguments.First, Arguments.Second)>
			<cfelse>
				<cfreturn this.DiffStrings(Arguments.First, Arguments.Second)>
			</cfif>
		</cfif>
		<cfif NOT IsQuery(Result)>
			<cfset Result=QueryNew(this.ResultColumnList())>
		</cfif>
		<cfreturn Result>
	</cffunction>
	
	<cffunction name="UnifiedDiffArrays" access="public" output="false" returntype="query">
		<cfargument name="Differences" type="query" required="true" />
		<cfargument name="First" type="array" required="true" />
		<cfargument name="Second" type="array" required="true" />
		<cfargument name="Context" type="numeric" required="false" default="3" />
		<cfset var P=Parallelize(Arguments.Differences, Arguments.First, Arguments.Second)>
		<cfset var Result=QueryNew(ListAppend(P.ColumnList,"Edge"))>
		<cfset var Want=StructNew()>
		<cfset var Rows=ArrayNew(1)>
		<cfset var R="">
		<cfset var C="">
		<cfloop query="P">
			<cfif P.Operation NEQ "">
				<cfloop from="#Max(1,P.CurrentRow-Arguments.Context)#" to="#Min(P.RecordCount,P.CurrentRow+Arguments.Context)#" index="R">
					<cfif NOT StructKeyExists(Want,R)>
						<cfset ArrayAppend(Rows,R)>
						<cfset Want[R]=1>
					</cfif>
				</cfloop>
			</cfif>
		</cfloop>
		<cfloop from="1" to="#ArrayLen(Rows)#" index="R">
			<cfset QueryAddRow(Result)>
			<cfloop list="#P.ColumnList#" index="C">
				<cfset Result[C][Result.RecordCount]=P[C][Rows[R]]>
			</cfloop>
			<cfif (R EQ 1) AND (R EQ ArrayLen(Rows))>
				<cfset Result.Edge[Result.RecordCount]="only">
			<cfelseif (R EQ 1) AND (Rows[R] EQ Rows[R+1]-1)>
				<cfset Result.Edge[Result.RecordCount]="top">
			<cfelseif (R EQ 1)>
				<cfset Result.Edge[Result.RecordCount]="whole">
			<cfelseif (R EQ ArrayLen(Rows)) AND (Rows[R-1]+1 EQ Rows[R])>
				<cfset Result.Edge[Result.RecordCount]="bottom">
			<cfelseif (R EQ ArrayLen(Rows))>
				<cfset Result.Edge[Result.RecordCount]="whole">
			<cfelseif (Rows[R-1]+1 EQ Rows[R+1]-1)>
				<cfset Result.Edge[Result.RecordCount]="middle">
			<cfelseif (Rows[R-1]+1 EQ Rows[R])>
				<cfset Result.Edge[Result.RecordCount]="bottom">
			<cfelseif (Rows[R] EQ Rows[R+1]-1)>
				<cfset Result.Edge[Result.RecordCount]="top">
			</cfif>
		</cfloop>
		<cfreturn Result>
	</cffunction>
	
	<cffunction name="LinearDiffArrays" access="public" output="false" returntype="query">
		<cfargument name="First" type="array" required="true" />
		<cfargument name="Second" type="array" required="true" />
		<cfset var Result=QueryNew("Operation,AtFirst,AtSecond,Value")>
		<cfset var Differences=Diff(Arguments.First, Arguments.Second)>
		<cfset var AtLeft=1>
		<cfset var AtRight=1>
		<cfloop query="Differences">
			<cfif AtLeft LT AtFirst>
				<cfloop from="#AtLeft#" to="#DecrementValue(AtFirst)#" index="AtLeft">
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "AtFirst", AtLeft, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtSecond", AtRight, Result.RecordCount)>
					<cfset QuerySetCell(Result, "Value", Arguments.First[AtLeft], Result.RecordCount)>
					<cfset AtRight=AtRight+1>
				</cfloop>
			</cfif>
			<cfif Operation EQ "+">
				<cfloop from="#AtSecond#" to="#DecrementValue(AtSecond+Count)#" index="AtRight">
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "Operation", Operation, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtSecond", AtRight, Result.RecordCount)>
					<cfset QuerySetCell(Result, "Value", Arguments.Second[AtRight], Result.RecordCount)>
				</cfloop>
			<cfelseif Operation EQ "-">
				<cfloop from="#AtFirst#" to="#DecrementValue(AtFirst+Count)#" index="AtLeft">
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "Operation", Operation, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtFirst", AtLeft, Result.RecordCount)>
					<cfset QuerySetCell(Result, "Value", Arguments.First[AtLeft], Result.RecordCount)>
				</cfloop>
			<cfelseif Operation EQ "!">
				<cfloop from="#AtFirst#" to="#DecrementValue(AtFirst+Count)#" index="AtLeft">
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "Operation", Operation, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtFirst", AtFirst, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtSecond", AtSecond, Result.RecordCount)>
					<cfset QuerySetCell(Result, "Value", Arguments.First[AtLeft], Result.RecordCount)>
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "Operation", Operation, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtFirst", AtFirst, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtSecond", AtSecond, Result.RecordCount)>
					<cfset QuerySetCell(Result, "Value", Arguments.Second[AtSecond], Result.RecordCount)>
				</cfloop>
				<cfset AtLeft=AtFirst+1>
				<cfset AtRight=AtSecond+1>
			</cfif>
		</cfloop>
		<cfreturn Result>
	</cffunction>
	
	<cffunction name="Parallelize" access="public" output="false" returntype="query">
		<cfargument name="Differences" type="query" required="true" />
		<cfargument name="First" type="array" required="true" />
		<cfargument name="Second" type="array" required="true" />
		<cfset var Result=QueryNew("Operation,AtFirst,AtSecond,ValueFirst,ValueSecond")>
		<cfset var AtLeft=1>
		<cfset var AtRight=1>
		<cfloop query="Arguments.Differences">
			<cfif AtLeft LT AtFirst>
				<cfloop from="#AtLeft#" to="#DecrementValue(AtFirst)#" index="AtLeft">
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "AtFirst", AtLeft, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtSecond", AtRight, Result.RecordCount)>
					<cfset QuerySetCell(Result, "ValueFirst", Arguments.First[AtLeft], Result.RecordCount)>
					<cfset QuerySetCell(Result, "ValueSecond", Arguments.Second[AtRight], Result.RecordCount)>
					<cfset AtRight=AtRight+1>
				</cfloop>
			</cfif>
			<cfif Operation EQ "+">
				<cfloop from="#AtSecond#" to="#DecrementValue(AtSecond+Count)#" index="AtRight">
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "Operation", Operation, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtSecond", AtRight, Result.RecordCount)>
					<cfset QuerySetCell(Result, "ValueSecond", Arguments.Second[AtRight], Result.RecordCount)>
				</cfloop>
			<cfelseif Operation EQ "-">
				<cfloop from="#AtFirst#" to="#DecrementValue(AtFirst+Count)#" index="AtLeft">
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "Operation", Operation, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtFirst", AtLeft, Result.RecordCount)>
					<cfset QuerySetCell(Result, "ValueFirst", Arguments.First[AtLeft], Result.RecordCount)>
				</cfloop>
			<cfelseif Operation EQ "!">
				<cfset AtRight=AtSecond>
				<cfloop from="#AtFirst#" to="#DecrementValue(AtFirst+Count)#" index="AtLeft">
					<cfset QueryAddRow(Result)>
					<cfset QuerySetCell(Result, "Operation", Operation, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtFirst", AtFirst, Result.RecordCount)>
					<cfset QuerySetCell(Result, "AtSecond", AtSecond, Result.RecordCount)>
					<cfset QuerySetCell(Result, "ValueFirst", Arguments.First[AtLeft], Result.RecordCount)>
					<cfset QuerySetCell(Result, "ValueSecond", Arguments.Second[AtRight], Result.RecordCount)>
					<cfset AtRight=AtSecond+1>
				</cfloop>
				<cfset AtLeft=AtFirst+1>
			</cfif>
		</cfloop>
		<cfif AtLeft LTE ArrayLen(Arguments.First)>
			<cfloop from="#AtLeft#" to="#ArrayLen(Arguments.First)#" index="AtLeft">
				<cfset QueryAddRow(Result)>
				<cfset QuerySetCell(Result, "AtFirst", AtLeft, Result.RecordCount)>
				<cfset QuerySetCell(Result, "AtSecond", AtRight, Result.RecordCount)>
				<cfset QuerySetCell(Result, "ValueFirst", Arguments.First[AtLeft], Result.RecordCount)>
				<cfset QuerySetCell(Result, "ValueSecond", Arguments.Second[AtRight], Result.RecordCount)>
				<cfset AtRight=AtRight+1>
			</cfloop>
		</cfif>
		<cfreturn Result>
	</cffunction>
	
</cfcomponent>