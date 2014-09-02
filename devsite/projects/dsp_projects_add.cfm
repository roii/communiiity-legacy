<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ProjectCategories
ORDER BY Title
</cfquery>

<cfquery name="qry_all_moderators" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName, Contacts.EmailAddress
FROM Contacts
WHERE Roles LIKE '2' OR Roles LIKE '2,%' OR Roles LIKE '%,2' OR Roles LIKE '%,2,%'
</cfquery>

<cfquery name="qry_all_moderators_all" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName, Contacts.EmailAddress
FROM Contacts 
</cfquery>

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>  
      <cfset userTypeIsAdmin = "yes">
<cfelse>
      <cfset userTypeIsAdmin = "no">
</cfif>

<link rel="stylesheet" href="#request.webroot#/css/jquery-ui-latest.css">

<script language="javascript">
	 var tagsData = new Array();
	 var tagNames = new Array();
	 var tagEmails = new Array();
	 var counter = 0;
	 var userTypeIsAdmin = "<cfoutput>#userTypeIsAdmin#</cfoutput>";
</script>
<cfoutput query="qry_all_moderators_all">
	<script language="javascript">
		  tagNames[counter++]    = "#TRIM(qry_all_moderators_all.Firstname)# #TRIM(qry_all_moderators_all.Lastname)# (#TRIM(qry_all_moderators_all.EmailAddress)#)"; 
		  /*tagEmails[counter++]   = "#TRIM(qry_all_moderators_all.EmailAddress)# (#TRIM(qry_all_moderators_all.Firstname)# #TRIM(qry_all_moderators_all.Lastname)#)";*/
	</script>
</cfoutput>
 
				
<SCRIPT LANGUAGE="JavaScript">
 var userTypeIsAdmin = "<cfoutput>#userTypeIsAdmin#</cfoutput>"; 
 function arrayUniques(array) {
		var a = array.concat();
		for(var i=0; i<a.length; ++i) {
			for(var j=i+1; j<a.length; ++j) {
				if(a[i] === a[j])
					a.splice(j--, 1);
			}
		} 
		return a;
	}; 
				
 tagsData = arrayUniques(tagNames.concat(tagEmails)); 
 
<!-- 
function validate(addform) {    
alert(addform.gallery_pics_1.value); return false;
if (addform.Title.value == "") {
	alert("<cfoutput>#titleerror#</cfoutput>");
	addform.Title.focus();
	return false;
	} 
<!---else if(userTypeIsAdmin == "yes" && (addform.Moderators.value == "" || addform.Moderators.value == 0 || addform.Moderators.value == "0")) {
	    alert("<cfoutput>#moderatorreq#</cfoutput>");
		addform.Moderators.focus();
		return false; 
	} --->
else if(addform.gallery_pics_1.value == "") {
	    alert("Required: You must select the Gallery Pic 1");
		addform.gallery_pics_1.focus();
		return false; 
	}	
else if(addform.gallery_pics_2.value == "") {
	    alert("Required: You must select the Gallery Pic 2");
		addform.gallery_pics_2.focus();
		return false; 
	}	
else if(addform.gallery_pics_3.value == "") {
	    alert("Required: You must select the Gallery Pic 3");
		addform.gallery_pics_3.focus();
		return false; 
	}	
else if(addform.gallery_pics_4.value == "") {
	    alert("Required: You must select the Gallery Pic 4");
		addform.gallery_pics_4.focus();
		return false; 
	}	
else if(addform.gallery_pics_5.value == "") {
	    alert("Required: You must select the Gallery Pic 5");
		addform.gallery_pics_5.focus();
		return false; 
	}					
		
else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	addform.submit(); //submit form
	}
}

