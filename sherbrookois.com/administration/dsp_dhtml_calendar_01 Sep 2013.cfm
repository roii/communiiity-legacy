<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>PopCalendar eXtremely Perfect 9.0 DHTML Engine - http://www.calendarxp.net</title>


<style>

td {
font-family: Arial, Verdana, Helvetica;
font-size:11px;
}

.whitefield {
font-size: 11px;
color: #0a0a0a;
font-family: Arial, Trebuchet MS, Verdana;
font-weight: normal;		
background-color: White;
border: solid 1px #b4b4b4;
}

A:link	
{
	text-decoration: underline;
	color:#ffffff;
}

A:visited	
{
	text-decoration: underline;
	color:#ffffff;
}

A:hover
{
	text-decoration: none;
	color:#ffffff;
}		
</style>


<script id='dynaScript' type='text/javascript'></script>

<script type='text/javascript'>
var gd=new Date(), gToday=[gd.getFullYear(),gd.getMonth()+1,gd.getDate()];
var ua=navigator.userAgent.toLowerCase();
var MAC=/mac/.test(ua),OP=!!self.opera,WEBTV=/webtv/.test(ua),IE=/msie/.test(ua)&&!OP&&!WEBTV;
var KO=ua.match(/konqueror\/(\d+)/),KO3=KO&&KO[1]==3, SA=ua.match(/safari\/(\d+)/),SA1=SA&&SA[1]<86; KO=!!KO; SA=!!SA;
var NN4=IE4=NS6=false,IE5=IE&&![].push&&!IE4;
var gfSelf=fGetById(parent.document,self.name);
var gTheme=self.name.split(":");
var gCurMonth=eval(gTheme[0]); gCurMonth=fCalibrate(gCurMonth[0],gCurMonth[1]);
var gContainer=parent;
var fOnResize,fRepaint,fHoliday,fOnChange,fAfterSelected,fOnDrag,gcOtherDayBG,fOnWeekClick,fIsSelected,fParseInput,fFormatInput;
var __agenda=[], popkey=["Lite"], flatkey=["Lite"], __stub=[];
var MILLIDAY=86400000, giInitDelay=200;
if (![].push) Array.prototype.push=function () {
	for (var i=0; i<arguments.length; i++)
		this[this.length]=arguments[i];
	return this.length;
}

function varDate() {
	alert("Something went wrong!.");
}

function fCalibrate(y,m) {
	if (m<1) { y--; m+=12; }
	else if (m>12) { y++; m-=12; }
	return [y,m];
}

function fGetById(doc, id) {
	return doc.getElementById(id);
}

function fLoadScript(url) {
	if (!(IE4||IE&&MAC)) fGetById(document, "dynaScript").src=url;
}

function fFilterNull(str) {
	return str==null||str=="null"||str=="NULL"?null:str;
}

function fAddEvent(y,m,d,message,action,bgcolor,fgcolor,bgimg,boxit,html) {
	var ag=gbShareAgenda?eval(gsAgShared):__agenda;
	ag[y+"-"+m+"-"+d]=[message,fFilterNull(action),fFilterNull(bgcolor),fFilterNull(fgcolor),fFilterNull(bgimg),boxit?boxit.toString().toLowerCase()=="true":null,fFilterNull(html)];
}

function fGetEvent(y,m,d) {
	var ag=gbShareAgenda?eval(gsAgShared):__agenda, id=y+"-"+m+"-"+d;
	return ag[id]?ag[id].slice(0):null;
}

function fRemoveEvent(y,m,d) {
	var ag=gbShareAgenda?eval(gsAgShared):__agenda;
	ag[y+"-"+m+"-"+d]=null;
}

document.write("<scr"+"ipt type='text/javascript' src='"+gTheme[1]+".js'></scr"+"ipt>");
document.write("<scr"+"ipt type='text/javascript' src='"+(gTheme[4]?gTheme[4]:"plugins.js")+"'></scr"+"ipt>");
</script>
<script type='text/javascript'>
function fAgReady(ctxName) {
	var ctx=eval("gContainer."+ctxName);
	if (ctx) {
		clearInterval(__stub[0]);
		fHoliday=ctx.fHoliday;
		if (fRepaint) { fInitRange(); fRepaint(); }
	}
}
var __isAS=gTheme[2]&&gTheme[2].substring(0,6)=="share[";
if (gbShareAgenda==true) {
	if (!eval(gsAgShared)) eval(gsAgShared+"=[]");
	if (__isAS) __stub[0]=setInterval("fAgReady('"+gTheme[2].split('[')[1].split(']')[0]+"')",350);
}
with (document) {
	write("<lin"+"k rel='stylesheet' type='text/css' href='"+gTheme[1]+".css'>");
}
</script>
</head>
<body leftmargin=0 topmargin=0 marginwidth=0 marginheight=0 hspace=0 vspace=0 onselectstart="return false" ondraggesture="return false" ondragstart="return false" oncontextmenu="return false" onmouseup="gContainer.defaultStatus='';fDragIt(0,0,0,2,event);return true;">

