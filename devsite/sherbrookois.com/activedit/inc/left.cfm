<!--- 
	Application: CF_Activedit
	Name: left.cfm
	Function: Left frame of image frame, upload/insert an image
	Authors: Pete Freitag, Matt Finn
	Company: CFDEV.COM
	Version: 4.0
	Revisions:
		- Fixed double image problem in IE 4
	Date: 3/2001
 --->
<cfoutput>
<CFSETTING SHOWDEBUGOUTPUT="No">
<cflock scope="SERVER" type="READONLY" timeout="30">
	<cfset ae_encryptkey=server.ae_encryptkey>
</cflock>

<cfset imgdata = decrypt("#url.imagedata#",ae_encryptkey)>

<cfif ListGetAt(imgdata,1) is 1>
	<cfset upload=1>
<cfelse>
	<cfset upload=0>
</cfif>

<cfif ListGetAt(imgdata,2) is 1>
	<cfset activscan = 1>
<cfelse>
	<cfset activscan = 0>
</cfif>

<html>

<script language="javascript1.1">

function init() {
	<cfif NOT IsDefined("url.img")>
	if (typeof(parent.image_loc) == "undefined") {
		parent.image_loc = ipreview.location;
	}
	</cfif>
}

function insert_image() {
	//insert the image into the activedit control '#url.imageurl#'
	
	eval(parent).opener.onImage(parent.image_loc, '#url.imageurl#' , getFormObject("imgfrm").bdr.value, getFormObject("imgfrm").algn.value, getFormObject("imgfrm").alt.value, #url.instance#);
	val = close();
}

function getFormObject( strForm ){

	var _info = navigator.userAgent; 
	var _ns = (navigator.appName.indexOf("Netscape") >= 0 && ((_info.indexOf("Win") > 0 && _info.indexOf("Win16") < 0 && java.lang.System.getProperty("os.version").indexOf("3.5") < 0) || (_info.indexOf("Sun") > 0) || (_info.indexOf("Linux") > 0) || (_info.indexOf("AIX") > 0) || (_info.indexOf("OS/2") > 0)));
	var _ns6 = ((_ns == true) && (_info.indexOf("Mozilla/5") >= 0));
	var _ie = (_info.indexOf("MSIE") > 0 && _info.indexOf("Win") > 0 && _info.indexOf("Windows 3.1") < 0);
	var _mac = ( _info.indexOf("Mac") > -1 ) ? true : false;
 
	if( _ie == true ) 
		return eval( strForm );
	else   
		return eval( "document.forms." + strForm );
}

</script>
<style type="text/css">
	A {
		color : 1d039e;
		text-decoration : none;
	}
	A:Hover {
		text-decoration : underline;
	}
	body {
		font-size: 12px;
	}
</style>

<body link="1d039e" vlink="1d039e" onload="init();" leftmargin="0" topmargin="0">
<div style="padding:4px;font-family : Verdana,Arial;font-size:14px;">
<cfif upload><a href="newimage.cfm?instance=#url.instance#&imageurl=#URLEncodedFormat(url.imageurl)#&imagedata=#URLEncodedFormat(url.imagedata)#"><img src="images/up.gif" width=23 height=22 alt="Add a New Image" border="0" align="absmiddle" hspace=5><b>New Image</b></a><span style="font-size:12px;"> - Upload a new image </cfif><br>
<cfparam name="url.img" default="activedit.gif">
<iframe name="ipreview" id="ipreview" frameborder="0" style="border : 1px solid gray;" height="245" width="400" src="#url.img#"></iframe>
</cfoutput>
<span style="font-size:10px"><br><br></span>
<span style="font-size:12px;">
<form name="imgfrm">

	<b>Border: </b> <input type="text" name="bdr" value="0" maxlength="100" size="2">
	&nbsp;&nbsp;
	<b>Align: </b> 
	<select name="algn">
		<option value="" selected>&nbsp;</option>
		<option value="middle">middle</option>
		<option value="bottom">bottom</option>
		<option value="top">top</option>
		<option value="left">left</option>
		<option value="right">right</option>
		<option value="absmiddle">absmiddle</option>
		<option value="baseline">baseline</option>
		<option value="texttop">texttop</option>
		<option value="absbottom">absbottom</option>
	</select>
	<br><br>
	<b>Text Description: </b> <input type="text" name="alt" value="" maxlength="100" size="41">
</span>
<br>
<br>
</div></form>
<div align="center" style="height:100%;font-family:verdana;background-color:#f5f5f5;padding:4px;border-top:1px solid silver;">
<a href="javascript:insert_image()"><img src="images/down.gif" alt="Insert Image" border="0" align="absmiddle"></a>&nbsp;<a href="javascript:insert_image()"><b>Insert Image</b></a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:parent.close()"><img src="images/delete.gif" alt="Close This window" border="0" align="absmiddle"></a>&nbsp;<A href="javascript:parent.close()"><B>Cancel</b></a>
</div>

</body>
</html>
