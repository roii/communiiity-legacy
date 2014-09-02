// File: lib.js
// Author: Matt Finn
// Company: CFDEV.COM / NETDesign Inc.
// Description:
// 		Java Script Library for ActiveScan ActiveX Control
// Date: June 2000
// Version: 1.0.0

/*

TODO:

	Add the form field setting stuff on line : 75 activescanctrl_OnPostComplete()

*/


var as_ev='';
var as_ztimeref;
var as_z;
var as_zcount=0;
window.onload=as_doafewthings;

function as_OnScan() {
	activescanctrl.StartScan();
	activescanctrl.mouse = 1;
}

function as_postbutton() {
	var imgName = '';

	if(as_imagename=='')
	{
		while (imgName == '' || imgName == 'My_Image') {
			imgName = prompt('Please Enter a Name for this Image', 'My_Image');
		}
		
		if(imgName == null)
			return;
	}
	else imgName=as_imagename

	// for testing //
	// as_upscript="http://dev.netdesign1.com/activescan/inc/imgup.cfm";
	// end for testing //
	activescanctrl.SendImage(as_upscript, "image", imgName, "key", PathKey, "", "");
}

function as_resize() {
	if(activescanctrl.imageWidth==0)
		return;

	var z = activescanctrl.Zoom;
	var msg="Please enter a percentage to scale the image.";
	
	z = prompt(msg, z);

	msg="Please enter a percentage to scale the image.\r\n"
		"The number must be between 10 and 200";

	while(!(z >= 5 && z <= 1000)&&z!=null) {
		z = prompt(msg, activescanctrl.Zoom);
		
	}
	
	if(z!=null)
	{
		activescanctrl.resample(z);
	}	
	as_updatezoom();
}

function as_updatezoom() {
	document.all.zoomtext.innerHTML="&nbsp;" + activescanctrl.Zoom.toString(10) + "%&nbsp; ";
}

function as_setCursor(x) {
	activescanctrl.mouse = x;
}

function as_setztimer(c, e) {

	if(c==0) {
		clearTimeout(as_ztimeref);
		if(as_zcount<=20) {
			if("zi"==e) {
				activescanctrl.Zoom=activescanctrl.Zoom*2;
				as_updatezoom();
			}
			else if("zo"==e) {
				activescanctrl.Zoom=activescanctrl.Zoom/2;			
				as_updatezoom();
			}
		}
	}
	else {
		as_zcount=0;
		as_ztimeref = setTimeout("as_ztimer()", 10);
	}
	     
    if(("zi"==e)||("zo"==e)) 
		as_z = activescanctrl.Zoom;

	as_ev=e;
}

function as_ztimer() {
	as_zcount++;
	
	if(as_zcount>20) {
	
		if(as_ev=="zi")
		{
			as_z = as_z * 1.05;
			activescanctrl.Zoom = as_z;
		
		}
		else if(as_ev=="zo") 
		{
			as_z = as_z / 1.05;
			activescanctrl.Zoom = as_z;
		}
		as_updatezoom();

	}
	
	as_ztimeref = setTimeout("as_ztimer();", 10);
}

function activescanctrl_OnPostComplete() {
	var s=activescanctrl.StatusString;
	var r;
	var r1;
	var re;
	var fname='';
	
		if(s.search("activescan:error")==0)
	{
		
		document.location = inc + "error.cfm";
		return;
	}	

	
	re=/activescan\:filename\=/i;

	
	r = s.search(re);
	re=/\;/;

	
	r1 = s.search(re);

	if(r>=0)
		fname=s.substring(r + 20,r1);
	
	re=/\%file\%/i;
	
	r = onSaveAction.replace(re, fname);

	if(0==activescanctrl.StatusCode) {
	
		switch(onSave) {
			case "alert":
				window.alert(r);
				break;
			case "redirect":
				document.location = r;
				break;
			case "call":
				eval(r);
				break;
			default:			
				alert("Attribute onSave="+onSave+" is invalid");
				break;			
		}
	}
	else
		window.alert(activescanctrl.errorMessage + "\n\n" + 
		"Error " + activescanctrl.StatusCode);
		

}

function as_xredirect() {
	


}

function as_selsource() {
	activescanctrl.SelectSource();
}

function as_zoomfull() {
	activescanctrl.Zoom=100;
	as_updatezoom();
}

function as_m_out() {
	//when the mouse leaves a button
	//return default status
	var src=event.srcElement;

	if(src.className=="btn") {
		window.status="";
		src.style.backgroundColor = "buttonface";
		src.style.borderTop = "buttonface solid 1px";
		src.style.borderRight = "buttonface solid 1px";
		src.style.borderLeft = "buttonface solid 1px";
		src.style.borderBottom = "buttonface solid 1px";
		window.event.cancelBubble=true;
	}
}

function as_m_over() {
	//mouse over button style
	var src=event.srcElement;

	if(src.className=="btn") {
		window.status=src.alt;		
		src.style.backgroundColor = "buttonface";
		src.style.borderBottom = "buttonshadow solid 1px";
		src.style.borderLeft = "buttonhighlight solid 1px";
		src.style.borderRight = "buttonshadow solid 1px";
		src.style.borderTop = "buttonhighlight solid 1px";
		window.event.cancelBubble=true;

	}
}

function as_m_down() {
	//mouse down button style
	var src=event.srcElement;
	if(src.className=="btn") {
		src.style.backgroundColor = "buttonface";
		src.style.borderTop = "buttonshadow solid 1px";
		src.style.borderRight = "buttonhighlight solid 1px";
		src.style.borderLeft = "buttonshadow solid 1px";
		src.style.borderBottom = "buttonhighlight solid 1px";
		window.event.cancelBubble=true;

	}
}

function as_m_up() {
	//mouse up button style
	var src=event.srcElement;
	if(src.className=="btn") {
		src.style.backgroundColor = "buttonface";
		src.style.borderBottom = "buttonshadow solid 1px";
		src.style.borderLeft = "buttonhighlight solid 1px";
		src.style.borderRight = "buttonshadow solid 1px";
		src.style.borderTop = "buttonhighlight solid 1px";
		window.event.cancelBubble=true;

	}
}

function as_cancelEvent()
{
    window.event.cancelBubble = true;
    window.event.returnValue = false;   
}

function as_doafewthings()
{


}

function as_help() {
	//show help dialog
	window.showModalDialog(inc + "help.cfm","","dialogHeight: 380px; dialogWidth: 350px; dialogTop: 150px; dialogLeft: 150px; center: Yes; help: No; resizable: No; status: No;");
}