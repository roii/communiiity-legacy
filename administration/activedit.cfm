<cfif NOT isdefined("thistag.ExecutionMode")>Activedit must be executed as a custom tag.<cfabort></cfif>
<cfsetting enablecfoutputonly="yes">
<cfparam name="attributes.type" default="form">

<cfif thisTag.executionMode IS "end"> 

<cfoutput>
<!--- trial token placeholder --->
<!-- begin cf_activedit v:4.0 (4.0.0.43 01/15/2004)  --></cfoutput>
<cfparam name="request.ae_num" default="0">
<cfset request.ae_num=request.ae_num+1>
<cfset ae_num=request.ae_num>

<!--- 	CF_Activedit 
		Copyright 1999-2003 CFDEV.COM
		All Rights reserved
		Authors: 	Pete Freitag
					Matt Finn 
					Greg Alton
		Version: 4.0 (4.0.0.43 01/15/2004)
  
   Release Notes 
	Requires Internet Explorer 4 or greater on windows platform, or Java 2 applet
	
--->
	
<!--- Build Stock buttons --->

<cfset ae_stockbtns=StructNew()>
<cfset ae_stockbtns.cut="5003,Cut,Cut the selected text and put it on the clipboard,images/cut.gif">
<cfset ae_stockbtns.copy="5002,Copy,Copy the selected text into the clipboard,images/copy.gif">
<cfset ae_stockbtns.paste="5032,Paste,Paste the contents of the clipboard into the workspace,images/paste.gif">
<cfset ae_stockbtns.undo="5049,Undo,Undo the last operation,images/undo.gif">
<cfset ae_stockbtns.redo="5033,Redo,Redo the last operation,images/redo.gif">
<cfset ae_stockbtns.font="5009,Font,Change font and color,images/fgcolor.gif">
<cfset ae_stockbtns.bold="5000,Bold,Make selected text bold,images/bold.gif">
<cfset ae_stockbtns.italic="5023,Italic,Make selected text italic,images/italic.gif">
<cfset ae_stockbtns.underline="5048,Underline,Underline the selected text,images/under.gif">
<cfset ae_stockbtns.outdent="5031,Decrease Indent,Reverse indent the current line,images/deindent.gif">
<cfset ae_stockbtns.indent="5018,Indent,Indent the current line,images/inindent.gif">
<cfset ae_stockbtns.justifyleft="5025,Align Left,Left justify the current line,images/left.gif">
<cfset ae_stockbtns.justifycenter="5024,Center,Center the current line,images/center.gif">
<cfset ae_stockbtns.justifyright="5026,Align Right,Right justify the current line,images/right.gif">
<cfset ae_stockbtns.bullets="5051,Bullets,Insert a bullet on current line,images/bullist.gif">
<cfset ae_stockbtns.numbers="5030,Numbering,Insert a numbered list on current line,images/numlist.gif">
<cfset ae_stockbtns.find="5008,Find,Find text in the document,images/find.gif">
<cfset ae_stockbtns.table="5022,Insert Table,Insert a table,images/instable.gif">
<cfset ae_stockbtns.image="5017,Insert Image,Insert an image,images/image.gif">
<cfset ae_stockbtns.hyperlink="5016,Insert Hyperlink,Insert a hyperlink on selected text,images/link.gif">
<cfset ae_stockbtns.help="6003,Help,Help,images/help.gif">
<cfset ae_stockbtns.showdetails="6004,Show Details,Displays hidden elements as glyphs,images/paragraph.gif">
<cfset ae_stockbtns.spellcheck="6007,Spell Check,Open spell check window,images/spell.gif">
<cfset ae_stockbtns.specialchars="6008,Special Characters,Insert a Special Character,images/specialchar.gif">
<cfset ae_stockbtns.hr = "6010,Horizontal Rule,Insert a Horizontal Rule,images/hr.gif">
<cfset ae_stockbtns.subscript = "6011,Subscript,Subscript,images/subscript.gif">
<cfset ae_stockbtns.superscript = "6012,Superscript,Superscript,images/superscript.gif">
<cfset ae_stockbtns.strike = "6013,Strike,Strike the selected text,images/strike.gif">
<cfset ae_stockbtns.highlight = "6014,Highlight,Highlight the selected text,images/highlight.gif">
<cfset ae_stockbtns.removeformat = "6015,Remove Format,Remove Formatting,images/removeformat.gif">
<cfset ae_stockbtns.replace = "6016,Replace,Replace Text,images/replace.gif">

			<!--- initialize error handeler ---> 
			<cfset error = 0>

			<!--- Error: inc is a required attribute --->
			<cfif NOT IsDefined("attributes.inc")>
				<cfset error = 1>
				<cfoutput>
					<li>ERROR: 
					The Required Attribute "inc" was not found in the tag input. 
					<i> This Attribute should contain the url to the 'inc' folder.</i></li>
				</cfoutput>
			</cfif>
			
			<cfparam name="attributes.fieldname" default="">
			<cfparam name="attributes.name" default="#attributes.fieldname#">
	
				<!--- Error: fieldname is a required attribute --->
				<cfif NOT Len(attributes.name)>
					<cfset error = 1>
					<cfoutput>
						<li>ERROR: 
						The Required Attribute "name" was not found in the tag input. 
						<i> This Attribute should contain the name of the field the dynamic data is stored in.</i></li>
					</cfoutput>
				</cfif>

			<!--- Set for conditional requirements --->
			<cfparam name="attributes.upload" default="1">
			<cfparam name="attributes.activscan" default="0">
			<cfparam name="attributes.path" default="">
			<cfparam name="attributes.url" default="">
			<cfparam name="attributes.imagepath" default="#attributes.path#">
			<cfparam name="attributes.imageurl" default="#attributes.url#">
      
			<cfif NOT IsDefined("attributes.image") AND 
					NOT Len(attributes.imagepath) AND
					NOT Len(attributes.imageurl)>
				<cfset attributes.image=0>
			</cfif>
			
			<cfparam name="attributes.image" default="1">
			
			<!--- Error: A conditional requirement of image=true requires imageurl and imagepath attributes --->
			<cfif attributes.image>
				<cfif NOT Len(attributes.imageurl)>
					<cfset error = 1>
					<cfoutput>
						<li>ERROR: 
						The Required Attribute (For Images) "imageurl" was not found in the tag input.
						<i>This Attribute should contain the url to the 'images' folder.</i></li>
					</cfoutput>
				</cfif>
				
				<cfif NOT Len(attributes.imagepath)>
					<cfset error = 1>
					<cfoutput>
						<li>ERROR: 
						The Required Attribute (For Images and upload) "imagepath" was not found in the tag input.  
						<i>This Attribute should contain the path to the 'images' folder.</i></li>
					</cfoutput>
				</cfif>	
			</cfif>
			
