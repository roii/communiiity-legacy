<!--- 

<fusedoc language="ColdFusion" FUSE="Downloads" Specification="2.0">

<responsibilities>To display file download summary and link to download</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<in>
	<recordset name="downloadDetails" format="CFML" Scope="variables">
</in>

</fusedoc>

 --->
 
<cfoutput>

<table border="0" cellpadding="0" cellspacing="2" width="100%">
		
<tr>
<td class="section_header" width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#TRIM(sectiondetails.fuseaction)#" style="text-decoration:none; color:black;"><cfif #session.textonly# EQ 'yes'>#SectionDetails.Title#<cfelse><img src="#request.imageroot#/title_#SectionDetails.fuseaction#.gif" border="0"></cfif></a></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>	

<tr>
<td bgcolor="676767" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>	

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>	


<tr>
<td class="page_header" width="100%">#UCASE(downloadDetails.Title)#</td>
</tr>


<tr>
<td><br>
<span class="normal">#downloadDetails.details#</span></td>
</tr>

<tr>
<td height="4" class="small"><br>

	<table width="400" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100"><span class="normal" style="color:black"><b>Author:</b></span></td>
	<td width="300"><span class="normal" style="color:dimgray;">#downloadDetails.Author#</span></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td><span class="normal" style="color:black"><b>Published:</b></span></td>
	<td><span class="normal" style="color:dimgray">#Dateformat(downloadDetails.DateUploaded, "d mmmm yyyy")#</span></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td><span class="normal" style="color:black"><b>Format:</b></span></td>
	<td><span class="normal" style="color:dimgray">#downloadDetails.FileFormat#</span></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td><span class="normal" style="color:black"><b>File Size:</b></span></td>
	<td><span class="normal" style="color:gray"><cfif #downloadDetails.Filesize# LT 1000000>#int(downloadDetails.Filesize/1024)#kb<cfelse>#int(downloadDetails.Filesize/1024000)#mb</cfif></span></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<form action="#request.webroot#/download/files/#downloadDetails.filename#" method="get" target="_blank">
	<tr>
	<td colspan="2" align="center"><br><input type="submit" class="whitefield" value="DOWNLOAD NOW >>" style="border: black 1px solid"><br><br></td>
	</tr>
	</form>
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<cfif #downloadDetails.FileFormat# EQ 'pdf'>
	<tr>
	<td colspan="2" align="center" class="normal"><br>
	To open and view a PDF file requires the FREE Acrobat Reader software, available for download by clicking the Acrobat logo below.<br><br>
	<a href="http://www.adobe.com/acrobat/readstep.html" target="_blank"><img src="#request.imageroot#/acrobat_logo.gif" width="88" height="31" alt="Get Acrobat" border="0"></a></div></td>
	</tr>
	</cfif>
	
	</table><br>

</td>
</tr>



</table>
<br>

</cfoutput>