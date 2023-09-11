$(function(){
  //先設定預設西元年的datepicker必要功能
  var old_generateMonthYearHeader = $.datepicker._generateMonthYearHeader;
  var old_formatDate = $.datepicker.formatDate;
  var old_parseDate = $.datepicker.parseDate;

  $.extend($.datepicker, {
  //選擇日期之後的value
  formatDate: function (format, date, settings){
    var oformatDate = old_formatDate(format, date, settings);    
    if(format == 'R/mm/dd'){
      var d = date.getDate();
      var m = date.getMonth()+1;
      var y = date.getFullYear();            
      var fm = function(v){            
        return (v<10 ? '0' : '')+v;
      };

      if((y - 1911) >= 100) {y = y - 1911 ;}else if((y - 1911) < 10) {y = "00" + String(y - 1911);}else { y = "0" + String(y - 1911);}
        //return (y) + '/' + fm(m) + '/' + fm(d);
		return (y) + fm(m) + fm(d);
      }
      return oformatDate;
    },
    //點取已存在日期的parse
    parseDate: function(format, value, settings){
      var v = new String(value);
      var Y,M,D;
      if(format == 'R/mm/dd'){
        if(v.length == 9){/*1001215*/
          Y = v.substring(0,3)-0+1911;
          M = v.substring(4,6)-0-1;
          D = v.substring(7,9)-0;
          return (new Date(Y,M,D));
        }else if(v.length == 8){/*0981215*/
          Y = "0" + String(v.substring(0,2)-0+1911);
          M = v.substring(3,5)-0-1;
          D = v.substring(6,8)-0;
          return (new Date(Y,M,D));
        }
        return (new Date());
      }else{
        var oparseDate = old_parseDate.apply(this, [format, value, settings]);
        return (oparseDate);
      }
    },
    //改變小工具的年
    _generateMonthYearHeader: function (inst, drawMonth, drawYear, minDate, maxDate,    secondary, monthNames, monthNamesShort){
      var dateFormat = this._get(inst, "dateFormat");
      var htmlYearMonth = old_generateMonthYearHeader.apply(this, [inst, drawMonth, drawYear, minDate, maxDate, secondary, monthNames, monthNamesShort]);
      if(dateFormat == 'R/mm/dd'){
        if ($(htmlYearMonth).find(".ui-datepicker-year").length > 0) {
          htmlYearMonth = $(htmlYearMonth).find(".ui-datepicker-year").find("option").each(function (i, e) {
            //console.log(e.textContent);
            //if (Number(e.value) - 1911 > 0) {$(e).text(Number(e.textContent) - 1911);}
			if (Number(e.value) - 1911 >= 100) {$(e).text(Number(e.textContent) - 1911);}
			else if (Number(e.value) - 1911 < 10) {$(e).text("00" + (Number(e.textContent) - 1911));}
			else{$(e).text("0" + (Number(e.textContent) - 1911));}
          }).end().end().get(0).outerHTML;
        }
      }
      return htmlYearMonth;
    }
  });
});