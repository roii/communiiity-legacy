<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!---
	File: help.cfm (CF_ActiveScan)
	Author: Matt Finn
    Company: CFDEV.COM / NETDesign Inc.
	Description:
 		Popup Help File for Activescan
    Date: August 2000
	Version: 1,0,0,1
--->
<html>
<head>
	<title>ActiveScan: Help</title>
</head>
<style>
TD { font-family: verdana; 
	 font-size: xx-small;
	 }
</style>

<body bgcolor="white">
<table width="100%" cellspacing="0" cellpadding="1"><form>
	<tr>
		<td valign="top">
			<img src="images/scanner.gif" width=23 height=22 alt="Select Scanner" border="0">
		</td>

		<td width="1" bgcolor="black"></td>
		<td valign="top">
			Allows you to select a scanner.
			<br><br>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<img src="images/scan.gif" width=23 height=22 alt="Scan" border="0">
		</td><td width="1" bgcolor="black"></td>
		<td valign="top">
			Starts up the scan.
		</td>
	</tr>
	<tr><TD><BR></td></tr>
	<tr>
		<td valign="top">
			<img src="images/minus.gif" width=23 height=22 alt="Zoom Out" border="0">
		</td>
		<td width="1" bgcolor="black"></td>
		<td valign="top">
			Zooms out the current image.
		</td>
	</tr>
	<tr>
		<td valign="top">
			<img src="images/plus.gif" width=23 height=22 alt="Zoom In" border="0">
		</td>
		<td width="1" bgcolor="black"></td>
		<td valign="top">
			Zooms in the current image.<br>
			<br>
		
		</td>
	</tr>
	<tr>
		<td valign="top">
			<img src="images/move.gif" width=23 height=22 alt="Zoom Full" border="0">
		</td>
		<td width="1" bgcolor="black"></td>
		<td valign="top">
			Zooms the image back to 100 percent.
		</td>
	</tr>
	<tr><td></td><td></td><TD>Tip: You can either click the zoom buttons to zoom <br>
	&nbsp;&nbsp;&nbsp;&nbsp; by half, or hold them down to zoom smoothly.<br><br><br>
	</td></tr>	
	<tr>
		<td valign="top">
			<img src="images/select.gif" width=23 height=22 alt="Select" border="0">
		</td>
		<td width="1" bgcolor="black"><img src="images/save.gif" alt="" width="1" height="1"></td>
		<td valign="top">
			Allows you to select an area of the image.
		</td>
	</tr>
	<tr>
		<td valign="top">
			<img src="images/drag.gif" width=23 height=22 alt="Font" border="0">
		</td>
		<td width="1" bgcolor="black"></td>
		<td valign="top">
			Allows you to move the display around by dragging on the image.
		</td>
	</tr>
	<tr>
		<td valign="top">
			<img src="images/crop.gif" width=23 height=22 alt="Bold" border="0">
		</td>
		<td width="1" bgcolor="black"></td>
		<td valign="top">
			Crops the image to the current selection.
		</td>
	</tr>
	<tr>
		<td valign="top">
			<img src="images/resize2res.gif" width=23 height=22 alt="Resample Image" border="0">
		</td>
		<td width="1" bgcolor="black"><img src="images/save.gif" alt="" width="1" height="1"></td>
		<td valign="top">
			Allows you to resample the image to a certain percent.
		</td>
	</tr>
		<tr><TD><BR></td></tr>
	<tr>
		<td valign="top">
			<img src="images/save.gif" width=23 height=22 alt="Save" border="0">	
		</td>
		<td width="1" bgcolor="black"><img src="images/save.gif" alt="" width="1" height="1"></td>
		<td valign="top">
			Saves the image to the server.
		</td>
	</tr>
	<tr>
		<td colspan="3">  
			<center>
				<!---<input type="button" value="close" onClick="self.close()">--->
			</center>
		</td>
	</tr></form>
</table>


</body>
</html>