function resetAllDisable()
{
        var checkbox = document.getElementsByName('ProjectCategoryID'); 
		var mainCategory = document.getElementsByName('mainCategory');  
	    var totalcheckbxs = 0;
		for(var i=0; i< checkbox.length; i++) 
		{
			if(checkbox[i].checked)
				totalcheckbxs++
		}  
		if(totalcheckbxs > 0)
		{	
		       $( "#categorySelectID" ).hide( "fast", function() {  
			  });
			   $( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
			  });  
			   $( "#categorySelectIDAtleastOneMain" ).hide( "fast", function() {  
			  });
			   $( "#NoCateSelID" ).hide( "fast", function() {  
			  }); 
			   var checkbox = document.getElementsByName('ProjectCategoryID');  
					for(var i=0; i< checkbox.length; i++) 
					{  
							checkbox[i].checked  = false;
							checkbox[i].disabled = false;	
							mainCategory[i].checked = false;
							mainCategory[i].disabled = false;
					}  
		}
		else
		{
		     $( "#categorySelectID" ).hide( "fast", function() {  
			  });
			 $( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
			  });  
			 $( "#categorySelectIDAtleastOneMain" ).hide( "fast", function() {  
			  }); 
			  $( "#NoCateSelID" ).show( 2000 );
		}			
}

function disableothers()
{
        var checkbox = document.getElementsByName('ProjectCategoryID'); 
		var totalcheckbxs  = 0;
		var totalchkboxIDs = new Array(100);
			for(var i=0; i< checkbox.length; i++) 
			{ 
					if(checkbox[i].checked)
					{
						totalcheckbxs++; 
						totalchkboxIDs[i] = checkbox[i].value; 
					}	
			}  	 
		if(totalcheckbxs > 2)
		{
			  for(var i=0; i< checkbox.length; i++) 
			  {  
			        var n = totalchkboxIDs.indexOf(checkbox[i].value);  
					var mainCategory = document.getElementsByName('mainCategory');   
					 if( n >= 0 )
					 { }
					 else
					 {   
					     idctr = i + 1;
					    // document.getElementById('mainCategory_'+idctr).disabled = true;
						 mainCategory[i].disabled = true;
					     checkbox[i].disabled = true;
					 }
			  }   
		}  
}