<!--- throw fatal error --->		
	
			<cfif error>
				<cfoutput>
				<title>Error Occurred</title>
				<br /><br />
				<b>This Page Is Terminating Prematurely Due To Fatal Configuration Errors</b>
				</cfoutput>
				<cfabort>
			</cfif>
		
<!--- define parameters --->			
			<cfparam name="attributes.debug" default="0" type="boolean">
			<cfparam name="attributes.buttoncolor" default="buttonface">
			<cfparam name="attributes.width" default="610">
			<cfparam name="attributes.height" default="300">
			<cfparam name="attributes.border" default="1px outset">			
			<cfparam name="attributes.alloweditsource" default="1" type="boolean">
			<cfparam name="attributes.breakonenter" default="0" type="boolean">
			<cfparam name="attributes.tabview" default="0" type="boolean">
			
			<cfparam name="attributes.find" default="0" type="boolean">
			<cfparam name="attributes.cutcopypaste" default="1" type="boolean">
			<cfparam name="attributes.allowtable" default="1" type="boolean">
			<cfparam name="attributes.redoundo" default="1" type="boolean">
			<cfparam name="attributes.font" default="1" type="boolean">
			<cfparam name="simpleImage" default="0" type="boolean">
			<cfparam name="attributes.help" default="1" type="boolean">
			<cfparam name="attributes.defaultfont" default="">
			<cfparam name="attributes.baseurl" default="">
			<cfparam name="attributes.quickfonts" default="Arial,Courier New,Helvetica,Times New Roman,Verdana">
			<cfparam name="attributes.quickfontcolors" default="red,blue,green,orange,gray,silver,black,white">
			<cfparam name="attributes.quickstyles" default="">
			<cfparam name="attributes.quickstyleNames" default="">
			<cfparam name="attributes.quickformatNames" default="Normal,Formatted,Address,Heading 1,Heading 2,Heading 3,Heading 4,Heading 5,Heading 6,Numbered List,Bulleted List,Directory List,Menu List,Definition Term,Definition,Paragraph">
			<cfparam name="attributes.stylesheet" default="">
			<cfparam name="attributes.xhtml" default="false">
			<cfparam name="attributes.tabindex" default="0">
		<cfif NOT IsDefined("attributes.toolbar")>
			<cfset toolbar="">
			<cfif attributes.cutcopypaste><cfset toolbar=toolbar&"cut,copy,paste,|,"></cfif>
			<cfif attributes.redoundo><cfset toolbar=toolbar&"redo,undo,|,"></cfif>
			<cfif attributes.font><cfset toolbar=toolbar&"font,bold,italic,underline,|,"></cfif>			
			<cfset toolbar=toolbar&"outdent,indent,|,justifyleft,justifycenter,justifyright,bullets,|,">
			<cfif attributes.find><cfset toolbar=toolbar&"find,"></cfif>			
			<cfif attributes.allowtable><cfset toolbar=toolbar&"table,"></cfif>			
			<cfif attributes.image><cfset toolbar=toolbar&"image,"></cfif>			
			<cfset toolbar=toolbar&"hyperlink">
			<cfif attributes.help><cfset toolbar=toolbar&",help"></cfif>			
			<cfset attributes.toolbar=toolbar>
		</cfif>
			<cfparam name="attributes.customCaptions" default="#StructNew()#" type="struct">
			<cfparam name="attributes.applet" default="auto">
