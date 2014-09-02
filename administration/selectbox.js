function clickKey(key) {
	if (key.value == "Keyword/JobID")
		key.value = "";
	key.setfocus;
}

function changeclass(group) {
	var arr = job_groups[group];
	if (arr == null)
		arr = new Array();
	var opt = document.forms.form1["class"].options;
	opt.length = 0;
	opt[0] = new Option("- Select a Programme -", "");
	for (var i=0;i<arr.length;i++)
		opt[opt.length] = new Option(arr[i].text, arr[i].value);
}

function searchOnLoad() {
	with (document.forms.form1["groupid"]) {
		if (selectedIndex!=0)
			changeclass(options[selectedIndex].value);
	}
}
function go()
{
	box = document.forms.form1["class"];
	destination = box.options[box.selectedIndex].value;
	if (destination) location.href = destination;
}


