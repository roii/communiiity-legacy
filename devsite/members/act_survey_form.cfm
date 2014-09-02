<!--- this template is responsible for processing of the form --->
<!--- setting up default parameter for the newlist 								--->
<!--- we need to remove duplicates from the incoming list of form.fieldnames 	--->

<!--- Main Form Processing Screen --->

<!--- check itemid --->
<!--- If Itemid already exists than redirect to the front page --->
<cfif isdefined("form.itemid")>
	<cfquery  datasource="#dsn#" name="checkitemid" username="#request.username#" password="#request.password#">
		select itemid
		from surveyResponse
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
	<cfoutput>
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
				<cfset ChosenOne = "">
				<!--- Process open questions --->
				<cfif ReFind("_", Form_Name_Index)>
					<cfset openquestion = form_value_index>
					<cfset ChosenOne = 0>
					  <cfquery  name="addopenfield" datasource="#dsn#" username="#request.username#" password="#request.password#">
						     insert into surveyResponse (QID, Response, itemid, choiceID, ip, browser, datein) 
					  	     values (#questionid#,'#openquestion#', #itemid#, #ChosenOne#, '#remote_addr#', '#left("#http_user_agent#", 255)#' 
						     , #localDateTime#)
				   	  </cfquery>
				<cfelse>
					<cfloop index="compl_index" list="#form_value_index#">
						<cfif evaluate(compl_index)>
							<cfset ChosenOne = evaluate(compl_index)> 
						</cfif>
						<cfif len(openquestion) or ChosenOne NEQ ''>
		  			       <cfquery  name="addresponse" datasource="#dsn#" username="#request.username#" password="#request.password#">
						     insert into surveyResponse (QID, Response, itemid, choiceID, ip, browser, datein) 
					  	     values (#questionid#,'#openquestion#', #itemid#, #ChosenOne#, '#remote_addr#', '#left("#http_user_agent#", 255)#' 
						     , #localDateTime#)
				   	       </cfquery>
				         </cfif>
					</cfloop>
				</cfif>

			    
  			</cfif>
			 
			<cfset form_value_index = "">
			<cfset newformfields = listappend(newformfields,form_name_index)>
			
 		</cfif> 
	</cfloop>
	</cfoutput>
</cfif>

<cfinclude template="act_inc_survey.cfm">
<cfoutput>
<cfquery  datasource="#dsn#" name="surveyDetails" username="#request.username#" password="#request.password#">
  select online from forms where formid = #form.formid#
</cfquery>
<!----------------enter prize draw if any------------------>
<cfif #session.UserIsAuthenticated# EQ 'yes'>
  <cfset activityid = 8>
  <cfinclude template="../administration/act_add_entry.cfm">
</cfif>
					
<script>		
<cfif surveyDetails.online GT 0>
  <cfif #session.UserIsAuthenticated# EQ 'yes'>
	<cfquery name="Addkids2survey" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO kids2survey(
		kidsid,
		formid,
		nocompleted,
		paid,
		completed
		)
		
		VALUES(
		#session.userid#, 
		#form.formid#,
		0,
		0,
		1
		)
	</cfquery>
  </cfif>
  alert("Thank you for doing this survey!");
  self.location="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=docs&documentID=35";
<cfelse>
  alert("Record has been save successfully!");
  self.location="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentID=35&articleID=27&surveyid=#form.formid#";
</cfif>
  
</script>

</cfoutput>
