<!---
	Name         : dsp.search.cfm
	Author       : Raymond Camden 
	Created      : 06/20/06
	Last Updated : 
	History      : 
--->

<cfset viewState.setValue("title","Search")>
<cfset searchterms = viewState.getValue("searchterms")>

<cfoutput>
<h1>Search</h1>
<form action="#viewState.getValue("myself")#search" method="post">
	<input type="text" name="searchterms" value="#searchterms#" /> 
	<input type="submit" value="Search" />
</form>
</cfoutput>