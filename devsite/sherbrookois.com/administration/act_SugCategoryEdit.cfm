


<cfif isdefined('Form.subSugCategoryEdit')>

	<cfquery name="UpSugCategoryEdit" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE 	SugCategory
			SET 	Name = '#trim(Form.name)#',
					Priority = #trim(Form.priority)#,
					description ='#trim(Form.description)#'	
			WHERE	categoryID = #Form.categoryID#				
	</cfquery>
	
	<script>
		alert("Category has been updated");
		self.location="http://www.mykidsbiz.com/index.cfm?fuseaction=administration&fusesubaction=manage_SugCat";
	</script>
		
</cfif>