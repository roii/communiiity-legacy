<cfoutput>

<script>
<!--
function SwapView(d, n){ 

        var temp_0 = "DL" + d;
		
        if (document.getElementById(temp_0).style.visibility == "hidden") { 
                document.getElementById(temp_0).style.visibility='visible'; 
			
				if (navigator.appName == 'Microsoft Internet Explorer') {
                document.getElementById(temp_0).style.position ='fixed'; }
        		else {
				 document.getElementById(temp_0).style.position ='relative'; }
				
				if (temp_0 == 'DL24') {
				 	document.getElementById("DL7").style.visibility='hidden';
                document.getElementById("DL7").style.position ='absolute'; 
				 	document.getElementById("DL30").style.visibility='hidden';
                document.getElementById("DL30").style.position ='absolute'; }
				 else if (temp_0 == 'DL7') {
				 	document.getElementById("DL24").style.visibility='hidden';
                document.getElementById("DL24").style.position ='absolute'; 
				 	document.getElementById("DL30").style.visibility='hidden';
                document.getElementById("DL30").style.position ='absolute'; }
				 else if (temp_0 == 'DL30') {
				 	document.getElementById("DL24").style.visibility='hidden';
                	document.getElementById("DL24").style.position ='absolute'; 
				 	document.getElementById("DL7").style.visibility='hidden';
                	document.getElementById("DL7").style.position ='absolute'; }
			
			
					 
        }else { 
                document.getElementById(temp_0).style.visibility='hidden'; 
                document.getElementById(temp_0).style.position ='absolute'; 
				
        } 
        return 0; 
} 
// -->
</script>



<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 1px ###AllSettings.BoxColour#;">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><a name="quickstats"><strong>QUICK STATISTICS</strong></a></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td>

	
	<div id="DL24" style="position:absolute; border-style:none; Z-INDEX: DL; visibility:hidden;">
	
		<cfinclude template="dsp_sidebar_quickstats_24hr.cfm">

	</div>
	
	
	
	<div id="DL7" style="position:absolute; border-style:none; Z-INDEX: DL; visibility:hidden;">
	
		<cfinclude template="dsp_sidebar_quickstats_7day.cfm">

	</div>
	
	
	
	<div id="DL30" style="position:relative; border-style:none; Z-INDEX: DL; visibility:visible;">
	
		<cfinclude template="dsp_sidebar_quickstats_30day.cfm">

	</div>

<br>
</td>
</tr>

</table>


</cfoutput>