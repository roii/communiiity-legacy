<cfcontent type="application/x-javascript">

<cftry>
<CFSETTING SHOWDEBUGOUTPUT="No">

<cfparam name="url.key" default="">
<cflock scope="SERVER" type="EXCLUSIVE" timeout="30">
	<cfif NOT StructDelete(server.ae_accesslist, url.key, "True")>
		//<script>
		alert("Incorrect key passed to editjs.cfm");
		//</script>
		<cfabort>
	</cfif>
</cflock>

//no<script>
/************************************************
 * CFDEV.COM Activedit Java Script Functions 
 *
 * Authors: Pete Freitag, Matt Finn, Greg Alton
 * URL: 	http://www.cfdev.com
 * Email: 	support@cfdev.com
 * Current 	Version: 4.0
 *
 * Notes:
 *	 Modification of source requires an open source license
 *   Reverse Engineering of this code is prohibited
 *	 All Rights Reserved Copyright 1999-2002 CFDEV.COM, ActivSoftware Inc.
 ************************************************/

////////////////////////////
//    global variables    //
////////////////////////////

//debugging parameter
errlevel = 0;

var ae_olddocmd; //saves the old ondocument click function pointer 

aeObjects = new Array(); //needs to be global for spell checker
var aeFieldnames = new Array();
var DHTMLSafe; // This is the active editor
var ae_count;
var ae_hot; //This tells which Activedit the context menu is for
var ae_sourceview=false; //Are we viewing source?
var ae_oldfontfamily=''; //Store the old font family for inline view source 
var ae_oldfontsize=''; //Store the old font size for inline view source
var ae_HTMLMode = new Array(); //true if current control is in html mode

var tableparamobj=new ActiveXObject("DEInsertTableParam.DEInsertTableParam");
tableparamobj.NumRows=3;
tableparamobj.NumCols=3;   
tableparamobj.Caption="";
tableparamobj.TableAttrs="border=0 cellpadding=0 cellspacing=0 width=75%";
tableparamobj.CellAttrs="";

var is_ie4 = ((parseInt(navigator.appVersion)  == 4) && (navigator.userAgent.toLowerCase().indexOf("msie 5")==-1) && (navigator.userAgent.toLowerCase().indexOf("msie 6")==-1) );

////////////////////////////
//initialization function //
////////////////////////////

function ae_initialize(num) {
	//initializes the control
	ae_count=num;
	thisContentItem=eval("document.all.ae_tx_content"+num);
	thisForm=thisContentItem;
	while(thisForm.tagName!="FORM"&&thisForm.tagName!="HTML") {
		thisForm=thisForm.parentElement; 
	}
	if(thisForm.tagName!="HTML") {		
		DHTMLSafe = eval("thisForm.DHTMLSafe"+num);
		aeObjects[num] = DHTMLSafe;
		aeObjects[thisContentItem.name] = DHTMLSafe;
		aeFieldnames[num] = thisContentItem.name;		
		//bind onSubmit event to ae_onSubmit()
		thisForm.onsubmit = ae_onSubmit;
	}
	else {
		alert("Activedit must be contained in a form.", "", true);
		return;
	}
	DHTMLSafe.NewDocument();
	DHTMLSafe.BaseURL=ae_baseurl[num];
 	set_tbstates(num);
	ae_onLoad(num);
	ae_HTMLMode[num] = false;
}

function ae_onLoad(num) {
	DHTMLSafe=aeObjects[num];
	if(DHTMLSafe.Busy) {
		setTimeout("ae_onLoad("+num+");", 100);	
		return;
	}
	if(num==1) window.onunload = ae_onUnload;
	
	if(ae_defaultfont[num].length) 
		DHTMLSafe.DOM.body.style.font=ae_defaultfont[num];
		
	if(ae_stylesheet[num].length)
		DHTMLSafe.DOM.createStyleSheet(ae_stylesheet[num]);

	if(oSel=eval('document.all.oQuickFormat'+num)) { //Populate QuickFormat Box
		var f=new ActiveXObject("DEGetBlockFmtNamesParam.DEGetBlockFmtNamesParam");
	    DHTMLSafe.ExecCommand(DECMD_GETBLOCKFMTNAMES,OLECMDEXECOPT_DODEFAULT,f);
		vbarr = new VBArray(f.Names);
		arr = vbarr.toArray();
		/* Load options from arr where block format names are stored and insert the values
		into the name property of oQuickFormat options. An e in quickformatNameArray excludes
		the formatting element. The value in quickformatNameArray is used in the text
		property of oQuickFormat options. 
		*/
		for (var i=0;i<arr.length;i++) {
			if (quickformatNameArray[num][i] != "e") {
				oOption = document.createElement("OPTION");
				oSel.options.add(oOption);
				oOption.text=quickformatNameArray[num][i];
				oOption.name=arr[i];
			}
		}
	}
	thisContentItem=eval("document.all.ae_tx_content"+num);
	if(thisContentItem.value.length)
		aeObjects[num].DOM.body.innerHTML = thisContentItem.value;	
	else
		aeObjects[num].DOM.body.innerHTML = " ";

	set_tbstates(num);
	if(typeof(aeapi_local_onLoad)=='function')
		aeapi_local_onLoad(DHTMLSafe, aeFieldnames[num]);
	if (typeof(aeapi_onLoad)=='function')
		aeapi_onLoad(DHTMLSafe, aeFieldnames[num]);
}

function ae_onUnload() {
	var ae_content = "";
	var i;	
	for(i=1;i<=ae_count;i++) {
		DHTMLSafe=aeObjects[i];
		thisContentItem = eval("document.all.ae_tx_content"+i);
		if(ae_sourceview) ae_editsourceinline(i,false);
		var content = DHTMLSafe.DOM.body.innerHTML;
		thisContentItem.value = content;
	}
}
////////////////////////////
//   event listeners      //
////////////////////////////

function ae_onSubmit() {
	var ae_content = "";
	var i;
	for(i=1;i<=ae_count;i++) {
		DHTMLSafe=aeObjects[i];
		if(ae_HTMLMode[i]) ae_editsourceinline(i,false);
		thisContentItem = eval("document.all.ae_tx_content"+i);

		if(typeof(aeapi_local_onBeforeSave)=='function')
			ae_content = aeapi_local_onBeforeSave(DHTMLSafe, aeFieldnames[i]);
			
			/* This makes it possible to return false to onSubmit when content is 
			set to false in the aeapi_local_onBeforeSave() event listener. Form validation
			would be placed in aeapi_local_onBeforeSave() and onSubmit(return(ae_onSubmit));
			placed in the form heading.
			*/
			//if (ae_content == false) {
			//return false;
			//}
		else if (typeof(aeapi_onBeforeSave)=='function')
			ae_content = aeapi_onBeforeSave(DHTMLSafe, aeFieldnames[i]);
		else
			ae_content = ae_onBeforeSave(DHTMLSafe, aeFieldnames[i]);
		thisContentItem.value = ae_content;
	}
	return true;
}


function ae_onkeypress(num) {
	var sel;
	DHTMLSafe=aeObjects[num];
	if(ae_breakonenter[num]||ae_sourceview) {
		//make enter insert <br> and ctrl+enter insert <p>
		switch(DHTMLSafe.DOM.parentWindow.event.keyCode) {
			case 10:
				DHTMLSafe.DOM.parentWindow.event.keyCode = 13;			
				break;
			case 13:
				if(DHTMLSafe.QueryStatus(DECMD_UNORDERLIST)!=DECMDF_LATCHED) {
					DHTMLSafe.DOM.parentWindow.event.returnValue = false;		
					sel = DHTMLSafe.DOM.selection.createRange();
					sel.pasteHTML("<BR>");
					sel.collapse(false);
					sel.select();
				}
				break;
			default:
				break;
		}
	}
}


// cancels the table selector when you click on DHTMLSafe
function ae_onmousedown(num) {
	if(typeof(document.all.frame1) != "undefined") {
		if(document.all.frame1.style.visibility == "visible") {
			closePopupFrame(false);
			return;
		}
	}
}

