<cfoutput>

<cfparam name="session.MainCatID" default="">
<cfif IsDefined("MainCatID")>
	<cfset session.MainCatID = MainCatID>
</cfif>
 
<script language="javascript">
	       function checkform()
		   {
		        var categoryallselectedVal = document.getElementById('categoryallselected').checked;
				if(categoryallselectedVal == true)
				{
				    document.getElementById('MainCatID').value = "";
					var temp = "";
					var test = 0;
					arrChecks = document.filterform.categoryselected;
					for (i=0; i<arrChecks.length; i++)
					 {
					      if(arrChecks[i].checked == true)
						  {
						       if(temp == "")
							   {
							       temp += arrChecks[i].value;
							   }
							   else
							   {
							       temp += "," + arrChecks[i].value;
							   } 
						  }
						  else
						  {
						       test = test + 1;
						  }
					 } 
					  if(test > 0)
					  {
					      document.getElementById('MainCatID').value = temp;
					  }
					  else
					  {
					      document.getElementById('MainCatID').value = document.getElementById('categoryallselected').value
					  } 
				}
				else
				{ 
				    document.getElementById('MainCatID').value = "";
					var temp = "";
					arrChecks = document.filterform.categoryselected;
					for (i=0; i<arrChecks.length; i++)
					 {
					      if(arrChecks[i].checked == true)
						  {
						       if(temp == "")
							   {
							       temp += arrChecks[i].value;
							   }
							   else
							   {
							       temp += "," + arrChecks[i].value;
							   } 
						  }
					 }
					document.getElementById('MainCatID').value = temp; 
			    } 
				
			  if(document.getElementById('MainCatID').value == '')
			  {
			         document.getElementById('MainCatID').value = 'All';  
			  } 
			  return true;
		   }
</script>		    
    
<!--- GET ALL MAIN CATEGORIES FOR DROP DOWN --->
<cfinclude template="qry_all_maincats.cfm">

<table width="100%" cellspacing="0" cellpadding="0" border="0">

<tr>
<td valign="top"> 
	 
<cfif session.MainCatID EQ ''>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
	
	<!---<tr>
	<td width="100%"><img src="#request.imageroot#/ideaFunL/01_select_cattopic.gif" width="162" height="52" alt="1. SELECT A CATEGORY &amp; TOPIC" border="0"></td>
	</tr>--->
	
	</table><br>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="100%">
	
		<hr width="100%" size="1" color="##999999">
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">	
		
		<tr>
		<td style="color:##333333;" colspan="2"><strong>Please select an Idea Category...</strong></td>
		</tr>
		
		
		<tr>
		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>		
		<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>		
		</tr>
		
		<tr>
		<td colspan="2"><strong><li style="color:###TRIM(AllSettings.BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&MainCatID=All" style="color:###TRIM(AllSettings.BoxColour)#;">All Categories</a></li></strong></td>		
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>		
		</tr>
		
		<cfloop query="qry_all_maincats">
		
		<cfset this_maincatID = qry_all_maincats.maincatID>
		<cfset this_title = qry_all_maincats.MainCatTitle>
		
		<tr>
		<td colspan="2"><li style="color:###TRIM(AllSettings.BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&MainCatID=#this_maincatID#"><strong>#TRIM(this_title)#</strong></a></li></td>		
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>		
		</tr>
		
		<cfquery name="Category" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM SugCategory
		WHERE MainCatID=#this_mainCatID# 
		AND Active = 1
		ORDER BY DisplayOrder
		</cfquery> 
		
		<cfloop query="Category">
        
    		<tr>
    		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>		
    		<td><li style="color:###TRIM(AllSettings.BoxColour)#;" type="square"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&MainCatID=#this_maincatID#&currentcategory=#Category.categoryID#&IdeaFunL_StartRow=1&srch_stage=ALL" style="font-size:11px;">#TRIM(Category.Name)#</a></li></td>
    		</tr>
    		
    		<tr>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>		
    		</tr>
    		
    		<tr>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
    		<td height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>		
    		</tr>
    		
    		<tr>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>		
    		</tr>
		
		</cfloop>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>		
		</tr>
		
		</cfloop>	
		
		</table><br>
		
		
	</td>
	</tr>
	
	</table>	
	
<cfelseif session.MainCatID EQ 'ALL'>
	
	<cfquery name="qry_all_maincats" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT MainCatID, MainCatTitle
	FROM SugMainCategory
	WHERE Active=1
	ORDER BY DisplayOrder
	</cfquery>
	
	<div class="fullwidth">
	     <div class="leftwidth">
		      <cfinclude template="/ideas/all_ideas_filter.cfm">
		 </div>
		 <div class="rightwidth">
		      <cfinclude template="/ideas/all_ideas.cfm"> 
		 </div>
	</div>   
	
<cfelseif IsNumeric("#session.MainCatID#")>		

    <div class="fullwidth">
	     <div class="leftwidth">
		      <cfinclude template="/ideas/all_ideas_filter.cfm">
		 </div>
		 <div class="rightwidth">
		      <cfinclude template="/ideas/selected_ideas.cfm"> 
		 </div>
	</div>  		 
</cfif>

</td>
</tr>

</table>

</cfoutput>