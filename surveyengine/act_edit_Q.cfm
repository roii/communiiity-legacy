<cftransaction>

<cfoutput>

<cftry>
<cfif #form.file_location# is not "">
	<cffile action="UPLOAD" filefield="file_location" destination="#request.fileroot#\surveyengine\temp\" nameconflict="OVERWRITE">
	<cfset file_uploaded="Q#form.qid#.#File.ServerFileExt#">
	<cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\surveyengine\images\#file_uploaded#" nameconflict="OVERWRITE">
</cfif>
<cfcatch>
      <cfset fileupload=true>
</cfcatch>
</cftry>

<cfif isdefined("formid")>
	<cfquery  datasource="#datasourceW#" name="CopyQuestion" username="mykidsbizcomi" password="u+67eNfJ">
		update #tablequestions# set
		questiontype = #form.questiontype#,
		question = '#form.question#',
		displayorder = #form.displayorder#
		<cfif #form.file_location# is not "">,image='#file_uploaded#'</cfif>
		where id = #form.qid#
	</cfquery>

</cfif>

<cfquery  datasource="#datasourceW#" name="choices" username="mykidsbizcomi" password="u+67eNfJ">
    select * from surveyChoice where QID=#form.QID#
</cfquery>

<!------------------------------------------------------------------>
<cfloop from="1" to="#NoofQ#" index="i">
 <cfset option = evaluate('form.Option#i#')>
 <cfset image = Evaluate("FORM.image#i#")>
 <cfset image_uploaded="">

 <cftry>
     <cfif image neq "">
       	<cffile action="UPLOAD" filefield="image#i#" destination="#request.fileroot#\surveyengine\temp\" nameconflict="OVERWRITE">
	<cfset image_uploaded="choice#form.qID#_#i#.#File.ServerFileExt#">
	<cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\surveyengine\images\#image_uploaded#" nameconflict="OVERWRITE">
     </cfif>
     <cfcatch>
        <cfset fileupload=true>
     </cfcatch>
 </cftry>
  

  
<cfif IsDefined("FORM.choice#i#")>
  <cfif IsDefined("FORM.breakline#i#")>
    <cfset breaklinevalue = 1>
  <cfelse>
    <cfset breaklinevalue = 0>
  </cfif>
   <cfset choiceid = evaluate('form.choice#i#')>
   <cfif option NEQ ''>
   <cfquery datasource="#datasourceW#" name="updateC" username="mykidsbizcomi" password="u+67eNfJ">
	update surveyChoice set
	Choice='#option#'
	,breakline=#breaklinevalue#
	<cfif image_uploaded neq ''>,image='#image_uploaded#'</cfif>
        where surveyChoiceID = #choiceid#
    </cfquery>
   <cfelse> <!-----------delete choice plus image-------------------->
     <cfquery datasource="#datasourceW#" name="deleteC" username="mykidsbizcomi" password="u+67eNfJ">
       delete from surveyChoice where surveyChoiceID = #choiceid#
     </cfquery>
     <cfif choices['image'][i] neq ''>  
        <cftry>
          <cffile action="DELETE" file="#request.fileroot#\surveyengine\images\#choices['image'][i]#">
          <cfcatch>
	    <cfset FileDError = true>
          </cfcatch>
        </cftry>
     </cfif> 
   </cfif>
<cfelseif option NEQ ''>
   <cfquery datasource="#datasourceW#" name="CopyQuestion" username="mykidsbizcomi" password="u+67eNfJ">
	insert into surveyChoice
	(
	Qid,
	Choice
	<cfif image_uploaded neq ''>,image</cfif>
	)
	values
	(
	#form.qid#,
	'#option#'
	<cfif image_uploaded neq ''>,'#image_uploaded#'</cfif>
	)	
   </cfquery>
<cfelse>
</cfif>
</cfloop>
</cfoutput>

</cftransaction>

<cfoutput>
<script>
alert("Question details have been updated!");
self.location="#request.webroot#/surveyengine/default.cfm?fuseaction=add_Q&surveyid=#form.formid#&at=5";
</script>
</cfoutput>
