<cfif IsDefined("FORM.upload_avtar") and FORM.upload_avtar neq ''>  
  <!---Upload and save image to server--->
        <cffile action = "upload" fileField = "upload_avtar" destination = "D:/home/iii.coop/wwwroot/images/profiles/" accept = "image/jpg, image/jpeg, image/png, image/gif, image/pjpeg, image/jpe, image/jfif, image/jif, image/exif, image/tiff" nameConflict = "MakeUnique"> 
        <cfset fileName = cffile.SERVERFILE>  
		
		<cfset myImage1 = ImageNew("../images/profiles/#fileName#")>
		<cfset ImageResize(myImage1,"21","21","lanczos",1)>
		
		<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
        <cfimage source="#myImage1#" action="write" destination="D:/home/iii.coop/wwwroot/images/profiles/small_#fileName#" overwrite="yes">
		 
		<!--- This example shows how to resize an image to 50% of original size and resize it proportionately to the new width. Notice that the height is blank.--->
		<cfset myImage=ImageNew("../images/profiles/#fileName#")>
		<cfset ImageResize(myImage,"25%","","lanczos",1)>
		
		<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
        <cfimage source="#myImage#" action="write" destination="D:/home/iii.coop/wwwroot/images/profiles/#fileName#" overwrite="yes"> 
		
		<cfset updateStatus = "success">
<cfelseif IsDefined("FORM.FILENAMETOCANCEL") and FORM.FILENAMETOCANCEL neq ''>  	
 
        <cfset largeFile = "D:/home/iii.coop/wwwroot/images/profiles/#FORM.FILENAMETOCANCEL#">
        <cfset FileDelete(#largeFile#)>
		<cfset smallFile = "D:/home/iii.coop/wwwroot/images/profiles/small_#FORM.FILENAMETOCANCEL#">
        <cfset FileDelete(#smallFile#)>
		
	    <cfset updateStatus = "delete">
<cfelse>
        <cfset fileName = "">
	    <cfset updateStatus = "fail">
</cfif>