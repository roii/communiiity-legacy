<a href="http://www.business.auckland.ac.nz">
                <img 
				src="http://www.business.auckland.ac.nz/images/logo_uabs.gif" 
				width="147" align="right" 
				height="110"
				border=0				
				alt=""></a>
<!--- Width of the Chart --->
<cfset w = "300"><cfset formid = #url.formid#><cfset vendorid = "0">
<cfquery name="Getsetting" datasource="#datasourceR#">
	select *
	from #tableforms#
	where ((formid = #formid#) and (vendorid = #vendorid#))
</cfquery>
<h1>Thanks for using our online survey, Here is the result for: </h1>
<h3><cfoutput>#Getsetting.title# as at #DateFormat(now())# #TimeFormat(now())#</cfoutput></h3>
<!--- Select Questions from the table for the Editor template --->
<cfquery name="GetForm" datasource="#datasourceR#">
	select *
	from #tablequestions#
	where ((formid = #formid#) and (vendorid = #vendorid#))
	order by datein
</cfquery>


<cfloop query="GetForm">

		<cfoutput><b>#question#</b><br></cfoutput>
		<cfif ((GetForm.questiontype is not "5") and (GetForm.questiontype is not "6"))>
			
			
			<cfquery name="GetData" datasource="#datasourceR#">
				SELECT Sum(#tableresponses#.Option1) AS SumOfOption1, Sum(#tableresponses#.Option2) AS SumOfOption2, Sum(#tableresponses#.Option3) AS SumOfOption3, Sum(#tableresponses#.Option4) AS SumOfOption4, Sum(#tableresponses#.Option5) AS SumOfOption5, Sum(#tableresponses#.Option6) AS SumOfOption6, Sum(#tableresponses#.Option7) AS SumOfOption7, Sum(#tableresponses#.Option8) AS SumOfOption8, Sum(#tableresponses#.Option9) AS SumOfOption9, Sum(#tableresponses#.Option10) AS SumOfOption10
				FROM #tableresponses#
				where formid = #formid# and questionID = #id# <!--- and ip  in (
'210.54.227.225', '210.54.139.20', '202.37.64.1', '210.50.67.37','203.109.204.217') --->
			</cfquery>
			
			<cfset items = "#GetForm.option1# ,#GetForm.option2# ,#GetForm.option3# ,#GetForm.option4# ,#GetForm.option5# ,#GetForm.option6# ,#GetForm.option7# ,#GetForm.option8# ,#GetForm.option9# ,#GetForm.option10# ">
			<cfset values = "#GetData.SumOfOption1# ,#GetData.SumOfOption2# ,#GetData.SumOfOption3# ,#GetData.SumOfOption4# ,#GetData.SumOfOption5# ,#GetData.SumOfOption6# ,#GetData.SumOfOption7# ,#GetData.SumOfOption8# ,#GetData.SumOfOption9# ,#GetData.SumOfOption10# ">
		
			<cfset minim = listfirst(values)>
			<cfset minimitem = listfirst(items)>
			<cfset maxim = 0>
			<cfset maximitem = "">
			<cfset subtotal = 0>
			<cfset count = 1>
			<cfloop list="#values#" index="n">
				<cfif n ge maxim>
					<cfset maxim = val(n)>
					<cfset maximitem = listgetat(items, count)>
				</cfif>
				<cfif n lt minim>
					<cfset minim = val(n)>
					<cfset minimitem = listgetat(items, count)>
				</cfif>
				<cfset subtotal = subtotal + val(n)>
				<cfset count = count + 1>
			</cfloop>
			<table cellpadding="0" cellspacing="0" border="0">
			<cfset j = 1>
			<cfloop list="#items#" index="i">
			
				<cfif j gt 10><cfset j = 10></cfif>
				<cfif maxim is 0><cfset maxim = 1></cfif>
				<cfif subtotal is 0><cfset subtotal = 1></cfif>
				<!--- Scale the Chart --->
				<cfset v = round(val(listgetat(values, j)))>
				<cfset pw = round(evaluate(v / maxim * 100))>
				<cfset pv = round(evaluate(v / subtotal * 100))>
				
				<cfoutput>
				<cfif len(i) gt 1>
					<tr><td><font face="arial" size="2">#i#&nbsp;</font></td>
					<td>
					   
					<table width="#w#">
					<tr>
						<td width="#pw#%" bgcolor="##808000" align="right"><font face="arial" size="2">#v#</font></td>
						<td width="#evaluate(100 - pw)#%"><font face="arial" size="2">#pv#%</font></td>
					</tr>
					</table>
					
					</td>
					</tr>
				</cfif>
				</cfoutput>
				<cfset j = j + 1>
				</cfloop>
				</table>
				<p>
				<!--- <cfelseif GetForm.questiontype contains "6" or GetForm.questiontype contains "5">
				The details are secured information<br> --->
		 <cfelseif GetForm.questiontype contains "6" or GetForm.questiontype contains "5">

			<cfquery datasource="#datasourceR#" name="recordset" maxrows="10">
				select ip, datein, openquestion, itemid
				from #tableresponses#
				where formid = #formid# and questionID = #id# <!--- and ip  in (
'210.54.227.225', '210.54.139.20', '202.37.64.1', '210.50.67.37','203.109.204.217') --->
				order by datein desc
			</cfquery>
			<table cellpadding=0 cellspacing=0 width="80%">
			<cfloop query="recordset">
				<!--- Trigger row color change --->
				<tr bgcolor="#dedede">
				<cfoutput>
				<td valign="top">
					<font face="arial" size="2">On:#datein#</font>
				</td><td valign="top">
					<font face="arial" size="2">By:#ip#</font>
				</td>
				</tr>
				<tr bgcolor="##f7f7f7">
				<td valign="top" colspan="2">
					<font face="arial" size="2">#openquestion#</font>
				</td>
				</cfoutput>
				</tr>
			</cfloop>
			<cfif recordset.recordcount is 0>
				<tr><td><font face="arial" size="2">No reponses.</font></td></tr>
			</cfif>
			</table>
			<!--- Table Ends Here --->


		</cfif>			
	</cfloop>
	

