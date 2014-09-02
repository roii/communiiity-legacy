<!--- 
	Application: CF_Activedit
	Name: upload.cfm
	Function: Uploads image files to server
	Authors: Pete Freitag, Matt Finn
	Company: CFDEV.COM
	Version: 4
	Revisions:
		Fix path problems
	Date: 4/2001

	SECURITY NOTES:
		It is possible for anyone who has access to run this file on the internet to upload
		a file of the content types: image/gif,image/jpg,image/jpeg,image/pjpeg 
 --->

<cflock scope="SERVER" type="READONLY" timeout="30">
	<cfset ae_encryptkey=server.ae_encryptkey>
</cflock>

<cfset imgdata = decrypt(url.imagedata,ae_encryptkey)>

<cfif NOT ListGetAt(imgdata,1) is 1>
	Uploads have been disabled
	<cfabort>
</cfif>

<cfset imagepath=ListGetAt(imgdata,3)&form.subdir>
<cfif Right(imagepath,1) neq "/">
<cfset imagepath=imagepath&"/">
</cfif>

<cftry>
	<cffile action="upload" nameconflict="makeunique" destination="#Trim(imagepath)#" filefield="photo" accept="image/gif,image/jpg,image/jpeg,image/pjpeg" mode="644">
	<font face="arial" size="-2" color="red">File Uploaded</font><Br>
<cfcatch type="any">
	<cfinclude template="right.cfm">
	<cfif Find("MIME", CFCATCH.Detail)>
	<script>alert('File Cannot Be Uploaded\nNot An Image');</script>
	<cfelse>
	<cfoutput>
	<table border=1 width="100%">
	<tr><td>
	#CFCATCH.Message#<br>
	#CFCATCH.Detail#<br>
	</td></tr>	
	</table>
	</cfoutput>
	</cfif>

	<cfabort>
</cfcatch>
</cftry>

<cfset url.dirname = form.subdir>
<script>
	<cfoutput>
	function upload_onLoad() {
		select_image("<cfif NOT form.subdir is "/">#form.subdir#</cfif>/#File.ServerFile#");
	}
	</cfoutput>
</script>
<cfinclude template="right.cfm">


