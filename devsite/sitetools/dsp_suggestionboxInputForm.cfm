
<html>
<head>
<title>Suggestionbox</title>
<link rel="stylesheet" type="text/css" href="CSS/small.css">

<script language="JavaScript">

function ValidateTextarea(frmSuggestionInputForm){
	var email = frmSuggestionInputForm.txtEmail.value;
	var at = email.indexOf("@");		
	var space = email.indexOf(" ");
	var comma = email.indexOf(",");
	var dot = email.indexOf(".");
	var two_dots = email.indexOf("..");
	var length = email.length -1;
	if(email != ""){
		if((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
		alert("Please enter a valid Email Address.");
		frmSuggestionInputForm.txtEmail.value = email;
		frmSuggestionInputForm.txtEmail.focus();
		return false;
		}
	} 
	if(trim(frmSuggestionInputForm.txtareaSuggestion.value) == ""){
		alert("Please enter your suggestion!");
		frmSuggestionInputForm.txtareaSuggestion.focus();
		return false;
	}
	
	if(trim(frmSuggestionInputForm.selCategory.value) =="notSelect"){
		alert("Please select a suggestion category!");
		frmSuggestionInputForm.selCategory.focus();
		return false;
	}
	return true;
}

function trim(s) {
  while (s.substring(0,1) == ' ') {
    s = s.substring(1,s.length);
  }
  while (s.substring(s.length-1,s.length) == ' ') {
    s = s.substring(0,s.length-1);
  }
  return s;
}

</script>
</head>

<body>
<span class="normal">
Got an idea to make the site better? Drop it in our Suggestion Box and hit 
Submit.<br>
Want to see or vote on other peoples suggestions? Click
<cfoutput>
<a href="#request.webroot#/index.cfm?fuseaction=sitetools&fusesubaction=docs&documentID=31">Here</a>.
</cfoutput>
<p></p>
</span>

<!--- return dynamic category Name --->
<cfinclude template="qry_SugCategory.cfm">
<cfform name="frmSuggestionInputForm" action="#request.webroot#/sitetools/act_suggestionboxInputForm.cfm" onSubmit="return ValidateTextarea(frmSuggestionInputForm)">
	
<cfoutput>	
	<input type="hidden" name="by" <cfif session.UserIsAuthenticated EQ 'yes'>value="#session.User_FirstName#"</cfif> >
	<input type="hidden" name="contactID" <cfif session.UserIsAuthenticated EQ 'yes'>value="#session.UserID#"</cfif> >

<cfif IsDefined("this_query_string")>
	<input type="hidden" name="this_query_string" value="#URLDecode(this_query_string)#">
<cfelse>
	<input type="hidden" name="this_query_string" value="fuseaction=sitetools&fusesubaction=docs&documentID=31">
</cfif>

  <table border="0" cellspacing="1">
    <tr> 
			
      <td bgcolor="e3f4f6"> 
        <div align="right" class="normal">Email(optional)</div>
			 </td>
			
      <td bgcolor="e3f4f6">
        <input type="text" name="txtEmail" size="40" <cfif session.UserIsAuthenticated EQ 'yes'>value="#session.user_email#"</cfif>>
	  </td>
	  </tr>
	  
	  <tr> 
			
      <td bgcolor="e3f4f6"> 
        <div align="right" class="normal">Category</div>
			 </td>
			
      <td bgcolor="e3f4f6"> 
        <select name="selCategory">
				<option value="notSelect" class="normal">Select a Suggestion Category</option>
				<!--- loop thru the dynamic category name return form qry --->
				<cfloop query="selCategory">
				<option value="#categoryID#" class="normal">#Name#</option>
				</cfloop>
			  </select>
      </td>
	  </tr>
	  <tr> 
			
      <td bgcolor="e3f4f6"> 
        <div align="right" class="normal">Suggestion</div></td>
			
      <td bgcolor="e3f4f6"> 
        <textarea name="txtareaSuggestion" cols="50" rows="10"></textarea></td>
	  </tr>
	  <tr>
			
      <td bgcolor="e3f4f6"> 
        <input type="submit" name="subSuggestionInputForm" value="Submit"></td>
			
      <td bgcolor="e3f4f6"> 
        <input type="reset" name="resReset" value="Reset"></td>
	  </tr>
	</table>
	</cfoutput>
</cfform>

</body>
</html>