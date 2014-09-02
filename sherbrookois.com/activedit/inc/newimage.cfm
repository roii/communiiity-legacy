<!--- 
	Application: CF_Activedit
	Name: left.cfm
	Function: Left frame of image frame, upload/insert an image
	Authors: Pete Freitag, Matt Finn
	Company: CFDEV.COM
	Version: 4
	Revisions:
		- Fixed double image problem in IE 4
	Date: 3/2001
 --->
<html>
<head></head>
<body>
<cflock scope="SERVER" type="READONLY" timeout="30">
	<cfset ae_encryptkey=server.ae_encryptkey>
</cflock>
<cfoutput>
<cfset imgdata = decrypt("#url.imagedata#",ae_encryptkey)>
</cfoutput>

<cfif ListGetAt(imgdata,1) is 1>
	<cfset upload=1>
<cfelse>
	<cfset upload=0>
</cfif>

<cfset this.root=ListGetAt(imgdata,3)>

<cfif ListGetAt(imgdata,2) is 1>
	<cfset activscan = 1>
<cfelse>
	<cfset activscan = 0>
</cfif>

<cfif NOT upload>
	<font face="verdana"><b>Image Uploads have been disabled.</b><br>
	<br> &nbsp;<A HREF="javascript:history.go(-1)"><B>&laquo; Go Back</b></a>
	</font><cfabort>
</cfif>

<script>
	function preview() {
		if ((frm.photo.value.length) > 3) {
			pwin = window.open('about:blank', "pwin", "directories=no,height=400,width=400,location=no,menubar=no,status=no,toolbar=no");
			var out = "<title>Image Upload Preview</title><font face=verdana size=2><b>Image Preview</b> <font size='-2'>- Click Upload this Image, or cancel to continue</font><BR><iframe width=380 height=330 frameborder=0 style='border : 1px solid gray;' src='";
			out  += frm.photo.value;
			out += "' borders=0></iframe><br><center><img src='images/up.gif' alt='' border=0 align='absmiddle'>&nbsp;<A href='javascript:eval(parent).opener.upload()' style='color:1d039e;'><b>Upload this image</b></a>&nbsp;&nbsp;&nbsp; <img src='images/delete.gif' border=0 alt='' align='absmiddle'>&nbsp;<A href='javascript:window.close();' style='color:1d039e;'><b>Cancel</b></a></font></center>";
			pwin.document.write(out);
			
		}
		else {
			alert('You need to browse for an image first.');
			frm.photo.focus();
		}
	}	
	function hasContent() {
		return (frm.photo.value.length > 3) ? false : true 
	}
	function upload() {
		frm.submit();
		if (typeof(pwin) != "undefined") {
			pwin.close();
		}
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
</style>
<body>
<font face="verdana" size="2">
	<center><B>ADD A NEW IMAGE</b></center><BR>
	<cfoutput>
	<!--- ACTIVESCAN --->
	<cfif activscan AND CGI.USER_AGENT contains "MSIE">
	<A Href="activscan_invoke.cfm?imageurl=#URLEncodedFormat(url.imageurl)#&imagedata=#URLEncodedFormat(url.imagedata)#&instance=#url.instance#"><img src="images/scan.gif" width=23 height=22 alt="" border="0" align="absmiddle"><B>Scan an Image</b></a>
	<font size="-2">Use your scanner, or digital camera to add an image to your web site</font>
	</cfif>
	
	<form action="upload.cfm?imageurl=#URLEncodedFormat(url.imageurl)#&imagedata=#URLEncodedFormat(url.imagedata)#&instance=#url.instance#" method="post" target="right" id="frm" ENCTYPE="multipart/form-data">
	</cfoutput>

	<b>Upload An Image</b><BR><BR>
	<cfdirectory action="LIST" directory="#Trim(this.root)#" name="d">
<cfset ndir = 0>
<cfoutput query="d">
	<cfif d.name IS NOT "." AND d.name IS NOT ".." AND type IS "dir"><cfset ndir = 1></cfif>
</cfoutput>
<cfif ndir>
<font size=-2>Select A Directory</font><br>
<select name="subdir">
<cf_recursedir basepath="#Trim(this.root)#">
</select><br>
<cfelse>
	<input type="hidden" name="subdir" value="/">
</cfif>
	<input type="File" name="photo" style="border: 1px solid black;">
	<BR><BR>
	<a href="javascript:upload()"><img src="images/up.gif" border=0 alt="Upload" align="absmiddle" id="upld"></a>&nbsp;<a href="javascript:upload()"><b>Upload</b></a>
	&nbsp;&nbsp;&nbsp;
	<a href="javascript:upload()"><img src="images/image.gif" border=0 alt="Preview" align="absmiddle" id="preview"></a>&nbsp;<a href="javascript:preview()"><b>Preview Image</b></a>
	
	</form>

<BR><BR><BR><BR>
<A HREF="javascript:history.go(-1)"><B>&laquo; Go Back</b></a>
</font>
</body>
</html>