function ae_onclick(num) {
	set_tbstates(num);
}

function ae_ondisplaychange(num) {
 	set_tbstates(num);
}

function ae_onmenuaction(itemIndex, num) {
	ae_onCommand(ContextMenu[itemIndex].cmdId, num);
}

////////////////////////////
//    member functions    //
////////////////////////////

function ae_onCommand(cmdId, num) {
	
	if(typeof(num)=="undefined") {
		num=ae_hot;
	}
	DHTMLSafe=aeObjects[num];
	if(cmdId==null) cmdid=eval(window.event.srcElement.cid);
	else cmdid=cmdId;

	doFocus=true;	
	cmdid = parseInt(cmdid);
	//only find and replace should work in html mode
	if (ae_HTMLMode[num]) { if (cmdid != DECMD_REPLACE && cmdid != DECMD_FIND) return; }
		
	switch(cmdid) {
		case DECMD_IMAGE:
			oSel = DHTMLSafe.DOM.selection;
			if (oSel.type == "Control") {
				ae_imageProperties(num);
			}
			else {
				//DHTMLSafe.DOM.selection.createRange().collapse(false);
				onImagewin(num);
			}
			doFocus=false;
			break;
		case DECMD_INSERTTABLE:
			onTableWin(num);
			doFocus=false;
			break;
		case DECMD_EDITSOURCE:
			if(tabview[num]) ae_editsourceinline(num);
			else { 
				ae_editsource(num);
				doFocus=false;
			}
			break;
		case DECMD_ABOUT:
			ae_about();
			doFocus=false;
			break;
		case DECMD_HELP:
			ae_help();
			doFocus=false;
			break;
		case DECMD_TOGGLE_DETAILS:
			ae_onToggleDetails(null, num);
			break;
		case DECMD_EDITTABLE:
			editTableWin(num);
			doFocus=false;
			break;
		case DECMD_HYPERLINK:
			ae_hyperlinkwin(num);
			doFocus=false;
			break;
		case DECMD_SPELLCHECK:
			ae_spellcheckwin(num);
			doFocus=false;
			break;
		case DECMD_SPECIAL_CHARS:
			ae_specialchars(num);
			doFocus=false;
			break;
		case DECMD_IMAGE_PROPERTIES:
			oSel = DHTMLSafe.DOM.selection.createRange();
			for (i=0; i<oSel.length; i++) {
				if (oSel(i).tagName == "IMG") {
					//alert(oSel(i).src);
					ae_imageProperties(num);
					doFocus=false;
				}
   			}
			break;
		case DECMD_PASTE:
   			ae_onPaste(num);
   			doFocus=false;
   			break;
		case DECMD_HR:
			ae_onHr(num);
			doFocus=false;
			break;
		case DECMD_STRIKE:
			ae_wrapTag(num,"STRIKE");
			doFocus=false;
			break;
		case DECMD_SUBSCRIPT:
			ae_wrapTag(num,"SUB");
			doFocus=false;
			break;
		case DECMD_SUPERSCRIPT:
			ae_wrapTag(num,"SUP");
			doFocus=false;
			break;
		case DECMD_HIGHLIGHT:
			ae_highLight(num);
			doFocus=false;
			break;
		case DECMD_REMOVEFORMAT:
			ae_removeFormat(num);
			doFocus=false;
			break;
		case DECMD_REPLACE:
			ae_replaceWindow(num);
			doFocus=false;
			break;
		default:
			if(DHTMLSafe.QueryStatus(cmdid)!=DECMDF_DISABLED) {
				DHTMLSafe.ExecCommand(cmdid, OLECMDEXECOPT_DODEFAULT);
			}
			break;
	}
	if (doFocus) {
		DHTMLSafe.focus();
		DHTMLSafe.DOM.body.focus();
	}
}

function ae_customExec(btnName, num) {
	//custom button api
	if (typeof(eval("aeapi_custom_"+btnName)) != "function") {
		alert("Custom API Function: aeapi_custom_" + btnName + "(aeNum)\nIs not accessable, or defined correctly.\nPlease refer to the documentation.");
		return;		
	}
	aeObject = aeObjects[num];
	eval("aeapi_custom_" + btnName + "(" + num + ")");
}

function ae_onHr(num) {
	DHTMLSafe=aeObjects[num];
	DHTMLSafe.focus();
	if (typeof(ae_hrwin) == "undefined" || ae_hrwin.closed) { //short circuit eval
		//spawn image properties window
		var szURL=inc + "hr.htm?instance=" + num;
		ae_hrwin = window.open(szURL ,"ae_hrwin","scrollbars=no,width=350,height=205, resizable=no");
 	}
 	ae_hrwin.focus();
}

function ae_wrapTag(num,tag) {
	DHTMLSafe = aeObjects[num];
	var textRange=DHTMLSafe.DOM.selection.createRange();
	var parent = textRange.parentElement();
	var outermostElement = null;
	selectionInnerText = textRange.text;
	//search for any strikes that are parent of this.
	
	while (true) {
		if (parent.tagName == tag) {
			//remove the strike
			parent.removeNode(false);
			return;
		}		
		if (parent.innerText == selectionInnerText) {
			outermostElement = parent;
		}
		else { break; }
		if (parent.tagName == "BODY") {
			break;
		}
		parent = parent.parentElement;
	}
	if (textRange.text.length > 0) {
		if (outermostElement != null) {
			outermostElement.innerHTML = "<" + tag + ">" + outermostElement.innerHTML + "</" + tag + ">";
		}	
		else {
			textRange.pasteHTML("<" + tag + ">" + textRange.htmlText + "</" + tag + ">");
		}
	}
}

function ae_highLight(num) {
	DHTMLSafe = aeObjects[num];
	var textRange=DHTMLSafe.DOM.selection.createRange();
	var parent = textRange.parentElement();
	var outermostElement = null;
	selectionInnerText = textRange.text;
	while (true) {
		if (parent.tagName == "SPAN" && parent.style.backgroundColor == "yellow") {
			//remove the strike
			parent.style.backgroundColor = "";
			if (parent.style.cssText == "" && parent.className == "") {
				parent.removeNode(false);//delete it empty
			}
			return;
		}		
		if (parent.innerText == selectionInnerText) {
			outermostElement = parent;
		}
		else { break; }
		if (parent.tagName == "BODY") {
			break;
		}
		parent = parent.parentElement;
	}
	if (textRange.text.length > 0) {
		if (outermostElement != null) {
			outermostElement.innerHTML = "<span style=\"background-color:yellow;\">" + outermostElement.innerHTML + "</span>";
		}	
		else {
			textRange.pasteHTML("<span style=\"background-color:yellow;\">" + textRange.htmlText + "</span>");
		}
	}
	removeExtraniousSpans(DHTMLSafe, DHTMLSafe.DOM.body, null);
}

function ae_imageProperties(num) {
	DHTMLSafe=aeObjects[num];
	DHTMLSafe.focus();
	if (typeof(ae_imgpropwin) == "undefined" || ae_imgpropwin.closed) { //short circuit eval
		//spawn image properties window
		var szURL=inc + "imageProperties.htm?instance=" + num;
		ae_imgpropwin = window.open(szURL ,"ae_imgpropwin","scrollbars=no,width=370,height=305, resizable=no");
 	}
 	ae_imgpropwin.focus();
}

function ae_onPaste(num) {
	DHTMLSafe=aeObjects[num];
	window.event.returnValue = true;
	var tr = DHTMLSafe.DOM.selection.createRange();
	tr.execCommand("Paste");
	replaceFontsWithSpans(DHTMLSafe, DHTMLSafe.DOM.body, null);
	condenseSpans(DHTMLSafe, DHTMLSafe.DOM.body, null);
	ae_cleanWord(DHTMLSafe);	
}



