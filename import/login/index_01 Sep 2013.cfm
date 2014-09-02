<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title><cfif IsDefined("this_metatitle")>#TRIM(this_metatitle)#<cfelse>#TRIM(AllSettings.SiteName)#</cfif></title>

<cfif IsDefined("this_metadescription")>
	<meta name="Description" content="#TRIM(this_metadescription)#">
</cfif>

<cfif IsDefined("this_metakeywords")>
	<meta name="Keywords" content="#TRIM(this_metakeywords)#">
</cfif>


<cfinclude template="../templates/styles.cfm">

</head>

<body leftmargin="5" topmargin="0" rightmargin="5" bottommargin="0" marginwidth="5" marginheight="0" bgcolor="##FFFFFF" text="###AllSettings.TextColour#" stats=1>

<!--BEGINNING OF DEEPMETRIX STATSCRIPT-->
<script language="javascript">
var DMdomain = "";
var DMpage = window.location;
var DMVersion = 86;
var DMsendTo = "//collector.deepmetrix.com/dm.gif?";
var DMsession;
function dmerr(){return true;}window.onerror=dmerr;
var u3k8u6y1j3 = new Date();
if (navigator.userAgent.indexOf('Mac') >= 0 && u3k8u6y1j3.getTimezoneOffset() >= 720){
u3k8u6y1j3.setTime (u3k8u6y1j3.getTime() - 1440*60*1000);}
var u3k8u6y1 = location.protocol+DMsendTo+"v="+DMVersion+"&vst=1";
var u3k8u6 = document.cookie.toString();if(u3k8u6.indexOf("_dmid") == -1)
{DMsession = parseInt( Math.random()*1000000 ) + "_" + u3k8u6y1j3.getTime();
var u3k8 = "";if(DMdomain != ""){u3k8 = "domain="+ DMdomain +";";}
document.cookie = "_dmid=" + DMsession + ";expires=Mon, 31-Dec-2008 00:00:00 GMT;"+u3k8+"path=/;";}
u3k8u6 = document.cookie.toString();if(u3k8u6.indexOf('_dmid') == -1){DMsession = "";}
else{if(u3k8u6.indexOf(';') == -1){u3k8u6 = u3k8u6.replace(/_dm/g, ';_dm');}var u3 = u3k8u6.indexOf("_dmid=") + 6;
var g5b1z7i5z6 = u3k8u6.indexOf(";",u3);if (g5b1z7i5z6 == -1){g5b1z7i5z6 = u3k8u6.length;}
DMsession = unescape(u3k8u6.substring(u3,g5b1z7i5z6));}
u3k8u6y1 += "&id="+DMsession+"&url="+escape(DMpage) + "&ref="+escape(document.referrer)+"&lng=" + 
((!document.all || navigator.userAgent.match('Opera')) ? navigator.language : navigator.userLanguage) + 
"&tz=" + (Math.round(new Date('dec 1, 2002').getTimezoneOffset()/60)*-1);
if(screen){u3k8u6y1 += "&scr=" + escape( screen.width + "x" + screen.height + " " + screen.colorDepth + "bpp" );}
u3k8u6y1 += "&rnd=" + new Date().getTime();if(document.layers){
document.write("<la"+"yer name=\"DMStats\" visibility=hide><img src=\""+u3k8u6y1+"\" height=1 width=1></la"+"yer>");
}else{document.write("<di"+
"v id=\"DMStats\" STYLE=\"position:absolute;visibility:hidden;\"><img src=\""+u3k8u6y1+
"\" height=1 width=1></di"+"v>");}
</script>
<!--END OF DEEPMETRIX STATSCRIPT-->



<table width="100%" cellpadding="0" cellspacing="0" border="0">


<!--- HEADER BAR - Logo / Subnav / Advert --->

<tr>
<td colspan="3">
	<cfinclude template="../templates/dsp_topbar.cfm">
</td>
</tr>


<!--- NAVIGATION BAR - Main Navigation --->

<tr>
<td colspan="3">
	<cfinclude template="../templates/dsp_menubar.cfm">
</td>
</tr>



<!--- MAIN LAYOUT - Leftside column, main column, rightside column --->

<tr>


<td width="170" valign="top">
	<cfinclude template="../templates/dsp_internal_Lsidebar.cfm">
</td>


<td width="*" valign="top" style="padding-left:10px;padding-right:10px;">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="459" height="8" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	
	<td width="100%" style="padding-left:10px;padding-right:10px;">
<cfinclude template="../templates/dsp_section_details.cfm">

<script language="javascript" type="text/javascript">
function validatePageLogin(PageLoginForm) {

if (PageLoginForm.LoginName.value == "") {
	alert("Please enter your Email Address or Login Name.");
	PageLoginForm.LoginName.focus();
	return;
	} 
	 
else if (PageLoginForm.Password.value == "") {
	alert("Please enter your Password.");
	PageLoginForm.Password.focus();
	return;
	} 
	
	 
else {
	PageLoginForm.submit(); //submit form
	}
	
}
</script>

<table cellpadding="0" cellspacing="0" border="0" width="100%">

<form method="post" action="#request.webroot#/index.cfm" onsubmit="validatePageLogin(PageLoginForm); return false;" name="PageLoginForm">

<tr>
<td>Email Address: <input type="text" class="field" name="LoginName" style="width:100px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Password: <input type="password" class="field" name="Password" style="width:100px;"> &nbsp; <input type="submit" class="field" value="Login Now"></td>
</tr>

<tr>
<td><hr width="100%" size="1" color="e2e2e2">
<a href="#request.webroot#/dsp_forgot_password.cfm" target="password" onclick="fdbackwindow=window.open ('','password','width=500,height=240,top=10,left=10,resizable=1,menubar=0,status=0,scrollbars=1,panel=0,addressbar=0')">Forgot Password</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <a href="#request.webroot#/index.cfm?fuseaction=join">Register</a></td>
</tr>


</form>		

</table>
</td>	
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>	
	</tr>
	
	</table>
	
	
</td>



<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
	<td width="0"></td>
<cfelse>
	<td width="170" valign="top" align="right">
		<cfinclude template="../templates/dsp_internal_Rsidebar.cfm">	
	</td>
</cfif>


</tr>



<!--- BOTTOM BAR - Copyright --->

<tr>
<td colspan="3">
	<cfinclude template="../templates/dsp_bottombar.cfm">
</td>
</tr>


</table>

<cfinclude template="../templates/dsp_partners.cfm">

</body>
</html>
</cfoutput>