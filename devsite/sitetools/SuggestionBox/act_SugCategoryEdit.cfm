


<cfif isdefined('Form.subSugCategoryEdit')>

	<cfquery name="UpSugCategoryEdit" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
			UPDATE 	SugCategory
			SET 	Name = '#trim(Form.name)#',
					Priority = #trim(Form.priority)#,
					description ='#trim(Form.description)#'	
			WHERE	categoryID = #Form.categoryID#				
	</cfquery>
	
	<script>
		alert("Category has been updated");
		self.location="dsp_manageSugCategory.cfm";
	</script>
		
</cfif>