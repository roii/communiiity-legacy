// borrowed from mediawiki wikibits.js
// add any onload functions in this hook (please don't hard-code any events in the xhtml source)

var doneOnloadHook;

if (!window.onloadFuncts)
	var onloadFuncts = [];

function addOnloadHook(hookFunct) {
	// Allows add-on scripts to add onload functions
	onloadFuncts[onloadFuncts.length] = hookFunct;
}

function runOnloadHook() {
	// don't run anything below this for non-dom browsers
	if (doneOnloadHook || !(document.getElementById && document.getElementsByTagName))
		return;

	histrowinit();

	// Run any added-on functions
	for (var i = 0; i < onloadFuncts.length; i++)
		onloadFuncts[i]();

	doneOnloadHook = true;
}

function hookEvent(hookName, hookFunct) {
	if (window.addEventListener)
		addEventListener(hookName, hookFunct, false);
	else if (window.attachEvent)
		attachEvent("on" + hookName, hookFunct);
}

hookEvent("load", runOnloadHook);

// Un-trap us from framesets
if (window.top != window)
	window.top.location = window.location;
	
// page history stuff
// attach event handlers to the input elements on history page
function histrowinit() {
	var hf = document.getElementById('wiki_pagehistory');
	if (!hf)
		return;
	var lis = hf.getElementsByTagName('tr');
	for (i = 0; i < lis.length; i++) {
		var inputs = historyRadios(lis[i]);
		if (inputs[0] && inputs[1]) {
			inputs[0].onclick = diffcheck;
			inputs[1].onclick = diffcheck;
		}
	}
	diffcheck();
}

function historyRadios(parent) {
	var inputs = parent.getElementsByTagName('input');
	var radios = [];
	for (var i = 0; i < inputs.length; i++) {
		if (inputs[i].name == "version" || inputs[i].name == "diffver")
			radios[radios.length] = inputs[i];
	}
	return radios;
}

// check selection and tweak visibility/class onclick
function diffcheck() {
	var dli = false; // the li where the diff radio is checked
	var oli = false; // the li where the oldid radio is checked
	var hf = document.getElementById('wiki_pagehistory');
	if (!hf)
		return;
	var lis = hf.getElementsByTagName('tr');
	for (i=0;i<lis.length;i++) {
		var inputs = historyRadios(lis[i]);
		if (inputs[1] && inputs[0]) {
			if (inputs[1].checked || inputs[0].checked) { // this row has a checked radio button
				if (inputs[1].checked && inputs[0].checked && inputs[0].value == inputs[1].value)
					return false;
				if (oli) { // it's the second checked radio
					if (inputs[1].checked) {
						oli.className = "selected";
						return false
					}
				} else if (inputs[0].checked) {
					return false;
				}
				if (inputs[0].checked)
					dli = lis[i];
				if (!oli)
					inputs[0].style.visibility = 'hidden';
				if (dli)
					inputs[1].style.visibility = 'hidden';
				//lis[i].className = "selected";
				oli = lis[i];
			}  else { // no radio is checked in this row
				if (!oli)
					inputs[0].style.visibility = 'hidden';
				else
					inputs[0].style.visibility = 'visible';
				if (dli)
					inputs[1].style.visibility = 'hidden';
				else
					inputs[1].style.visibility = 'visible';
				//lis[i].className = "";
			}
		}
	}
}

// for form upload
function fillDestFilename() {
	if (!document.getElementById)
		return;
	var path = document.getElementById('sourcefile').value;
	// Find trailing part
	var slash = path.lastIndexOf('/');
	var backslash = path.lastIndexOf('\\');
	var fname;
	if (slash == -1 && backslash == -1) {
		fname = path;
	} else if (slash > backslash) {
		fname = path.substring(slash+1, 10000);
	} else {
		fname = path.substring(backslash+1, 10000);
	}

	// replace spaces by underscores
//	fname = fname.replace(/ /g, '_');

	// Output result
	var destFile = document.getElementById('destfile');
	if (destFile)
		destFile.value = fname;
}