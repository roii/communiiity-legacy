<!--- this template is responsible for processing of the form --->

<!--- Main Form Processing Screen --->

<!--- check itemid --->
<!--- If Itemid already exists than redirect to the front page --->

<cfif isdefined("form.itemid")>
	<cfquery datasource="#datasourceW#" name="checkitemid">
		select itemid
		from #tableresponses#
		where ip = '#remote_addr#' and formid = #formid#
	</cfquery>
	<cfif checkitemid.recordcount is not 0>
	
		<!--- Redirection Block --->
		<cfif isdefined("vendorid")>
			<cfquery name="PullFormInfo" datasource="#datasourceR#">
				select *
				from #tableforms#
				where vendorid = #vendorid# and formid = #formid#
			</cfquery>
			<cfif PullFormInfo.report is 1>
				<cflocation url="#PullFormInfo.url#">
			<cfelse>
				<cfoutput>
				<p>
				<a href="#PullFormInfo.url#">#PullFormInfo.url#</a><p>
				</cfoutput>			
				<cfinclude template="report.cfm">
				<cfoutput>
				<p>
				<a href="#PullFormInfo.url#">#PullFormInfo.url#</a><p>
				</cfoutput>
				<cfabort>
			</cfif>
		<cfelse>
			<cflocation url="http://www.business.auckland.ac.nz">
		</cfif>
	</cfif>
<cfelse>
		<cflocation url="http://www.business.auckland.ac.nz">
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
		  			<cfquery name="addresponse" datasource="#datasourceW#">
						insert into #tableresponses# (option1, option2, option3, option4, option5, option6, option7, 
						option8, option9, option10, openquestion, itemid, ip, browser, questionid, formid,datein) 
					  	values (#responsematrix#,'#openquestion#', #itemid#, '#remote_addr#', '#AUTH_USER#', 
						#questionid#, #form.formid#, #now()#)
				   	</cfquery> 
				</cfif>
			    
  			</cfif>
			 
			<cfset form_value_index = "">
			<cfset newformfields = listappend(newformfields,form_name_index)>
			
 		</cfif> 
	</cfloop>
</cfif>

<!--- Redirection Block --->
<cfif isdefined("vendorid")>
	<cfquery name="PullFormInfo" datasource="#datasourceR#">
		select *
		from #tableforms#
		where vendorid = #vendorid# and formid = #formid#
	</cfquery>
	<cfif PullFormInfo.report is 1>
		<cflocation url="#PullFormInfo.url#">
	<cfelse>
		<cfoutput>
		<p>
		<a href="#PullFormInfo.url#">#PullFormInfo.url#</a><p>
		</cfoutput>
		<cfinclude template="report.cfm">
		<cfoutput>
		<p>
		<a href="#PullFormInfo.url#">#PullFormInfo.url#</a><p>
		</cfoutput>
		<cfabort>
	</cfif>
<cfelse>
	<cflocation url="http://www.business.auckland.ac.nz">
</cfif>



