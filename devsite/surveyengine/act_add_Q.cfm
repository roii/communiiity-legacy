<cftransaction>
<cfoutput>
<cfif form.questiontype eq ''>
  oops! you forgot to choose a question type. <br>
  Plese <a href="javascript:history(-1)">go back</a> and choose one first.
<cfabort>
</cfif>

<cfquery  datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ" name="Qcount">
  select * from questions where formid = #form.formid#	
</cfquery>

<cfif Qcount.recordcount>
  <cfset displayorder = Qcount.recordcount + 1>
<cfelse>
  <cfset displayorder = 1>
</cfif>

<cfif isdefined("formid")>
	<cfquery  datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ" name="AddQuestion">
		insert into #tablequestions# 
		(
		formid,
		questiontype,
		question,
		validation,
		datein,
		displayorder
		)
		values
		(
		#form.formid#,
		#form.questiontype#,
		'#form.question#',
		0,
		#now()#,
		#displayorder#
		);
	SELECT InsertedID = @@IDENTITY;
	</cfquery>

</cfif>
	<cfquery name="addedQ" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
       select top 1 ID from questions where formid=#form.formid# order by ID desc
	</cfquery>
<cfset questionID=addedQ.ID>

<cftry>
<cfif #form.file_location# is not "">
	<cffile action="UPLOAD" filefield="file_location" destination="#request.fileroot#\surveyengine\temp\" nameconflict="OVERWRITE">
	<cfset file_uploaded="Q#questionID#.#File.ServerFileExt#">
	<cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\surveyengine\images\#file_uploaded#" nameconflict="OVERWRITE">

<cfquery  datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ" name="UpdateQuestion">
  update #tablequestions# set image = '#file_uploaded#' where id = #questionID#
</cfquery>

</cfif>
<cfcatch>
      <cfset fileupload=true>
</cfcatch>
</cftry>

<!------------------------------------------------------------------>
<cfloop from="1" to="#NoofQ#" index="i">
   <cfset option = evaluate('form.Option#i#')>
   <cfif option NEQ ''>

     <cftry>
     <cfif IsDefined("FORM.image#i#") AND Evaluate("FORM.image#i#") neq "">
       	<cffile action="UPLOAD" filefield="image#i#" destination="#request.fileroot#\surveyengine\temp\" nameconflict="OVERWRITE">
	    <cfset image_uploaded="choice#questionID#_#i#.#File.ServerFileExt#">
	    <cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\surveyengine\images\#image_uploaded#" nameconflict="OVERWRITE">
	 <cfelse>
	    <cfset image_uploaded="">
     </cfif>
     <cfcatch>
        <cfset fileupload=true>
     </cfcatch>
     </cftry>

   <cfquery datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ" name="CopyQuestion">
	insert into surveyChoice
	(
	Qid,
	Choice
	<cfif image_uploaded neq ''>,image</cfif>
	)
	values
	(
	#questionID#,
	'#option#'
	<cfif image_uploaded neq ''>,'#image_uploaded#'</cfif>
	)	
   </cfquery>
   <cfelse>
     <cfbreak>
   </cfif>
</cfloop>
</cfoutput>

</cftransaction>

<cfoutput>
<cfif form.wizard eq 'on'>
  <script>
	alert("Question has been added successfully!");
	self.location="#request.webroot#/surveyengine/default.cfm?fuseaction=add_Q&surveyID=#form.formid#&at=5&wizard=on";
  </script>
<cfelse>
  <script>
	alert("Question has been added successfully!");
	self.location="#request.webroot#/surveyengine/default.cfm?fuseaction=add_Q&surveyID=#form.formid#&at=5";
  </script>
</cfif>
</cfoutput>
