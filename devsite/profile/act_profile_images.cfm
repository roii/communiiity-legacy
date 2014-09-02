<cfoutput>

<cfif NOT DirectoryExists("#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#")>
    <cfdirectory action="create" directory="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#">
</cfif>

<!--- GET CURRENT IMAGE NAMES --->
<cfquery name="ProfileStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM UserProfiles
WHERE UserID=#session.UserID#
</cfquery>

<cfif ProfileStuff.recordcount>
    <cfset current_image1=ProfileStuff.ProfilePic1>
    <cfset current_image2=ProfileStuff.ProfilePic2>
    <cfset current_image3=ProfileStuff.ProfilePic3>
<cfelse>    
    <cfquery name="NewProfile" datasource="#dsn#" username="#request.username#" password="#request.password#">
    INSERT INTO UserProfiles(UserID, ProfileText, ProfilePic1, ProfilePic2, ProfilePic3)
    VALUES(#session.UserID#, '', '', '', '')
    </cfquery>
    <cfset current_image1="">
    <cfset current_image2="">
    <cfset current_image3="">    
</cfif>
    
<cfif TRIM(form.Image1) NEQ ''>
    <cftry>
        <cffile action="upload" filefield="Image1" destination="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\" nameconflict="overwrite" accept="image/*">
        <cfset image1Upload=file.serverfile>    
        <cfif file.FileSize GT 1000000>
            <cffile action="delete" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#image1Upload#">
            <cfset Image1_FileError = true>
            <cfset Image1_ErrorType = "size">
        <cfelse>    
            <!--- REMOVE OLD IMAGE 1 --->
            <cfif TRIM(current_image1) NEQ ''>
                <cftry>
                <cffile action="delete" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#TRIM(current_image1)#">
                <cfcatch></cfcatch>
                </cftry>
            </cfif>
        <cfx_image action="resize" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#image1Upload#" output="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\TMB_#image1Upload#" quality="100" x="160" y="120">
        </cfif>
    <cfcatch>
        <cfset Image1_FileError = true>
        <cfset Image1_ErrorType = "random">
    </cfcatch>    
    </cftry>
</cfif>

<cfif TRIM(form.Image2) NEQ ''>
    <cftry>
        <cffile action="upload" filefield="Image2" destination="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\" nameconflict="overwrite" accept="image/*">
        <cfset image2Upload=file.serverfile>        
        <cfif file.FileSize GT 1000000>
            <cffile action="delete" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#image2Upload#">
            <cfset Image2_FileError = true>
            <cfset Image2_ErrorType = "size">
        <cfelse>    
            <!--- REMOVE OLD IMAGE 2 --->
            <cfif TRIM(current_image2) NEQ ''>
                <cftry>
                <cffile action="delete" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#TRIM(current_image2)#">
                <cfcatch></cfcatch>
                </cftry>
            </cfif>
        <cfx_image action="resize" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#image2Upload#" output="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\TMB_#image2Upload#" quality="100" x="160" y="120">
        </cfif>
    <cfcatch>
        <cfset Image2_FileError = true>
        <cfset Image2_ErrorType = "random">
    </cfcatch>
    </cftry>
</cfif>

<cfif TRIM(form.Image3) NEQ ''>
    <cftry>
        <cffile action="upload" filefield="Image3" destination="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\" nameconflict="overwrite" accept="image/*">
        <cfset image3Upload=file.serverfile>
        <cfif file.FileSize GT 1000000>
            <cffile action="delete" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#image3Upload#">
            <cfset Image3_FileError = true>
            <cfset Image3_ErrorType = "size">
        <cfelse>
            <!--- REMOVE OLD IMAGE 3 --->
            <cfif TRIM(current_image3) NEQ ''>
                <cftry>
                <cffile action="delete" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#TRIM(current_image3)#">
                <cfcatch></cfcatch>
                </cftry>
            </cfif>
        <cfx_image action="resize" file="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#image3Upload#" output="#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\TMB_#image3Upload#" quality="100" x="160" y="120">
        </cfif>  
    <cfcatch>
        <cfset Image3_FileError = true>
        <cfset Image3_ErrorType = "random">
    </cfcatch>
    </cftry>
</cfif>


<cfquery name="UpdateProfile" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE UserProfiles
SET
<cfif TRIM(form.Image1) NEQ '' AND NOT IsDefined("Image1_FileError")>
    ProfilePic1='TMB_#image1Upload#',
</cfif>
<cfif TRIM(form.Image2) NEQ '' AND NOT IsDefined("Image2_FileError")>
    ProfilePic2='TMB_#image2Upload#',
</cfif>
<cfif TRIM(form.Image3) NEQ '' AND NOT IsDefined("Image3_FileError")>
    ProfilePic3='TMB_#image3Upload#',
</cfif>
ProfileText='#form.ProfileText#'
WHERE UserID=#session.UserID#
</cfquery>

<cfif IsDefined("Image1_FileError") OR IsDefined("Image2_FileError") OR IsDefined("Image3_FileError")>
    <cfset fileerrortext = "AN ERROR OCCURED\n">
    <cfif IsDefined("Image1_FileError")>
        <cfif Image1_ErrorType EQ 'size'>
            <cfset fileerrortext = fileerrortext & "Photo 1 was larger than 1mb and has not been saved.\n">
        <cfelse>
            <cfset fileerrortext = fileerrortext & "Photo 1 has not been saved.\n">
        </cfif>
    </cfif>
    <cfif IsDefined("Image2_FileError")>
        <cfif Image2_ErrorType EQ 'size'>
            <cfset fileerrortext = fileerrortext & "Photo 2 was larger than 1mb and has not been saved.\n">
        <cfelse>
            <cfset fileerrortext = fileerrortext & "Photo 2 has not been saved.\n">
        </cfif>
    </cfif>
    <cfif IsDefined("Image3_FileError")>
        <cfif Image3_ErrorType EQ 'size'>
            <cfset fileerrortext = fileerrortext & "Photo 3 was larger than 1mb and has not been saved.\n">
        <cfelse>
            <cfset fileerrortext = fileerrortext & "Photo 3 has not been saved.\n">
        </cfif>
    </cfif>
    
<script type="text/javascript">
alert("#fileerrortext#");
self.location="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#session.User_ScreenName#";
</script>
<cfelse>
<cflocation url="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#session.User_ScreenName#">
</cfif>

</cfoutput>