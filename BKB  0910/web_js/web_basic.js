// JavaScript Document
  //日曆
//附件上傳顯示檔名
$().ready(function(){
    var Today = new Date();
	var nowDate = new Date(new Date().toLocaleDateString());//獲取當前時間
	var Tomorrow = new Date(nowDate.getTime()+24*60*60*1000);
    // jquery 日曆 ui 設定
    var opt = {
      dayNames: ["星期日" ,"星期一" ,"星期二" ,"星期三" ,"星期四" ,"星期五" ,"星期六"],
      dayNamesMin: ["日" ,"一" ,"二" ,"三" ,"四" ,"五" ,"六"],
      monthNames: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      monthNamesShort: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      // prevText: "上月",
      // nextText: "次月",
      weekHeader: "週",
      showMonthAfterYear: true,
      showOtherMonths: true,
      selectOtherMonths: true,
      dateFormat: "yy/mm/dd",
      firstDay: 1, //設定日曆起始為星期幾
      showOn: "focus", //設定是否在input項目右邊顯示按鈕或圖片
      buttonText: "日曆", //設定按鈕文字
      buttonImage: "../web_img/calendar.png", //設定按鈕背景圖，以此檔案所在位置為位置起始點
      buttonImageOnly: true, //設定是否只顯示圖片
      changeYear: true,  //顯示年度下拉式選單
      changeMonth: true,  //顯示月份下拉式選單
      hideIfNoPrevNext: true,
      duration: "",
	  minDate : Today,
      //yearRange: "1912:"+Today.getFullYear()  //顯示年度區間，未設定預設為當年度前後+-10年
	  yearRange: "1912:2032"
	  
	  //minDate : "1912-01-01"
    };
    $(".datepicker").datepicker(opt);
	var opt0 = {
      dayNames: ["星期日" ,"星期一" ,"星期二" ,"星期三" ,"星期四" ,"星期五" ,"星期六"],
      dayNamesMin: ["日" ,"一" ,"二" ,"三" ,"四" ,"五" ,"六"],
      monthNames: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      monthNamesShort: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      // prevText: "上月",
      // nextText: "次月",
      weekHeader: "週",
      showMonthAfterYear: true,
      showOtherMonths: true,
      selectOtherMonths: true,
      dateFormat: "Rmmdd",
      firstDay: 1, //設定日曆起始為星期幾
      showOn: "focus", //設定是否在input項目右邊顯示按鈕或圖片
      buttonText: "日曆", //設定按鈕文字
      buttonImage: "../web_img/calendar.png", //設定按鈕背景圖，以此檔案所在位置為位置起始點
      buttonImageOnly: true, //設定是否只顯示圖片
      changeYear: true,  //顯示年度下拉式選單
      changeMonth: true,  //顯示月份下拉式選單
      hideIfNoPrevNext: true,
      duration: "",
	  //minDate : Today,
      yearRange: "1912:"+Today.getFullYear()  //顯示年度區間，未設定預設為當年度前後+-10年
	  
	  //minDate : "1912-01-01"
    };
    $(".datepicker0").datepicker(opt0);
	var opt1 = {
      dayNames: ["星期日" ,"星期一" ,"星期二" ,"星期三" ,"星期四" ,"星期五" ,"星期六"],
      dayNamesMin: ["日" ,"一" ,"二" ,"三" ,"四" ,"五" ,"六"],
      monthNames: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      monthNamesShort: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      // prevText: "上月",
      // nextText: "次月",
      weekHeader: "週",
      showMonthAfterYear: true,
      showOtherMonths: true,
      selectOtherMonths: true,
      dateFormat: "yy/mm/dd",
      firstDay: 1, //設定日曆起始為星期幾
      showOn: "focus", //設定是否在input項目右邊顯示按鈕或圖片
      buttonText: "日曆", //設定按鈕文字
      buttonImage: "../web_img/calendar.png", //設定按鈕背景圖，以此檔案所在位置為位置起始點
      buttonImageOnly: true, //設定是否只顯示圖片
      changeYear: true,  //顯示年度下拉式選單
      changeMonth: true,  //顯示月份下拉式選單
      hideIfNoPrevNext: true,
      duration: "",
	  maxDate : Today,
      yearRange: "1912:"+Today.getFullYear()  //顯示年度區間，未設定預設為當年度前後+-10年
    };
	$(".datepicker1").datepicker(opt1);
	var opt2 = {
      dayNames: ["星期日" ,"星期一" ,"星期二" ,"星期三" ,"星期四" ,"星期五" ,"星期六"],
      dayNamesMin: ["日" ,"一" ,"二" ,"三" ,"四" ,"五" ,"六"],
      monthNames: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      monthNamesShort: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      // prevText: "上月",
      // nextText: "次月",
      weekHeader: "週",
      showMonthAfterYear: true,
      showOtherMonths: true,
      selectOtherMonths: true,
      dateFormat: "yy/mm/dd",
      firstDay: 1, //設定日曆起始為星期幾
      showOn: "focus", //設定是否在input項目右邊顯示按鈕或圖片
      buttonText: "日曆", //設定按鈕文字
      buttonImage: "../web_img/calendar.png", //設定按鈕背景圖，以此檔案所在位置為位置起始點
      buttonImageOnly: true, //設定是否只顯示圖片
      changeYear: true,  //顯示年度下拉式選單
      changeMonth: true,  //顯示月份下拉式選單
      hideIfNoPrevNext: true,
      duration: "",
	  minDate : Tomorrow,
      yearRange: "1912:"+Today.getFullYear()  //顯示年度區間，未設定預設為當年度前後+-10年
    };
	$(".datepicker2").datepicker(opt2);
	var opt3 = {
      dayNames: ["星期日" ,"星期一" ,"星期二" ,"星期三" ,"星期四" ,"星期五" ,"星期六"],
      dayNamesMin: ["日" ,"一" ,"二" ,"三" ,"四" ,"五" ,"六"],
      monthNames: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      monthNamesShort: ["一月" ,"二月" ,"三月" ,"四月" ,"五月" ,"六月" ,"七月" ,"八月" ,"九月" ,"十月" ,"十一月" ,"十二月"],
      // prevText: "上月",
      // nextText: "次月",
      weekHeader: "週",
      showMonthAfterYear: true,
      showOtherMonths: true,
      selectOtherMonths: true,
      dateFormat: "yy/mm/dd",
      firstDay: 1, //設定日曆起始為星期幾
      showOn: "focus", //設定是否在input項目右邊顯示按鈕或圖片
      buttonText: "日曆", //設定按鈕文字
      buttonImage: "../web_img/calendar.png", //設定按鈕背景圖，以此檔案所在位置為位置起始點
      buttonImageOnly: true, //設定是否只顯示圖片
      changeYear: true,  //顯示年度下拉式選單
      changeMonth: true,  //顯示月份下拉式選單
      hideIfNoPrevNext: true,
      duration: "",
	  maxDate : Tomorrow,
      yearRange: "1912:"+Today.getFullYear()  //顯示年度區間，未設定預設為當年度前後+-10年
    };
	$(".datepicker3").datepicker(opt3);
   });

//通用函式

//extra height in px to add to iframe in FireFox 1.0+ browsers
var getFFVersion=navigator.userAgent.substring(navigator.userAgent.indexOf("Firefox")).split("/")[1];
var FFextraHeight=getFFVersion>=0.1? 16 : 0;

function dyniframesize(iframename) {	
	var pTar = null;
	if (document.getElementById){
		pTar = document.getElementById(iframename);
	} else {
		eval('pTar = ' + iframename + ';');
	}
	if (pTar && !window.opera){
		//begin resizing iframe
		pTar.style.display="block";
		if (pTar.contentDocument && pTar.contentDocument.body.offsetHeight){
			//ns6 syntax
			//alert(pTar.contentDocument.body.scrollHeight);
			pTar.height = pTar.contentDocument.body.scrollHeight+FFextraHeight;
		} else if (pTar.Document && pTar.Document.body.scrollHeight){
			//ie5+ syntax
			pTar.height = pTar.Document.body.scrollHeight;
		}
		
	}
}


