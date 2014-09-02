		<cfquery  name="GetType" datasource="#datasourceR#">
			SELECT *
			FROM #tablequestions#
			where 	formid = #formid#
			 		and id = #id#
		</cfquery>
		
	
		<!--- Table Header --->
		<cfoutput>
		<table  border="#tableborder#" width="#tablewidth#" cellpadding="3" cellspacing="0">
		<tr><td>
			&nbsp;<b><font face="Arial" size="2" color="##000000">#GetType.question#</font></b><br>
		</td></tr></table>
		</cfoutput>
		
		<!--- If the question type is not Open Question than display Graphs --->
		<cfif ((GetType.questiontype is not "5") AND (GetType.questiontype is not "6"))>
		
			<cfquery  name="GetData" datasource="#datasourceR#">
				SELECT Sum(#tableresponses#.Option1) AS SumOfOption1, Sum(#tableresponses#.Option2) AS SumOfOption2, Sum(#tableresponses#.Option3) AS SumOfOption3, Sum(#tableresponses#.Option4) AS SumOfOption4, Sum(#tableresponses#.Option5) AS SumOfOption5, Sum(#tableresponses#.Option6) AS SumOfOption6, Sum(#tableresponses#.Option7) AS SumOfOption7, Sum(#tableresponses#.Option8) AS SumOfOption8, Sum(#tableresponses#.Option9) AS SumOfOption9, Sum(#tableresponses#.Option10) AS SumOfOption10
				FROM #tableresponses#
				where formid = #formid# and QuestionId = #id#
			</cfquery>

			<cfoutput query="getdata">
			<table width="100%" border="0"><tr><td>
			
				<!--- Dynamic Chart --->
				<table border="0"  border="#tableborder#" width="#tablewidth#" cellpadding="3" cellspacing="0">
				<tr>
					<td border="#tableborder#">
						<b><font face="Arial, Helvetica" size=2 color="##FFFFFF" style="color:##FFFFFF; text-decoration:none">Bar Chart</font></b>
					</td>
				</tr>
				<tr>
				<td valign="top" align="center">
				<APPLET CODE="BarChart.class" CODEBASE="CFGraphs/" WIDTH="#chartwidth#" HEIGHT="#chartheight#">
				<PARAM NAME="ChartData.Columns" VALUE="Items,Values"> 
				<PARAM NAME="ChartData.Items" VALUE="#ReReplace(left(GetType.Option1,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option2,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option3,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option4,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option5,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option6,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option7,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option8,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option9,15), ",", "", "ALL")#,#ReReplace(left(GetType.Option10,15), ",", "", "ALL")#"> 
				<PARAM NAME="ChartData.Values" VALUE="#SumOfOption1#,#SumOfOption2#,#SumOfOption3#,#SumOfOption4#,#SumOfOption5#,#SumOfOption6#,#SumOfOption7#,#SumOfOption8#,#SumOfOption9#,#SumOfOption10#"> 
				<PARAM NAME="Title" VALUE="Bar Chart"> 
				<PARAM NAME="TitleFontName" VALUE="Arial">
				<PARAM NAME="TitleFontHeight" VALUE="15">
				<PARAM NAME="DebugInfoEnabled" VALUE="yes">
				<PARAM NAME="Orientation" VALUE="horizontal">
				<PARAM NAME="BackgroundColor" VALUE="FFFFFF">
				This template displays Java based graph.<br>
				If you see this message it means that:<br>
				<H2> Your Browser Does Not Support JAVA!</H2> 
				</APPLET>
				</td></tr></table>
				
				</td>
				<td>
				
				Dynamic Chart 
				<table  border="#tableborder#" width="#tablewidth#" cellpadding="3" cellspacing="0">
				<tr>
					<td  border="#tableborder#">
						<b><font face="Arial, Helvetica" size=2 color="##FFFFFF" style="color:##FFFFFF; text-decoration:none">Pie Chart</font></b>
					</td>
				</tr>
				<tr>
				<td valign="top" align="center">
				<APPLET CODE="PieChart.class" CODEBASE="CFGraphs/" WIDTH="#chartwidth#" HEIGHT="#chartheight#">
				<PARAM NAME="ChartData.Columns" VALUE="Items,Values"> 
				<PARAM NAME="ChartData.Items" VALUE="#ReReplace(GetType.Option1, ",", "", "ALL")#, #ReReplace(GetType.Option2, ",", "", "ALL")#,#ReReplace(GetType.Option3, ",", "", "ALL")#,#ReReplace(GetType.Option4, ",", "", "ALL")#,#ReReplace(GetType.Option5, ",", "", "ALL")#,#ReReplace(GetType.Option6, ",", "", "ALL")#,#ReReplace(GetType.Option7, ",", "", "ALL")#,#ReReplace(GetType.Option8, ",", "", "ALL")#,#ReReplace(GetType.Option9, ",", "", "ALL")#,#ReReplace(GetType.Option10, ",", "", "ALL")#"> 
				<PARAM NAME="ChartData.Values" VALUE="#SumOfOption1#,#SumOfOption2#,#SumOfOption3#,#SumOfOption4#,#SumOfOption5#,#SumOfOption6#,#SumOfOption7#,#SumOfOption8#,#SumOfOption9#,#SumOfOption10#"> 
				<PARAM NAME="Title" VALUE="Pie Chart"> 
				<PARAM NAME="TitleFontName" VALUE="Arial">
				<PARAM NAME="TitleFontHeight" VALUE="15">
				<PARAM NAME="DebugInfoEnabled" VALUE="yes">
				<PARAM NAME="Showlegend" VALUE="no">
				<PARAM NAME="Orientation" VALUE="horizontal">
				<PARAM NAME="BackgroundColor" VALUE="FFFFFF">
				This template displays Java based graph.<br>
				If you see this message it means that:<br>
				<H2> Your Browser Does Not Support JAVA!</H2> 
				</APPLET>
				</td></tr></table>
			</cfoutput>
		<cfelse>
		<!--- For open question type display grap --->
		
			<cfinclude template="o010.cfm">			
			
		</cfif>
		</td></tr>
		</table>

	