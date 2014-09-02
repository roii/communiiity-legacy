aeApplets = new Array();
aeApplets[0] = null;
// This is an applet instance reference
hotApplet = null;
var frmLoaded = new Array();

// Handler of an insert image window
var g_wImageDialog = null;

aeNames = new Array();
aeNames[0] = null;

// Method to initialize reference
// This method will be called from JApplet.init()
function initApplet( aeApplet ){
	aeApplets[aeApplet.getInstanceId()] = aeApplet;
	
	hotApplet = aeApplet;	
	if (!frmLoaded[aeApplet.getInstanceId()]) {
		findForm(aeApplet.getInstanceId());
	}
}

function txtLoad(num) {
	if (aeApplets[num] != null) {
		findForm(num);
	}
}

function findForm(num) {
	var thisContentItem = getFormField(num);
	thisForm=thisContentItem;
	while(thisForm.tagName!="FORM"&&thisForm.tagName!="HTML") {
		if (document.getElementById) 
			thisForm=thisForm.parentNode; 
		else 
			thisForm=thisForm.parentElement;
	}
	
	if(thisForm.tagName!="HTML") {		
		//bind onSubmit event to ae_onSubmit()
		thisForm.onsubmit = ae_onSubmit;
	}
	else {
		alert("ActivEdit must be contained in a HTML form.", "", true);
		return;
	}
	aeApplets[num].setHtmlContent(thisContentItem.value);
	frmLoaded[num] = true;
}

function getFormField(num) {
	//IE 5+ NS6+, w3c DOM compliant
	if (document.getElementById) {
		return document.getElementById("ae_tx_content"+num);
	}
	//ie4
	else if (document.all) {
		return eval("document.all.ae_tx_content"+num);
	}
	else {
		alert("Your Browser is not compliant to DOM standards");
		return null;
	}
}

function ae_onSubmit() {
	
	for(i=1;i<aeApplets.length;i++) {
		if (typeof(aeapi_applet_onBeforeSave)=='function') {
			ae_content = aeapi_applet_onBeforeSave(aeApplets[i], aeNames[i]);
		}
		field = getFormField(i);
		field.value = getBodyHTML(aeApplets[i].getHtmlContent());
	}
}


// Inserting HTML string into editor
function insertHtml( strHtml ){

	g_refApplet.insertHtml( strHtml );
};

// Inserting plane text string into editor
function insertText( strText ){

	g_refApplet.insertText( strText );
};

// Obtaine selected text from applet
function getSelectedText(){
	
	return g_refApplet.getSelectedText();
}

// Returns complete HTML document
function getHtmlContent(){

	return 	g_refApplet.getHtmlContent();
}
// Modified image selection window procedure
function onImagewin( num ){
		
	if( (g_wImageDialog != null) &&
		!(typeof(g_wImageDialog) == "undefined" || g_wImageDialog.closed) )
	// Image window is allready visible								
		return;
			
	// Spawn image window
	var strUrl;
	
	strUrl =  inc + "image.cfm?instance=" + num;
	strUrl += "&imagedata=";
	strUrl += ae_imagedata[num];
	strUrl += "&imageurl=";
	strUrl += ae_imageurl[num];

	g_wImageDialog = window.open( strUrl , "g_wImageDialog", "scrollbars=yes,width=650,height=410,resizable=yes" );
	g_wImageDialog.focus();
}

// Calback method for an insert image dialog
function onImage( strLocation, base_url, iborder, ialign, ialt, num ){		
	
	// Format a tag 
	strImageUrl = "<img src='";
		strImageUrl += strLocation;
		strImageUrl += "' border='";
		strImageUrl += iborder; 
		strImageUrl += "' align='";
		strImageUrl += ialign; 
		strImageUrl += "' alt='";
		strImageUrl += ialt + "'>";	
	
	// Call API to insert the tag into editor
	aeApplets[num].insertHtml( strImageUrl );	
	
	// Close dialog
	g_wImageDialog.close();
}

// Callback for an applet 
// to initialize insert image dialog
function uploadFileAction(){
	
	onImagewin( 1 );	
	return null;
}

// Callback for an applet 
// to save HTML content
function save( formname, txt ){

}

function getBodyHTML(content) {
	var lc = content.toLowerCase();
	var bodyStart = lc.indexOf("<body");
	if (bodyStart != -1) {
		var bodyStartEnd = lc.indexOf('>', bodyStart+3);
		var bodyEnd = lc.indexOf("</body");
		return content.substring(bodyStartEnd+1, bodyEnd);
	}
	return content;
}

function onAppletSpellCheck(num) {
	spell('aeApplets[' + num + '].getHtmlContent()');
}