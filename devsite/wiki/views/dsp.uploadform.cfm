<!---
	Name         : dsp.uploadform.cfm
	Author       : Mark Mazelin
	Created      : 10/11/06
	Last Updated : 
	History      : 
--->

<cfset webpath = viewState.getValue("webpath")>
<cfset viewState.setValue("title","Upload")>
<cfset errorMsg = viewState.getValue("errorMsg", "")>
<!--- fields --->
<cfset sourcefile = viewState.getValue("sourcefile", "")>
<cfset destfile = viewState.getValue("destfile", "")>
<cfset summary = viewState.getValue("summary", "")>


<cfoutput>
<h1>Upload File</h1>
<cfif len(errorMsg)>
	<h3>The following error occurred:</h3>
	<p>#ErrorMSg#</p>
</cfif>
<form id="wiki_uploadform" action="#viewState.getValue("myself")#UploadFormSubmit" method="post" enctype="multipart/form-data">
	<label for="sourcefile">Source File:</label><input type="file" name="sourcefile" id="sourcefile" value="#sourcefile#" size="40" onchange="fillDestFilename()" /><br />
	<label for="destfile">Destination File:</label><input type="text" name="destfile" id="destfile" value="#destfile#" size="40" /><br />
	<label for="summary">Summary:</label><textarea cols="50" rows="5" name="summary">#summary#</textarea><br />
	<input type="submit" value="Upload File" />
</form>
</cfoutput>