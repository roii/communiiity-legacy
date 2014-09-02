<cflock scope="application" timeout="100">
  <cfscript>
  application.imageno=application.imageno + 1;
  if(application.imageno eq 10) {
  	application.imageno=0;
  }
  imageno=application.imageno;
  imagepath=application.imagepath;
  </cfscript>
</cflock>

<cfoutput>

<cftry>
<cffile action="delete" file="#imagepath##imageno#.jpg">
<cfcatch>
</cfcatch>
</cftry>

<cftry>
<cffile action="rename" source="#imagepath##url.wrote#" destination="#imagepath##imageno#.jpg">
<cfcatch>
</cfcatch>
</cftry>

<script language="javascript1.2">
	
   window.opener.zabam("#imageno#");
	window.close();

</script>
</cfoutput>


