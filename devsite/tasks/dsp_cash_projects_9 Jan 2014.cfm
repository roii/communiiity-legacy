<cfparam name="selStatus" default="">
<cfparam name="selPriority" default="">
<cfparam name="sortBy" default="">
<cfparam name="sortDir" default="desc">
<cfset amarCounter = 1>
<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmCategoryDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmProjectDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Project?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	</script>

</cfif> 
 
<cfset ProjectCatIDList = #valueList(CatDetails.ProjectCategoryID,",")#>

<cfif IsDefined("FORM.selStatus") and FORM.selStatus neq ''>
     <cfset selStatus   = #FORM.selStatus#>
	 <cfset selStatusAr = ListToArray(selStatus,",")> 
<cfelse>
     <cfset selStatus = ''>	 
</cfif> 

<cfif IsDefined("FORM.selCategory") and FORM.selCategory neq ''>
     <cfset selCategory = #FORM.selCategory#>
<cfelse>
     <cfset selCategory = ''>	 
</cfif>

<cfif IsDefined("FORM.selPriority") and FORM.selPriority neq ''>
     <cfset selPriority   = #FORM.selPriority#> 
	 <cfset selPriorityAr = ListToArray(selPriority,",")> 
<cfelse>
     <cfset selPriority = ''>	 
</cfif>

<cfif session.UserType EQ 'Administrator'>
    <cfset allowTasks = 1>
<cfelse>
    <cfset allowTasks = 0> 
</cfif> 
 
<cfif allowTasks eq 1> 
   <cfinclude template="/tasks/content_after_login.cfm">   
<cfelse> 
   <cfinclude template="/tasks/content_before_login.cfm"> 
</cfif>
 
 
<br><br>
