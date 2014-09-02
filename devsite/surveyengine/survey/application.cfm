<!--- NAVWRAPPER CONFIGURATION --->
<cfparam name="tableforms" default="forms">
<cfparam name="tablequestions" default="questions">
<cfparam name="tableresponses" default="responses">

<!--- Application specific preferences --->
<cfparam name="datasourceR" default="survey2">
<cfparam name="datasourceW" default="survey2">

<!--- Custom Font Style --->
<cfset fontstyle = "face=""Arial, Helvetica"" size=5 color=""FFFFFF"" style=""color:FFFFFF; text-decoration:none""">
<cfset fontstyle1 = "face=""Arial, Helvetica"" size=2 color=""000000"" style=""color:000000; text-decoration:none""">
<cfset fontstyle2 = "face=""Arial, Helvetica"" size=1 color=""000000"" style=""color:000000; text-decoration:none""">
<cfset fontstyle3 = "face=""Arial, Helvetica"" size=2 color=""ff0000"" style=""color:000000; font-weight : bold; text-decoration:none""">

<!--- Random Session ID --->
<cfset itemid1 = randrange(1,9999)>
<cfset itemid2 = randrange(1,9999)>
<cfset itemid = "#itemid1##itemid2#">

