<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Contacts
	WHERE EmailAddress = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(FORM.email)#">
	AND ContactStatus <> 'Deleted'
	AND ContactTypeID IN (1,2,4,6,7)
</cfquery>

<cfif checkuseremail.recordcount lte 0>
    <cfset statustoGo = 1>
<cfelse>
    <cfif checkuseremail.CONTACTID eq #SESSION.userid#>
	      <cfset statustoGo = 1>
	<cfelse>
	      <cfset statustoGo = 0>	  
	</cfif>
</cfif> 

<cfif statustoGo eq 1> 
   <cfif IsDefined("FORM.upload_avtar") and FORM.upload_avtar neq ''>
        <cffile action = "upload" fileField = "upload_avtar" destination = "D:/home/iii.coop/wwwroot/images/profiles/" accept = "image/jpg, image/jpeg, image/png, image/gif, image/pjpeg, image/jpe, image/jfif, image/jif, image/exif, image/tiff" nameConflict = "MakeUnique"> 
        <cfset fileName = cffile.SERVERFILE> 
		
		<cfset myImage1=ImageNew("../images/profiles/#fileName#")>
			<cfset ImageResize(myImage1,"21","21","lanczos",1)>
		<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
            <cfimage source="#myImage1#" action="write" destination="D:/home/iii.coop/wwwroot/images/profiles/small_#fileName#" overwrite="yes">
		 
		<!--- This example shows how to resize an image to 50% of original size and resize it proportionately to the new width. Notice that the height is blank.--->
			<cfset myImage=ImageNew("../images/profiles/#fileName#")>
			<cfset ImageResize(myImage,"25%","","lanczos",1)>
		<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
            <cfimage source="#myImage#" action="write" destination="D:/home/iii.coop/wwwroot/images/profiles/#fileName#" overwrite="yes">  
		<!---<cfimage source="D:/home/iii.coop/wwwroot/images/profiles/#fileName#" action="resize" width="100" height="100" destination="D:/home/iii.coop/wwwroot/images/profiles/#fileName#" overwrite="yes">--->
   <cfelse>
  	    <cfset fileName = ""> 	
   </cfif>		 
    <cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
    UPDATE Contacts
	 SET FirstName    = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.fname#">,
	     LastName     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.lname#">,
	     EmailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.email#">
		 <cfif fileName neq ''>
		  ,profilepic   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#fileName#">
		 </cfif>
		 <cfif IsDefined("FORM.pass") and FORM.pass neq ''>
		  ,Password     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.pass#">
		 </cfif>  
	 WHERE ContactID = #FORM.USERID#  
    </cfquery>

	<cfif IsDefined("session.User_FullName") and #session.User_FullName# neq ''>
	   <cfset session.User_FullName = #FORM.fname# & " " & #FORM.lname#>
	<cfelse>
	   <cfif IsDefined("session.User_FirstName") and #session.User_FirstName# neq ''>
		   <cfset session.User_FirstName = #FORM.fname#>   
	   </cfif>
	</cfif> 
    <cfset updateStatus = "success">	
<cfelse>
    <cfset updateStatus = "fail">	  
</cfif> 