<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>ActivEdit Example</title>
</head>

<body>

<!--- figure out some environment variables, normally you could just hardcode these --->
<cfset thisDir = "http://" & CGI.HTTP_HOST & Replace(CGI.SCRIPT_NAME, "example.cfm","")>

<form method="post">
	<strong>Document Title:</strong><br />
	<input type="text" name="title" value="ActivEdit works as part of an html form" size="50"><br /><br />
	<strong>Content:</strong><br />
	<cf_activedit name="content"
		toolbar="font,bold,italic,underline,|,outdent,indent,|,justifyleft,justifycenter,justifyright,bullets,|,table,image,hyperlink,|,spellcheck,|,subscript,superscript,strike,highlight,removeformat,replace,||,quickstyles,quickformat,quickfont,quickfontsize"
		imagepath="#ExpandPath("./exampleimages/")#"
		imageurl="#thisDir#exampleimages/"
		inc="inc/"
		defaultfont="10pt verdana"
		quickstyles="title,emphasize"
		quickstylenames="Title,Emphasize"
		stylesheet="#thisDir#example_style.css"
		tabview="true"
		width="620"
		xhtml="true"
		encryptkey="greg"
		activscan="true"
		appletlicense="1171723861">
	<cfoutput>
		<div class="title">ActivEdit 4.0</div>
		<img src="#thisDir#inc/activedit.gif" alt="ActivEdit 4.0" border="0" align="left" style="margin-right:10px;">
		<br><strong>Welcome to ActivEdit<sup>4.0</sup></strong> - the most <span class="emphasize">feature rich</span> WYSIWYG HTML
		Editor on the market. ActivEdit 4.0 features include <span class="emphasize">seamless CSS integration</span>, XHTML compatible, updated spell checker, improved look and feel, and more.
		<br><br><br><br>
		<div class="title">ActivEdit 4.0 is as easy as...</div>
		<br>
		<img src="#thisDir#exampleimages/1.gif" alt="One" align="middle"> <span class="emphasize">One</span> <br>
		<img src="#thisDir#exampleimages/2.gif" alt="Two" align="middle"> <span class="emphasize">Two</span> <br>
		<img src="#thisDir#exampleimages/3.gif" alt="Three" align="middle"> <span class="emphasize">Three</span> <br>
		
	</cfoutput>
	</cf_activedit>
	
	<br>
	
	<input type="submit" value="submit form">
</form>


<cfif IsDefined("form.content")>
This is the content you submitted:
<hr>
<cfoutput>#HTMLEditFormat(form.content)#</cfoutput>
</cfif>



</body>
</html>
