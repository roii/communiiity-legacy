<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script> 

<cfquery name="getallSkills" datasource="#dsn#" username="#request.username#" password="#request.password#">
	 SELECT * FROM allmanageskills
</cfquery>
 
<cfset ctrVar = 1>
  <cfloop query="getallSkills">
        <cfset skilsArray[ctrVar] = '#getallSkills.skillName#'> 
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

<cfoutput>  
	 <div class="i-profile-settings"> 
		<form name="updateSkillsForm" action="/index.cfm?fuseaction=updateprofile&fusesubaction=update" method="post" onsubmit="return checkform();" enctype="multipart/form-data">	  
			<div class="i-musty-background i-profile-story">
				  <h3>Skills</h3>
				  <div class="row">
					<div class="col-lg-9"> 
					<input type="text" name="skillsNeeded" id="skillsNeeded" class="whitefield" size="80" value="" /> 
					</div>
				  </div>
			</div> 
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td valign="top" colspan="2">
							 <div style="float: right">
								<input type="submit" name="saveskills" value="Save Skills" />
							 </div>
						</td>
					</tr>
				</table> 
		</form>  
	 </div>  
</cfoutput>