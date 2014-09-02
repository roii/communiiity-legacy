


<cfif IsDefined ("Form.subSuggestionInputForm")> 
	
	<cfquery name="AddSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
	  INSERT INTO 	Suggestion(email,categoryID,suggestion)
	  VALUES	 	('#Trim(Form.txtEmail)#',
	  				'#Trim(Form.selCategory)#',
					'#Form.txtareaSuggestion#')
	</cfquery>
	
	<script>
		alert('Thank you! \n Your suggestion was added to the database.')
		self.location="dsp_suggestionboxInputForm.cfm";
	</script>
</cfif>