function ae_onToggleDetails(bVal, num) {
	//Show hidden Tags as glyphs
	DHTMLSafe=aeObjects[num];
	if (bVal == null) {
		DHTMLSafe.ShowDetails = !(DHTMLSafe.ShowDetails);
	}
	else {
		DHTMLSafe.ShowDetails = bVal;
	}
}

function editTableWin(num) {
	editTbl = window.open(inc + 'edittable.htm', "editTbl", "directories=no,height=310,width=350,location=no,menubar=no,status=no,toolbar=no");
	editTbl.focus();
}

function onTableWin(num) {	
	DHTMLSafe=aeObjects[num];
		if(DHTMLSafe.QueryStatus(DECMD_INSERTTABLE) == DECMDF_DISABLED) 
		{
		   	DHTMLSafe.focus();
		   	DHTMLSafe.DOM.body.focus();
		 	return;
		}	
		ae_hot = num;
		arr = window.open(inc + "table.htm", "arr", "Width=450, Height=230");
		arr.focus();
}

//dropdown table selector
function onTable(num) {
  	//open's table dialog window
	 //if it's in a table

    //no buttons should work in html mode
	if (ae_HTMLMode[num]) { return; }
	DHTMLSafe=aeObjects[num];
	if(DHTMLSafe.QueryStatus(DECMD_INSERTTABLE) == DECMDF_DISABLED) 
	{
	   	DHTMLSafe.focus();
	   	DHTMLSafe.DOM.body.focus();
  		return;
	}
	if(	document.all.frame1.style.visibility == "visible" ) {
		closePopupFrame();
		return;
	}
	
	var str = "<div id=\"tblsel\" style=\"background-color:blue;position:absolute;";
	str = str + "width:0;height:0;z-index:-1;\"></div>";
	str = str + makeTable(4, 5);
	str = str + "<div style=\"text-align:center\" id=\"tblstat\">1 by 1 Table</div>";
	
	var obj=eval("document.all.ae_tbtn"+num);
	createPopupFrame(obj, str);
	ae_hot=num;
	document.frames("frame1").document.body.onmouseover = paintTable;	
	document.frames("frame1").document.body.onclick = insertTable;
}

/* creates the popup iframe used for quick table, and quick font color */
function createPopupFrame(btnObject, htmlSrc)
{
	var ifrm = document.frames("frame1");
	var obj= btnObject;
	var x=0;
	var y=0;
	ifrm.document.body.innerHTML=htmlSrc;
	while(obj.tagName!="BODY") {
		x+=obj.offsetLeft;
		y+=obj.offsetTop;
		obj=obj.offsetParent;
	}	
	document.all.frame1.style.pixelTop = y + 24;
	document.all.frame1.style.pixelLeft = x;
	document.all.frame1.style.pixelWidth = 0;
	document.all.frame1.style.pixelHeight = 0;
	document.all.frame1.style.visibility = "visible";
	//bind events
	if(typeof(document.onmousedown)=="function")
		ae_olddocmd = document.onmousedown;
	else ae_olddoccmd=null;
	
	document.onmousedown = closePopupFrame;
	DHTMLSafe.onmousedown = closePopupFrame;
	event.cancelBubble = true;
	ifrm.document.body.onselectstart=new Function("return false;");
	document.all.frame1.style.pixelWidth = ifrm.document.all.oTable.offsetWidth + 3
	document.all.frame1.style.pixelHeight = ifrm.document.all.oTable.offsetHeight + 3;
}

// Does the insert table for table selector
function insertTable(rows, cols, attrs, num) {
	//drop down table implementation
	if(typeof(num)=="undefined") num=ae_hot;
	DHTMLSafe=aeObjects[num];
	if (typeof(rows) == "undefined") {
		var se = document.frames('frame1').window.event.srcElement;
		if(se.tagName!='TD') {
			closePopupFrame();
			return;
		}
		tableparamobj.NumRows = se.parentElement.rowIndex + 1;
		tableparamobj.NumCols = se.cellIndex + 1;
	  	tableparamobj.TableAttrs = "border=1 cellPadding=0 cellSpacing=0 width=75%";
		closePopupFrame();
	}
	else {
		tableparamobj.NumRows = rows;
		tableparamobj.NumCols = cols;
		tableparamobj.TableAttrs = attrs;
	}
	DHTMLSafe.ExecCommand(DECMD_INSERTTABLE,OLECMDEXECOPT_DODEFAULT, tableparamobj);    
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();
}

//Paints the table selector
function paintTable() {
	var se = document.frames('frame1').window.event.srcElement;
	var sr, sc, tbl, fAll;
	fAll = document.frames('frame1').document.all;
	if(se.tagName!='TD') {
		sr = 0;
		sc = 0;
		var str="&nbsp;Cancel";
		fAll.tblsel.style.width = 0;
		fAll.tblsel.style.height = 0;
		return;
	}
	tbl=fAll.oTable;
	sr=se.parentElement.rowIndex;
	sc=se.cellIndex;
	//Expand the table selector if its too small
	if(!is_ie4) {
		if(tbl.rows.length == sr+1) {
			var r = tbl.insertRow(-1);
			var td;
			for(var i=0;i<tbl.rows(1).cells.length;i++) {
				td = r.insertCell(-1);
				td.innerHTML = "&nbsp;";
				td.style.pixelWidth = 20;
				td.style.pixelHeight = 20;
	
			}
				var bdy = document.frames("frame1").document.body;			
				var ifrm = document.frames("frame1");
				document.all.frame1.style.pixelWidth = ifrm.document.all.oTable.offsetWidth + 3
				document.all.frame1.style.pixelHeight = ifrm.document.all.oTable.offsetHeight + 3 +
				ifrm.document.all.tblstat.offsetHeight;
		}
		if(tbl.rows(1).cells.length == sc+1) {
			var td;
			for(var i=0;i<tbl.rows.length;i++) {
				td = tbl.rows(i).insertCell(-1);
				td.innerHTML = "&nbsp;";
				td.style.pixelWidth = 20;
				td.style.pixelHeight = 20;
			}			
				var bdy = document.frames("frame1").document.body;
				document.all.frame1.style.pixelWidth = bdy.createTextRange().boundingWidth + 5;
				document.all.frame1.style.pixelHeight = bdy.createTextRange().boundingHeight + 5;
		}
	}
	var str=(sr+1) + " by " + (sc+1) + " Table";
	fAll.tblsel.style.width = se.offsetWidth*(sc+1)+5;
	fAll.tblsel.style.height = se.offsetHeight*(sr+1)+5;
	fAll.tblstat.innerHTML = str;
}

//makes table html
function makeTable(rows, cols) {
	var a, b, str, n;
	str = "<table style=\"table-layout:fixed;border-style:solid; cursor:default;\" "; 
	str = str + "id=\"oTable\" cellpadding=\"0\" ";
	str = str + "cellspacing=\"0\" cols=" + cols;
	str = str + " border=6>\n";
	for (a=0;a<rows;a++) {
		str = str + "<tr>\n";
		for(b=0;b<cols;b++) {			
			str = str + "<td width=\"20\">" 
			str = str + "&nbsp;</td>\n";	
		}	
		str = str + "</tr>\n";
	}
	str = str + "</table>"
	return str;
}

//Closes table selector iframe and replaces document mousedown
function closePopupFrame(a) {
	document.onmousedown=null;
	document.all.frame1.style.visibility = "hidden";
	document.all.frame1.style.pixelWidth = 0;
	document.all.frame1.style.pixelHeight = 0;

	if(a==false) return;

	if(typeof(ae_olddocmd)=="function") {
		ae_olddocmd(false);
		document.onmousedown = ae_olddocmd;
	}
	ae_olddocmd = null;
	//Set DropDownTable IFrame to small
	document.all.frame1.style.pixelWidth = 10;
	document.all.frame1.style.pixelHeight = 10;
}

