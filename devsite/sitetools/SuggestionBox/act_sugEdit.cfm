
<cfscript>
	function changeDateFormation(dateStr){
		var date = ArrayNew(1);
		var startIndex =1;
		var index = -1;
		for(loop=1; loop LE 3; loop=loop + 1){
			date[loop] = getToken(dateStr,loop,'/');
		}
	return date;
}
</cfscript>


<cfif isdefined('Form.subSugEdit')>

	<cfset dateArray = changeDateFormation(#Form.closeDate# & '/')>
	<cfset correctDateFormat = DateFormat(CreateDate(dateArray[3],dateArray[2],dateArray[1]),"yyyy-mm-dd")>
	
	<cfquery name="UpSugEdit" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
			UPDATE 	Suggestion
			SET 	whenVotingClose = CAST('#correctDateFormat#' as datetime),
					email = '#Trim(Form.email)#',
					authorise ='#Trim(Form.authorise)#',
					categoryID = #Form.category#,
					suggestion ='#Form.suggestion#'
			WHERE	sugID = #Form.sugID#				
	</cfquery>
	
	<script>
		alert("Suggestion has been updated");
		self.location="dsp_manageSug.cfm";
	</script>
		
</cfif>
