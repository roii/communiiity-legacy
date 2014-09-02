<cfif FORM.UPLOADFILEEXTENSIONEXT neq ''>
	<cfif IsDefined("FORM.UPLOADFILEEXTENSIONEXT") and (trim(FORM.UPLOADFILEEXTENSIONEXT) eq "gif" or trim(FORM.UPLOADFILEEXTENSIONEXT) eq "jpg" or trim(FORM.UPLOADFILEEXTENSIONEXT) eq "jpeg" or trim(FORM.UPLOADFILEEXTENSIONEXT) eq "png")> 
	<cfelse>  
	   <cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&fileext=0" addtoken="no">
	   <cfabort>
	</cfif> 
</cfif>

<cfif FORM.adminIDCheck eq 'No'>    

		<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT ContactID
			FROM Contacts
			WHERE ContactID = #FORM.userID#
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
	
	     <!---Start of code - Upload and save Profile Image to server--->
	    <cfif IsDefined("FORM.upload_avtar") and FORM.upload_avtar neq ''>   
				<cffile action = "upload" fileField = "upload_avtar" destination = "D:/home/crowdsourciiing.com/wwwroot/images/profiles/" accept = "image/jpg, image/jpeg, image/png, image/gif, image/pjpeg, image/jpe, image/jfif, image/jif, image/exif, image/tiff" nameConflict = "MakeUnique"> 
				<cfset uploadProfileImgFileName = cffile.SERVERFILE>  
				
				<cfset myImage1 = ImageNew("../images/profiles/#uploadProfileImgFileName#")>
				<!---<cfset ImageResize(myImage1,"21","21","lanczos",1)>--->
				
				<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
				<cfimage source="#myImage1#" action="resize" destination="D:/home/crowdsourciiing.com/wwwroot/images/profiles/small_#uploadProfileImgFileName#" height="21" width="21" overwrite="yes">
				 
				<!--- This example shows how to resize an image to 50% of original size and resize it proportionately to the new width. Notice that the height is blank.--->
				<cfset myImage=ImageNew("../images/profiles/#uploadProfileImgFileName#")>
				<!---<cfset ImageResize(myImage,"20%","","lanczos",1)>--->
				
				<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
				<cfimage source="#myImage#" action="resize" destination="D:/home/crowdsourciiing.com/wwwroot/images/profiles/#uploadProfileImgFileName#" height="200" width="200" overwrite="yes">  
				<cfset uploadProfileImgFileNameStatus = "success"> 
		<cfelse>
				<cfset uploadProfileImgFileName       = "">
				<cfset uploadProfileImgFileNameStatus = "fail">
		</cfif>
        <!---End of code - Upload and save Profile Image to server--->
		
		<!---Start of code - Upload and save Avtaar to server--->
	    <cfif IsDefined("FORM.upload_avtar_image") and FORM.upload_avtar_image neq ''>   
				<cffile action = "upload" fileField = "upload_avtar_image" destination = "D:/home/crowdsourciiing.com/wwwroot/images/profiles/" accept = "image/jpg, image/jpeg, image/png, image/gif, image/pjpeg, image/jpe, image/jfif, image/jif, image/exif, image/tiff" nameConflict = "MakeUnique"> 
				<cfset uploadAvtarFileName = cffile.SERVERFILE>  
				
				<cfset myImage1 = ImageNew("../images/profiles/#uploadAvtarFileName#")>
				<!---<cfset ImageResize(myImage1,"21","21","lanczos",1)>--->
				
				<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
				<cfimage source="#myImage1#" action="resize" destination="D:/home/crowdsourciiing.com/wwwroot/images/profiles/small_#uploadAvtarFileName#" height="21" width="21" overwrite="yes">
				 
				<!--- This example shows how to resize an image to 50% of original size and resize it proportionately to the new width. Notice that the height is blank.--->
				<cfset myImage=ImageNew("../images/profiles/#uploadAvtarFileName#")>
				<!---<cfset ImageResize(myImage,"25%","","lanczos",1)>--->
				
				<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
				<cfimage source="#myImage#" action="resize" destination="D:/home/crowdsourciiing.com/wwwroot/images/profiles/#uploadAvtarFileName#" height="100" width="100" overwrite="yes"> 
				
				<cfset uploadAvtarFileNameStatus = "success"> 
		<cfelse>
				<cfset uploadAvtarFileName       = "">
				<cfset uploadAvtarFileNameStatus = "fail">
		</cfif>
        <!---End of code - Upload and save Avtaar to server--->	
		<!---<cfset cleanindividual_description_html = #replace(form.individual_description_html,Chr(13),"<br>", "all")#>--->
		<cfif statustoGo eq 1> 	 
			<cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Contacts
			 SET FirstName    = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.fname#">,
				 LastName     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.lname#">,
				 country      = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.country#">,
				 PostalCode   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.postalcode#">,
				 cellNum      = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.cellNum#">,
				 individual_tagline = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.individual_tagline#">,
				 individual_description_html = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.individual_description_html#">
				 <cfif uploadProfileImgFileName neq ''>
					  , PROFILEPIC   = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#uploadProfileImgFileName#">
				 </cfif>	  
				 <cfif uploadAvtarFileName neq ''>
					 , upload_avtar_image = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#uploadAvtarFileName#">
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
		
