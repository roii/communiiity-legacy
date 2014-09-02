<cfsetting enablecfoutputonly="yes">
<cfparam name="attributes.width" default="100%">
<cfparam name="attributes.cellpadding" default="1">
<cfparam name="attributes.cellspacing" default="0">
<cfparam name="attributes.border" default="0">
<cfparam name="attributes.bgcolor1" default="ededfd">
<cfparam name="attributes.bgcolor2" default="333399">
<cfparam name="attributes.bgcolor3" default="ededfd">
<cfparam name="attributes.title" default="">

<CFSWITCH expression="#ThisTag.ExecutionMode#">
    <CFCASE value='start'>
        <!--- Start tag processing --->
<cfoutput>
<table width="#attributes.width#" cellpadding="#attributes.cellpadding#" cellspacing="#attributes.cellspacing#" border="#attributes.border#">
<cfif len(attributes.title)>
<TR><TD bgcolor="#attributes.bgcolor2#">
	<font face="verdana,arial,helvetica" color=ffffff size="2">
		&nbsp;&nbsp;<b>#attributes.title#</b>
    </font>
	</TD></TR>
</cfif>	
	<tr><td bgcolor="#attributes.bgcolor1#">
			<table border=0 width=100% bgcolor="#attributes.bgcolor3#" cellspacing="0" border="0" cellpadding="5">
				<TR><TD colspan=2 bgcolor="#attributes.bgcolor3#"></cfoutput>
    </CFCASE>
    <CFCASE value='end'>
        <!--- End tag processing --->
<cfoutput>
</td></tr></TABLE></td></tr></table></cfoutput>
    </CFCASE>
</CFSWITCH>
<cfsetting enablecfoutputonly="no">
