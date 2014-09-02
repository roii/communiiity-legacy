
<cfscript>
	function changeDateFormation(dateStr){
		var date = ArrayNew(1);
		var startIndex =1;
		var index = -1;
		for(loop=1; loop LE 3; loop=loop + 1){
			date[loop] = getToken(dateStr,loop,'/');
		}
	return date;
}
</cfscript>


<cfif isdefined('Form.subSugEdit')>

	<cfset dateArray = changeDateFormation(#Form.closeDate# & '/')>
	<cfset correctDateFormat = DateFormat(CreateDate(dateArray[3],dateArray[2],dateArray[1]),"yyyy-mm-dd")>
	
	<cfquery name="UpSugEdit" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE 	Suggestion
			SET 	whenVotingClose = CAST('#correctDateFormat#' as datetime),
					email = '#Trim(Form.email)#',
					authorise ='#Trim(Form.authorise)#',
					categoryID = #Form.category#,
					suggestion ='#Form.suggestion#',
					comments = '#Form.comments#',
					madeBy = '#Trim(Form.by)#'
			WHERE	sugID = #Form.sugID#				
	</cfquery>
     
    <cfif Form.contactID NEQ '' and Form.authorise EQ 'yes'>
	  <cfset activityid = 2>
	  <cfset kidsid = Form.contactID>
	  <cfset showconfirm = "false">
	  <cfinclude template="act_add_entry.cfm">
    </cfif>

<cfif form.comments neq ''>
<cfquery name="kidsdetails" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT * FROM contacts where contactid = #Form.contactID#
</cfquery>
<cfmail server="#application.emailserver#" to="#Trim(Form.email)#" from="theTeam@mykidsbiz.com" subject="Your suggestion has been authorised!" type="HTML">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>MyKidsBiz.com</title>

<style>

.introduction
{
   FONT-SIZE: 12px;
   COLOR: Black;
   FONT-FAMILY: Arial, Verdana, Tahoma, Trebuchet MS;
   FONT-DECORATION: NONE;
LINE-HEIGHT: 170%;
}


.normal
{
   FONT-SIZE: 11px;
   COLOR: Black;
   FONT-FAMILY: Arial, Verdana, Tahoma, Trebuchet MS;
   FONT-DECORATION: NONE;
LINE-HEIGHT: 150%;
}

</style>


</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


<tr>
<td width="100%" valign="top">


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
	
	<tr>
	<td width="300" valign="top" bgcolor="white"><a href="http://www.mykidsbiz.com"><img src="#request.imageroot#/logo.gif" border="0" alt="MyKidzBiz.com"></a></td>
	</tr>
	
	</table>
	
</td>
</tr>

</table>

</td>
<!--- BLACK STRIP --->
</tr>



<tr>
<td width="100%" valign="top">

<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
	
<tr>
<td>


	<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
	<td class="normal"><br>

		
		<table width="100%" cellpaddinig="10" border="0">
	
		<tr>
		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1"  border="0"></td>
		<td class="normal">
Hi #kidsdetails.firstname#, <br><br>

#form.comments#<br><br>

<hr width="100%" size="1" color="e2e2e2">

		<span style="font-size:12px;"><strong>Thanks!<br>
		The Team @ MyKidsBiz</strong></span>
		
		</td>
		</tr>
		
		</table>
		
	
	</td>
	</tr>
	
	</table>
		
	
</td>
</tr>
	
</table>


</td>
</tr>

</table>

</body>
</html>
</cfmail>	



<script type="text/javascript">
alert("Comments have been sent to the kid!");
</script>

</cfif>

<script type="text/javascript">
alert("Suggestion has been updated");
self.location="http://www.mykidsbiz.com/index.cfm?fuseaction=administration&fusesubaction=manage_sug";
</script>
		
</cfif>
