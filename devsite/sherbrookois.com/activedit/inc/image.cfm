<!--- 
	Application: CF_Activedit
	Name: image.cfm
	Function: Frames for Inserting an image
	Authors: Pete Freitag, Matt Finn
	Company: CFDEV.COM
	Version: 4
	Revisions:
		Add instance support and remove cookie requirement
	Date: 4/13/00
 --->
<title>Insert Image</title>
<!-- frames -->
<cfparam name="url.instance" default="">
<cfparam name="url.imagedata" default="">
<cfparam name="url.imageurl" default="">

<cfoutput>
<frameset  cols="450,*" style="border:1px solid gray;" border="0">
	<frame name="left" src="left.cfm?instance=#url.instance#&imageurl=#URLEncodedFormat(url.imageurl)#&imagedata=#URLEncodedFormat(url.imagedata)#" scrolling="no" frameborder="yes" noresize>
	<frame name="right" src="right.cfm?instance=#url.instance#&imageurl=#URLEncodedFormat(url.imageurl)#&imagedata=#URLEncodedFormat(url.imagedata)#" scrolling="auto" frameborder="no">
</frameset>
</cfoutput>
