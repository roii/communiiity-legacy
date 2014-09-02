<cfinclude template="app_locals.cfm">

<!--- Default Parameters --->
<cfparam name="obj" default="001">
<cfparam name="NoofQ" default="10">

<html>
<head>
	<title>myKidsBiz Survey Engine</title>
	<!---<cfoutput>
		<script>
					<!--
						if (window == window.top)
							location.href = "dsp_build_frames.cfm?obj=#obj#";
					//-->
		</script>
	</cfoutput>--->
</head>
<body>
<a href="http://www.my3p.com">
<img src="http://www.my3p.com/images/logo.gif" border="0" alt="myKidsBiz" align="right"></a><br clear="all">
<!--- <cfif cookie.user is "">
<div>

<cfform name="form" action="default.cfm?obj=016" method="post">
	<font face="verdana">
		<table border="0" align="center">
			<tr>
				<td>
					<font face=verdana size="-2">Username:</font>
				</td>
				<td>
					<cfinput type="text" name="user" size="10" required="Yes">
				</td>
			
				<td>
					<font face=verdana size="-2">Password:</font>
				</td>
				<td>
					<cfinput type="password" name="pass" size="10" required="Yes">
				</td>
			
			<td>&nbsp;
				</td>
				<td align="center">
					<input type="submit" value="Login" class="submit">
					<input TYPE="reset" VALUE="Reset" class="submit" >
				</td>
			</tr>
		</table>
	</font>
</cfform>
</div></cfif>  --->
<!--- Standard Header --->
<cfinclude template="header.cfm">

<cfparam name="attributes.method" default="">
<cfparam name="attributes.obj" default="">
<cfparam name="attributes.fuseaction" default="">

<cfset obj=attributes.obj>
<cfset method=attributes.method>
<!--- Load Action method --->
<cfif isdefined("method")>
	<cfif isnumeric(method)>
		<cfinclude template="m#method#.cfm">
	</cfif>
</cfif>
<!--- Load Standard CFML Object --->
<cfif isnumeric(obj)>
	<cfinclude template="o#obj#.cfm">
</cfif>

<cfif #attributes.fuseaction# EQ 'add_com'>
  <cfinclude template="dsp_add_com.cfm">

<cfelseif #attributes.fuseaction# EQ 'edit_com'>
  <cfinclude template="dsp_edit_com.cfm">

<cfelseif #attributes.fuseaction# EQ 'add_survey'>
  <cfinclude template="dsp_add_survey.cfm">

<cfelseif #attributes.fuseaction# EQ 'edit_survey'>
  <cfinclude template="dsp_edit_survey.cfm">

<cfelseif #attributes.fuseaction# EQ 'add_term'>
  <cfinclude template="dsp_add_terms.cfm">
  
<cfelseif #attributes.fuseaction# EQ 'edit_term'>
  <cfinclude template="dsp_edit_term.cfm">  

<cfelseif #attributes.fuseaction# EQ 'add_Q'>
  <cfinclude template="dsp_add_Q.cfm">

<cfelseif #attributes.fuseaction# EQ 'act_add_Q'>
  <cfinclude template="act_add_Q.cfm">

<cfelseif #attributes.fuseaction# EQ 'edit_Q'>
  <cfinclude template="dsp_edit_Q.cfm">

<cfelseif #attributes.fuseaction# EQ 'act_edit_Q'>
  <cfinclude template="act_edit_Q.cfm">

<cfelseif #attributes.fuseaction# EQ 'survey_page'>
  <cfinclude template="dsp_survey_page.cfm">

<cfelseif #attributes.fuseaction# EQ 'survey_form'>
  <cfinclude template="dsp_survey_form.cfm">

<cfelseif #attributes.fuseaction# EQ 'results_page'>
  <cfinclude template="dsp_results_page.cfm">

<cfelseif #attributes.fuseaction# EQ 'email_results'>
  <cfinclude template="dsp_email_results.cfm">
    
</cfif>
<!--- Standard Footer --->
<cfinclude template="footer.cfm">

</body>
</html>
