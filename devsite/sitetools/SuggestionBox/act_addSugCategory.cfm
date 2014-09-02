

<cfif isdefined('Form.subSugCategoryAdd')>

	<cfquery name="CurrentSuggestion" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
		INSERT INTO sugCategory(Name,Description,Priority)
		VALUES 		('#trim(Form.name)#','#trim(Form.description)#',#Form.priority#)
	</cfquery>

	<script>
		alert("The category has been added to the database!");
		self.location="dsp_manageSugCategory.cfm";
	</script>

</cfif>