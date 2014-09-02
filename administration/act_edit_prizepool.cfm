<cfparam name="uploadFileError" default="false">



<cfscript>
  function convertmonthnametonum(monthname)
  {
       switch(monthname) {
	   
	       case 'Jan': 
		      monthnum = 1;
		   break;
		   
		   case 'Feb': 
		      monthnum = 2;
		   break;
		   
		   case 'Mar': 
		      monthnum = 3;
		   break;
		   
		   case 'Apr': 
		      monthnum = 4;
		   break;
		   
		   case 'May': 
		      monthnum = 5;
		   break;
		   
		   case 'Jun': 
		      monthnum = 6;
		   break;
		   
		   case 'Jul': 
		      monthnum = 7;
		   break;
		   
		   case 'Aug': 
		      monthnum = 8;
		   break;
		   
		   case 'Sep': 
		      monthnum = 9;
		   break;
		   
		   case 'Oct': 
		      monthnum = 10;
		   break;
		   
		   case 'Nov': 
		      monthnum = 11;
		   break;
		   
		   case 'Dec': 
		      monthnum = 12;
		   break;
	   
	   }
	   
	   return monthnum;
  }
</cfscript>
 
<cfset start_datearr = ListToArray(form.start_date, "-")>
<cfset dayV   = start_datearr[1]>
<cfset monthV = convertmonthnametonum(start_datearr[2])>
<cfset yearV  = start_datearr[3]>

<cfset draw_datearr = ListToArray(form.draw_date, "-")>
<cfset dayV1   = draw_datearr[1]>
<cfset monthV1 = convertmonthnametonum(draw_datearr[2])>
<cfset yearV1  = draw_datearr[3]>

<cfset start_date = CREATEDATE(#yearV#,#monthV#,#dayV#)>
<!---<cfset startd = CREATEDATE(#mid(form.start_date,7,4)#,#mid(form.start_date,4,2)#,#mid(form.start_date,1,2)#)>--->
<cfset start_date = DateFormat(#start_date#,"mm/dd/yyyy")>

<cfset draw_date = CREATEDATE(#yearV1#,#monthV1#,#dayV1#)>
<!---<cfset endd = CREATEDATE(#mid(form.draw_date,7,4)#,#mid(form.draw_date,4,2)#,#mid(form.draw_date,1,2)#)>--->
<cfset draw_date = DateFormat(#draw_date#,"mm/dd/yyyy")>


<cfif Trim(form.prizeImage) NEQ ''>
	
	<cftry>
		<cffile action="upload" filefield="Form.prizeImage" destination="#request.fileroot#\images\prize\" nameconflict="makeunique" accept="image/*">

		<cfset this_upload_name = file.serverfile>
		
		<cfx_image action="resize" file="#request.fileroot#\images\prize\#this_upload_name#" output="#request.fileroot#\images\prize\thumb_#this_upload_name#" quality="100" x="80" y="60">

		<cffile action="delete" file="#request.fileroot#\images\prize\#file.serverfile#">
		
	<cfcatch>
		<cfset uploadFileError = true>
	</cfcatch>
	</cftry>

</cfif>	
		
		
		
<cfoutput>

<cfquery name="UpdatePP" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE prize_pool
SET Name='#TRIM(form.name)#',
Description='#TRIM(form.description)#',
draw_date='#draw_date#',
start_date='#start_date#',
country='#INT(form.countryID)#',
related_campaign = #FORM.related_campaign#,
<cfif Trim(form.prizeImage) NEQ '' AND uploadFileError EQ 'false'>
	image='thumb_#this_upload_name#',
</cfif>

<cfif IsNumeric("#form.pointsvalue#")>
	pointsvalue=#form.pointsvalue#,
<cfelse>
	pointsvalue=0,
</cfif>

<cfif IsDefined("form.inviteFriend") AND form.inviteFriend EQ 1>
	inviteFriend=1,
<cfelse>
	inviteFriend=0,
</cfif>

<cfif IsDefined("form.displayOrder") AND IsNumeric("#form.DisplayOrder#")>
	DisplayOrder=#form.DisplayOrder#
<cfelse>
	DisplayOrder=0
</cfif>

WHERE prizepoolid=#form.prizepoolid#
</cfquery>



<cfif uploadFileError>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("Prize pool details have been saved successfully!\n But prize image upload failed \n Either the path of the image was incorrect \n or upload was not an image file.");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes')"></body>

<cfelse>
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("Prize pool details have been saved successfully!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes')"></body>

</cfif>
	

</cfoutput>