function validateForm(addform) {
    var checkbox = document.getElementsByName('ProjectCategoryID'); 
	var totalcheckbxs = 0;
		for(var i=0; i< checkbox.length; i++) 
		{
			if(checkbox[i].checked)
				totalcheckbxs++
		} 
	var totalValues = "";	  
    if(totalcheckbxs > 0)
	{  
	    for(var i=0; i< checkbox.length; i++) 
		{
			  if(checkbox[i].checked)
			  {
			      if(totalValues == "")
			           totalValues += checkbox[i].value;
				  else
				       totalValues += ", " + checkbox[i].value;	   
			  }
		}
		addform.projCatValues.value = totalValues;
	} 
	
	var mainCategoryR = document.getElementsByName('mainCategory'); 
	var totalMCatcheckbxs = 0;
		for(var i=0; i< mainCategoryR.length; i++) 
		{
			if(mainCategoryR[i].checked)
				totalMCatcheckbxs++
		} 
	var totalMCatValues = "";	  
    if(totalMCatcheckbxs > 0)
	{  
	    for(var i=0; i< mainCategoryR.length; i++) 
		{
			  if(mainCategoryR[i].checked)
			  {
			      if(totalMCatValues == "")
			           totalMCatValues += mainCategoryR[i].value;
				  else
				       totalMCatValues += ", " + mainCategoryR[i].value;	   
			  }
		} 
	    document.getElementById('MainCatSelectedID').value = totalMCatValues; 
	}   
	
	if(totalcheckbxs <= 0)
	{     
	    $( "#NoCateSelID" ).hide( "fast", function() {  
			  }); 
		$( "#categorySelectID" ).show( 2000 );  
		return false;
	} 
	else if(totalcheckbxs < 3)
	{
	    $( "#NoCateSelID" ).hide( "fast", function() {  
			  }); 
	    $( "#categorySelectID" ).hide( "fast", function() {  
		  });
	    $( "#categorySelectIDForThreeCheck" ).show( 2000 ); 
		return false;
	}
	else if( totalMCatcheckbxs <= 0 )
	{
	    $( "#NoCateSelID" ).hide( "fast", function() {  
			  }); 
	    $( "#categorySelectID" ).hide( "fast", function() {  
		  });
		$( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
		  });  
	    $( "#categorySelectIDAtleastOneMain" ).show( 2000 );  
		return false;
	}
    else if (addform.Title.value == "") {
	    $( "#categorySelectID" ).hide( "fast", function() {  
		  });
		$( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
		  });  
		$( "#categorySelectIDAtleastOneMain" ).hide( "fast", function() {  
		  });     
		$( "#NoCateSelID" ).hide( "fast", function() {  
			  });   
		 $( "#projectTitleID" ).show( 2000 );     
		addform.Title.focus();
		return false;
	}  
	else if(document.getElementById('media_proj_video').checked == false && document.getElementById('media_proj_img').checked == false)
	{  
	    $( "#categorySelectID" ).hide( "fast", function() {  
		  });
		$( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
		  });  
		$( "#categorySelectIDAtleastOneMain" ).hide( "fast", function() {  
		  });
		$( "#NoCateSelID" ).hide( "fast", function() {  
			  });   
		$( "#projectTitleID" ).hide( "fast", function() {  
		  });  
		$( "#videoURLerrorID1" ).show( 2000 );   
		document.getElementById('media_proj_video').focus();
		return false; 
	}
	else if(document.getElementById('media_proj_video').checked == true && addform.campaign_video.value == "")
	{   
	    $( "#categorySelectID" ).hide( "fast", function() {  
		  });
		$( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
		  });  
		$( "#categorySelectIDAtleastOneMain" ).hide( "fast", function() {  
		  });
		$( "#NoCateSelID" ).hide( "fast", function() {  
			  });   
		$( "#projectTitleID" ).hide( "fast", function() {  
		  });  
		$( "#videoURLerrorID1" ).hide( "fast", function() {  
		  });   
		$( "#videoURLerrorID2" ).show( 2000 ); 
		addform.campaign_video.focus();
		return false; 
	}
	else if(document.getElementById('media_proj_img').checked == true && addform.primary_picture.value == "")
	{ 
	    $( "#categorySelectID" ).hide( "fast", function() {  
		  });
		$( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
		  });  
		$( "#categorySelectIDAtleastOneMain" ).hide( "fast", function() {  
		  });
		$( "#NoCateSelID" ).hide( "fast", function() {  
			  });   
		$( "#projectTitleID" ).hide( "fast", function() {  
		  });  
		$( "#videoURLerrorID1" ).hide( "fast", function() {  
		  }); 
		$( "#videoURLerrorID2" ).hide( "fast", function() {  
		  });   
		$( "#videoURLerrorID3" ).show( 2000 );   
		addform.primary_picture.focus();
		return false; 
	}
	<!---else if(userTypeIsAdmin == "yes" && (addform.Moderators.value == "" || addform.Moderators.value == 0 || addform.Moderators.value == "0")) {
	    $( "#categorySelectID" ).hide( "fast", function() {  
		  });
		$( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
		  });  
		$( "#categorySelectIDAtleastOneMain" ).hide( "fast", function() {  
		  });
		$( "#NoCateSelID" ).hide( "fast", function() {  
			  });   
		$( "#projectTitleID" ).hide( "fast", function() {  
		  });  
		$( "#videoURLerrorID1" ).hide( "fast", function() {  
		  }); 
		$( "#videoURLerrorID2" ).hide( "fast", function() {  
		  });
		$( "#videoURLerrorID3" ).hide( "fast", function() {  
		  });
		$( "#moderatorID" ).show( 2000 );      
		addform.Moderators.focus();
		return false; 
	}	--->
	/*else if(addform.gallery_pics_1.value == "") {
	    alert("Required: You must select the Gallery Pic 1");
		addform.gallery_pics_1.focus();
		return false; 
	}	
else if(addform.gallery_pics_2.value == "") {
	    alert("Required: You must select the Gallery Pic 2");
		addform.gallery_pics_2.focus();
		return false; 
	}	
else if(addform.gallery_pics_3.value == "") {
	    alert("Required: You must select the Gallery Pic 3");
		addform.gallery_pics_3.focus();
		return false; 
	}	
else if(addform.gallery_pics_4.value == "") {
	    alert("Required: You must select the Gallery Pic 4");
		addform.gallery_pics_4.focus();
		return false; 
	}	
else if(addform.gallery_pics_5.value == "") {
	    alert("Required: You must select the Gallery Pic 5");
		addform.gallery_pics_5.focus();
		return false; 
	}	*/	
    else {
	    $( "#categorySelectID" ).hide( "fast", function() {  
		  });
		$( "#categorySelectIDForThreeCheck" ).hide( "fast", function() {  
		  });  
		$( "#categorySelectIDAtleastOneMain" ).hide( "fast", function() {  
		  });
		$( "#NoCateSelID" ).hide( "fast", function() {  
			  });   
		$( "#projectTitleID" ).hide( "fast", function() {  
		  });  
		$( "#videoURLerrorID1" ).hide( "fast", function() {  
		  }); 
		$( "#videoURLerrorID2" ).hide( "fast", function() {  
		  });
		$( "#videoURLerrorID3" ).hide( "fast", function() {  
		  }); 
		 
		if(userTypeIsAdmin == "yes")
		 {   
				if($( "#autocomplete" ).val() != "")
				{
					 var usersdata = $("#autocomplete").val();  
					   var result = tagsData.indexOf(usersdata);  
					   $( "#notenterID" ).hide( "fast", function() {  }); 
					   if(result < 0)
					   {
					        $( "#selectedUserHeading" ).hide( "fast", function() {  
					         }); 
					        //$( "#notenterID" ).show( 2000 );
							$('#usertoSHow').html("<span style='color: red;'><cfoutput>#enteredwronguname#</cfoutput></span>");
							return false;
					   }
					   else
					   {
					        $( "#notenterID" ).hide( "fast", function() {  
					         }); 
							 $( "#selectedUserHeading" ).show( 2000 );
							$('#usertoSHow').html("<span style='color: blue;'>"+usersdata+"</span>");
							return true;
					   }
				}
				else
				{   
					$( "#usertoSHow" ).hide( "fast", function() {  
					  }); 
					$( "#notenterID" ).hide( "fast", function() {  
					  });   
					$( "#moderatorID" ).hide( "fast", function() {  
					});
					$( "#selectedUserHeading" ).hide( "fast", function() {  
				     });
				   return true;
				}   
		}
		else
		{
		       return true;
		}  		
		//ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
		//addform.submit(); //submit form
	}
}
// -->
</script>  

