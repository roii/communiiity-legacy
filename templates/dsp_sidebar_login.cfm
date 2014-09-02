<cfoutput>

<script language="javascript" type="text/javascript">
function validateLogin(LoginForm) {

if (LoginForm.LoginName.value == "") {
	alert("Please enter your Email Address or Login Name.");
	LoginForm.LoginName.focus();
	return;
	} 
	 
else if (LoginForm.Password.value == "") {
	alert("Please enter your Password.");
	LoginForm.Password.focus();
	return;
	} 
	
	 
else {
	LoginForm.submit(); //submit form
	}
	
}
</script>
<table width="170" cellpadding="0" cellspacing="0" style="border:solid 2px ###AllSettings.BoxColour#;">

<tr>
<td bgcolor="###TRIM(AllSettings.BoxColour)#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>MEMBERS LOGIN</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>

	
	<table width="160" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<form name="LoginForm" method="post" action="#request.webroot#/index.cfm" onsubmit="validateLogin(LoginForm); return false;">
	
	<tr>
	<td style="padding-left:5px;font-size:11px;color:black;">Screen Name / Email:<br>
	<input type="text" class="field" name="LoginName" style="width:140px;"><br>
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="padding-left:5px;font-size:11px;color:black;">Password:<br>
	<input type="password" class="field" name="Password" style="width:82px;" align="absmiddle"> <input type="submit" style="cursor:hand; background-color:###TRIM(AllSettings.BoxColour)#;font-size:11px; color:black; font-weight:bold; border:0px;" class="whitefield" value="Login &raquo;"></td>
	</tr>
	
	<tr>
	<td style="font-size:11px;padding-left:5px;"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
	<a href="#request.webroot#/dsp_forgot_password.cfm" target="password" onclick="fdbackwindow=window.open ('','password','width=500,height=240,top=10,left=10,resizable=1,menubar=0,status=0,scrollbars=1,panel=0,addressbar=0')" style="color:black;">Forgot Password?</a><br>
	<a href="#request.webroot#/index.cfm?fuseaction=join" style="color:black;">Register Now!</a>
	</td>
	</tr>
	
	
	</form>
	
	
	</table><br>


</td>
</tr>

</table>


</cfoutput>