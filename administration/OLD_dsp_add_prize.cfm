<cfparam name="attributes.prizepoolid" default="">
<cfinclude template="qry_prize.cfm">

<cfif AllPrize.recordcount>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0">
	<tr bgColor="a0d8e0">
     <td width="150"><b>Name</b></td>
	 <td width="250"><b>Description</b></td>
	 <td width="200"><b>Image</b></td>
	 <td><b>Winner</b></td>
	 <td width="100"><b>Action</b></td>
       </tr>
    <cfset i=1>
    <cfoutput query="AllPrize">
  <cfquery name="Prizewinner" datasource="#dsn#" username="#request.username#" password="#request.password#">
     SELECT * from contacts c,prize_entry pe where c.contactid = pe.contactid
	 and pe.prizeid = #AllPrize.prizeid# and pe.winner = 1
   </cfquery>
       <tr bgColor="e3f4f6">
         <td>#Name#</td>
	 <td>#Description#</td>
	 <td>
		<cfif image neq ''>
		  <cfif external_url neq ''>
		    <a href="#external_url#" target="_blank"><img src="#request.webroot#/Images/prize/#image#" border="0"></a>
		  <cfelse>
		    <img src="#request.webroot#/Images/prize/#image#">
		  </cfif>
		</cfif>
	 </td>
	 <td><cfif Prizewinner.recordcount>
	 <a href="#request.webroot#/admin/dsp_kid_edit.cfm?contactID=#Prizewinner.contactid#" target="editContact" ONCLICK="fdbackwindow=window.open ('','editContact','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;">#Prizewinner.firstname# #Prizewinner.lastname#
	 </cfif></td>
	 <td>
          [<a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=edit_prize&prizeid=#prizeid#&prizepoolid=#attributes.prizepoolid#">Edit</a>] |  
          [<a href="#request.webroot#/administration/act_del_prize.cfm?prizeID=#prizeid#&prizepoolid=#attributes.prizepoolid#" onclick="return confirm('This will delete all records related to this prize including prize entries.\nAre you sure you want to delete this prize?')">Delete</a>]
		  <cfif Prizewinner.recordcount eq 0>
          [<a href="#request.webroot#/administration/act_draw_prize.cfm?prizeID=#prizeid#&prizepoolid=#attributes.prizepoolid#" onclick="return confirm('This will randomly select a winner and close this draw.\nClick on Yes to proceed')">Draw</a>]
		  </cfif>
  	 </td>
     </tr>
    </cfoutput>
  </table>
</cfif>
<br><br>
<cfoutput>


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>ADD A NEW PRIZE TO THE PRIZE POOL</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	</tr>
	</table>
	
	<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<cfform name="AddPrize" action="#request.webroot#/administration/act_add_prize.cfm" method="post" enctype="multipart/form-data">
			
			<tr>
			<td style="color:404040;">Prize Name</td>
			<td><cfinput type="text" required="Yes" message="Please enter prize name first" name="name" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
						
			<tr>
			<td style="color:404040;">Prize Description</td>
			<td>
			<textarea rows="5" cols="35" name="description"></textarea>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">External URL</td>
			<td>
			<input type="text" name="external_url" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</td>
			</tr>
						
			<tr>
			<td style="color:404040;">Prize Image</td>
			<td>
			<input type="file" name="PrizeImage"></td>
			</tr>

			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>			
			
			<tr>
			<td style="color:404040;"> </td>
			<td>
			<input type="hidden" name="prizepoolid" value="#attributes.prizepoolid#">
			<input type="submit" class="whitefield" style="border-color:a0d8e0;" value="ADD NOW!"></td>
			</tr>
			</cfform>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>

</cfoutput>