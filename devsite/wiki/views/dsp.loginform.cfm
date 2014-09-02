<!---
	Name         : dsp.loginform.cfm
	Author       : Mark Mazelin
	Created      : 09/06/06
	Last Updated : 
	History      : 
--->
<cfset viewstate.setValue("PageTitle", "Login Form") />
<cfset Errors = viewstate.getValue("Errors") />
<cfset submitted = viewstate.getValue("submit") />
<cfset username = viewstate.getValue("username") />
<cfset password = viewstate.getValue("password") />

<cfoutput>
<h1>Login</h1> 
<cfif Len(submitted)>
	<p style="color: red;">Login failed: Your username/password was wrong. So please try again.</p>  
	<cfscript>
		tellTimeCFC = CreateObject("component","model.UserRecord");
		tellTimeCFC.login();        
    </cfscript>  
</cfif>
<script language="javascript">
   function checkform(formObj)
   {
        if(formObj.username.value == "")
		{
		     alert("Required: Please enter your username"); 
			 formObj.username.focus();
			 return false;
		}
		else if(formObj.password.value == "")
		{
		     alert("Required: Please enter your password"); 
			 formObj.password.focus();
			 return false; 
		}
		else
		{
		     return true;
		} 
   }
</script>
<form name="wiki_loginform" action="index.cfm?event=SubmitLoginForm" method="post" onsubmit="return checkform(this);">
	<table>	
	<tr>
		<td valign="top">
		<label for="username">Email ID:</label>
		</td><td valign="top">
		<input type="text" name="username" size="20" id="username" value="#username#" />
		</td>
	</tr>
	<tr>
		<td valign="top">
		<label for="password">Password:</label>
		</td><td valign="top">
		<input type="password" name="password" size="20" id="password" value="#password#" />
		</td>
	</tr>
	</table>
	<input type="submit" name="submit" value="Login" />
</form>
</cfoutput>