<cfelse> 
	    <!---Start of code - Upload and save Profile Image to server--->
	    <cfif IsDefined("FORM.upload_avtar") and FORM.upload_avtar neq ''>   
				<cffile action = "upload" fileField = "upload_avtar" destination = "D:/home/crowdsourciiing.com/wwwroot/images/profiles/" accept = "image/jpg, image/jpeg, image/png, image/gif, image/pjpeg, image/jpe, image/jfif, image/jif, image/exif, image/tiff" nameConflict = "MakeUnique"> 
				<cfset uploadProfileImgFileName = cffile.SERVERFILE>  
				
				<cfset myImage1 = ImageNew("../images/profiles/#uploadProfileImgFileName#")>
				<!---<cfset ImageResize(myImage1,"21","21","lanczos",1)>--->
				
				<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
				<cfimage source="#myImage1#" action="resize" destination="D:/home/crowdsourciiing.com/wwwroot/images/profiles/small_#uploadProfileImgFileName#" height="21" width="21" overwrite="yes">
				 
				<!--- This example shows how to resize an image to 50% of original size and resize it proportionately to the new width. Notice that the height is blank.--->
				<cfset myImage=ImageNew("../images/profiles/#uploadProfileImgFileName#")>
				<!---<cfset ImageResize(myImage,"20%","","lanczos",1)>--->
				
				<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
				<cfimage source="#myImage#" action="resize" destination="D:/home/crowdsourciiing.com/wwwroot/images/profiles/#uploadProfileImgFileName#" height="200" width="200" overwrite="yes">  
				<cfset uploadProfileImgFileNameStatus = "success"> 
		<cfelse>
				<cfset uploadProfileImgFileName       = "">
				<cfset uploadProfileImgFileNameStatus = "fail">
		</cfif>
        <!---End of code - Upload and save Profile Image to server--->
		
		<!---Start of code - Upload and save Avtaar to server--->
	    <cfif IsDefined("FORM.upload_avtar_image") and FORM.upload_avtar_image neq ''>   
				<cffile action = "upload" fileField = "upload_avtar_image" destination = "D:/home/crowdsourciiing.com/wwwroot/images/profiles/" accept = "image/jpg, image/jpeg, image/png, image/gif, image/pjpeg, image/jpe, image/jfif, image/jif, image/exif, image/tiff" nameConflict = "MakeUnique"> 
				<cfset uploadAvtarFileName = cffile.SERVERFILE>  
				
				<cfset myImage1 = ImageNew("../images/profiles/#uploadAvtarFileName#")>
				<!---<cfset ImageResize(myImage1,"21","21","lanczos",1)>--->
				
				<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
				<cfimage source="#myImage1#" action="resize" destination="D:/home/crowdsourciiing.com/wwwroot/images/profiles/small_#uploadAvtarFileName#" height="21" width="21" overwrite="yes">
				 
				<!--- This example shows how to resize an image to 50% of original size and resize it proportionately to the new width. Notice that the height is blank.--->
				<cfset myImage=ImageNew("../images/profiles/#uploadAvtarFileName#")>
				<!---<cfset ImageResize(myImage,"25%","","lanczos",1)>--->
				
				<!--- Save the modified image to a file called "test_myImage.jpeg" and display the image in a browser. --->
				<cfimage source="#myImage#" action="resize" destination="D:/home/crowdsourciiing.com/wwwroot/images/profiles/#uploadAvtarFileName#" height="100" width="100" overwrite="yes"> 
				
				<cfset uploadAvtarFileNameStatus = "success"> 
		<cfelse>
				<cfset uploadAvtarFileName       = "">
				<cfset uploadAvtarFileNameStatus = "fail">
		</cfif>
        <!---End of code - Upload and save Avtaar to server--->
	  
        <cfset adminIDArr = ListToArray(FORM.userID, "999")>
	    <cfset adminID = adminIDArr[1]>
        <cfquery name="CheckAdminEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT AdministratorID
			FROM Administrator
			WHERE AdministratorID =  #adminID#
		</cfquery> 
		<!---<cfset cleanindividual_description_html = #replace(form.individual_description_html,Chr(13),"<br>", "all")#>--->
		    <cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Administrator
				 SET FirstName    = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.fname#">,
					 LastName     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.lname#">,
					 country      = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.country#">,
					 PostalCode   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.postalcode#">,
					 cellNum      = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.cellNum#">,
					 individual_tagline = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.individual_tagline#">,
					 individual_description_html = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.individual_description_html#">
					 <cfif uploadProfileImgFileName neq ''>
					      , PROFILEPIC   = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#uploadProfileImgFileName#">
					 </cfif>	  
					 <cfif uploadAvtarFileName neq ''>
					     , upload_avtar_image = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#uploadAvtarFileName#">
					 </cfif> 			  
				 WHERE AdministratorID = #adminID#  
			</cfquery> 
			<cfif IsDefined("session.User_FullName") and #session.User_FullName# neq ''>
			   <cfset session.User_FullName = #FORM.fname# & " " & #FORM.lname#>
			<cfelse>
			   <cfif IsDefined("session.User_FirstName") and #session.User_FirstName# neq ''>
				   <cfset session.User_FirstName = #FORM.fname#>   
			   </cfif>
			</cfif> 
			<cfset updateStatus = "success"> 
</cfif>		