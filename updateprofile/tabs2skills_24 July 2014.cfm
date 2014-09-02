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
  
<cfset TagsArr = SerializeJSON(skilsArray)>   
 
 <cfoutput>
<script type="text/javascript"> 
	var TagsArr = #TagsArr#; 
</script></cfoutput> 


<script>
$(function() {
var availableTags = TagsArr;
function split( val ) {
return val.split( /,\s*/ );
}
function extractLast( term ) {
return split( term ).pop();
}
$( "#skillsNeeded" )
// don't navigate away from the field on tab when selecting an item
.bind( "keydown", function( event ) { 
if ( event.keyCode === $.ui.keyCode.TAB &&
$( this ).data( "ui-autocomplete" ).menu.active ) {
event.preventDefault();
}
})
.autocomplete({
minLength: 0,
source: function( request, response ) {
// delegate back to autocomplete, but extract the last term 
response( $.ui.autocomplete.filter(
availableTags, extractLast( request.term ) ) );
},
focus: function() {
// prevent value inserted on focus
return false;
},
select: function( event, ui ) {
var terms = split( this.value ); 
// remove the current input
terms.pop();
// add the selected item
terms.push( ui.item.value );
// add placeholder to get the comma-and-space at the end
terms.push( "" );
this.value = terms.join( ", " );
return false;
}
});
});
</script>

<cfif IsDefined("SESSION.userid") and #SESSION.userid# neq ''>
	 <cfset userid = #SESSION.userid#>
<cfelse>
	 <cfset userid = ''>
</cfif>

<cfquery name="checkforUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
	 SELECT * FROM userSkills WHERE userID = #userid#
</cfquery>

<cfset skillsTmp   = ''> 
<cfset SkillArrayData = ArrayNew(1)>
 
<cfif TRIM(checkforUSerSkills.SKILLIDS) neq ''>
	 <cfset skillsArray = ListToArray(#TRIM(checkforUSerSkills.SKILLIDS)#, ",")>
	 <cfset totalSkills = ArrayLen(skillsArray)> 
	 <cfloop from="1" to="#totalSkills#" index="i">
			<cfquery name="getManageSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
				 SELECT * FROM allmanageskills WHERE id = '#skillsArray[i]#'
			</cfquery>
			<cfif skillsTmp eq ''>
				   <cfset skillsTmp = #getManageSkills.skillName#>
			<cfelse>
				   <cfset skillsTmp = "," & #getManageSkills.skillName#>
			</cfif> 
			<!---#skillsTmp#--->
			<cfset SkillArrayData[i] = getManageSkills.skillName>
	 </cfloop>
</cfif>	  
<cfset SkillArrayDataStr = ArrayToList(SkillArrayData, ",")> 

<cfoutput>  
	 <div class="i-profile-settings"> 
		<form name="updateSkillsForm" action="/index.cfm?fuseaction=updateprofile&fusesubaction=updateSkills" method="post" onsubmit="return checkform();" enctype="multipart/form-data">	  
			<div class="i-musty-background i-profile-story">
				  <h3>Skills</h3>
				  <div class="row">
					<div class="col-lg-9"> 
					<!---<input type="text" name="skillsNeeded" id="skillsNeeded" class="whitefield" size="80" value="#SkillArrayDataStr#" style="height: 22px;" /> --->
					</div>
				  </div>
			</div> 
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td valign="top" colspan="2">
							 <div style="float: right">
								<!---<input type="submit" name="saveskills" value="Save Skills" />--->
							 </div>
						</td>
					</tr>
				</table> 
		</form>  
	 </div>   
	 
</cfoutput> 

<form id="p" name="updateSkillsForm" action="/updateprofile/dsp_update_skills_add_into_user.cfm" method="post" class="tagcontainer"> 
  <p> <!---
   
  <br />
Multiple select option box ( with selected options ):--->

<input type="hidden" name="skillsNeeded" value="" id="skillsNeeded" />
<cfset skillsDataArray = ListToArray(#checkforUSerSkills.SKILLIDS#)>

<select name="editname" multiple="multiple" class="suggest" size="100">
<cfoutput>
   <cfloop from="1" to="#ArrayLen(skilsArray)#" index="i">
         <cfif #arrayFind( skillsDataArray, #skilsArray[i].SKILLID# )#>
             <option value="#skilsArray[i].SKILLID#" selected="selected">#skilsArray[i].SKILL#</option>
		 <cfelse>
		     <option value="#skilsArray[i].SKILLID#">#skilsArray[i].SKILL#</option>	 
		 </cfif>	 
   </cfloop>
</cfoutput>
</select>  
  </p>
  
  
  
  <input type="submit" name="submitSkills" value="Add Skills" />
</form>
<script type="text/javascript">




$('form').submit(function(){
	
	
	var data = decodeURIComponent( $(this).serialize() );
	$('#skillsNeeded').val(data); 
	
	// alert( $('#skillsNeeded').val(data) );
	 return true;
	
	
	});


	
	//$('.suggest').each(function(){
		
		
		$('select').select2tag();
		
		//});
	
	
	$('.clone').MultiField({maxitem:50});

</script>