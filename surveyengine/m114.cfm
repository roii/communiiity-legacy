<!--- Copy Question in the table --->
<cfif isdefined("fid")>
	<cfquery  datasource="#datasourceW#" name="CopyQuestion">
		select questiontype,question,option1,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,validation,itemid,datein
		from #tablequestions#
		where formid = #val(formid)#
	</cfquery>
	<cfloop query="CopyQuestion">
		<cfquery  datasource="#datasourceW#" name="InsertQuestions">
			insert into #tablequestions# (questiontype,question,<cfif len(option1)>option1,</cfif><cfif len(option2)>option2,</cfif><cfif len(option3)>option3,</cfif><cfif len(option4)>option4,</cfif><cfif len(option5)>option5,</cfif><cfif len(option6)>option6,</cfif><cfif len(option7)>option7,</cfif><cfif len(option8)>option8,</cfif><cfif len(option9)>option9,</cfif><cfif len(option10)>option10,</cfif>formid,vendorid,itemid,datein,validation)
			values (#questiontype#,'#question#',<cfif len(option1)>'#option1#',</cfif><cfif len(option2)>'#option2#',</cfif><cfif len(option3)>'#option3#',</cfif><cfif len(option4)>'#option4#',</cfif><cfif len(option5)>'#option5#',</cfif><cfif len(option6)>'#option6#',</cfif><cfif len(option7)>'#option7#',</cfif><cfif len(option8)>'#option8#',</cfif><cfif len(option9)>'#option9#',</cfif><cfif len(option10)>'#option10#',</cfif>#fid#,#val(vendorid)#,#itemid#,#now()#,0)
		</cfquery>
	</cfloop>
	<cflocation url="default.cfm?formid=#val(fid)#&obj=002">
</cfif>
