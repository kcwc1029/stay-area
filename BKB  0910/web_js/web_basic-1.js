// JavaScript Document

function SF01(A,B,C,D,E){
//alert(D+","+E);
//if(D != ""){
FM01.PK01.value=D;
//}
//if(E != ""){
FM01.PK02.value=E;
//}
FM01.target=C;
FM01.action=A+"."+B;
//alert(A+"/"+B+"/"+C+"/"+D+"/"+E);
FM01.submit();
}

function SF99(A,B,C){
alert(C);
location.href=A+"."+B;
}

function PG01(A,B){
FM01.PNO01.value=A;
FM01.target="_self";
FM01.action=B;
//alert(B);
//alert(A);
FM01.submit();
}
function Add3Zero(A){
	B=A.value;
	j=B.length;
	if(j==0)return;
	for(i=0;i<3-j;i++){
		B="0"+B;
	}
	A.value=B;
}
function Add4Zero(A){
	B=A.value;
	j=B.length;
	if(j==0)return;
	for(i=0;i<4-j;i++){
		B="0"+B;
	}
	A.value=B;
}
function Add5Zero(A){
	B=A.value;
	j=B.length;
	if(j==0)return;
	for(i=0;i<5-j;i++){
		B="0"+B;
	}
	A.value=B;
}

/*
function SF02(A,B,C,D){
FM01.target=C;
FM01.action=A+"."+B;
FM01.PK01.value=D;
FM01.submit();
}
*/
/*
function add_new_data() {
var num = document.getElementById("mytable").rows.length;
alert(num);
	//var num = document.getElementById("mytable").rows.length;
	var Tr = document.getElementById("mytable").insertRow(num);
	Td = Tr.insertCell(Tr.cells.length);
	Td.innerHTML = '<table width="50" border="0" cellspacing="0" cellpadding="5"><tr><td width="1%" nowrap="nowrap" class="text13">檔案標題：</td><td><table width="50" border="0" cellspacing="0" cellpadding="0"><tr><td><select name="KDC002009'+num+'" id="KDC002009'+num+'"><option>-請選擇檔案格式-</option><option>WORD</option><option>EXCEL</option><option>PPT</option><option>PDF</option></select></td><td>&nbsp;</td><td><input name="KDC002005'+num+'" type="text" class="formstyle" id="KDC002005'+num+'" size="51"></td></tr></table></td></tr><tr><td width="1%" nowrap="nowrap" class="text13">選取檔案：</td><td><input name="KDC002004" type="file" class="formstyle" id="KDC002004" size="64"></td></tr></table>';
    document.getElementById("mytable").refresh();
}
*/


//通用函式

//extra height in px to add to iframe in FireFox 1.0+ browsers
var getFFVersion=navigator.userAgent.substring(navigator.userAgent.indexOf("Firefox")).split("/")[1]
var FFextraHeight=getFFVersion>=0.1? 16 : 0

function dyniframesize(iframename) {
//alert(document.getElementById(iframename));
var pTar = null;
if (document.getElementById){
pTar = document.getElementById(iframename);
} else {
eval('pTar = ' + iframename + ';');
}
if (pTar && !window.opera){
//begin resizing iframe
pTar.style.display="block"
if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){
//ns6 syntax
//pTar.height = pTar.contentDocument.body.offsetHeight+FFextraHeight;
pTar.height = pTar.contentWindow.document.body.scrollHeight;
//alert(FFextraHeight);
} else if (pTar.Document && pTar.Document.body.scrollHeight){
//ie5+ syntax
pTar.height = pTar.Document.body.scrollHeight;
}
}
}
<!--
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

