<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css"> 
<link rel="stylesheet" type="text/css" href="/css/css.css" />
<script type="text/javascript" src="/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="/js/jquery.multi_field_extender.js"></script> 
<script type="text/javascript" src="/js/jquery.select2tagsuggsion.js"></script>

<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script> 

<cfquery name="getallSkills" datasource="#dsn#" username="#request.username#" password="#request.password#">
	 SELECT * FROM allmanageskills
</cfquery>
<cfset skilsArray = ArrayNew(1)>
 
<cfset ctrVar = 1>
  <cfloop query="getallSkills">
        <cfset skilsData  = StructNew()>
        <cfset skilsData.skill     = '#getallSkills.skillName#'> 
		<cfset skilsData.skillID   =  #getallSkills.id#> 
        <cfset skilsArray[ctrVar]  = skilsData>  
		<cfset ctrVar = ctrVar + 1>
  </cfloop> 

<select name="editname" class="suggest" size="100">
	<cfoutput>
	   <cfloop from="1" to="#ArrayLen(skilsArray)#" index="i"> 
			 <option value="#skilsArray[i].SKILLID#">#skilsArray[i].SKILL#</option>	 
	   </cfloop>
	</cfoutput>
</select> 