<!--- Format Parameters --->

	<cfif NOT Right(attributes.inc, 1) is "/">
		<cfset attributes.inc=attributes.inc & "/">
	</cfif>

	<cfif attributes.image>
		<cfif Right(attributes.imagepath, 1) is "/" OR
      Right(attributes.imagepath, 1) is "\">
			<cfset attributes.imagepath= Left(attributes.imagepath, Len(attributes.imagepath)-1)>		
		</cfif>
		<cfif Right(attributes.imageurl, 1) is "/">
			<cfset attributes.imageurl= Left(attributes.imageurl, Len(attributes.imageurl)-1)>		
		</cfif>
	</cfif>	
			
<!--- define global key --->

				<cfset ae_accesskey=CreateUUID()>
				<cflock scope="SERVER" type="EXCLUSIVE" timeout="30">
					<cfif NOT IsDefined("server.ae_encryptkey")>
						<cfif IsDefined("attributes.encryptkey")>
							<cfset server.ae_encryptkey=attributes.encryptkey>
						<cfelse>					
							<cfset server.ae_encryptkey="#CreateUUID()#ae">
						</cfif>
					</cfif>
					<cfif NOT IsDefined("server.ae_accesslist")>
						<cfset server.ae_accesslist=StructNew()>
					</cfif>
					<cfset StructInsert(server.ae_accesslist, ae_accesskey, 1, true)>
					<cfset ae_encryptkey=server.ae_encryptkey>
				</cflock>
					<cfset ae_imagedata="#attributes.upload#,#attributes.activscan#,#attributes.imagepath#">
					<cfset ae_encimgdata=encrypt( ae_imagedata, ae_encryptkey)>
					
					<!--- <cfset ae_encimgdata=#Left(ae_encimgdata,Len(ae_encimgdata)-1)#> --->
				
<!--- define settings --->
		<cfsetting enablecfoutputonly="no">