//表單檢驗
function YY_checkform() { //v4.71
//copyright (c)1998,2002 Yaromat.com
  var a=YY_checkform.arguments,oo=true,v='',s='',err=false,r,o,at,o1,t,i,j,ma,rx,cd,cm,cy,dte,at;
  for (i=1; i<a.length;i=i+4){
    if (a[i+1].charAt(0)=='#'){r=true; a[i+1]=a[i+1].substring(1);}else{r=false}
    o=MM_findObj(a[i].replace(/\[\d+\]/ig,""));
    o1=MM_findObj(a[i+1].replace(/\[\d+\]/ig,""));
    v=o.value;t=a[i+2];
    if (o.type=='text'||o.type=='password'||o.type=='hidden'){
      if (r&&v.length==0){err=true}
      if (v.length>0)
      if (t==1){ //fromto
        ma=a[i+1].split('_');if(isNaN(v)||v<ma[0]/1||v > ma[1]/1){err=true}
      } else if (t==2){
        rx=new RegExp("^[\\w\.=-]+@[\\w\\.-]+\\.[a-zA-Z]{2,4}$");if(!rx.test(v))err=true;
      } else if (t==3){ // date
        ma=a[i+1].split("#");at=v.match(ma[0]);
        if(at){
          cd=(at[ma[1]])?at[ma[1]]:1;cm=at[ma[2]]-1;cy=at[ma[3]];
          dte=new Date(cy,cm,cd);
          if(dte.getFullYear()!=cy||dte.getDate()!=cd||dte.getMonth()!=cm){err=true};
        }else{err=true}
      } else if (t==4){ // time
        ma=a[i+1].split("#");at=v.match(ma[0]);if(!at){err=true}
      } else if (t==5){ // check this 2
            if(o1.length)o1=o1[a[i+1].replace(/(.*\[)|(\].*)/ig,"")];
            if(!o1.checked){err=true}
      } else if (t==6){ // the same
            if(v!=MM_findObj(a[i+1]).value){err=true}
      }
    } else
    if (!o.type&&o.length>0&&o[0].type=='radio'){
          at = a[i].match(/(.*)\[(\d+)\].*/i);
          o2=(o.length>1)?o[at[2]]:o;
      if (t==1&&o2&&o2.checked&&o1&&o1.value.length/1==0){err=true}
      if (t==2){
        oo=false;
        for(j=0;j<o.length;j++){oo=oo||o[j].checked}
        if(!oo){s+='* '+a[i+3]+'\n'}
      }
    } else if (o.type=='checkbox'){
      if((t==1&&o.checked==false)||(t==2&&o.checked&&o1&&o1.value.length/1==0)){err=true}
    } else if (o.type=='select-one'||o.type=='select-multiple'){
      if(t==1&&o.selectedIndex/1==0){err=true}
    }else if (o.type=='textarea'){
      if(v.length<a[i+1]){err=true}
    }
    if (err){s+='* '+a[i+3]+'\n'; err=false}
  }
  if (s!=''){alert('您 所 送 出 的 資 料 ， 發 現 以 下 錯 誤 ：\t\t\t\t\t\n\n'+s)}
  document.MM_returnValue = (s=='');
}

//日期選取
var sDate = new Array();
var mName = new Array("一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月")
var wName = new Array("日","一","二","三","四","五","六")
var cFontName = "細明體, 新細明體, 標楷體;"
var KW_color = new Array("#ffffff","#FFDD11","#ECF0D9","#f5f5f5","#ccffcc","#cccccc","#829165","#A2AD8C") 
                       //年月文字顏色,今天區塊顏色,假日區塊顏色,一般日期區塊顏色,未知,上月與下月區塊顏色,背景色,星期區塊顏色
var KW_cl=0;
var KW_od=-1;
var KW_tmo=0;
var KW_cWidth=170;
var KW_fd=-1;
var descx=-1;
var descy=-1;
var bwNN=(document.captureEvents)?1:0;
function popmousemove(e){descx=(bwNN)?e.pageX:event.x;descy=(bwNN)?e.pageY:event.y}
function KW_mouseInit(){
	if(bwNN)document.captureEvents(Event.MOUSEMOVE);document.onmousemove=popmousemove;
}
function m_class(m,d,y) { 
	this.month=m;this.day=d;this.year=y;
	var m1=(this.month>9)?this.month:"0"+this.month;
	var d1=(this.day>9)?this.day:"0"+this.day;
	this.output=this.year+""+m1+d1;
	var kd=new Date();this.special=checkDates(this.year,this.month,this.day)
	this.today=((kd.getMonth()+1)==this.month && kd.getDate()==this.day && kd.getFullYear()==this.year)
	var td=new Date(this.year, (this.month-1), this.day+KW_od);this.past=(KW_od==-1)?0:(kd>td)
	var tf=new Date(kd.getFullYear(),kd.getMonth(),kd.getDate()+KW_fd);
	var d1=new Date(this.year, (this.month-1), this.day);
	this.future=(KW_fd==-1)?0:(tf<d1);
}

