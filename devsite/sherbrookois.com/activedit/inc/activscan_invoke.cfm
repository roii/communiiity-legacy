<html>
<head>
<title>Activescan Demo</title>

<cflock scope="SERVER" type="READONLY" timeout="30">
	<cfset ae_encryptkey=server.ae_encryptkey>
</cflock>
<cfset imgdata = decrypt("#url.imagedata#",ae_encryptkey)>


<cfset aeinc = "/" & ListDeleteAt(CGI.SCRIPT_NAME, ListLen(CGI.SCRIPT_NAME, "/"), "/") & "/">
<cfset aeinc = Replace(aeinc, "//", "/")>
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

<cfset imagepath = ListGetAt(imgdata,3)>

<cfif CGI.SERVER_PORT eq 443>
	<cfset protocol = "https">
<cfelse>
	<cfset protocol = "http">
</cfif>



<cfoutput>
<script>

	function swapURL(scanned) {
		parent.right.location.reload(true);
		parent.left.location = "#protocol#://#CGI.HTTP_HOST##aeinc#left.cfm?imageurl=#URLEncodedFormat(url.imageurl)#&imagedata=#URLEncodedFormat(url.imagedata)#&instance=#url.instance#&activscan=1&img=#URLEncodedFormat(url.imageurl)#/" + scanned;
	}
	
</script>
</cfoutput>


<cfif NOT upload OR NOT activscan>
	You can't access this page<cfabort>
</cfif>
</head>
<body leftmargin="0" topmargin="0">

  <cf_activescan 
  	
	width="426"
	height="340"
  	inc="#protocol#://#CGI.HTTP_HOST##aeinc#activscan/inc/"
  	imagepath="#Trim(imagepath)#/"
	onsave="call"
	onsaveaction="swapURL('%file%')"
	license="LONneiC7"
  >
</body>

</html>