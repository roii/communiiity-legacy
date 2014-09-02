<cfscript>
function stripHTML(str) {
return REReplaceNoCase(str,"<[^>]*>","","ALL");
}
</cfscript>

<cfset cleanStr = stripHTML(form.Comment)>
<cfset cleanAuth = stripHTML(form.Author)>

<cfhttp url="http://www.google.com/recaptcha/api/verify" method="post" timeout="5" throwonerror="true">
    <cfhttpparam type="formfield" name="privatekey" value="6LfCrMUSAAAAAGwuvDOrCXV9yA2gu6ECM_E4Yhuf">
    <cfhttpparam type="formfield" name="remoteip" value="#cgi.REMOTE_ADDR#">
    <cfhttpparam type="formfield" name="challenge" value="#form.recaptcha_challenge_field#">
    <cfhttpparam type="formfield" name="response" value="#form.recaptcha_response_field#">
</cfhttp>

<cfset aResponse = listToArray(cfhttp.fileContent, chr(10))>
	<cfif aResponse[1] eq "false" and aResponse[2] neq "incorrect-captcha-sol">
	<cflocation url="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#form.documentID#&projectmode=#form.projectmode#&ProjectCategoryID=#form.ProjectCategoryID#&ProjectID=#form.projectID#">
<cfelse>

<!---<cfif form.captcha neq session.captcha>--->

<!---<cfset errors = "Sorry, the captcha image did not match the string you entered.<br />">
<cfoutput>
<h3> #errors#</h3>
<p>Please use your browsers back button and try again.</p>

</cfoutput>
          
<cfelse>--->
<cfif IsDefined('SESSION.userid') and SESSION.userid neq ''>
    <cfset userid = SESSION.userid>
<cfelse>
    <cfset userid = 0>
</cfif>

<cfquery name="AddComment" datasource="#dsn#" username="#request.username#" password="#request.password#">

INSERT INTO ProjectComments(ProjectID, Comment, Author, AuthorEmail, DateAdded, contactid)

VALUES('#form.ProjectID#', '#cleanStr#', '#cleanAuth#', '#form.AuthorEmail#', GETDATE(), #userid#)

</cfquery> 

<cflocation url="#request.webroot#/index.cfm?fuseaction=tasks">

</cfif>



