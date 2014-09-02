<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head> 
<title><cfif IsDefined("this_metatitle") and this_metatitle neq ''>#TRIM(this_metatitle)#<cfelse>#TRIM(AllSettings.SiteName)# - Login</cfif></title>

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

<div style="width: 100%;">
      <cfinclude template="../templates/header_include.cfm"> 	  
	  <div class="content">
        <cfif browser eq 'Internet Explorer'>
		  <div class="container" style="text-align: left;">
		<cfelse>
		  <div class="container">
		</cfif> 
			    <table style="width:1000px;" cellpadding="0" cellspacing="0" border="0"> 
						<tr>
						       <td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="459" height="8" border="0"></td>
						</tr> 
						<tr>
						       <!---<td width="1" background="#request.imageroot#/dots_vertical.gif">
							         <img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0">
							   </td>--->
							   <td width="100%" style="padding-left:10px;padding-right:10px;" colspan="3">
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
								 <form method="post" action="#request.webroot#/index.cfm" onSubmit="validatePageLogin(PageLoginForm); return false;" name="PageLoginForm">
										<tr>
												<td>#emailaddress#: <input type="text" class="field" name="LoginName" style="width:100px;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #password#: <input type="password" class="field" name="Password" style="width:100px;"> &nbsp; <input type="submit" class="field" value="#loginnow#">
												 <br> #ortext# <br>
												    <span style="color:##000; font-family: Verdana,Geneva,sans-serif; font-size: small;">
									                    #signinwith# <a href="javascript: void(0);" onClick="javascript: window.open('/getRequestToken.cfm','linkedLogin','width=800,height=600,scrollbars=1,resizable=1');"> 
														<img src="/images/linkedin-icon-footer.png" style="height: 20px; margin: 0; padding: 0;" border="0" /></a>
									                </span> 
												</td>
										</tr>
										<tr style="height: 30px;">
												<td>&nbsp;</td>
										</tr>
										<tr>
												<td><hr width="50%" size="1" color="e2e2e2">
													<a href="#request.webroot#/dsp_forgot_password.cfm" target="password" onClick="fdbackwindow=window.open ('','password','width=500,height=240,top=10,left=10,resizable=1,menubar=0,status=0,scrollbars=1,panel=0,addressbar=0')">#forgotPass#</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <a href="#request.webroot#/index.cfm?fuseaction=join">#register#</a> 
												</td>
										</tr>
										<tr style="height: 250px;">
												<td>&nbsp;</td>
										</tr>					
								</form>							
							 </table>
						   </td>	
						   <!---<td width="1" background="#request.imageroot#/dots_vertical.gif">
						           <img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0">
						   </td>--->	
					   </tr>
			  </table>
	      </div>
	  </div>
	  <cfinclude template="../templates/footer_include.cfm">
</div> 
<cfinclude template="../templates/dsp_partners.cfm">
</body>
</html>
</cfoutput>