/***************************************************************
 *	Current Version: 4
 *  Authors: Pete Freitag
 *  		 Matt Finn
 *	File: user.js
 *	Description: Activedit API (AEAPI) User Controlled Functions
 *
****************************************************************/

/*
function aeapi_init(aeObject) {
	//Run at component initialization
	//This may be before the control is completely loaded
	//...
}
*/

function aeapi_onLoad(aeObject) {
	//Run once activedit is loaded

	//ShowBorders: control default: false; activedit default: true
	aeObject.ShowBorders = true;	//Show a 1 pixel border on tables and images with border=0
	
	//ShowDetails: control default; false; activedit default: false
	//Uncomment to enable "Show hidden tags as glyphs" on startup
	//aeObject.ShowDetails = true;
}

function aeapi_onBeforeSave(aeObject) {
	//run just before calling the save / submit function
	//overrides native function, an aeapi_local_onBeforeSave() will override this function
	
	//so the pages look ok in netscape, use attributes instead of style="width:x;etc"
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
	//note: replaceString() is an activedit specific function
	replaceString("&#65279;", " ", content); 
	//convert to xhtml
	content = (ae_xhtml[1]) ? formatHTML(content) : content;
	//convert style attributes to lower case
	content = content.replace(/style="[^"]+"/gi, function(w) { return w.toLowerCase() })
	return content;
}


/*
function aeapi_onAfterSave(aeObject) {
	//runs after sucessful completion of the save functionality
	//this function will not be called if type=form
	
	//This function will override the CF_Activedit onsave="x" attribute
	//so keep it commented out, unless you intend to replace the current onsave implementation
	
	//...
}
*/
