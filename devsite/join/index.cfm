<cfinclude template="app_locals.cfm">

<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfif IsDefined("this_metatitle")>
<cfset this_metatitle = Replace(this_metatitle,"3P.com", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"3p.com", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"my3P.com", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"MY3P.com", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"mY3P.com", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"My3P.com", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"mY3p.com", 'crowdsourciiing.com', 'all')> 
<cfset this_metatitle = Replace(this_metatitle,"3P", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"my3P", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"3p", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"my3p", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"MY3p", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"MY3P", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"My3p", 'crowdsourciiing.com', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"mY3p", 'crowdsourciiing.com', 'all')>
<title>#TRIM(this_metatitle)#</title>
<cfelse><title>#TRIM(AllSettings.SiteName)#</title></cfif>

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
 

      <cfinclude template="../templates/header_include.cfm"> 
	    
					<cfif attributes.fusesubaction EQ 'index'>	 
						<cfinclude template="dsp_signup_form.cfm">	
						
					<cfelseif attributes.fusesubaction EQ 'step1complete'>
						<cfinclude template="dsp_registration_step1complete.cfm">
						
						
					<cfelseif attributes.fusesubaction EQ 'reverify'>
						<cfinclude template="dsp_reverify.cfm">	
					
					<cfelseif attributes.fusesubaction EQ 'step2'>
						<cfinclude template="dsp_verification_thanks.cfm">
					
					<cfelseif attributes.fusesubaction EQ 'registration_thanks'>
						<cfinclude template="dsp_registration_thanks.cfm">
					</cfif>  
	  
	  <cfinclude template="../templates/footer_include.cfm">
	  
 
 
<cfinclude template="../templates/dsp_partners.cfm">
</body>
</html>
</cfoutput>