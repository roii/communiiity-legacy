


<cfif IsDefined ("Form.subSuggestionInputForm")> 
	
	<cfquery name="AddSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
	  INSERT INTO 	Suggestion(email,categoryID,suggestion,path,madeBy
        <cfif Form.contactID NEQ ''>
	,contactID</cfif>
	)
	  VALUES	 	('#Trim(Form.txtEmail)#',
	  				'#Trim(Form.selCategory)#',
					'#Form.txtareaSuggestion#',
					'#form.this_query_string#',
					'#Trim(Form.by)#'
	<cfif Form.contactID NEQ ''>
	,#Trim(Form.contactID)#</cfif>)
	</cfquery>
	
	<cfoutput><script>
		alert('Thank you! \n Your suggestion was added to the database.')
		self.location="http://www.mykidsbiz.com/index.cfm?#this_query_string#";
	</script></cfoutput>
</cfif>