<cfquery  datasource="#datasourceR#" name="ExportInfo">
	select *
	from #tableresponses#
	where formid = #formid#
	<cfif session.accesslevel lt 3>
		and vendorid = #vendorid#	
	</cfif>
</cfquery>

<cffile action="APPEND" file="#logdir#\#formid#.csv" output="sample">
<cffile action="DELETE" file="#logdir#\#formid#.csv">
	
<cfoutput query="ExportInfo">
	<cffile action="APPEND" file="#logdir#\#formid#.csv" output=" ""#id#"", ""#itemid#"", ""#dateIn#"", ""#formid#"", ""#questionid#"", ""#vendorid#"", ""#respondentid#"", ""#option1#"",""#option2#"",""#option3#"",""#option4#"",""#option5#"",""#option6#"",""#option7#"",""#option8#"",""#option9#"",""#option10#"",""#openquestion#"",""#ip#"",""#browser#""">
</cfoutput>

<cfoutput><h2><a href="#setupdir#/log/#formid#.csv">Download #formid#.csv</a></h2></cfoutput>