function checkDates(m1,d1,y1) { //v2.1.5
	var rStr=false;for(var i=0;i<sDate.length;i++) {var tDate=sDate[i].split(",");
		if (tDate[2]=="*" || tDate[2]==y1) {if (tDate[1]==d1 && tDate[0]==m1)	rStr=true;
		}}return rStr;
}

function KW_doCalendar(obj,E,m,y) { //v2.3.0
  
  var d=new Date();f=0;d.setDate(1);if (!m && m!=0) {m=d.getMonth();f=KW_cl}
  if (f==1 && MM_findObj('KW_selectedMonth').value!=-1) 
  m=MM_findObj('KW_selectedMonth').value-1;d.setMonth(m);	
  if (!y) y=d.getFullYear();if (f==1 && MM_findObj('KW_selectedYear').value!=-1) 
  y=MM_findObj('KW_selectedYear').value;d.setFullYear(y);dy=d.getDay();if (!E) E=0;
  if(E==1)dy=(dy==0)?6:dy-1;dP=new Date();dP.setMonth(m);dP.setDate(0);
  pStart=dP.getDate()-dy+1;dStr=new Array();for (i=pStart;i<dP.getDate()+1;i++) { tmo=(KW_tmo)?"":i;
  tMonth=(m==0)?"12":m;tYear=(m==0)?y-1:y;dStr[dStr.length]=new m_class(tMonth,tmo,tYear);
  }EOM=false;for (i=1;!EOM;i++){d.setDate(i);if (m!=d.getMonth()) EOM=true; else { 
  dStr[dStr.length]=new m_class((Number(m)+1),i,y);}}cnt=1;si=0;
  if(E==1)si=(d.getDay()==0)?6:d.getDay()-1;else si=d.getDay();	for (i=si;i<7;i++) {
  tMonth=(m==11)?"1":Number(m)+2;tYear=(m==11)?Number(y)+1:y; tmo=(KW_tmo)?"":cnt;
  dStr[dStr.length]=new m_class(tMonth,tmo,tYear); cnt++;}pM=(m==0)?11:m-1;
  pY=(m==0)?y-1:y;nM=(m==11)?0:Number(m)+1;nY=(m==11)?Number(y)+1:y;
  var yTH = y-1911;
  wStr="<html><head><style type=\"text/css\"><!--td {  font-family: "+cFontName+" font-size: 12px; }\n.tblHdr { font-weight: bold; color: "+KW_color[0]+"; background-color: "+KW_color[6]+" }\n.subTbl{ color: "+KW_color[0]+"; background-color: "+KW_color[7]+";  text-align: center}-->\n</style>\n<title>"+(y-1911)+" 年 "+mName[m]+"</title>\n</head>\n<body   bgcolor=\"#829165\" topmargin=\"0\" marginwidth=\"0\" marginheight=\"0\" leftmargin=\"0\" onLoad=\"window.focus()\">\n<table width=\"100%\" border=\"0\" cellspacing=\"0\">\n<tr>\n<td bgcolor=\""+KW_color[6]+"\">\n<table width=\"100%\" border=0>\n"
  wStr+="<tr>\n<td align=center bgcolor=\""+KW_color[6]+"\" class=\"tblHdr\" colspan=\"4\"><a href=\"javascript:window.opener.KW_doCalendar('"+obj+"',"+E+",'"+pM+"','"+pY+"');\" class=\"tblHdr\">&laquo</a>&nbsp;&nbsp;"+mName[m]+"&nbsp;&nbsp;<a href=\"javascript:window.opener.KW_doCalendar('"+obj+"',"+E+",'"+nM+"','"+nY+"');\"  class=\"tblHdr\">&raquo</a></td>\n<td colspan=3 align=center class=\"tblHdr\"><a href=\"javascript:window.opener.KW_doCalendar('"+obj+"',"+E+",'"+m+"','"+(y-1)+"');\" class=\"tblHdr\">&laquo</a>&nbsp;&nbsp;"+yTH+"&nbsp;&nbsp;<a href=\"javascript:window.opener.KW_doCalendar('"+obj+"',"+E+",'"+m+"','"+(Number(y)+1)+"');\"  class=\"tblHdr\">&raquo</a></td>\n</tr>\n"
  wStr+="<tr>\n";for(wdn=0;wdn<7;wdn++)wStr+="<td class=\"subTbl\">"+wName[wdn]+"</td>\n";wStr+="</tr>\n"
  for (x=0;x<parseInt(dStr.length/7);x++) {	wStr+="<tr>\n";	for (y=0;y<7;y++) {
  yT=(E==1)?5:0;bC=(y==yT||y==6)?KW_color[2]:KW_color[3];
  if ((Number(m)+1)!=dStr[x*7+y].month) bC=KW_color[5]; if (dStr[x*7+y].special) 
  bC=KW_color[4];if (dStr[x*7+y].today) bC=KW_color[1];
  a0=(KW_cl!=1)?"":"window.opener.MM_findObj('KW_selectedMonth',window.opener.document).value='"+dStr[x*7+y].month+"';window.opener.MM_findObj('KW_selectedYear',window.opener.document).value='"+dStr[x*7+y].year+"'; "  
  a1=(dStr[x*7+y].past || dStr[x*7+y].future)?"":"<a href=\"javascript:window.opener.MM_findObj('"+obj+"',window.opener.document).value='"+dStr[x*7+y].output+"';"+a0+" window.close();\" >";
  a2=(dStr[x*7+y].past || dStr[x*7+y].future)?"":"</a>";
  wStr+="<td align=\"center\" bgcolor="+bC+">"+a1+dStr[x*7+y].day+a2+"</td>\n";
	}	wStr+="</tr>\n";}	wStr+="<tr><td colspan=7></td></tr></table></td></tr></table></body></html>";
	var screenX=(self.screenX)?self.screenX+20:window.screenLeft
	var screenY=(self.screenY)?self.screenY+70:window.screenTop
	var w =(descx==-1)?parseInt(screen.width/2-75):descx+screenX;
	var h=(descy==-1)?parseInt(screen.height/2-75):descy+screenY;
	var look='width='+KW_cWidth+',height=140,left='+w+',top='+h;	popwin=window.open('','calendar',look);
	popwin.document.open();	popwin.document.write(wStr);	popwin.document.close();
}