<script type='text/javascript'>
var __gdos=gdSelect.slice(0);
gCurMonth=fCalibrate(gCurMonth[0],gCurMonth[1]);
gdSelect=gdSelect.slice(0); gBegin=gBegin.slice(0); gEnd=gEnd.slice(0);
if (gCurMonth[0]>gEnd[0]||gCurMonth[0]==gEnd[0]&&gCurMonth[1]>gEnd[1]) gCurMonth=gEnd.slice(0);
if (gCurMonth[0]<gBegin[0]||gCurMonth[0]==gBegin[0]&&gCurMonth[1]<gBegin[1]) gCurMonth=gBegin.slice(0);
if (gsSplit=="") {giMonthMode=0; gbPadZero=true;}
var gdBegin,gdEnd,gRange,gcbMon,gcbYear,gdCtrl,gcTemp;
var giSat=(6-g<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>PopCalendar eXtremely Perfect 9.0 DHTML Engine - http://www.calendarxp.net</title>


<style>

td {
font-family: Arial, Verdana, Helvetica;
font-size:11px;
}

.whitefield {
font-size: 11px;
color: #0a0a0a;
font-family: Arial, Trebuchet MS, Verdana;
font-weight: normal;		
background-color: White;
border: solid 1px #b4b4b4;
}

A:link	
{
	text-decoration: underline;
	color:#ffffff;
}

A:visited	
{
	text-decoration: underline;
	color:#ffffff;
}

A:hover
{
	text-decoration: none;
	color:#ffffff;
}		
</style>


<script id='dynaScript' type='text/javascript'></script>

<script type='text/javascript'>
var gd=new Date(), gToday=[gd.getFullYear(),gd.getMonth()+1,gd.getDate()];
var ua=navigator.userAgent.toLowerCase();
var MAC=/mac/.test(ua),OP=!!self.opera,WEBTV=/webtv/.test(ua),IE=/msie/.test(ua)&&!OP&&!WEBTV;
var KO=ua.match(/konqueror\/(\d+)/),KO3=KO&&KO[1]==3, SA=ua.match(/safari\/(\d+)/),SA1=SA&&SA[1]<86; KO=!!KO; SA=!!SA;
var NN4=IE4=NS6=false,IE5=IE&&![].push&&!IE4;
var gfSelf=fGetById(parent.document,self.name);
var gTheme=self.name.split(":");
var gCurMonth=eval(gTheme[0]); gCurMonth=fCalibrate(gCurMonth[0],gCurMonth[1]);
var gContainer=parent;
var fOnResize,fRepaint,fHoliday,fOnChange,fAfterSelected,fOnDrag,gcOtherDayBG,fOnWeekClick,fIsSelected,fParseInput,fFormatInput;
var __agenda=[], popkey=["Lite"], flatkey=["Lite"], __stub=[];
var MILLIDAY=86400000, giInitDelay=200;
if (![].push) Array.prototype.push=function () {
	for (var i=0; i<arguments.length; i++)
		this[this.length]=arguments[i];
	return this.length;
}

function varDate() {
	alert("Something went wrong!.");
}

function fCalibrate(y,m) {
	if (m<1) { y--; m+=12; }
	else if (m>12) { y++; m-=12; }
	return [y,m];
}

function fGetById(doc, id) {
	return doc.getElementById(id);
}

function fLoadScript(url) {
	if (!(IE4||IE&&MAC)) fGetById(document, "dynaScript").src=url;
}

function fFilterNull(str) {
	return str==null||str=="null"||str=="NULL"?null:str;
}

function fAddEvent(y,m,d,message,action,bgcolor,fgcolor,bgimg,boxit,html) {
	var ag=gbShareAgenda?eval(gsAgShared):__agenda;
	ag[y+"-"+m+"-"+d]=[message,fFilterNull(action),fFilterNull(bgcolor),fFilterNull(fgcolor),fFilterNull(bgimg),boxit?boxit.toString().toLowerCase()=="true":null,fFilterNull(html)];
}

function fGetEvent(y,m,d) {
	var ag=gbShareAgenda?eval(gsAgShared):__agenda, id=y+"-"+m+"-"+d;
	return ag[id]?ag[id].slice(0):null;
}

function fRemoveEvent(y,m,d) {
	var ag=gbShareAgenda?eval(gsAgShared):__agenda;
	ag[y+"-"+m+"-"+d]=null;
}

document.write("<scr"+"ipt type='text/javascript' src='"+gTheme[1]+".js'></scr"+"ipt>");
document.write("<scr"+"ipt type='text/javascript' src='"+(gTheme[4]?gTheme[4]:"plugins.js")+"'></scr"+"ipt>");
</script>
<script type='text/javascript'>
function fAgReady(ctxName) {
	var ctx=eval("gContainer."+ctxName);
	if (ctx) {
		clearInterval(__stub[0]);
		fHoliday=ctx.fHoliday;
		if (fRepaint) { fInitRange(); fRepaint(); }
	}
}
var __isAS=gTheme[2]&&gTheme[2].substring(0,6)=="share[";
if (gbShareAgenda==true) {
	if (!eval(gsAgShared)) eval(gsAgShared+"=[]");
	if (__isAS) __stub[0]=setInterval("fAgReady('"+gTheme[2].split('[')[1].split(']')[0]+"')",350);
}
with (document) {
	write("<lin"+"k rel='stylesheet' type='text/css' href='"+gTheme[1]+".css'>");
}
</script>
</head>
<body leftmargin=0 topmargin=0 marginwidth=0 marginheight=0 hspace=0 vspace=0 onselectstart="return false" ondraggesture="return false" ondragstart="return false" oncontextmenu="return false" onmouseup="gContainer.defaultStatus='';fDragIt(0,0,0,2,event);return true;">

<script type='text/javascript'>
var __gdos=gdSelect.slice(0);
gCurMonth=fCalibrate(gCurMonth[0],gCurMonth[1]);
gdSelect=gdSelect.slice(0); gBegin=gBegin.slice(0); gEnd=gEnd.slice(0);
if (gCurMonth[0]>gEnd[0]||gCurMonth[0]==gEnd[0]&&gCurMonth[1]>gEnd[1]) gCurMonth=gEnd.slice(0);
if (gCurMonth[0]<gBegin[0]||gCurMonth[0]==gBegin[0]&&gCurMonth[1]<gBegin[1]) gCurMonth=gBegin.slice(0);
if (gsSplit=="") {giMonthMode=0; gbPadZero=true;}
var gdBegin,gdEnd,gRange,gcbMon,gcbYear,gdCtrl,gcTemp;
var giSat=(6-giFirstDOW)%7,giSun=(7-giFirstDOW)%7;
gWeekDay=gWeekDay.slice(giFirstDOW).concat(gWeekDay.slice(0,giFirstDOW));
var __cal=[],gDays=[31,31,28,31,30,31,30,31,31,30,31,30,31];
for (var i=0;i<6;i++) { __cal[i]=[]; for (var j=0;j<7;j++) __cal[i][j]=[]; }

if (!fIsSelected)
	fIsSelected=function(y,m,d) {
		return gdSelect[2]==d&&gdSelect[1]==m&&gdSelect[0]==y;
	}
if (!fParseInput)
	fParseInput=function(str) {
		return fParseDate(str);
	}
if (!fFormatInput)
	fFormatInput=function(y,m,d) {
		return fFormatDate(y,m,d);
	}
	
if (fOnDrag&&!(IE&&MAC||OP)) {
	var __om=IE4||IE5?gContainer.document.onmouseover:gContainer.document.onmouseup;
	if (IE4||IE5) gContainer.document.onmouseover=fOm;
	else gContainer.document.onmouseup=fOm;
}
function fOm(e){
	if(!e)e=gContainer.event;var t=e.target?e.target:e.srcElement;
	if(t.name!=self.name)__lastDrag=null;if(__om)__om(e)
}

var __lastDrag=null;
function fDragIt(y,m,d,aStat,e) {
	if (!fOnDrag||!(__lastDrag&&aStat>0||aStat==0)) return false;
	var dt=[y,m,d];
	if (aStat==1&&__lastDrag+''==dt+'') return false;
	__lastDrag=aStat==2||IE&&MAC||OP?null:dt;
	return fOnDrag(dt[0],dt[1],dt[2],aStat,e);
}

function fRepaint() {
	fSetCal(gCurMonth[0],gCurMonth[1],0,false,null);
}

function fUpdSelect(y,m,d,bDoNotReformat) {
	gdSelect[0]=y; gdSelect[1]=m; gdSelect[2]=d;
	if (!bDoNotReformat) gdCtrl.value=d==0?"":fFormatInput(y,m,d);
}

function fPopCalendar(dateCtrl,range,posLayerId,posCtrl,posOffset) {
	var dc=dateCtrl;
	var pc=posCtrl?posCtrl:dc;
	if (gdCtrl!=dc)
		gdCtrl=dc;
	else if (gfSelf.offsetLeft>0) {
		fHideCal();
		return;
	}
	var s=fParseInput(gdCtrl.value);
	if (s==null) {
		if (__gdos[2]==0) {
			s=eval(gTheme[0]);
			fUpdSelect(0,0,0);
		} else {
			s=__gdos;
			fUpdSelect(s[0],s[1],s[2]);
		}
	} else fUpdSelect(s[0],s[1],s[2],true);
	fInitRange(range);
	if (gRange[2]&&fIsOutRange(s[0],s[1])) {
		fUpdSelect(0,0,0);
		s=gRange[2];
	}
	if (!fSetCal(s[0],s[1],0,true,null)) {
		fUpdSelect(0,0,0);
		fHideCal();
		return;
	}
	var p,oh,isFixed=posOffset?posOffset[2]:gbFixedPos;
	if (isFixed) {
		p=posOffset?posOffset:gPosOffset;
		oh=-1;
	} else {
		p=fGetXY(pc,posOffset?posOffset:gPosOffset);
		if (posLayerId) {
			var lyr=fGetById(parent.document,posLayerId);
			if (lyr&&lyr.tagName.toUpperCase()=="IFRAME") {
				var pl=fGetXY(lyr);
				var p2=fGetWinSize(parent.frames[posLayerId]).slice(2);
				p[0]+=pl[0]-p2[0];
				p[1]+=pl[1]-p2[1];
			}
		}
		var oh=pc.offsetHeight;
		var ptb=fGetById(document,"outerTable");
		var h=ptb.offsetHeight;
		var w=ptb.offsetWidth;
		h=(h?h:gfSelf.height)+oh;
		if (gbAutoPos) {
			var ws=fGetWinSize(parent);
			var tmp=ws[0]+ws[2]-(w?w:gfSelf.width);
			p[0]=p[0]<ws[2]?ws[2]+2:p[0]>tmp?tmp:p[0];
			tmp=ws[1]+ws[3]-h;
			if (p[1]>tmp&&(!gbPopDown||p[1]-ws[3]+oh>=h)) 
				p[1]-=oh>0?h+2:h+25;
		} else if (!gbPopDown) p[1]-=oh>0?h+2:h+25;
	}
	with (gfSelf.style) {
		left=p[0]+"px";
		top =p[1]+oh+1+"px";
	}
}

function fGetWinSize(w) {
	if (w.innerWidth)
		return [w.innerWidth-16,w.innerHeight,w.pageXOffset,w.pageYOffset];
	else if (w.document.compatMode=='CSS1Compat')
		with (w.document.documentElement) return [clientWidth,clientHeight,scrollLeft,scrollTop];
	else
		with (w.document.body) return [clientWidth,clientHeight,scrollLeft,scrollTop];
}

function fHideCal() {
	gfSelf.style.left="-500px";
	__lastDrag=null;
}

function fGetXY(a,offset) {
	var p=offset?offset.slice(0):[0,0],tn;
	while(a) {
		tn=a.tagName.toUpperCase();
		p[0]+=a.offsetLeft-(!KO3&&tn=="DIV"&&a.scrollLeft?a.scrollLeft:0);
		p[1]+=a.offsetTop-(!KO3&&tn=="DIV"&&a.scrollTop?a.scrollTop:0);
		if (tn=="BODY") break;
		a=a.offsetParent;
	}
	return p;
}

function fInitRange(r) {
	gRange=r?r:[];
	var rb=gRange[0]?r[0]:gBegin;
	gdBegin=new Date(rb[0],rb[1]-1,rb[2]);
	gRange[0]=rb;
	var re=gRange[1]?r[1]:gEnd;
	gdEnd=new Date(re[0],re[1]-1,re[2]);
	gRange[1]=re;
}

function fParseDate(ds) {
	var i,r=null,pd=[];
	if (!ds) return r;
	if (gsSplit.length>0) {
		pd=ds.split(gsSplit);
	} else {
		var yl=gbShortYear?2:4;
		if (giDatePos==2) { pd[0]=ds.substring(0,yl);pd[1]=ds.substring(yl,yl+2);pd[2]=ds.substring(yl+2,yl+4); }
		else { pd[0]=ds.substring(0,2);pd[1]=ds.substring(2,4);pd[2]=ds.substring(4,4+yl); }
	}
	if (pd.length==3) {
		var m=pd[giDatePos==1?0:1];
		for (i=0; (i<12)&&(gMonths[i].substring(0,3).toLowerCase()!=m.substring(0,3).toLowerCase())&&(i+1!=m); i++);
		if (i<12) {
			var y=parseInt(pd[giDatePos==2?0:2].substring(0,4),10);
			var pf=Math.floor(gEnd[0]/100)*100;
			r=[y<100?y>gEnd[0]%100?pf-100+y:pf+y:y,i+1,parseInt(pd[giDatePos],10)];
		} else return null;
	} else return null;
	var td=new Date(r[0],r[1]-1,r[2]);
	if (isNaN(td)||td.getMonth()!=r[1]-1) return null;
	return r;
}

function fFormatDate(y,m,d){
	var M=giMonthMode==0?gbPadZero&&m<10?"0"+m:m:giMonthMode==1?gMonths[m-1]:gMonths[m-1].substring(0,giMonthMode);
	var D=gbPadZero&&d<10?"0"+d:d;
	var sy=y%100;
	var Y=gbShortYear?sy<10?"0"+sy:sy:y;
	switch (giDatePos) {
		case 0: return D+gsSplit+M+gsSplit+Y;
		case 1: return M+gsSplit+D+gsSplit+Y;
		case 2: return Y+gsSplit+M+gsSplit+D;
	}
}

function fGetAgenda(y,m,d,taint) {
	var s=fCalibrate(y,m),cm=gCurMonth,oor=false;
	var def=["",gsAction,gcCellBG,null,guCellBGImg,false,gsCellHTML];
	if (taint) if ((giShowOther&4)&&(s[0]<cm[0]||s[0]==cm[0]&&s[1]<cm[1])||(giShowOther&8)&&(s[0]>cm[0]||s[0]==cm[0]&&s[1]>cm[1]))
		return null;
	var ag=fHoliday?fHoliday(s[0],s[1],d):fGetEvent(y,m,d);
	if (ag==null) ag=def;
	else {
		for (var i=0;i<7;i++) {
			if (gAgendaMask[i]!=-1) ag[i]=gAgendaMask[i];
			if (ag[i]==null&&i!=1) ag[i]=def[i];
		}
		if (taint&&s[1]!=cm[1]&&!(giShowOther&1)) {
			def[0]=ag[0]; def[1]=ag[1]; ag=null; ag=def;
		}
	}
	if (taint&&s[1]!=cm[1]) {
		if (gcOtherDayBG&&ag[2]==gcCellBG) ag[2]=gcOtherDayBG;
		ag[3]=gcOtherDay;
	}
	for (var i=3; i<gRange.length; i++)
		if (gRange[i][2]==d&&gRange[i][1]==s[1]&&gRange[i][0]==s[0])
			{ oor=true; break; }
	if (oor||!fValidRange(s[0],s[1],d)) {
		ag[0]=gsOutOfRange; ag[1]=null;
		if (guOutOfRange) ag[4]=guOutOfRange;
	}
	return ag;
}

function fGetDOW(y,m,d) {
	return (7+(new Date(y,m-1,d).getDay())-giFirstDOW)%7;
}

function fGetWeekNo(y,m,d) {
	var dow=fGetDOW(y,1,1);
	return Math.ceil(((Date.UTC(y,m-1,d)-Date.UTC(y,0,1))/MILLIDAY+dow-6)/7)+(dow<=3?1:0);
}

function fW2Date(y,w,wd) { // w > 0, wd > 0
	var dow=fGetDOW(y,1,1);
	if (dow<=3) w--;
	var date=new Date(new Date(y,0,1)-0+(w*7+wd-dow-1)*MILLIDAY);
	return [date.getFullYear(),date.getMonth()+1,date.getDate()];
}

function fDate2W(y,m,d) {
	var w=fGetWeekNo(y,m,d), wd=fGetDOW(y,m,d)+1;
	if (w==0) { y--; w=fGetWeekNo(y,12,31); }
	else if (w>52) {
		var w1=fGetWeekNo(y+1,1,1);
		if (w1>0) { y++; w=w1; }
	}
	return [y,w,wd];
}

function fValidRange(y,m,d) {
	var dt=new Date(y,m-1,d);
	return (dt>=gdBegin)&&(dt<=gdEnd);
}

function fGetDays(y) {
	gDays[2]=y%4==0&&y%100!=0||y%400==0?29:28;
	return gDays;
}

function fBuildCal(y,m) {
	var days=fGetDays(y),iDay1=fGetDOW(y,m,1);
	var iLast=days[m-1]-iDay1+1,iDate=1,iNext=1;
	for (var d=0;d<7;d++) {
		__cal[0][d][0]=d<iDay1?m-1:m;
		__cal[0][d][1]=d<iDay1?iLast+d:iDate++;
	}
	for (var w=1;w<6;w++)
		for (var d=0;d<7;d++) {
			__cal[w][d][0]=iDate<=days[m]?m:m+1;
			__cal[w][d][1]=iDate<=days[m]?iDate++:iNext++;
		}
}

function fIsOutRange(y,m) {
	return (y>gRange[1][0]||y<gRange[0][0]||y==gRange[0][0]&&m<gRange[0][1]||y==gRange[1][0]&&m>gRange[1][1]);
}
function fBfRange(y,m) {
	return y<gRange[0][0]||y==gRange[0][0]&&m<=gRange[0][1];
}
function fAfRange(y,m) {
	return y>gRange[1][0]||y==gRange[1][0]&&m>=gRange[1][1];
}
function fToggleNavs(y,m) {
	var n=fGetById(document,"navPrev"); if(n)n.style.visibility=fBfRange(y,m)?"hidden":"visible";
	n=fGetById(document,"navNext"); if(n)n.style.visibility=fAfRange(y,m)?"hidden":"visible";
}

function fCheckRange(y,m) {
	if (fIsOutRange(y,m)) {
		stopShowMon();
		if (gsOutOfRange!="") alert(gsOutOfRange);
		return false;
	}
	return true;
}

function fSetCal(y,m,d,bTriggerOnChg,e) {
	var t=fCalibrate(parseInt(y,10),parseInt(m,10));
	y=t[0];	m=t[1];
	if (!fCheckRange(y,m)||bTriggerOnChg&&fOnChange&&fOnChange(y,m,d,e)) {
		if (gcbMon) gcbMon.options[gCurMonth[1]-1].selected=true;
		if (gcbYear) gcbYear.options[gCurMonth[0]-gBegin[0]].selected=true;
		return false;
	}
	if (d>0) fUpdSelect(y,m,d);
	var iDiv=fGetById(document,"innerDiv");
	fGetById(document,"innerDiv").innerHTML=fDrawCal(y,m);
	if (gcbMon) gcbMon.options[m-1].selected=true;
	if (gcbYear) gcbYear.options[y-gBegin[0]].selected=true;
	if (!gbHideTop&&giDCStyle>0) fGetById(document,"calTitle").innerHTML=eval(gsCalTitle)+"\n";
	fToggleNavs(y,m);
	gcTemp=null;
	setTimeout("fResize()",giInitDelay+giResizeDelay);
	return true;
}

function fResize() {
	if (fOnResize) fOnResize();
	giInitDelay=0;
	var ptb=fGetById(document,"outerTable");
	if (!ptb) return;
	var ow=ptb.offsetWidth;
	var oh=ptb.offsetHeight;
	if (ow) gfSelf.style.width=ow+"px";
	if (oh) gfSelf.style.height=oh+"px";
}

function fSetDate(y,m,d,taint,e) {
	var ag=fGetAgenda(y,m,d,taint);
	if (ag==null||ag[1]==null) return false;
	if (!fSetCal(y,m,d,true,e)) return false;
	if (gbAutoClose) fHideCal();
	eval(ag[1]);
	if (fAfterSelected) fAfterSelected(y,m,d,e);
	return true;
}

function fPrevMonth(e) {
	return fSetCal(gCurMonth[0],gCurMonth[1]-1,0,true,e);
}
function fNextMonth(e) {
	return fSetCal(gCurMonth[0],gCurMonth[1]+1,0,true,e);
}
function showPrevMon() {
	if (!__stub[1]&&fPrevMonth()&&!fBfRange(gCurMonth[0],gCurMonth[1])) __stub[1]=setInterval("fPrevMonth()", giShowInterval);
}
function showNextMon() {
	if (!__stub[1]&&fNextMonth()&&!fAfRange(gCurMonth[0],gCurMonth[1])) __stub[1]=setInterval("fNextMonth()", giShowInterval);
}
function stopShowMon() {
	clearInterval(__stub[1]); __stub[1]=null;
}

function fMouseOver(t) {
	if (!gbFocus) return;
	gcTemp=t.style.backgroundColor;
	t.style.backgroundColor=gcToggle;
}

function fMouseOut(t) {
	if (!gbFocus||gcTemp==null) return;
	t.style.backgroundColor=gcTemp?gcTemp:"transparent";
}

function fHint(t,id) {
	t.title=__tis[id];
	gContainer.status=__tis[id];
}



var __sWH="<td class='WeekHead'><div style='position:relative;width:"+giWeekWidth+"px;top:"+giHeadTop+"px;'>",
__sCH="<td class='CalHead' bgcolor='82868A' style='color:ffffff;'><div style='position:relative;width:"+giCellWidth+"px;height:"+giHeadHeight+"px;top:"+giHeadTop+"px;'>",
__sWC="<td class='WeekCol'><div style='position:relative;width:100%;top:"+giWeekTop+"px;'>",
__sCC=" class='CalCol'><div class='CalCell' style='position:relative;width:100%;height:"+giCellHeight+"px;",
__sDIVTD="</div></td>",
__tis=[];

function fDrawCal(y,m) {
	var td,htm,bo,ag,i,c,c1,dayNo,dc,cbg,isT,isS,weekNo,cd,ex,bfb,sCellDate,sWkCol,weekYear;
	var ms=giMarkSelected,ht=giMarkToday;
	var a=["<TABLE width='100%' ",gsInnerTable,"><tr>"];
	gCurMonth[0]=y; gCurMonth[1]=m;
	fBuildCal(y,m);
	for (var wd=0,i=0; i<8; i++)
		if (i==giWeekCol) a.push(__sWH,gsWeekHead,__sDIVTD);
		else if (i!=7||giWeekCol>=0) a.push(__sCH,gWeekDay[wd++],__sDIVTD);
	a.push("</tr>");
	if (giWeekCol>=0) {
		var w=fDate2W(y,m,1);
		weekYear=w[0];
		weekNo=w[1];
	}
	for (var week=0; week<6; week++) {
		ex=week>3&&__cal[week][0][1]<20;
		if (gbShrink2fit&&ex) continue;
		a.push("<tr>");
		for (var day=-1,i=0; i<8; i++)
			if (i==giWeekCol) {
				sWkCol=fOnWeekClick?"<a class='WeekAnchor' href='javascript:void(0)' onfocus='if(this.blur)this.blur()' onclick='fOnWeekClick("+weekYear+","
       +weekNo+");return false;'>"+eval(gsWeeks)+"</a>":"<span class='WeekAnchor'>"+eval(gsWeeks)+"</span>";
				a.push(__sWC,(giShowOther&8)&&!(giShowOther&16)&&ex?"&nbsp;":sWkCol,__sDIVTD);
				if (m==1&&weekNo>50||m==12&&weekNo>=52&&weekNo>=fDate2W(y,12,31)[1]) {
					weekNo=0; weekYear++;
				}
				weekNo++;
			} else if (i!=7||giWeekCol>=0) {
				day++; dayNo=__cal[week][day][1];
				var tid=week*10+day;
				cd=fCalibrate(y,__cal[week][day][0]);
				isT=gToday[2]==dayNo&&gToday[1]==cd[1]&&gToday[0]==cd[0];
				ag=fGetAgenda(cd[0],cd[1],dayNo,true);
				if (ag==null) {
					dc=giShowOther&16&&(week<2&&(giShowOther&4)||week>3&&(giShowOther&8))?gcOtherDay:"";
					cbg=null; bo=false; __tis[tid]=td=htm=""; bfb=gbFlatBorder; c=c1=gcOtherDayBG;
				} else {
					isS=fIsSelected(cd[0],cd[1],dayNo)&&ag[1]!=null;
					cbg=ag[4]; dc=ag[3]==null?day==giSun?gcSun:day==giSat?gcSat:gcWorkday:ag[3];
					if (cd[1]==m||(giShowOther&2)) {
						c=isS&&(ms&2)?gcBGSelected:isT&&(ht&2)?gcBGToday:ag[2];
						c1=isS&&(ms&1)?gcBGSelected:ag[2]!=gcCellBG&&ag[5]!=true?ag[2]:isT&&(ht&1)?gcBGToday:gcCellBG;
						bo=isS&&(ms&4)||isT&&(ht&4);
						dc=isS&&(ms&8)?gcFGSelected:isT&&(ht&8)?gcFGToday:dc;
						cbg=isS&&(ms&16)?guSelectedBGImg:isT&&(ht&16)?guTodayBGImg:cbg;
					} else {
						bo=false; c=ag[2]; c1=ag[5]==true?gcCellBG:c;
					}
					bo=gbBoldAgenda&&ag[0]&&ag[0]!=gsOutOfRange||bo;
					bfb=gbFlatBorder&&c1!=gcCellBG;
					htm=ag[6]?ag[6]:"";
					td=ag[1]==null?";text-decoration:line-through":"";
					__tis[tid]=isS&&gsSelectedTip?gsSelectedTip:ag[0]?ag[0]:isT&&gsTodayTip?gsTodayTip:"";
					if (gcSunBG&&day==giSun) { c1=c1==gcCellBG?gcSunBG:c1; c=c==gcCellBG?gcSunBG:c; }
					if (gcSatBG&&day==giSat) { c1=c1==gcCellBG?gcSatBG:c1; c=c==gcCellBG?gcSatBG:c; }
				}
				if (gbInvertBold) bo=!bo;
				if (gbInvertBorder) bfb=!bfb;
				sCellDate=cd[0]+","+cd[1]+","+dayNo;
				a.push("<td valign='top'");if(c)a.push(" bgcolor='",c,"'");if(bfb)a.push(" style='border-style:solid;border-color:",c1,"'");a.push(__sCC);if(c1)a.push(";background-color:",c1);
				if(cbg)a.push(";background-image:url(",cbg,")");if(dc=="")a.push("' ><span class='CellAnchor'>&nbsp;</span>",__sDIVTD);else{
				a.push("' onmouseover='fHint(this,",tid,");fMouseOver(this);fDragIt(",sCellDate,",1,event);return true' onmouseout='fMouseOut(this)' onmousedown='if(!fDragIt(",sCellDate,",0,event))fSetDate(",sCellDate,",true,event);return false' onmouseup='fDragIt(",sCellDate,",2,event)'><A href='javascript:void(0)' class='CellAnchor' style='color:",dc);
				if(bo)a.push(";font-weight:bold");a.push(td,"' onmouseover='fHint(this,",tid,")' onfocus='if(this.blur)this.blur()'>",eval(gsDays),"</A>",htm,__sDIVTD);}
				ag=null;
			}
		a.push("</tr>");
	}
	a.push("</TABLE>\n");
	return a.join('');
}

with (document) {
	body.bgColor=gcCalBG;
	var a=["<TABLE id='outerTable' ",gsOuterTable,"><FORM name='cxpTopForm'>"];
	if (!gbHideTop)
	if (giDCStyle==2)
		a.push("<TR><TD class='CalTop' nowrap><SPAN id='calTitle' class='CalTitle'>",eval(gsCalTitle),"</SPAN></TD></TR>");
	else if (giDCStyle==1){
		a.push("<TR><TD class='CalTop' nowrap><table border=0 cellspacing=0 cellpadding=0 width='100%'><tr><TD align='left' nowrap>",gsNavPrev,"</TD><TD class='CalTitle' nowrap><SPAN id='calTitle'>");
		a.push(eval(gsCalTitle));
		a.push("</SPAN></TD><TD align='right' nowrap>",gsNavNext,"</TD></tr></table></TD></TR>");
	} else {
		a.push("<TR><TD class='CalTop' nowrap>",gsNavPrev," ");
		var mstr=["<SELECT id='MonSelect' class='CalTitle' onchange='fSetCal(gcbYear.value, gcbMon.value,0,true,event)'>"];
		for (var i=0; i<12; i++) mstr.push("<OPTION value='",i+1,"'>",gMonths[i],"</OPTION>");
		mstr.push("</SELECT>"); mstr=mstr.join('');
		var ystr=["<SELECT id='YearSelect' class='CalTitle' onchange='fSetCal(gcbYear.value, gcbMon.value,0,true,event)'>"];
		for(var i=gBegin[0];i<=gEnd[0];i++)
			ystr.push("<OPTION value='",i,"'>",i,"</OPTION>");
		ystr.push("</SELECT>"); ystr=ystr.join('');
		if (gbDCSeq) a.push(mstr,ystr);
		else a.push(ystr,mstr);
		a.push(" ",gsNavNext,"</TD></TR>");
	}
	a.push("</FORM><TR><TD class='CalMiddle'><DIV id='innerDiv' style='background:",gcCalFrame,guCalBG?" url("+guCalBG+") ":"",";'></DIV></TD></TR>");
	if (!gbHideBottom) a.push("<FORM name='cxpBottomForm'><TR><TD class='CalBottom' nowrap>",gsBottom,"</TD></TR></FORM>");
	a.push("</TABLE>");
	for (var i=0;i<giFreeDiv;i++)
		a.push("<DIV class='FreeDiv' id='freeDiv",i,"' style='position:absolute;visibility:hidden;z-index:500'></DIV>");
	write(a.join(''));
	close();
}
</script>
<script type='text/javascript'>
if (giDCStyle==0) {
	gcbMon=fGetById(document,"MonSelect");
	gcbYear=fGetById(document,"YearSelect");
}
if (!gTheme[3]) gTheme[3]="gfPop";
if (gTheme[2]&&!__isAS) document.write("<scr"+"ipt type='text/javascript' src='"+gTheme[2]+(gbCacheAgenda?"":(/\?/.test(gTheme[2])?"&":"?")+gd.getTime())+"'></scr"+"ipt>");
</script>
<script type='text/javascript'>eval("parent."+gTheme[3]+"=parent.frames[self.name]");</script>

</body>
</html>