function ae_replaceWindow(num) {
	DHTMLSafe=aeObjects[num];
	DHTMLSafe.focus();
	if (typeof(ae_rewin) == "undefined" || ae_rewin.closed) {
		var szURL;
		szURL=inc + "image.cfm?instance=" + num;
		szURL+="&imagedata=";
		szURL+=ae_imagedata[num];
		szURL+="&imageurl=";
		szURL+=ae_imageurl[num];
		ae_rewin = window.open(inc + "replace.htm" ,"ae_rewin","scrollbars=no,width=400,height=155, resizable=no");
	}
	ae_rewin.focus();
}

function onImagewin(num) {
	//if the focus never touched the control, you get an error, so lets touch the control
	DHTMLSafe=aeObjects[num];
	DHTMLSafe.focus();
	if (typeof(ae_imgwin) == "undefined" || ae_imgwin.closed) { //short circuit eval
		//spawn image window
		var szURL;
		szURL=inc + "image.cfm?instance=" + num;
		szURL+="&imagedata=";
		szURL+=ae_imagedata[num];
		szURL+="&imageurl=";
		szURL+=ae_imageurl[num];
		ae_imgwin = window.open(szURL ,"ae_imgwin","scrollbars=yes,width=650,height=400, resizable=yes");

	}
	ae_imgwin.focus();
}
//insert the image
function onImage(u, base_url, iborder, ialign, ialt, num) {
	DHTMLSafe=aeObjects[num];
	var img = "<img src=\"" + u + "\" border=\"" + iborder + "\" align=\"" + ialign + "\" alt=\"" + ialt + "\">";
	DHTMLSafe.DOM.selection.createRange().pasteHTML(img);
	ae_imgwin.close();
}