<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head> 
	<title>#TRIM(AllSettings.SiteName)# - #addprojecttitle#</title>
<script src="/administration/ckeditor.js"></script>
<script src="/administration/sample.js"></script>
<cfparam name="URL.fuseaction" default="administration">
<cfparam name="URL.fusesubaction" default="">
<cfparam name="URL.secti" default="">	
<cfinclude template="../templates/styles.cfm"> 
<script language="javascript" type="text/javascript">
	function intOnlyfn(i)
	{
		if(i.value.length>0)
		{
			 i.value = i.value.replace(/[^\d]+/g, '');
		}
	}
	function openbox(boxtouse, boxtohide)
	{
	      document.getElementById(boxtohide).style.display = "none"; 
		  document.getElementById(boxtouse).style.display  = "";
	}
</script>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="###TRIM(AllSettings.BoxColour)#" width="40" align="center" valign="top" height="40">&nbsp;</td>
<td width="1" bgcolor="###TRIM(AllSettings.BoxColour)#" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#addprojecttitle#</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr> 
<td valign="top" colspan="3">
<br>


	<form method="post" action="#request.webroot#/projects/act_projects_add.cfm" name="addform" enctype="multipart/form-data" onSubmit="return validateForm(this);">
	<input type="hidden" name="DocumentID" value="#DocumentID#">
    <input type="hidden" name="UserType" value="#session.UserType#">
	<input type="hidden" name="projCatValues" value="">
	<input type="hidden" id="MainCatSelectedID" name="MainCatSelectedID" value="">
	<input type="hidden" id="EmailAlertFrom" name="EmailAlertFrom" value="#TRIM(AllSettings.EmailAlertFrom)#">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(addform); return false;" value="#addcashbttn# >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.location = '#request.webroot#/index.cfm?fuseaction=projects&documentID=5';" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#category#</td>
	<td class="normal" valign="top"><!---<select name="ProjectCategoryID" class="whitefield" multiple="multiple" style="width: 160px; height: 190px;"><cfloop query="allCats"><option value="#TRIM(AllCats.ProjectCategoryID)#">#TRIM(allCats.Title)#</cfloop></select>--->
	      <input type="button" name="resetDisableCats" id="resetDisableCats" value="#resetSel#" onClick="resetAllDisable();" /> &nbsp;
		   <span style="color: blue;"> #resetSelNote# </span>
	       <cfset start = 1>
			<table cellpadding="4" cellspacing="4" border="0" width="75%">
			   <cfloop query="allCats">   
						   <cfif start eq 1>
							   <tr>
							</cfif>
								  <td valign="top">
								        <table cellpadding="0" cellspacing="0" border="0" width="100%">
										    <tr>
											      <td valign="top" width="10%">
												          <input type="checkbox" name="ProjectCategoryID" id="ProjectCategoryID_#start#" value="#TRIM(allCats.ProjectCategoryID)#" onClick="disableothers();" />
												  </td>
												  <td valign="middle" width="90%">
												          &nbsp;#TRIM(allCats.Title)# <br>
														  <input type="radio" name="mainCategory" id="mainCategory_#start#" value="#TRIM(allCats.ProjectCategoryID)#" />#mainCatTitle#
												  </td>
											</tr>
										</table> 
								  </td>  
					  <cfif start MOD 3 eq 0>
						  </tr>
						  <tr>
					  </cfif> 
				      <cfset start = start + 1>
			   </cfloop> 
		    </table>  
			<div id="categorySelectID" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #selCatProjTitle#</div>	 
			<div id="categorySelectIDForThreeCheck" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #selThreeCate#</div>	
			<div id="categorySelectIDAtleastOneMain" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #selatleastone#</div>	 
			<div id="NoCateSelID" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #selacateerror#</div> 
	</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#currstatus#</td>
	<td class="normal" valign="top"><select name="CurrentStatus" class="whitefield">
	<option value="Draft">#Draft#
	<option value="Active">#active#
	<option value="Complete">#complete# 
	</select></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr> 
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#addprojtitlefield#</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="68" rows="2" name="Title" maxlength="60"></textarea>
	      <div id="projectTitleID" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #projectTitle#</div>
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr> 
	    <td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	    <td class="normal" valign="top" width="10">#projmedtitle#</td>
		<td class="normal" valign="top">
		      <table cellpadding="0" cellspacing="0" border="0" width="100%">
			            <tr> 
							<td class="normal" valign="top">
							           <div class="radio-option clearfix">
											<input type="radio" value="MDIA_PVID" name="media_type" id="media_proj_video" class="fl field" checked="checked" onClick="openbox('project_pitchmedia_link', 'project_pitchmedia_primary_picture');">
											<label for="project_pitchmedia_attributes_media_type_mdia_pvid" class="fl auto-width">#campaignVid#  
											</label> 
											<div id="project_pitchmedia_link" class="input-item-text clearfix hilight" style="display: block; margin-left: 40px;">  
													(#campvidnote1#) <br>
													#campvidnote2# <br>
													#campvidnote3# <br> 
											  <input type="text" id="link" name="campaign_video" value="" size="80" maxlength="100" />
											</div>  
									  </div> 
									  <div class="radio-option clearfix">
											<input type="radio" value="MDIA_PIMG" name="media_type" id="media_proj_img" class="fl field" onClick="openbox('project_pitchmedia_primary_picture', 'project_pitchmedia_link');">
											<label for="project_pitchmedia_attributes_media_type_mdia_pimg" class="fl auto-width">
											      Image <span class="mini-text">(PNG, JPG, or GIF - 565 x 281 pixels)</span>
										    </label> <br>
											<div id="project_pitchmedia_primary_picture" class="clearfix hilight" style="display: none;  margin-left: 40px;">
												  <div class="fl submit-container">
													<label class="fl cabinet grey new-image" id="pitchmedia_picture_upload">
								
													  <input type="file" style="top: -15.5px; left: -183px;" name="primary_picture" id="primary_picture" class="file pitchmedia-file-field">
													  <div class="spinner-container" id="pitchmedia_picture_saving">
													  </div>
													</label>
												  </div> <!-- End submit-container -->
											</div> <!-- End clearfix hilight -->    
                                     </div> <!-- End radio-option clearfix --> 
									 <div id="videoURLerrorID1" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #videoURLerror#</div>
									 <div id="videoURLerrorID2" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #videoURL2#</div>
									 <div id="videoURLerrorID3" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #projImgError#</div>
							</td>
						</tr>
			  </table> 
		</td>
	</tr> 
	 
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#camppics#</td>
	<td class="normal" valign="top">
	             <input type="file" name="project_pic" id="project_pic" value="" />
			<strong style="color: blue;">#upload2text#.</strong> 
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
		<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
		<td class="normal" valign="top" width="110">#galleryimg#</td>
		<td class="normal" valign="top">
				<input type="file" name="gallery_pics_1" id="gallery_pics_1" value="" />
				<strong style="color: blue;">#uploadtext#.</strong> <br>
				<input type="file" name="gallery_pics_2" id="gallery_pics_2" value="" />
				<strong style="color: blue;">#uploadtext#.</strong><br>
				<input type="file" name="gallery_pics_3" id="gallery_pics_3" value="" />
				<strong style="color: blue;">#uploadtext#.</strong><br>
				<input type="file" name="gallery_pics_4" id="gallery_pics_4" value="" />
				<strong style="color: blue;">#uploadtext#.</strong><br>
				<input type="file" name="gallery_pics_5" id="gallery_pics_5" value="" />
				<strong style="color: blue;">#uploadtext#.</strong>
		</td>
	</tr>
	  
	<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>  
		<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td colspan="2"><hr width="100%" size="1" color="silver"></td>
		</tr>
		<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td style="font-size:11px;" width="110" valign="top">#moderators#</td>
			<td valign="top"> 
					<!---<select multiple name="Moderators" class="whitefield" style="width:300px;" size="6">
						<option value="0" selected="true">--- #selmoderator# ---</option>
						<cfloop query="qry_all_moderators">
						<option value="#qry_all_moderators.contactID#">#TRIM(qry_all_moderators.Firstname)# #TRIM(qry_all_moderators.Lastname)# (#TRIM(qry_all_moderators.Screenname)#)
						</cfloop>
					</select>---> 
				<input id="autocomplete" type="text" name="autocomplete" value="" size="60"> 
				<style>
				    .ui-autocomplete {
						left: 271px !important;
						top: 968px !important;
						width: 30%;
					}
				</style>
				<script language="javascript">
				function arrayUnique(array) {
					var a = array.concat();
					for(var i=0; i<a.length; ++i) {
						for(var j=i+1; j<a.length; ++j) {
							if(a[i] === a[j])
								a.splice(j--, 1);
						}
					} 
					return a;
				}; 
					 var tags = new Array();
					 var tagNames = new Array();
					 var tagEmails = new Array();
					 var tagsID = new Array();
					 var counter = 0;
				</script>
				<cfloop query="qry_all_moderators_all">
				        <script language="javascript">
						     tagNames[counter++]    = "#TRIM(qry_all_moderators_all.Firstname)# #TRIM(qry_all_moderators_all.Lastname)# (#TRIM(qry_all_moderators_all.EmailAddress)#)"; 
							 /*tagEmails[counter++]   = "#TRIM(qry_all_moderators_all.EmailAddress)# (#TRIM(qry_all_moderators_all.Firstname)# #TRIM(qry_all_moderators_all.Lastname)#)";*/
						</script>
				</cfloop>
				<script language="javascript">
				    tags = arrayUnique(tagNames.concat(tagEmails));
				var testFlag = 0;  
				var counterVal = 0;  
				$( "##notenterID" ).hide( "fast", function() {  }); 
				$( "##autocomplete" ).autocomplete({
				     source: tags  
					/*source: function( request, response ) {
					var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( request.term ), "i" ); 
					response( $.grep( tags, function( item ){ 
						 if(matcher.test( item ))
						  {
						      $( "##notenterID" ).hide( "fast", function() {  }); 
							  return matcher.test( item );
						  } 
						  else
						  { 
							  testFlag = testFlag + 1;
						  } 
					}) ); 
					}*/
				}); 
				
				$( "##autocomplete" ).autocomplete({
					 close: function( event, ui ) { 
					      var usersdata = $('##autocomplete').val(); 
						  $( "##notenterID" ).hide( "fast", function() {  }); 
						  $( "##moderatorID" ).hide( "fast", function() {  }); 
						  $("##usertoSHow").show( 2000 );
					      $('##usertoSHow').html("<span style='color: blue;'>"+usersdata+"</span>");					       
					 }
				}); 
				
				$( "##autocomplete" ).blur(function() {
				       var usersdata = $(this).val();  
					   var result = tags.indexOf(usersdata); 
					   $( "##notenterID" ).hide( "fast", function() {  }); 
					    $( "##moderatorID" ).hide( "fast", function() {  });
					   $("##usertoSHow").show( 2000 );
					   if(result < 0)
					   {  
					         $( "##selectedUserHeading" ).hide( "fast", function() {  });
					         $('##usertoSHow').html("<span style='color: red;'>#enteredwronguname#</span>");
					   }
					   else
					   { 
					        $( "##notenterID" ).hide( "fast", function() {  }); 
					        $( "##selectedUserHeading" ).show( 2000 );
					        $('##usertoSHow').html("<span style='color: blue;'>"+usersdata+"</span>");
					   }
				});
				</script> 	
				<div id="moderatorID" style="display: none; border: 1px solid ##FF0000; color: ##FF0000; font-weight: bold; padding: 5px; width: 50%;">#errorT#: #moderatorError#</div><br>
				<span id="selectedUserHeading" style="display: none; color: blue;">#seluser#</span>
				<span id="usertoSHow"></span>
				<span id="notenterID" style="display: none; color: red;">#enteredwronguname#</span>
			</td>
		</tr>
		  <input type="hidden" name="projectOwner" id="projectOwner" value="#session.userid#">
	<cfelse>  
	    <input type="hidden" name="projectOwner" id="projectOwner" value="#session.userid#">  	
	</cfif>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#dashvarval#</td>
	<td class="normal" valign="top">	           
			   <table width="100%" cellpadding="0" cellspacing="0" border="0">
			        <tr>
					      <td>
						        #labeltxt# 1
						  </td>
						  <td>
						        #valtxt# 1
						  </td>
						  <td>
						        #percentvaltxt# 1
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_1_label" id="dashboard_var_1_label" value="" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_1_value" id="dashboard_var_1_value" value="" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_1_percentage" id="dashboard_var_1_percentage" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        #labeltxt# 2
						  </td>
						  <td>
						        #valtxt# 2
						  </td>
						  <td>
						        #percentvaltxt# 2
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_2_label" id="dashboard_var_2_label" value="" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_2_value" id="dashboard_var_2_value" value="" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_2_percentage" id="dashboard_var_2_percentage" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        #labeltxt# 3
						  </td>
						  <td>
						        #valtxt# 3
						  </td>
						  <td>
						        #percentvaltxt# 3
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_3_label" id="dashboard_var_3_label" value="" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_3_value" id="dashboard_var_3_value" value="" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_3_percentage" id="dashboard_var_3_percentage" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        #labeltxt# 4
						  </td>
						  <td>
						        #valtxt# 4
						  </td>
						  <td>
						        #percentvaltxt# 4
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_4_label" id="dashboard_var_4_label" value="" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_4_value" id="dashboard_var_4_value" value="" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_4_percentage" id="dashboard_var_4_percentage" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        #labeltxt# 5
						  </td>
						  <td>
						        #valtxt# 5
						  </td>
						  <td>
						        #percentvaltxt# 5
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_5_label" id="dashboard_var_5_label" value="" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_5_value" id="dashboard_var_5_value" value="" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_5_percentage" id="dashboard_var_5_percentage" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
					<tr>
					      <td colspan="3">&nbsp;
						        
						  </td>
					</tr>
					<tr>
					      <td>
						        #labeltxt# 6
						  </td>
						  <td>
						        #valtxt# 6
						  </td>
						  <td>
						        #percentvaltxt# 6
						  </td>
					</tr>
					<tr>
					      <td>
						        <input type="text" name="dashboard_var_6_label" id="dashboard_var_6_label" value="" maxlength="50" />
						  </td>
						  <td>
						        <input type="text" name="dashboard_var_6_value" id="dashboard_var_6_value" value="" maxlength="50" />
						  </td> 
						  <td>
						        <input type="text" name="dashboard_var_6_percentage" id="dashboard_var_6_percentage" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" maxlength="30" /> 
						  </td>
					</tr>
			   </table> 
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top">#projintro#</td>
	<td class="normal" valign="top">
	     <p> 
			<textarea cols="80" id="IntroText" name="IntroText" rows="20" cols="60" maxlength="140"></textarea>
			<!---<script> 
				 CKEDITOR.replace( 'IntroText', {
					extraPlugins: 'magicline',	// Ensure that magicline plugin, which is required for this sample, is loaded.
					allowedContent: true		// Switch off the ACF, so very complex content created to
												// show magicline's power isn't filtered.
				} ); 
			</script>--->
		 </p>
	<!--- <cf_activedit name="IntroText" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="445" height="220"	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="no" DEFAULTFONT="8pt Verdana"></cf_activedit>
	---> 
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#addprojdetails#</td>
	<td Class="normal" valign="top">
	<p> 
			<textarea cols="80" id="details" name="details" rows="20" cols="60"></textarea>
			<script> 
				 CKEDITOR.replace( 'details', {
					extraPlugins: 'magicline',	// Ensure that magicline plugin, which is required for this sample, is loaded.
					allowedContent: true		// Switch off the ACF, so very complex content created to
												// show magicline's power isn't filtered.
				} ); 
			</script>
		 </p>
	<!---
	<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" 
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="445" height="420"
	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="no" DEFAULTFONT="8pt Verdana"></cf_activedit>--->
	</td>
	</tr> 
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<input type="hidden" size="68" name="AssignedTo" value="">
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#assignedto#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="68" name="AssignedTo"></td>
	</tr>--->		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#fundinggoals#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="15" name="CreditsOffered" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#paymenttype#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="PaymentType" value="Money" checked> #money# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="PaymentType" value="Points"> #points#</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<input type="hidden" size="15" name="PaidIn" value="">
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#paidin#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="15" name="PaidIn" value="NZ$"></td>
	</tr>	--->	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#percentcomp#</td>
	<td Class="normal" valign="top">
	      <input type="text" class="whitefield" size="15" name="PercentComplete" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);">%
<!---	<select name="PercentComplete" class="whitefield">
			<option value="0">0
			<cfloop from="1" to="10" index="loopcount">
			   <option value="#loopcount#0">#loopcount#0%
			</cfloop>
		</select>
--->	
    </td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#featurecamp#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="FeatureCampaigns" value="1" checked> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="FeatureCampaigns" value="0"> #notitle#</td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#location#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="location" value=""></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#createdby#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="60" maxlength="60" name="addedBy" value=""></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#campaignorder#</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="10" maxlength="10" name="campaigns_order" value="" onKeyDown="intOnlyfn(this);" onKeyUp="intOnlyfn(this);" onKeyPress="intOnlyfn(this);"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#disproj#</td>
	<td Class="normal" valign="top"><input type="radio" Class="whitefield" name="displaycampaigns" value="1" checked> #yestitle# &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="displaycampaigns" value="0"> #notitle#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" onClick="javascript:ae_onSubmit(); validate(addform); return false;" value="#addcashbttn# >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript: window.location = '#request.webroot#/index.cfm?fuseaction=projects&documentID=5';" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</form>	
	
	
	
</td>
</tr>
</cfoutput>

</table>

</body>
</html> 