<cfoutput>

<style>


A:link	
{
	text-decoration: underline;
	color:###AllSettings.LinkColour#;
}

A:visited	
{
	text-decoration: underline;
	color:###AllSettings.LinkColour#;
}

A:hover
{
	text-decoration: none;
	color:###AllSettings.LinkColour#;
}		



H1 { 
	font-size: 20px;
	font-family: Trebuchet MS, Arial, Verdana, Helvetica;
	color:###AllSettings.DkTextColor#;
	}

H2 { 
	font-size: 16px;
	font-family: Trebuchet MS, Arial, Verdana, Helvetica;
	}

H3 { 
	font-size: 14px;
	font-family: Trebuchet MS, Arial, Verdana, Helvetica;
	}

H4 { 
	font-size: 12px;
	font-family: Arial, Verdana, Helvetica;
	}

	
td {
	font-size: 12px;
	font-family: Arial, Verdana, Helvetica;
	}


.field {
	font-size: 11px;
	color: ##0a0a0a;
	font-family: Arial, Trebuchet MS, Verdana;
	font-weight: normal;		
	background-color: White;
	border: solid 1px ##b4b4b4;
	}
	
.whitefield {
	font-size: 11px;
	color: ##0a0a0a;
	font-family: Arial, Trebuchet MS, Verdana;
	font-weight: normal;		
	background-color: White;
	border: solid 1px ##b4b4b4;
	}
	
.buttonControl {
	font-size: 11px;
	color: ###request.buttonColor#;
	font-family: Arial, Trebuchet MS, Verdana;
	font-weight: normal;		
	background-color: ###request.siteBackGColor#;
	border: solid 1px ##b4b4b4;
	}
	
.PageTitle { 
	font-size: 20px;
	font-family: Trebuchet MS, Arial, Verdana, Helvetica;
	color:###AllSettings.DkTextColor#;
	}

.TRow {
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-style: solid;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	border-top-color: ##FFFFFF;
	border-right-color: ##FFFFFF;
	border-bottom-color: ##FFFFFF;
	border-left-color: ##FFFFFF;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: small;
	font-weight: bold;
	color: ##FFFFFF;
	text-align: left;
	padding-top: 4px;
	padding-right: 0px;
	padding-bottom: 4px;
	padding-left: 0px;
}

.topRowColor {
    background-color: ##EEEEEE;
}

.rowSet {
    float: right; 
	width: #request.widthSize#;
}

.rowSet2 {
    float: right; 
	width: 100%;
}

.topRowSet {
    float: right; 
	width: 100%;
	background: black;
	color: white;
}

.menuRowSet {
    float: right; 
	width: 100%;
	background: black;
	color: white;
}

.rowSetBottomBar {
    float: right; 
	width: 100%;
	background-color: ##AEAEAE;
}

.clearfix:before, .clearfix:after {
    content: "";
    display: table;
}
.clearfix:after {
    clear: both;
}
.clearfix:before, .clearfix:after {
    content: "";
    display: table;
}
.main-header { 
    border-bottom: 0px solid ##777777;
    height: 67px;
    position: relative;
	background-color: ##EEEEEE;
} 
.main-header .container {
   /* padding: 15px 10px 0;*/
   margin-top: 0px;
   padding: 0px;
}
 

.sub-header { 
    padding: 15px 0;
    background-color: ##EEEEEE;
} 
.content .container { 
    margin-bottom: 70px;
    padding-top: 30px;
    position: relative;
    z-index: 10;
}
.container {
    margin: 0 auto;
    padding-left: 9px;
    padding-right: 9px;
    position: relative;
    width: #request.widthSize#;
	padding-top: 11px;
	text-align: right;
	font-variant: normal;
	font-weight: normal;
}

.main-footer {
    background: none repeat scroll 0 0 ##000;
    padding: 22px 0;
}

h1.gray {
    color: ##ACBEC2;
    display: block;
    margin: 0 0 10px;
    width: 100%;
}

.field {
    margin-bottom: 15px;
    position: relative;
}

.field-heading label {
    display: inline;
}

.field label {
    margin-bottom: 3px;
}
 
.field-heading {
    color: ##ACBEC2;
    font-size: 13px;
    font-weight: bold;
    margin: 5px;
}

.textFields {
    margin: 10px 10px 10px 6px;
}

</style>

</cfoutput>