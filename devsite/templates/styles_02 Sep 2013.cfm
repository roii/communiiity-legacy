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
    padding: 15px 10px 0;
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
}

.main-footer {
    background: none repeat scroll 0 0 ##AEAEAE;
    padding: 22px 0;
}
</style>

</cfoutput>