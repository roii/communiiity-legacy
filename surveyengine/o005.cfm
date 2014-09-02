<!--- this template is responsible for processing of the form --->
<!--- setting up default parameter for the newlist 								--->
<!--- we need to remove duplicates from the incoming list of form.fieldnames 	--->

<!--- Main Form Processing Screen --->

<!--- check itemid --->
<!--- If Itemid already exists than redirect to the front page --->
<cfif isdefined("form.itemid")>
	<cfquery  datasource="#datasourceW#" name="checkitemid">
		select itemid
		from #tableresponses#
		where itemid = #form.itemid#
	</cfquery>
	<cfif checkitemid.recordcount is not 0>
		<cflocation url="default.cfm?formid=#formid#&obj=004">
		<cfabort>
	</cfif>
<cfelse>
		<cflocation url="default.cfm">
		<cfabort>
</cfif>

<cfset newformfields = "">
<!--- check if parameter form.fieldnames has been passed to the template  	--->
<cfif isdefined("form.fieldnames")>

	<!--- loop trough the form.fieldnames --->
	<cfloop index="form_name_index" list="#form.fieldnames#">
	
		<!--- checking for duplicate incoming form.names --->		
		<cfif listfind(newformfields, form_name_index) is 0>
		<!--- only unique form.fields will be processed --->
		
			<!--- default values for output matrix --->
			<cfset responsematrix = "0,0,0,0,0,0,0,0,0,0">
			<cfset openquestion = "">
			
			<!--- evaluate form field index --->
			<cfset form_value_index = evaluate("form." & form_name_index)>

			<!--- process only formfileds that have variable as a name --->									  
			<cfif findnocase("variable", form_name_index)>

				<!--- Process Questionid by removing all non numeric values --->
				<cfset Questid = ReReplace(Form_Name_Index, "[a-zA-Z]", "", "ALL")>
				<cfset Questionid = ReReplace(Questid, "_", "", "ALL")>
				<!--- Process open questions --->
				<cfif ReFind("_", Form_Name_Index)>
					<cfset openquestion = form_value_index>
				<cfelse>
					<cfloop index="compl_index" list="#form_value_index#">
						<cfif evaluate(compl_index)>
							<cfset responsematrix = listsetat(responsematrix, evaluate(compl_index), "1")> 
						</cfif>
					</cfloop>
				</cfif>
				<cfif len(openquestion) or ReFind("1", responsematrix)>
		  			<cfquery  name="addresponse" datasource="#datasourceW#">
						insert into #tableresponses# (option1, option2, option3, option4, option5, option6, option7, 
						option8, option9, option10, openquestion, itemid, ip, browser, questionid, formid,datein) 
					  	values (#responsematrix#,'#openquestion#', #itemid#, '#remote_addr#', '#left("#http_user_agent#", 255)#', 
						#questionid#, #form.formid#, #now()#)
				   	</cfquery> 
				</cfif>
			    
  			</cfif>
			 
			<cfset form_value_index = "">
			<cfset newformfields = listappend(newformfields,form_name_index)>
			
 		</cfif> 
	</cfloop>
</cfif>
<cflocation url="default.cfm?formid=#formid#&obj=006&itemid=#itemid#&at=3">

