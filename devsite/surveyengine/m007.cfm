 <cfquery  name="BuildResponses" datasource="#datasourceR#">
	select 
	q.option1 as a1, q.option2 as a2, q.option3 as a3, q.option4 as a4,
	q.option5 as a5, q.option6 as a6, q.option7 as a7, q.option8 as a8, q.option9 as a9, q.option10 as a10,
	r.option1 as r1, r.option2 as r2, r.option3 as r3, r.option4 as r4, r.option5 as r5,
	r.option6 as r6, r.option7 as r7, r.option8 as r8, r.option9 as r9, r.option10 as r10,
	q.question, r.openquestion
  	from #tablequestions# q, #tableresponses# r
	where q.id = r.questionid
	and q.formid = r.formid
	and q.formid = #formid#
	and r.itemid = #itemid#
</cfquery> 


