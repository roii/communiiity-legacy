<link rel="stylesheet" type="text/css" href="CSS/small.css">

<script language="javascript">

var ie4 = false; 
if(document.all) { ie4 = true; }
function getObject(id) { 
	if (ie4) { 
		return document.all[id]; 
	} else { 
		return document.getElementById(id); 
	}
}

function hide(ID){
	var display = getObject(ID);
	display.style.display = 'none';
}

function show(ID){
	var display = getObject(ID);
	display.style.display = 'block';
}

function hideAll(questionCount){
	for(i=2; i<=questionCount; i++){
		var question = 'q' + i;
		//var choice   ='c' + i;
		hide(question);
		hide('end');
		//hide(choice);
	}
}
/*store the question show*/
var currentShowQuestionIndex = 1;

function showNext(questionCount){

     var agree=document.Termfrm.agree;
	
	if ((agree.value=="Yes")||(agree.value=="yes")){
	}
	else {
		alert("Please read the terms and conditions and type in yes first!")
		agree.focus();
		return false
	}

	if(currentShowQuestionIndex < questionCount){
		//hide the previous question
		hide('q' + currentShowQuestionIndex);
		//show next question
		currentShowQuestionIndex = currentShowQuestionIndex  + 1;
		show('q' + currentShowQuestionIndex);
		agree.value="";
	}else{
		show('end');
		hide('preButton');
	}
	updateQuestionAnswer();
}

function PreviousQuestion(){

	currentShowQuestionIndex = currentShowQuestionIndex - 1;
	
	if(currentShowQuestionIndex >= 1){
		//hide the current
		hide('q' + (currentShowQuestionIndex + 1));
		//show prev
		show('q' + currentShowQuestionIndex);
	}else{
		currentShowQuestionIndex = currentShowQuestionIndex + 1;
	}
}

function viewResponse(questionCount){
	for(i=1; i<=questionCount; i++){
		var question = 'q' + i;
		show(question);
	}

}

var questionAnswer = 0;
var radioArray = new Array();
function updateQuestionAnswer(){
	questionAnswer = questionAnswer + 1;
}

function validateSubmit(frm){

	//check if all question answer
	if(questionAnswer < frm.NumberOfTerm.value){
		alert("Please read the terms and conditions first \n then type in 'Yes' in the box and click on the Continue Button!")
		return false;
	}
	return true;
}

</script>
</head>

<cfoutput>
<cfset questionCount = 0>

<!--- select distinct questionID --->
<cfquery name="AllTerms" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
   SELECT * FROM surveyTerms where formid = #attributes.surveyid#
</cfquery>

<cfif AllTerms.recordcount eq 0>
  <cflocation url="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=27&surveyid=#attributes.surveyid#">
  <cfabort>
</cfif>

Market Research is easy and great way to make money. 
However it is very important that the information you gather is accurate and true. <br>
So please read carefully and agree to these terms before you can start your survey. <br>
Otherwise you may <b>NOT</b> get paid for surveys returned which do not meet these terms<br>

<cfset questionCount = 0>
<cfset choiceArray = ListToArray("a),b),c),d),e),f),g)",",")>
<form name="Termfrm" action="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=26" method="post" onSubmit="return validateSubmit(this)">
<input type="hidden" name="NumberOfTerm" value="#AllTerms.RecordCount#">
<input type="hidden" name="Surveyid" value="#attributes.surveyid#">

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr align="center">
		<td align="center">
		
	<cfloop query="AllTerms">	
	        <cfset questionCount = questionCount + 1>
			<div id="q#questionCount#">
			<table border="0" cellpadding="1" cellspacing="1" width="100%">
				<tr>
					<td><span class="normal">Term #questionCount#</span></td>
				</tr>
				<tr>
					<td>
					<cfif imageLoc neq ''>
					  <img src="#request.webroot#/surveyengine/images/#imageLoc#"><br>
					</cfif>
					<b>#Term#</b>
					</td>
				</tr>
			</table>
			</div>
			<cfif #questionCount# NEQ 1><script language="JavaScript">hide('q#questionCount#')</script></cfif>
			</cfloop>
<br>
			<table border="0" cellpadding="1" cellspacing="1" width="100%">
				<tr>
					<td>
					<p>Do you understand? If you do type "yes" in the box below and then click "continue"</p>
						<div id="preButton">			
						<input type="Text"  name="agree" size="5">&nbsp;&nbsp;
						<input type="button"  name="continue" value="Continue" onClick="showNext(#questionCount#)">					
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="end">						
						<input type="submit" name="subTerm" value="Submit">					
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</table>
	<script language="JavaScript">hide('end')</script>

</form>
</cfoutput>