var Today=new Date();
// jquery 日曆 ui 設定
var opt={
   dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
   dayNamesMin:["日","一","二","三","四","五","六"],
   monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
   monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
   prevText:"上月",
   nextText:"次月",
   weekHeader:"週",
   showMonthAfterYear:true,
   showOtherMonths: true,
   selectOtherMonths: true,
   dateFormat:"Rmmdd", //R為自己寫的民國年，若要西元年則為yy
   firstDay: 1,      //設定日曆起始為星期幾
   showOn: "focus",   //設定是否在input項目右邊顯示按鈕或圖片
   buttonText: "日曆",//設定按鈕文字
   buttonImage: "../web_img/calendar.png", //設定按鈕背景圖，以此檔案所在位置為位置起始點
   buttonImageOnly: true, //設定是否只顯示圖片
   changeYear : true,  //顯示年度下拉式選單
   changeMonth : true,  //顯示月份下拉式選單
   //yearRange: "1912:"+Today.getFullYear()  //顯示年度區間，未設定預設為當年度前後+-10年
   yearRange: "1912:2111"  //顯示年度區間，未設定預設為當年度前後+-10年
   };
//-->


$.fn.postData = function(method, url, type, bAsync, dataList, fName, callBackFunction, callBackErrorFunction){
  $.ajax({
    type: method,
    url: url,
    dataType: type,
    async: bAsync,
    data: dataList,
    success: callBackFunction,
    error: callBackErrorFunction
  });
}