<!--- global java script --->		
		<cfoutput>
			<script language="JavaScript">
				<cfif ae_num is 1>
				var alloweditsource = new Array();
				var tabview = new Array();
				var ae_fieldname = new Array();				
				var ae_imagedata = new Array();				
				var ae_imageurl = new Array();
				var ae_defaultfont = new Array();				
				var ae_baseurl = new Array();				
				var ae_breakonenter = new Array();
				var ae_xhtml = new Array();
				var inc = '#attributes.inc#';
				var quickformatNameArray = new Array();
				var ae_stylesheet = new Array();
				var ae_quickfontcolors = new Array();
				var fileType = 'cfm';
				</cfif>
				
				var errlevel = 2;

				ae_breakonenter[#ae_num#] = <cfif attributes.breakonenter>true<cfelse>false</cfif>;
				ae_baseurl[#ae_num#] = "#attributes.baseurl#";
				ae_defaultfont[#ae_num#] = "#attributes.defaultfont#";
				tabview[#ae_num#] = <cfif attributes.tabview>true<cfelse>false</cfif>;
				alloweditsource[#ae_num#] = <cfif attributes.alloweditsource>true<cfelse>false</cfif>;
				ae_imagedata[#ae_num#] = '#URLEncodedFormat(ae_encimgdata)#';				
				ae_imageurl[#ae_num#] = '#URLEncodedFormat(attributes.imageurl)#';
				ae_stylesheet[#ae_num#] = '#attributes.stylesheet#';
				ae_xhtml[#ae_num#] = <cfif attributes.xhtml>true<cfelse>false</cfif>;
				quickformatNameArray[#ae_num#] = new Array();
				<cfloop from="1" to="#ListLen(attributes.quickformatNames)#" index="quickformatNameIndex">
					<cfset i = quickformatNameIndex - 1>
					quickformatNameArray[#ae_num#][#i#] = "#ListGetAt(attributes.quickformatNames, quickformatNameIndex)#";
				</cfloop>
				
				
				
			</script>
		</cfoutput>
<!--- check applet/dhtml mode --->
			<cfset dhtml = false>
			<cfset applet = false>
			
			<cfif cgi.http_user_agent DOES NOT CONTAIN "MSIE" OR LCase(cgi.http_user_agent) does not contain "windows">
				<cfset ISIE=0>
				
				<cfif attributes.applet IS NOT "off"><cfset applet = true></cfif>
				<cfif LCase(cgi.http_user_agent) contains "mac"><cfset applet = false></cfif>
				<cfif LCase(cgi.http_user_agent) contains "mozilla/4"><cfset applet = false></cfif>
				<cfif LCase(cgi.http_user_agent) contains "mozilla/3"><cfset applet = false></cfif>
				<cfif LCase(cgi.http_user_agent) contains "netscape6/6.0"><cfset applet = false></cfif>
				<cfif LCase(cgi.http_user_agent) contains "netscape6/6.1"><cfset applet = false></cfif>
			<cfelse>
				<!--- IS WIN IE --->
				<cfset dhtml = true>
				<cfif attributes.applet IS "always">
					<cfset dhtml = false>
					<cfset applet = true>
				<cfelseif attributes.applet IS "off">
					<cfset applet = false>
				</cfif>
				<cfset ISIE=1>
			</cfif>

<CFIF dhtml>
	<cfoutput>
  <cfif ae_num is 1>
		<cfif NOT IsDefined("ae_trial")><script language="JavaScript" src="#attributes.inc#spellchecker/spell.js"></script></cfif>
		<script language="JavaScript" src="#attributes.inc#dhtmled.js"></script>
		<script language="JavaScript" id="clientEventHandlersJS" src="#attributes.inc#editjs.cfm?key=#ae_accesskey#" type="text/javascript"></script>
		<script language="JavaScript">
			//declare global javascript variables
			if (errlevel == 2){
				//error catching
				document.write("<BR>The file editjs.cfm did not load properly. Make sure the the inc attribute is specified correctly<br>");
				document.write("Current Value: inc=" + inc + "<br>");
				document.write("<comment>"); // Keeps the rest of the page from displaying
			}
		</script>
		<script language="javascript" src="#attributes.inc#user.js"></script>
		<cfset isXP = true>
<!--- style sheets --->
		<style type="text/css">
			.disabled {filter:mask() mask(color=buttonshadow) dropshadow(offX=1,offY=1,color=buttonhighlight,positive=1);width:23;height:22;margin:1px;padding:0px;vertical-align:middle;border-width:0;visibility:visible;}
			.flat {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border-width:1px;border-color:#attributes.buttoncolor#;border-style:solid;visibility:visible;}		
			.outset { width:23;height22;margin:0px;padding:0px;vertical-align:middle;border:1px solid navy;background-Color:##B9C2DC;}
			.inset {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border-width:1px solid navy;visibility:visible;}
			.latched {width:23;height:22;margin:0px;padding:0px;vertical-align:middle;border:1px solid navy;background-color:##B9C2DC;visibility:visible;}
			.spc {margin:0;padding:0;vertical-align:middle;}
			/* Don't allow the background color to be overridden by default style sheet*/
			TABLE.ae_tableClass {border:#attributes.border# #attributes.buttoncolor#;cursor:default;background-color:#attributes.buttoncolor#;}
			TR.ae_trClass {background-color:#attributes.buttoncolor#;}
			TD.ae_tdClass {background-color:#attributes.buttoncolor#;}
		</style>
  </cfif> 
<!--- end if ae_num is 1 --->		
<!--- output object --->
		<table bgcolor="#attributes.buttoncolor#" cellpadding="0" cellspacing="0" width="#attributes.width#" height="#attributes.height#" ondragstart="window.event.returnValue=false;"	onselectstart="window.event.returnValue=false;" class="ae_tableClass">
			<tr class="ae_trClass">	
				<td valign="bottom" colspan="2" class="ae_tdClass">
<!---  Begin Toolbar 	--->
					<cfif ae_num is 1><iframe src="#attributes.inc#blank.html" id="frame1" style="position:absolute; visibility:hidden; width:10; height:10; z-index:2;" vspace=0 hspace=0 marginheight="0" marginwidth="0" scrolling="no"></iframe></cfif>
					<table cellspacing="2" cellpadding="0" border="0">
					<tr valign="middle">
					<td width="10" background="#attributes.inc#images/toolbar.gif"><img src="#attributes.inc#images/spacer.gif" width=9 height=24 alt=""></td>
					<td><span id="ae_tbar#ae_num#" 
						onmouseover="ae_m_over(window.event.srcElement);"
						onmousedown="ae_m_down(window.event.srcElement);"
						onmouseup="ae_m_up(window.event.srcElement);"
						onmouseout="ae_m_out(window.event.srcElement);"
						ondragstart="window.event.returnValue=false;"
						onselectstart="window.event.returnValue=false;"
						><nobr><cfloop index="btn" list=#attributes.toolbar#><cfif btn eq "|"><cfset brn=Trim(btn)><img 
							src="#attributes.inc#images/space.gif" class="spc" alt="" /><wbr /><cfelseif btn eq "||"><br><cfelseif btn eq "quickstyles"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" alt="" style="vertical-align:middle;">
							<select size="1" id="oQuickStyle#ae_num#" style="width:120px;font:8pt Verdana;vertical-align:middle;" onchange="ae_quickstyle(#ae_num#);">
							<option name="none" value="none">Select Style</option>
							<cfloop from="1" to="#ListLen(attributes.quickstyles)#" index="stylename"><option name="#Trim(ListGetAt(attributes.quickstyles, stylename))#" value="#Trim(ListGetAt(attributes.quickstyles, stylename))#"><cfif Len(attributes.quickstyleNames)>#ListGetAt(attributes.quickstyleNames, stylename)#<cfelse>#ListGetAt(attributes.quickstyles, stylename)#</option></cfif>
							</cfloop><option name="ae_removeStyle" value="ae_removeStyle">Remove Style</option>
							</select>
<!--- build quickfont drop-down list --->
							<cfelseif btn eq "quickfont"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="oQuickFont#ae_num#" style="width:120px;font:8pt Verdana;vertical-align:middle;" onchange="ae_quickfont(#ae_num#);">
							<cfloop index="fontname" list="#attributes.quickfonts#"><option name="#fontname#" value="#fontname#">#fontname#
							</cfloop>
							</select>
<!--- build quickfontcolors drop-down list --->
							<cfelseif btn eq "quickfontcolors"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="oQuickFontColors#ae_num#" style="width:120px;font:8pt Verdana;vertical-align:middle;" onchange="ae_quickFontColor(#ae_num#);">
							<option name="Quick Font Colors" value="Quick Font Colors">Text Colors</option>
							<cfloop index="fontcolor" list="#attributes.quickfontcolors#"><option name="#fontcolor#" value="#fontcolor#">#fontcolor#</option>
							</cfloop>
							</select>
<!--- build quickformat drop-down list. Populated in editjs initialization functions --->
							<cfelseif btn eq "quickformat"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="oQuickFormat#ae_num#" style="width:120px;font:8pt Verdana;vertical-align:middle;" onchange="ae_quickformat(#ae_num#);">
							</select>
							<cfelseif btn eq "quickfontsize"><img src="#attributes.inc#images/spacer.gif" width="1" height="24" style="vertical-align:middle;" alt="" />
							<select size="1" id="oQuickFontSize#ae_num#" style="width:40px;font:8pt Verdana;vertical-align:middle;" onchange="ae_quickfontsize(#ae_num#);">
								<option name="ae_fs1" value=1>8</option>
								<option name="ae_fs2" value=2>10</option>
								<option name="ae_fs3" value=3>12</option>
								<option name="ae_fs4" value=4>14</option>
								<option name="ae_fs5" value=5>18</option>
								<option name="ae_fs6" value=6>24</option>
								<option name="ae_fs7" value=7>36</option>
							</select>
							<cfelseif StructKeyExists(ae_stockbtns, btn) AND Len(ae_stockbtns[btn])><img alt="#ListGetAt(ae_stockbtns[btn], 2)#"
							status="#ListGetAt(ae_stockbtns[btn], 3)#"
							onclick="ae_onCommand(null, #ae_num#)"
							src="#attributes.inc##ListGetAt(ae_stockbtns[btn], 4)#"
							type="btn" class="flat" cid="#ListGetAt(ae_stockbtns[btn], 1)#"<cfif btn eq "table">
							onDragStart="return false"
							onmouseover="ae_m_over(ae_tdrop#ae_num#);"
							onmouseout="ae_m_out(ae_tdrop#ae_num#);"
							name="ae_tbtn#ae_num#" /><img alt="Quick Table"
							onclick="onTable(#ae_num#)"
							onDragStart="return false"
							onmouseover="ae_m_over(ae_tbtn#ae_num#);"
							onmouseout="ae_m_out(ae_tbtn#ae_num#);"
							name="ae_tdrop#ae_num#"
							status="Insert a table"
							src="#attributes.inc#images/tbdown.gif"
							type="btn" class="flat" style="width:9;" 
							cid="5022"</cfif> /><cfelse><cfset caption="Custom Button"><cfif IsDefined("attributes.customCaptions.#btn#")><cfset caption = attributes.customCaptions["#btn#"]></cfif> <img 
							alt="#caption#"	status="#caption#"
							onclick="ae_customExec('#btn#', #ae_num#)"
							src="#attributes.inc#images/custom/#btn#.gif"
							type="btn" class="flat" /></cfif></cfloop></nobr><br /><img src="#attributes.inc#images/spacer.gif" width=1 height=1 alt="" /></td>
					</tr>
					</table>
</cfoutput>
				</td>
				<td class="ae_tdClass">&nbsp;</td>
			</tr>
			<tr class="ae_trClass">		
				<td class="ae_tdClass">&nbsp;</td>
				<td class="ae_tdClass" width="100%" height="100%">
<!--- output the safe for scripting dHTML editing object --->
					<cfoutput>
					<script language="javascript">
						document.write("<object style=\"z-index:1;\" classid=\"clsid:2D360201-FFF5-11d1-8D03-00A0C959BC0A\" width=\"100%\" height=\"100%\" id=\"DHTMLSafe#ae_num#\" title=\"ActivEdit\"<cfif attributes.tabindex> tabindex=\"#attributes.tabindex#\"</cfif>>");
						document.write("<param name=\"ScrollbarAppearance\" value=\"0\">");
						document.write("</object>");
					</script>
					</cfoutput>					
<!--- initialize control --->
						<cfif Len(thisTag.generatedContent)>
							<cfset content = thisTag.GeneratedContent>
							<cfset content=HTMLEditFormat(content)>
							<cfset thisTag.generatedContent = " ">
						<cfelse>
							<cfset content = " ">
							<cfset thisTag.generatedContent = " ">
						</cfif>
				<cfoutput>
					<script LANGUAGE="javascript" FOR="DHTMLSafe#ae_num#" EVENT="ShowContextMenu">
						return ShowMenu(#ae_num#);
					</script>
					<script LANGUAGE="javascript" FOR="DHTMLSafe#ae_num#" EVENT="onkeypress">
						return ae_onkeypress(#ae_num#);
					</script>
					<script LANGUAGE="javascript" FOR="DHTMLSafe#ae_num#" EVENT="onmousedown">
						return ae_onmousedown(#ae_num#);
					</script>
					<script LANGUAGE="javascript" FOR="DHTMLSafe#ae_num#" EVENT="onclick">
						return ae_onclick(#ae_num#);
					</script>
					<script LANGUAGE="javascript" FOR="DHTMLSafe#ae_num#" EVENT="onbeforepaste">
						//return ae_onbeforepaste(#ae_num#);
					</script>
					<script LANGUAGE="javascript" FOR="DHTMLSafe#ae_num#" EVENT="DisplayChanged">
						return ae_ondisplaychange(#ae_num#);
					</script>
					<script LANGUAGE="javascript" FOR="DHTMLSafe#ae_num#" EVENT="ContextMenuAction(itemIndex)">
						return ae_onmenuaction(itemIndex);
					</script>
				</cfoutput>
				</td>
				<td class="ae_tdClass">&nbsp;</td>
			</tr>
			<tr class="ae_trClass">
				<td colspan="3" class="ae_tdClass">
					<table cellspacing=0 cellpadding=0 border=0 width="100%">
						<tr>
						<cfoutput>
							<td><img src="#attributes.inc#images/spacer.gif" alt=""
								width="20" height="1" /><cfif attributes.tabview><img 
								src="#attributes.inc#images/normaltabon.gif" 
								width="49" height="11" border="0" 
								alt="Visual Edit Mode" name="normaltab#ae_num#"
								onclick="ae_editsourceinline(#ae_num#, false)" /><img 
								src="#attributes.inc#images/htmltaboff.gif" 
								width="41" height="11" border="0" 
								alt="HTML Edit Mode" name="htmltab#ae_num#"
								onclick="ae_editsourceinline(#ae_num#, true)" /></cfif></td>				
				<td align="right">
				<a href="javascript:ae_about()" style="text-decoration:none;color:gray;"><span style="font-family:Arial;font-size:10px;"><cfif NOT IsDefined("attributes.removecopyright")>ActivEdit 4.0 &copy; 1999-2004</cfif>&nbsp;</span></a>
				</td>
				</cfoutput>
						</tr>					
					</table>
				</td>				
			</tr>
		</table> 
<!--- embed hidden objects continue initializing --->
<cfoutput>					
	<textarea style="position:absolute; visibility:hidden;" id="ae_tx_content#ae_num#" name="#attributes.name#">#content#</textarea>
	<script>ae_initialize(#ae_num#);</script>
</cfoutput>	
<!--- debugging output ---><cfif attributes.debug></cfif>
<!--- Continue displaying if editjs.cfm crashed --->
		<script>
			//</comment>
		</script>

<!--- APPLET MODE --->
<cfelseif applet>
	<!--- applet only --->
	<cfparam name="attributes.showmenu" default="0" type="boolean">
	<cfparam name="attributes.appletlicense" default="0">
	<cfoutput>
	
	<cfif ae_num eq 1>
		<script language="JavaScript" src="#attributes.inc#spellchecker/appletspell.js"></script>
		<script language="JavaScript" src="#attributes.inc#applet/applet.js"></script>
	</cfif>
	<script>
		aeNames[#ae_num#] = "#attributes.name#";
		frmLoaded[#ae_num#] = false;
	
	<cfif ISIE>
		document.write("<object classid=\"clsid:8AD9C840-044E-11D1-B3E9-00805F499D93\" width=\"#attributes.width#\" height=\"#attributes.height#\"  codebase=\"http://java.sun.com/products/plugin/autodl/jinstall-1_4_0-win.cab##version=1,4,0,0\" id=\"aeApplet#ae_num#\" name=\"aeApplet#ae_num#\" title=\"ActivEdit\">");
	<cfelse>
		document.write("<applet width=\"#attributes.width#\" height=\"#attributes.height#\"  code=\"activedit.ActivEditApplet\" title=\"ActivEdit\" ");
		document.write("		archive=\"aeApplet.jar\"");
		document.write("		codebase=\"#attributes.inc#applet/\" ");
		document.write("		mayscript=\"true\" scriptable=\"true\" id=\"aeApplet#ae_num#\" name=\"aeApplet#ae_num#\">");
	</cfif>
		document.write("<param name=\"MAYSCRIPT\" value=\"true\">");
		document.write("<param name=\"scriptable\" value=\"true\">");
		document.write("<param name=\"CODE\" value=\"activedit.ActivEditApplet\">");
		document.write("<param name=\"CODEBASE\" value=\"#attributes.inc#applet/\"> ");
		document.write("<param name=\"ARCHIVE\" value=\"aeApplet.jar\">");
		document.write("<param name=\"type\" value=\"application/x-java-applet;jpi-version=1.3\">");
		document.write("<param name=\"instance\" value=\"#ae_num#\">");
		document.write("<param name=\"formname\" value=\"TopStuff\">");
		document.write("<param name=\"images\" value=\"#attributes.image#\">");
		document.write("<param name=\"fileuploadaction\" value=\"uploadFileAction\">");
		document.write("<param name=\"showhtml\" value=\"#attributes.tabview#\">");
		document.write("<param name=\"baseurl\" value=\"#attributes.baseurl#\">");
		document.write("<param name=\"showmenu\" value=\"#attributes.showmenu#\">");
		document.write("<param name=\"toolbars\" value=\"#attributes.toolbar#\">");
		document.write("<param name=\"license\" value=\"#attributes.appletlicense#\">");
		document.write("<param name=\"stylesheet\" value=\"#JSStringFormat(attributes.stylesheet)#\">");
	<cfif ISIE>
		document.write("</object>");
	<cfelse>
		document.write("</applet>");
	</cfif>
	</script>
	
	<cfif Len(thisTag.generatedContent)>
		<cfset content = thisTag.GeneratedContent>
		<cfset content=HTMLEditFormat(content)>
		<cfset thisTag.generatedContent = " ">
	<cfelse>
		<cfset content = " ">
		<cfset thisTag.generatedContent = " ">
	</cfif>
	
	<textarea name="#attributes.name#" id="ae_tx_content#ae_num#" style="position:absolute; visibility:hidden;">#content#</textarea>
	<script>txtLoad(#ae_num#);</script>
	</cfoutput>
<cfelse>
<!--- Degrade to textarea --->
	<cfif Len(thisTag.generatedContent) AND attributes.type is "form">
		<cfset content = thisTag.GeneratedContent>
		<cfset thisTag.generatedContent = " ">
	<cfelse>
		<cfset content = " ">
		<cfset thisTag.generatedContent = " ">
	</cfif>
	<cfparam name="attributes.buttoncolor" default="silver">
	<cfoutput><table border="0" cellpadding="0" cellspacing="0" bgcolor="#attributes.buttoncolor#">
	<tr>
		<td height="20"><img src="#attributes.inc#/images/space.gif" border="0" alt="" align="absmiddle" />&nbsp;<a href="javascript:alert('You are using an unsupported browser.\n You should use Internet Explorer, or a browser that works with the Java 2 Plugin (such as netscape 6.2 and up) and up to get all the functionality.')"><img src="#attributes.inc#/images/help.gif" border="0" alt="Info" align="absmiddle" /></a></td>
	</tr>
	<tr><td>

	<cfif Find("%",attributes.width)><cfset attributes.width=100></cfif>
	<cfif Find("%",attributes.height)><cfset attributes.height=100></cfif>

	<cfif NOT IsDefined("attributes.cols")>
		<CFIF IsDefined("attributes.width")>
			<cfset attributes.cols="#Fix(Evaluate(attributes.width/8))#">
		<CFELSE>
			<cfset attributes.cols=100>
		</CFIF>
	</cfif>
	<cfif NOT IsDefined("attributes.rows")>
		<CFIF IsDefined("attributes.height")>
			<cfset attributes.rows="#Fix(Evaluate(attributes.height/13))#">
		<CFELSE>
			<cfset attributes.rows=18>
		</CFIF>
	</cfif>
		<textarea name="#attributes.name#" COLS="#attributes.cols#" ROWS="#attributes.rows#">#content#</textarea>
	</td></tr>
	</table>
	</cfoutput>

</cfif><!--- end if applet/dhtml type --->
<cfelseif NOT thisTag.HasEndTag>
<cfoutput>
	<ul>
	<li><span style="font: 10pt Arial">Error: Missing &lt;/cf_activedit&gt; tag.</span> </li>
	</ul>
</cfoutput>
<!-- end cf_activedit v:4.0 (4.0.0.43 01/15/2004) -->
</cfif><!--- end if thisTag.executionMode = end --->

<cfsetting enablecfoutputonly="No">