function ae_cleanWord(aeObject) {
		var newData = aeObject.DOM.body.innerHTML;
		newData = newData.replace(/<o:p>&nbsp;<\/o:p>/g, ""); // Remove all instances of <o:p>
		newData = newData.replace(/<o\:p><\/o\:p>/g, "");
		newData = newData.replace(/o:/g, ""); // remove all o: prefixes
		newData = newData.replace(/<st1:[^>]*>/g, ""); // remove all SmartTags (from Word XP!)
		newData = newData.replace(/<\?xml:[^>]*>/g, ""); // remove all XML(from Word XP!)
	    newData = newData.replace(/\\r/g, "<BR>");
	    newData = newData.replace(/\\n/g, "<BR>");
		newData = newData.replace(/class=MsoNormal/g, "");
		newData = newData.replace(/class=class=MsoHeader/g, "");
		newData = newData.replace(/class=MsoBodyText/g, "");
		newData = newData.replace(/style=\"mso-cellspacing.*\"/g, "cellspacing=0");
		newData = newData.replace(/mso-[^\";]*/g, "");
		aeObject.DOM.body.innerHTML = newData;
		newData = aeObject.DOM.body.innerHTML;
		newData = newData.replace(/<P><\/P>/g, "");
	    newData = newData.replace(/<P> <\/P>/g, "");
		newData = newData.replace(/<SPAN><\/SPAN>/g, "");
		newData = newData.replace(/<SPAN> <\/SPAN>/g, " ");
		aeObject.DOM.body.innerHTML = newData;
		removeExtraniousSpans(aeObject, aeObject.DOM.body, null);
}

//removes duplicate span tags, and condenses them into one

function condenseSpans(aeObject, oElement, oPrevious) {
  for(var i=0;i<oElement.childNodes.length;i++) {
  	var child = oElement.childNodes[i];
    oElement = condenseSpans(aeObject, child, oElement);
  }
  if (oElement.tagName=="SPAN" && oPrevious != null && oPrevious.tagName =="SPAN") {
	    if (oElement.innerText == oPrevious.innerText) {
			cClass=oElement.className;
			pClass=oPrevious.className;
	    	if(pClass.length && !cClass.length) {
		      oElement.setAttribute("class", pClass);
			}
			var css = oPrevious.style.cssText;
			var styleProps = css.split("; ");
			var curStyleProps = oElement.style.cssText.split("; ");
			for (var i=0;i<styleProps.length;i++) {
				var kv = styleProps[i].split(":");
				var key = kv[0];
				var value = kv[1];
				var hasProp = false;
				for (var k=0;k<curStyleProps.length;k++) {
					var ckv = curStyleProps[k].split(":");
					var cProp = ckv[0];
					var cValue = ckv[1];
					if (cProp == key) {
						hasProp = true;
						break;
					}
				}
				if (!hasProp) {
					oElement.style.cssText = oElement.style.cssText + ";" + key + ":" + value;
				}
			}
			oPrevious.removeNode(false);
			return oElement;
	    }
  }
  return oPrevious;
}

//removes duplicate span tags, and condenses them into one
function removeExtraniousSpans(aeObject, oElement, oPrevious) {
	for(var i=0;i<oElement.childNodes.length;i++) {
		removeExtraniousSpans(aeObject, oElement.childNodes[i], oElement);
	}
	if (oElement.tagName=="SPAN" && oPrevious != null && oPrevious.tagName =="P") {
		if (oElement.innerText == oPrevious.innerText) {
			cClass=oElement.className;
			pClass=oPrevious.className;
			if(cClass.length) {
				oPrevious.setAttribute("class", pClass);
			}
			var css = oPrevious.style.cssText;
			var styleProps = css.split("; ");
			var curStyleProps = oElement.style.cssText.split("; ");
			for (var i=0;i<curStyleProps.length;i++) {
				var kv = curStyleProps[i].split(":");
				var cProp = kv[0];
				var cValue = kv[1];
				var hasProp = false;
				for (var k=0;k<styleProps.length;k++) {
					var pkv = styleProps[k].split(":");
					var pProp = pkv[0];
					var pValue = pkv[1];
					if (cProp == pProp) {
						hasProp = true;
						break;
					}
				}
				if (!hasProp) {
					oPrevious.style.cssText = oPrevious.style.cssText + ";" + cProp + ":" + cValue;
				}
			}
			oElement.removeNode(false);
	    }
  }
}

function ae_onBeforeSave(aeObject) {
	//for images
	for (var i=0;i<aeObject.DOM.images.length;i++) {
		hs=aeObject.DOM.images[i].getAttribute("STYLE",0).height;
		ws=aeObject.DOM.images[i].getAttribute("STYLE",0).width;
		
		if(hs.length) {
			aeObject.DOM.images[i].removeAttribute("HEIGHT", 0); 			
			aeObject.DOM.images[i].setAttribute("HEIGHT", replaceString("px", "", hs),0); 
			aeObject.DOM.images[i].getAttribute("STYLE",0).removeAttribute("HEIGHT",0);
		}
		if(ws.length) {
			aeObject.DOM.images[i].removeAttribute("WIDTH", 0);	
			aeObject.DOM.images[i].setAttribute("WIDTH", replaceString("px", "", ws),0); 
			aeObject.DOM.images[i].getAttribute("STYLE",0).removeAttribute("WIDTH",0);
		}
	}
	//for tables
	for (var k=0;k<aeObject.DOM.all.tags("TABLE").length;k++) {
		hs=aeObject.DOM.all.tags("TABLE").item(k).getAttribute("STYLE",0).height;
		ws=aeObject.DOM.all.tags("TABLE").item(k).getAttribute("STYLE",0).width;
		if(hs.length) {
			aeObject.DOM.all.tags("TABLE").item(k).removeAttribute("HEIGHT", 0); 			
			aeObject.DOM.all.tags("TABLE").item(k).setAttribute("HEIGHT", replaceString("px", "", hs),0); 
			aeObject.DOM.all.tags("TABLE").item(k).getAttribute("STYLE",0).removeAttribute("HEIGHT",0);
		}
		if(ws.length) {
			aeObject.DOM.all.tags("TABLE").item(k).removeAttribute("WIDTH", 0);	
			aeObject.DOM.all.tags("TABLE").item(k).setAttribute("WIDTH", replaceString("px", "", ws),0); 
			aeObject.DOM.all.tags("TABLE").item(k).getAttribute("STYLE",0).removeAttribute("WIDTH",0);
		}
	}
	//use the DOM to filter out just what's inside the body
	var content = aeObject.DOM.body.innerHTML;
	if(content.length) {
		content = aeObject.FilterSourceCode(content);
	}
	//get rid of "the strange character" 
	replaceString("&#65279;", " ", content); 
	content = (ae_xhtml[num]) ? formatHTML(content) : content;
	return content;
}

function ae_submit_form(obj, field) {
	//var ae_content = "";
	var i;	
	for(i=1;i<=ae_count;i++) {	
		DHTMLSafe=aeObjects[i];
		if (typeof(aeapi_local_onBeforeSave) == "function") {
			var ae_content = aeapi_local_onBeforeSave(DHTMLSafe, aeFieldnames[num]);
		}
		else if (typeof(aeapi_onBeforeSave) == "function") {
			var ae_content = aeapi_onBeforeSave(DHTMLSafe, aeFieldnames[num]);
		}
		else {
			var ae_content = ae_onBeforeSave(DHTMLSafe, aeFieldnames[num]);
		}
		//update the form value so it gets submitted
		eval(obj).elements[element_idx].value = ae_content;
	}
	//submit the form
	eval(obj).submit();
}

function replaceString(oldS,newS,fullS) {
	// Replaces oldS with newS in the string fullS
	for (var i=0; i<fullS.length; i++) {
 		if (fullS.substring(i,i+oldS.length) == oldS) {
			fullS = fullS.substring(0,i)+newS+fullS.substring(i+oldS.length,fullS.length);
		}
	}
 	return fullS;
}
function ae_help() {
	window.showModalDialog(inc + "help.htm","","dialogHeight: 380px; dialogWidth: 350px; dialogTop: 150px; dialogLeft: 150px; center: Yes; help: No; resizable: No; status: No;");
}
function ae_about() {
	window.showModalDialog(inc + "about.htm","","dialogHeight: 260px; dialogWidth: 400px; dialogTop: 150px; dialogLeft: 150px; center: Yes; help: No; resizable: No; status: No;");
}

function ae_editsource(num) {
	DHTMLSafe=aeObjects[num];
	DHTMLSafe.DOM.selection.empty();
	codewin = window.open(inc + "editsource.htm","codewin","scrollbars=no,width=485,height=475");
}

function ae_editsourceinline(num, bVal) {
	//Toggle the inline source view
	DHTMLSafe=aeObjects[num];
	thisContentItem=eval("document.all.ae_tx_content"+num);
	if(ae_HTMLMode[num]==bVal) return;
	DHTMLSafe.DOM.selection.empty();
	if(ae_HTMLMode[num]) { //Coming out of view source
		document.images["normaltab"+num].src=img_normaltabon.src;
		document.images["htmltab"+num].src=img_htmltaboff.src;
		if(ae_defaultfont[num].length) 
			DHTMLSafe.DOM.body.style.font=ae_defaultfont[num];
		else {
			DHTMLSafe.DOM.body.style.fontFamily="";	
			DHTMLSafe.DOM.body.style.fontSize="";
		}
		//thisContentItem.value=DHTMLSafe.DOM.body.createTextRange().text;
		//DHTMLSafe.DOM.body.innerHTML = thisContentItem.value;	
		DHTMLSafe.DOM.body.innerHTML = DHTMLSafe.DOM.body.createTextRange().text
		ae_HTMLMode[num] = false;
	}
	else { //Going into view source
		var re=/((<br>)+)/ig;
		document.images["normaltab"+num].src=img_normaltaboff.src;
		document.images["htmltab"+num].src=img_htmltabon.src;
		// Set the font to fixed width
		DHTMLSafe.DOM.body.style.fontFamily = "Courier New";
		DHTMLSafe.DOM.body.style.fontSize = "10pt";
		thisContentItem.value = (ae_xhtml[num]) ? formatHTML(DHTMLSafe.DOM.body.innerHTML) : DHTMLSafe.DOM.body.innerHTML;
		thisContentItem.value = thisContentItem.value.replace(/style="[^"]+"/gi, function(w) { return w.toLowerCase() })
		DHTMLSafe.DOM.body.innerHTML = "";
		DHTMLSafe.DOM.body.createTextRange().text = thisContentItem.value.replace(re, "$1\n");
		//re = new RegExp("style=[\"']([^\"']*)[\"']", "gi");
		
		ae_HTMLMode[num] = true;
	}
}

function ae_specialchars(num) {
	var szURL = inc + "specialchars.htm?instance=" + num;
	ae_specialwin = window.open(szURL ,"ae_specialwin",",width=390,height=260, resizable=yes",true);
}

function replaceFontsWithSpans(aeObject, oElement, sNewClass) {
	for(var i=0;i<oElement.childNodes.length;i++) {
		replaceFontsWithSpans(aeObject, oElement.childNodes[i], sNewClass);
	}
	if(oElement.tagName=="FONT") {
		if(oElement.face=="ae_newclass") {
			sPreserve=oElement.innerHTML;
			oNewNode=aeObject.DOM.createElement("SPAN");
			oElement.replaceNode(oNewNode);
			oNewNode.innerHTML=sPreserve;
			oNewNode.className=sNewClass;
		}
		if(oElement.xclass!=null) {
			sPreserve=oElement.innerHTML;
			sClass=oElement.xclass;
			oNewNode=aeObject.DOM.createElement("SPAN");
			oElement.replaceNode(oNewNode);
			oNewNode.innerHTML=sPreserve;
			oNewNode.className=sClass;
		}
		else {
			var style = "";
			if (oElement.face.length) {
				style += "font-family: " + oElement.face + ";";
			}	
			if (oElement.size.length) {
				var sizeMap = new Array(7,7,9,12,14,18,24,36);
				var size = oElement.size;
				if (size > 7) size = 7;
				if (size==-1) size = 2;
				if (size==-2) size = 1;
				if (size < -2) size = 1;
				var ptsize = sizeMap[size];
				style += "font-size: " + ptsize + "pt;";
			}
			if (oElement.color.length) {
				style += "color: " + oElement.color + ";";
			}
			if (style.length) {
				sPreserve=oElement.innerHTML;
				oNewNode=aeObject.DOM.createElement("SPAN");
				oElement.replaceNode(oNewNode);
				oNewNode.innerHTML=sPreserve;
				oNewNode.style.cssText=style;
			}
		}
	}
}

function ae_quickstyle(num){
	//no buttons should work in html mode
	if (ae_HTMLMode[num]) { return; }
	DHTMLSafe=aeObjects[num];
	
	var oSel=eval('document.all.oQuickStyle'+num);
	var sClass = oSel.options[oSel.selectedIndex].name;
	var tr=DHTMLSafe.DOM.selection.createRange();
	if (sClass == "ae_removeStyle") {
		var parent = tr.parentElement();
		if (parent.tagName == "SPAN" || parent.tagName == "FONT" || parent.tagName == "B" ||
			parent.tagName == "STRONG" || parent.tagName == "I" || parent.tagName == "DIV" || parent.tagName == "EM"
			|| parent.tagName == "U") {
			tr.parentElement().removeNode(false);
		}
	}
	else {
		var sBookmark=tr.getBookmark();
		tr.moveToBookmark(sBookmark);
		tr.execCommand("FontName", false, "ae_newclass");
		replaceFontsWithSpans(DHTMLSafe, DHTMLSafe.DOM.body, sClass);
		condenseSpans(DHTMLSafe, DHTMLSafe.DOM.body, null);
	   	oSel.selectedIndex = null;
		tr.collapse();
		tr.select();
		sBookmark = "";
	}
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();
}

function ae_removeFormat(num) {
	DHTMLSafe = aeObjects[num];
	var parentElm = DHTMLSafe.DOM.selection.createRange().parentElement();
	if (parentElm.tagName == "SPAN" || parentElm.tagName == "FONT" || parentElm.tagName == "B" ||
		parentElm.tagName == "STRONG" || parentElm.tagName == "I" || parentElm.tagName == "DIV" || parentElm.tagName == "EM"
		|| parentElm.tagName == "U" || parentElm.tagName == "STRIKE" || parentElm.tagName == "SUP" || parentElm.tagName == "SUB") {
		parentElm.removeNode(false);
	}
	if (parentElm.tagName == "TD") {
		parentElm.style.cssText = "";
	}
	
}

function ae_quickfont(num) {
	if (ae_HTMLMode[num]) { return; }
	DHTMLSafe=aeObjects[num];
	oSel=eval('document.all.oQuickFont'+num);	
	DHTMLSafe.ExecCommand(DECMD_SETFONTNAME, OLECMDEXECOPT_DODEFAULT, oSel.options[oSel.selectedIndex].name);
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();
	replaceFontsWithSpans(DHTMLSafe, DHTMLSafe.DOM.body, null);
	condenseSpans(DHTMLSafe, DHTMLSafe.DOM.body, null);
}

function ae_quickFontColor(num) {
	if (ae_HTMLMode[num]) { return; }
	DHTMLSafe=aeObjects[num];
	var oSel=eval('document.all.oQuickFontColors'+num);
	var sColor = oSel.options[oSel.selectedIndex].name;
	if (oSel.selectedIndex == 0) {return;}	
	var tr=DHTMLSafe.DOM.selection.createRange();
	var sBookmark=tr.getBookmark();
	tr.moveToBookmark(sBookmark);
	tr.execCommand("FontName", false, "ae_newclass");
	setColor(DHTMLSafe, DHTMLSafe.DOM.body, sColor);
	condenseSpans(DHTMLSafe, DHTMLSafe.DOM.body, null);
	oSel.selectedIndex = null;
	tr.collapse();
	tr.select();
	sBookmark = "";
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();
}

function setColor(aeObject, oElement, sNewColor) {
  for(var i=0;i<oElement.childNodes.length;i++) {
    setColor(aeObject, oElement.childNodes[i], sNewColor);
  }
	if(oElement.tagName=="FONT") {
		if(oElement.face=="ae_newclass") {
			sPreserve=oElement.innerHTML;
			oNewNode=aeObject.DOM.createElement("SPAN");
			oElement.replaceNode(oNewNode);
			oNewNode.innerHTML=sPreserve;
			oNewNode.style.color=sNewColor;
		}
		if(oElement.xclass!=null) {
			sPreserve=oElement.innerHTML;
			sClass=oElement.xclass;
			oNewNode=aeObject.DOM.createElement("SPAN");
			oElement.replaceNode(oNewNode);
			oNewNode.innerHTML=sPreserve;
			oNewNode.className=sClass;
		}
	}
}

function ae_quickfontsize(num) {
	if (ae_HTMLMode[num]) { return; }
	DHTMLSafe=aeObjects[num];
	oSel=eval('document.all.oQuickFontSize'+num);	
	DHTMLSafe.ExecCommand(DECMD_SETFONTSIZE, OLECMDEXECOPT_DODEFAULT, oSel.options[oSel.selectedIndex].value);
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();
}

function ae_quickformat(num) {
	if (ae_HTMLMode[num]) { return; }
	DHTMLSafe=aeObjects[num];
	oSel=eval('document.all.oQuickFormat'+num);	
	if (oSel.options[oSel.selectedIndex].name == "quickformat") { return; }
	DHTMLSafe.ExecCommand(DECMD_SETBLOCKFMT, OLECMDEXECOPT_DODEFAULT, oSel.options[oSel.selectedIndex].name);
	oSel.selectedIndex = "null";
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();
}

function ae_hyperlinkwin(num) {
	ae_hot=num;
	DHTMLSafe=aeObjects[num];
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();	
	if(DHTMLSafe.DOM.selection.type=="Control") {
		var el=DHTMLSafe.DOM.selection.createRange().commonParentElement();
		var tr = DHTMLSafe.DOM.body.createTextRange();
		tr.moveToElementText(el);
		tr.select();
	}
	if (typeof(ae_linkwin) == "undefined" || ae_linkwin.closed) { //short circuit eval
		var szURL=inc + "hyperlink.htm";
		ae_linkwin = window.open(szURL ,"ae_linkwin","scrollbars=auto,width=360,height=190, resizable=yes",true);
	}
	ae_linkwin.focus();
}

function ae_imagepropertywin(num) {
	ae_imgpropertywin = window.open(inc+"imgproperties.htm" ,null,"scrollbars=yes,width=490,height=340, resizable=yes");
	ae_imgpropertywin.focus();
}

function ae_imageproperty(num, aWidth, aHeight, aBorder, aSrc, aAlt, aAlign) {
	DHTMLSafe=aeObjects[num];
	var oSel=DHTMLSafe.DOM.selection.createRange().commonParentElement();
	var tr = DHTMLSafe.DOM.body.createTextRange();
	hs=oSel.getAttribute("STYLE",0).height;
	ws=oSel.getAttribute("STYLE",0).width;
	if (hs.length) {
		oSel.getAttribute("STYLE",0).removeAttribute("HEIGHT",0);
	}
	if (ws.length) {
		oSel.getAttribute("STYLE",0).removeAttribute("WIDTH",0);
	}
	oSel.width=aWidth;
	oSel.height=aHeight;
	oSel.border=aBorder;
	oSel.src=aSrc;
	oSel.alt=aAlt;
	oSel.align=aAlign;
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();
	tr.moveToElementText(oSel);
	tr.collapse(false);
	tr.select();
}

function ae_hyperlink(num, iHref, iTarget, iStyle, iClass, iName) {
	DHTMLSafe=aeObjects[num];
	var uid="ae"+Math.random().toString();
	if(iHref=="" && !iName.length) { // Unlink
		if(DHTMLSafe.QueryStatus(DECMD_UNLINK)==DECMDF_ENABLED)
			DHTMLSafe.ExecCommand(DECMD_UNLINK);
	}
	else {
		var trSel=DHTMLSafe.DOM.selection.createRange();
		if(trSel.compareEndPoints("StartToEnd",trSel)==0) { // Need a brand new link
			txtHTML="<A href=\""+iHref+"\" ";
			if(iTarget.length)
				txtHTML+="target=\""+iTarget+"\" ";
			if(iStyle.length)
				txtHTML+="style=\""+iStyle+"\" ";
			if(iClass.length)
				txtHTML+="class=\""+iClass+"\" ";
			if(iName.length)
				txtHTML+="name=\""+iName+"\" ";
			txtHTML+=">"+iHref+"</a>";
			trSel.pasteHTML(txtHTML);
		}
		else { //Update existing link or link plain text
			DHTMLSafe.ExecCommand(DECMD_HYPERLINK,OLECMDEXECOPT_DONTPROMPTUSER,uid);
			var coll=DHTMLSafe.DOM.all.tags("A");
			for(i=0;i<coll.length;i++) {
				if(coll[i].href==uid) {
					if (iHref.length) { coll[i].href=iHref; }
					else { coll[i].removeAttribute("HREF",0); }
					if (iName.length) { coll[i].name=iName; }
					if(iTarget.length) coll[i].target=iTarget;
					else coll[i].removeAttribute("TARGET",0);
					if(iStyle.length) coll[i].style.cssText=iStyle;
					else {
						coll[i].style.cssText="";
					}
					if(iClass.length) coll[i].className=iClass;
					else {
						coll[i].className="";
						coll[i].removeAttribute("CLASS",0);
					}
				}
			}
		}
	}
	DHTMLSafe.focus();
	DHTMLSafe.DOM.body.focus();
}

function ae_spellcheckwin(num) {
	spell('aeObjects[' + eval(num) + '].DOM.body.innerHTML');
/*
	if (typeof(ae_spellwin) == "undefined" || ae_spellwin.closed) { //short circuit eval
		var szURL=inc + "spellchecker/window.cfm?jsvar=aeObjects["+num+"].DOM.body.innerHTML";
		ae_spellwin = window.open(szURL, null, 
        "height=230,width=450,status=no,toolbar=no,menubar=no,location=no");
	}
	ae_spellwin.focus();
*/
}

function getHtmlContent() {
	var html = DHTMLSafe.DOM.body.parentElement;
	
}


function formatHTML(input) {
	var out = "";
	for (i=0;i<input.length;i++) {
		var c = input.charAt(i);
		if (c == '<') {
			out += '<';
			i++;
			var endTag = (input.charAt(i) == '/');
			var s=input.indexOf(' ',i);
			var e=input.indexOf('>',i);
			var tagName;
			if (s > e || s==-1 || endTag) { //no attr
				tagName = input.substring(i,e).toLowerCase();
				out+=tagName;
				if (tagName == "br" || tagName == "hr")	out += " /";
				out+=">";
				i=e;
			}			
			else {
				tagName = input.substring(i,s).toLowerCase();
				out+=tagName;
				var tagContents = input.substring(i+tagName.length,e);
				var s_attr = 1;
				var s_eq = 2;
				var s_val = 3;
				var quoted = false;
				var status = s_attr;
				for(var k=0;k<tagContents.length;k++) {
					c = tagContents.charAt(k);
					if (status == s_attr) {
						if (c == '=') status = s_eq;
						out+=c.toLowerCase();
					}
					else if (status == s_eq) {
						if (c == "\"") {
							 quoted = true;
							 status = s_val;
							 out +=c;
						}
						else if (c!=" " && c!="\t" && c!="\n") {
							 quoted=false;
							 out +="\"" + c;
							 status = s_val;
						}
						else out+=c;
					}
					else if (status == s_val) {
						if (c == "\"") status = s_attr;
						else if (!quoted && (c==' ' || c=="\t" || c=="\n" || c=='>')) {
							 status = s_attr;
							 out+="\"";
						}
						out+=c;
					}
				}
				if (status == s_val) out+="\"";
				if (tagName == "img") out+=" /";
				out+=">"
				i = e;
			}
			
		}
		else {
			out+=c;
		}
	}
	
	return out;
}


//////////////////////////
//context menu functions//
//////////////////////////

function ShowMenu(num) {
	var menuStrings = new Array();
	var menuStates = new Array();
	var state;
	var i;
	var idx = 0;
	ae_hot=num;
	DHTMLSafe=aeObjects[num];
	// Rebuild the context menu. 
	ContextMenu.length = 0;
	// Always show general menu
	if(alloweditsource[num]) i=0;
	else i=2;
	for (;i<GeneralContextMenu.length; i++) {
		ContextMenu[idx++] = GeneralContextMenu[i];
	}
	// Is the selection inside a table? Add table menu if so
	if (DHTMLSafe.QueryStatus(DECMD_INSERTROW) != DECMDF_DISABLED) {
		for (i=0; i<TableContextMenu.length; i++) {
			ContextMenu[idx++] = TableContextMenu[i];
		}
	}
	// If the selection is an image, add image properties to the menu
 	var tr = DHTMLSafe.DOM.selection.createRange();
	if (DHTMLSafe.DOM.selection.type == "Control") {
		for (i=0; i<ImageContextMenu.length; i++) {
			ContextMenu[idx++] = ImageContextMenu[i];
   		}
	}
	// Set up the actual arrays that get passed to SetContextMenu
	for (i=0; i<ContextMenu.length; i++) {
		menuStrings[i] = ContextMenu[i].string;
		if ((menuStrings[i] != MENU_SEPARATOR) && (ContextMenu[i].cmdId < 6000)) {
			state = DHTMLSafe.QueryStatus(ContextMenu[i].cmdId);
		}
		else {
			state = DECMDF_ENABLED;
		}
		if (state == DECMDF_DISABLED || state == DECMDF_NOTSUPPORTED) {
			menuStates[i] = OLE_TRISTATE_GRAY;
		}
		else if (state == DECMDF_ENABLED || state == DECMDF_NINCHED) {
			menuStates[i] = OLE_TRISTATE_UNCHECKED;
		}
		else { // DECMDF_LATCHED
			menuStates[i] = OLE_TRISTATE_CHECKED;
		}
		//CUSTOM Attribute Toggle Glyphs
		if (ContextMenu[i].cmdId == DECMD_TOGGLE_DETAILS) {
			if (DHTMLSafe.ShowDetails) {
				menuStates[i] = OLE_TRISTATE_CHECKED;
			}
			else {
				menuStates[i] = OLE_TRISTATE_UNCHECKED;
			}	
		}
		if(ContextMenu[i].cmdId == DECMD_EDITSOURCE) {
			if(ae_sourceview) {
				menuStates[i] = OLE_TRISTATE_CHECKED;							
			}
			else {
				menuStates[i] = OLE_TRISTATE_UNCHECKED;
			}	
		}
	}
	// Set the context menu
	DHTMLSafe.SetContextMenu(menuStrings, menuStates);
}

function ContextMenuItem(string, cmdId) {
	this.string = string;
	this.cmdId = cmdId;
}

function QueryStatusItem(command, element) {
	this.command = command;
	this.element = element;
}

////////////////////////////
//Global Menu Declarations//
////////////////////////////

var MENU_SEPARATOR = "";
var ContextMenu = new Array();
var GeneralContextMenu = new Array();
var TableContextMenu = new Array();
var ImageContextMenu = new Array();

//define context elements

var genId = 0; //index ids
var tblId = 0;
var imgId = 0;

GeneralContextMenu[genId++] = new ContextMenuItem("Edit Source", DECMD_EDITSOURCE);
GeneralContextMenu[genId++] = new ContextMenuItem(MENU_SEPARATOR, 0);

if (!is_ie4) {
  	//no edit table in IE 4
	TableContextMenu[tblId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
  	TableContextMenu[tblId++] = new ContextMenuItem("Edit Table", DECMD_EDITTABLE);
}

TableContextMenu[tblId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
TableContextMenu[tblId++] = new ContextMenuItem("Insert Row", DECMD_INSERTROW);
TableContextMenu[tblId++] = new ContextMenuItem("Delete Rows", DECMD_DELETEROWS);
TableContextMenu[tblId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
TableContextMenu[tblId++] = new ContextMenuItem("Insert Column", DECMD_INSERTCOL);
TableContextMenu[tblId++] = new ContextMenuItem("Delete Columns", DECMD_DELETECOLS);
TableContextMenu[tblId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
TableContextMenu[tblId++] = new ContextMenuItem("Insert Cell", DECMD_INSERTCELL);
TableContextMenu[tblId++] = new ContextMenuItem("Delete Cells", DECMD_DELETECELLS);
TableContextMenu[tblId++] = new ContextMenuItem("Merge Cells", DECMD_MERGECELLS);
TableContextMenu[tblId++] = new ContextMenuItem("Split Cell", DECMD_SPLITCELL);

ImageContextMenu[imgId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
ImageContextMenu[imgId++] = new ContextMenuItem("Image Properties", DECMD_IMAGE_PROPERTIES);

	
GeneralContextMenu[genId++] = new ContextMenuItem("Find", DECMD_FINDTEXT);
GeneralContextMenu[genId++] = new ContextMenuItem("Show Details", DECMD_TOGGLE_DETAILS);
GeneralContextMenu[genId++] = new ContextMenuItem(MENU_SEPARATOR, 0);
GeneralContextMenu[genId++] = new ContextMenuItem("About", DECMD_ABOUT);
GeneralContextMenu[genId++] = new ContextMenuItem("Help", DECMD_HELP);

//////////////////////
// Style Functions  //
//////////////////////

//CSS style functions for buttons

function ae_m_out(src) {
	//mouse out button style
	if(src.state==0) return;	
	if(src.state==2) { src.className="latched"; return; }
	if(src.type=="btn") {
		window.status="";
		src.className="flat";
	}
}

function ae_m_over(src) {
	//mouse over button style
	if(src.state==0) return;
	if(src.state==2) return;
	if(src.type=="btn") {
		//window.status=src.status;
		src.className="outset";
	}
}

function ae_m_down(src) {
	//mouse down button style
	if(src.state==0) return;
	if(src.type=="btn") {
		src.className="inset";
	}
}

function ae_m_up(src) {
	//mouse up button style
	if(src.state==0) return;
	if(src.state==2) { src.className="latched"; return; }
	if(src.type=="btn") {
		src.className="outset";
	}
}

function set_tbstates(num) {
	var pbtn;
	var cid;
	var state;
	DHTMLSafe=aeObjects[num];
	ae_tbar=eval("ae_tbar"+num);
	if(DHTMLSafe.QueryStatus(5002)!=DHTMLSafe.QueryStatus(5003)) return;
	for(var i=0;i<ae_tbar.all.length;i++) {
		pbtn= ae_tbar.all(i);
		cid=pbtn.cid;
		if(cid < 6000&&cid!=DECMD_HYPERLINK) {
			if (!is_ie4) pbtn.style.visibility="visible";
			state=DHTMLSafe.QueryStatus(cid)
	   		if(state == DECMDF_DISABLED || state == DECMDF_NOTSUPPORTED) {
				if(pbtn.state!=0) {
						pbtn.className = "disabled";
						pbtn.state = 0;
				}
			}
			else if(state == DECMDF_ENABLED || state == DECMDF_NINCHED){
				if(pbtn.state!=1) {
					pbtn.className = "flat";
					pbtn.state = 1;
				}
			}
			else {   //latched
				if(pbtn.state!=2) {
					pbtn.className = "latched";
					pbtn.state = 2;
				}
			}
		}
		else if(cid==DECMD_TOGGLE_DETAILS) {
			if(DHTMLSafe.ShowDetails) {
				if(pbtn.state!=2) {
					pbtn.className = "latched";
					pbtn.state = 2;
				}
			}
			else {
				if(pbtn.state!=1) {
					pbtn.className = "flat";
					pbtn.state = 1;
				}
			}
		}
		
		if(DHTMLSafe.QueryStatus(DECMD_SETBLOCKFMT)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {			
			if(cid==DECMD_STRIKE) {
				if (hasParentTag(num,"STRIKE")) {
					if (pbtn.state!=2) {
						pbtn.className="latched";
						pbtn.state=2;
					}
				}
				else if (pbtn.state!=1) {
					pbtn.className="flat";
					pbtn.state=1
				}
			}
			else if (cid ==DECMD_SUBSCRIPT) {
				if (hasParentTag(num,"SUB")) {
					if (pbtn.state!=2) {
						pbtn.className="latched";
						pbtn.state=2;
					}
				}
				else if (pbtn.state!=1) {
					pbtn.className="flat";
					pbtn.state=1
				}
			}	
			else if (cid == DECMD_SUPERSCRIPT) {
				if (hasParentTag(num,"SUP")) {
					if (pbtn.state!=2) {
						pbtn.className="latched";
						pbtn.state=2;
					}
				}
				else if (pbtn.state!=1) {
					pbtn.className="flat";
					pbtn.state=1
				}
			}
			else if (cid == DECMD_HIGHLIGHT) {
				DHTMLSafe = aeObjects[num];
				var parentElm = DHTMLSafe.DOM.selection.createRange().parentElement();
				while (parentElm != null) {
					if (parentElm.tagName == "SPAN" && parentElm.style.backgroundColor == "yellow") {
						if (pbtn.state!=2) {
							pbtn.className="latched";
							pbtn.state=2;	
						}
						break;
					}
					if (parentElm.tagName == "BODY") {
						if (pbtn.state!=1) {
							pbtn.className="flat";
							pbtn.state=1;
						}
						break;
					}
					parentElm = parentElm.parentElement;
				}
			}
		}
	}
	if(oSel=eval('document.all.oQuickFont'+num)){
		if(DHTMLSafe.QueryStatus(DECMD_SETFONTNAME)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			fontname=DHTMLSafe.ExecCommand(DECMD_GETFONTNAME);
			if(fontname!=""&&fontname!=null) {
				fCreateNew=true;
				window.status=fontname;
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name==fontname) {
						if(!oSel.options[i].selected)
							oSel.options[i].selected=true;
						fCreateNew=false;
					}
				}
				if(fCreateNew) {
					var oOption = document.createElement("OPTION");
					oSel.options.add(oOption,0);
					oOption.text = fontname;
					oOption.name = fontname;
					oOption.selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}
	if(oSel=eval('document.all.oQuickFontSize'+num)){
		if(DHTMLSafe.QueryStatus(DECMD_SETFONTSIZE)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false; 
			fs=DHTMLSafe.ExecCommand(DECMD_GETFONTSIZE);
			if(fs!=null&&fs!="") {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name=="ae_fs"+fs&&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}	
	if(oSel=eval('document.all.oQuickFormat'+num)){
		if(DHTMLSafe.QueryStatus(DECMD_SETBLOCKFMT)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			fmt=DHTMLSafe.ExecCommand(DECMD_GETBLOCKFMT);
			if(fmt!=""&&fmt!=null) {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name==fmt&&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}	
	if (oSel=eval('document.all.oQuickStyle'+num)) {
		if(DHTMLSafe.QueryStatus(DECMD_SETBLOCKFMT)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			//fmt=DHTMLSafe.ExecCommand(DECMD_GETBLOCKFMT);
			var cssClass = DHTMLSafe.DOM.selection.createRange().parentElement().className;
			if(cssClass!=""&&cssClass!=null) {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].name==cssClass&&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=0;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}
	if (oSel=eval('document.all.oQuickFontColors'+num)) {
		if(DHTMLSafe.QueryStatus(DECMD_SETBLOCKFMT)!=DECMDF_DISABLED&&DHTMLSafe.DOM.selection.type!="control") {
			if(oSel.disabled) oSel.disabled=false;
			//fmt=DHTMLSafe.ExecCommand(DECMD_GETBLOCKFMT);
			var cssColor = DHTMLSafe.DOM.selection.createRange().parentElement().style.color;
			if(cssColor!=""&&cssClass!=null) {
				for(i=0;i<oSel.options.length;i++) {
					if(cssColor.toLowerCase()==(oSel.options[i].name.toLowerCase())  &&!oSel.options[i].selected)
						oSel.options[i].selected=true;
				}
			}
			else {
				oSel.selectedIndex=0;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}
}

function hasParentTag(num, tag) { 
	DHTMLSafe = aeObjects[num];
	var parentElm = DHTMLSafe.DOM.selection.createRange().parentElement();
	//search for any strikes that are parent of this.
	while (parentElm != null) {
		if (parentElm.tagName == tag) {
			return true;
		}		
		if (parentElm.tagName == "BODY") {
			return false;
		}
		parentElm = parentElm.parentElement;
	}
	return false;
}

//////////////////
//Image preloads//
//////////////////
var img_htmltabon=new Image();
img_htmltabon.src=inc+"images/htmltabon.gif";
var img_htmltaboff=new Image();
img_htmltaboff.src=inc+"images/htmltaboff.gif";
var img_normaltabon=new Image();
img_normaltabon.src=inc+"images/normaltabon.gif";
var img_normaltaboff=new Image();
img_normaltaboff.src=inc+"images/normaltaboff.gif";

<cfcatch type="Any">
	<cfoutput>
	errwin = window.open("","","scrollbars=yes,width=400,height=300", true);
	errwin.document.write("<HR><H3>Error Occurred While Processing Request</H3><P><TABLE BORDER><TR><TD><H4>Error Diagnostic Information</H4><P>");
	errwin.document.write("#ReplaceList(CFCATCH.Message, "\,"",',	,#Chr(10)#",  "\\,\"",\',\t,\n" )# #ReplaceList(CFCATCH.Detail, "\,"",',	,#Chr(10)#",  "\\,\"",\',\t,\n" )#");
	errwin.document.write("<P><P></TD></TR></TABLE><P><HR>");
	</cfoutput>
</cfcatch>
</cftry>
//</script>