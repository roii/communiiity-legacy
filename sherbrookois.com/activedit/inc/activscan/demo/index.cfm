<!---
	File: index.cfm (ActiveScan Example Application)
	Author: Matt Finn
    Company: CFDEV.COM / NETDesign Inc.
	Description:
 		Main page for ActiveScan demo application
    Date: August 2000
	Version: 1,0,0,1
--->

<html>
<head>
<title>ActiveScan Example Application</title>
<script language="javascript1.2">
function popup() {
	window.open("popup.cfm", "ascanpopup", "height=284,width=454,status=no,toolbar=no,menubar=no,location=no");
}
function zabam(haust) {
	var l;

	l=window.location;
	parent.document.location.search="first="+haust+"&t=1";

}
</script>
</head>
<body>
<cflock scope="application" timeout="100">
  <cfparam name="url.first" default="#application.imageno#">
  <cfset imageurl=application.imageurl>
</cflock>

<cfparam name="url.t" default=0>

<BR>
<table>
<tr>
<td>
<font face="arial" size=4>
<img src="images/ascansmall.gif">
</font>
</td>
<td>
<font face="arial" size="-2">
This is a demo of Activescan. 
You should have a<br>
scanner or digital camera installed 
to view the demo. <br>Internet Explorer 4.0 or higher is required.<br>
If you do not have a scanner, download and install this <br>
<a href="http://twain.org/devfiles/twainkit.exe">sample source</a> to try activescan.
</font>

</td>
</tr>
</table>

<font face="arial" size=3>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<A href="#" onclick="popup();"><img src="images/scanicon.gif" align="absmiddle" border="0" hspace="6">Click here to scan an image.</a>
</font><br><br>


<table>
<tr valign="top" >
<td width="25%">

<cfif url.t>
<B>Your image:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;
<cfelse>
<b>Last 10 images:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;
</cfif>
<cfoutput>
<cfset i=1>
<CFLOOP INDEX="idx"
    FROM="#url.first#"
    TO=#Evaluate("#url.first# - 9")#
    STEP="-1">
<cfif idx LT 0><cfset imgno=idx+10>
<cfelse><cfset imgno=idx></cfif>

  <a href="#imageurl##imgno#.jpg"><img src="#imageurl##imgno#.jpg" width=40></a>

<cfif i eq 5 ><br>&nbsp;&nbsp;&nbsp;&nbsp;</cfif>

<cfif i eq 1 and url.t></td><td align="center" width="75%"><b>Last 9 images:</b><br><br>&nbsp;&nbsp;&nbsp;&nbsp;</cfif>

<cfset i=i+1>


</CFLOOP>

</td>
</tr>
</table>

</cfoutput>
</body>
</html>



