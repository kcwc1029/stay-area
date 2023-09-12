<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
//取得日期
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
%>
<%
String MSG01 = "";
String FTYPE = SQLIJ(request.getParameter("FTYPE"));
String SENDURL = SQLIJ(request.getParameter("SENDURL"));
String BKA002001 = SQLIJ(request.getParameter("BKA002001"));
String BKA002002 = SQLIJ(request.getParameter("BKA002002"));
String BKA003001 = SQLIJ(request.getParameter("BKA003001"));
//計算流水號
if(FTYPE.equals("A") && BKA003001.equals("")){   //判斷是否新增取編號
	BKA003001 = UUID.randomUUID().toString();
}
String BKA003002 = SQLIJ(request.getParameter("BKA003002"));
String BKA003003 = SQLIJ(request.getParameter("BKA003003"));
String BKA003004 = SQLIJ(request.getParameter("BKA003004"));
BKA003004 = BKA003004.replace("/","");
//日期是否有在場次接種日期內
SQL01 = "SELECT * FROM BKA002 WHERE BKA002001 = '"+BKA002001+"'"; //宣告SQL語法
RS01 = TAB01.buildMaps(SQL01);
if(RS01.length !=0){
	if(Double.parseDouble(BKA003004) >= Double.parseDouble(RS01[0].get("BKA002009").toString()) && Double.parseDouble(BKA003004) <= Double.parseDouble(RS01[0].get("BKA002010").toString())){
		//out.print("接種時間符合");
	}else{
		MSG01 = "接種時間不符合，請重新輸入";
		//out.print("接種時間不符合，請重新輸入");
		//return;
	}
}
String BKA003005 = SQLIJ(request.getParameter("BKA003005"));
String BKA003006 = SQLIJ(request.getParameter("BKA003006"));
String BKA003007 = SQLIJ(request.getParameter("BKA003007"));
String BKA003008 = SQLIJ(request.getParameter("BKA003008"));
String BKA003009 = SQLIJ(request.getParameter("BKA003009"));
String BKA003010 = SQLIJ(request.getParameter("BKA003010"));
String BKA003011 = SQLIJ(request.getParameter("BKA003011"));
String BKA003012 = SQLIJ(request.getParameter("BKA003012"));
String BKA003901 = SQLIJ(request.getParameter("BKA003901"));
String BKA003902 = SQLIJ(request.getParameter("BKA003902"));
String BKA003903 = SQLIJ(request.getParameter("BKA003903"));
String BKA003904 = SQLIJ(request.getParameter("BKA003904"));
String BKA003905 = SQLIJ(request.getParameter("BKA003905"));

if(FTYPE.equals("A")){
	String URA004_MSG = URA004_Log(USERID,SC01,BKA003001,BKA003002,"新增接種量能維護",URA004006);
}else if(FTYPE.equals("U")){
	String URA004_MSG = URA004_Log(USERID,SC01,BKA003001,BKA003002,"修改接種量能維護",URA004006);
}else{
	out.print("嚴重錯誤，請洽系統管理員");
	return;
}
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Covid-19疫苗施打量能調查平台</title>
</head>

<body>
<iframe name="IFM01" style="display:none"></iframe>
<form id="FM01" name="FM01" method="post" action="">
  <input name="BKA002001" type="hidden" id="BKA002001" value="<%=BKA002001%>" />
  <input name="BKA002002" type="hidden" id="BKA002002" value="<%=BKA002002%>" />
  <input name="BKA003001" type="hidden" id="BKA003001" value="<%=BKA003001%>" />
  <input name="BKA003002" type="hidden" id="BKA003002" value="<%=BKA003002%>" />
  <input name="BKA003003" type="hidden" id="BKA003003" value="<%=BKA003003%>" />
  <input name="BKA003004" type="hidden" id="BKA003004" value="<%=BKA003004%>" /> 
  <input name="BKA003005" type="hidden" id="BKA003005" value="<%=BKA003005%>" />
  <input name="BKA003006" type="hidden" id="BKA003006" value="<%=BKA003006%>" />
  <input name="BKA003007" type="hidden" id="BKA003007" value="<%=BKA003007%>" />
  <input name="BKA003008" type="hidden" id="BKA003008" value="<%=BKA003008%>" />
  <input name="BKA003009" type="hidden" id="BKA003009" value="<%=BKA003009%>" />
  <input name="BKA003010" type="hidden" id="BKA003010" value="<%=BKA003010%>" />
  <input name="BKA003011" type="hidden" id="BKA003011" value="<%=BKA003011%>" />
  <input name="BKA003012" type="hidden" id="BKA003012" value="<%=BKA003012%>" />
  <input name="BKA003901" type="hidden" id="BKA003901" value="<%=BKA003901%>" />
  <input name="BKA003902" type="hidden" id="BKA003902" value="<%=BKA003902%>" />
  <input name="BKA003903" type="hidden" id="BKA003903" value="<%=BKA003903%>" />
  <input name="BKA003904" type="hidden" id="BKA003904" value="<%=BKA003904%>" />
  <input name="BKA003905" type="hidden" id="BKA003905" value="<%=BKA003905%>" />
  <input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" />
  <input name="tabname" type="hidden" id="tabname" value="BKA003" />
  <input name="indkey" type="hidden" id="indkey" value="3" />
  <input name="sendmsg" type="hidden" id="sendmsg" value="<%= FTYPE.equals("A") ? "新增成功" : "修改成功" %>" />
  <input name="sendurl" type="hidden" id="sendurl" value="../web_page/<%=SENDURL%>.jsp" />
  <input name="PK01" type="hidden" id="PK01" value="BKA002001" />
  <input name="PK01V" type="hidden" id="PK01V" value="<%=BKA002001%>" />
  <input name="PK02" type="hidden" id="PK02" value="BKA002002" />
  <input name="PK02V" type="hidden" id="PK02V" value="<%=BKA002002%>" />
</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
<script type="text/javascript">
  <%if(!MSG01.equals("")){%>
  Swal.fire({
	position: 'center',
	title: '<%=MSG01%>',
	//showDenyButton: true,
	//showCancelButton: true,
	//denyButtonText:'',
	confirmButtonText:'返回',
	allowEscapeKey: false,
	allowOutsideClick: false
	}).then((result) => {
		if (result.isConfirmed) {
			FM01.target = "_self";
			FM01.action = "BKB020102.jsp";
			FM01.submit();
		} else if (result.isDenied) {
			return;
		}
	});
  <%}else{%>
  FM01.target = "_self";
  FM01.action="<%= FTYPE.equals("A") ? "../web_script/KDY010100.jsp" : "../web_script/KDY010200.jsp"%>";
  FM01.submit();
  <%}%>
</script>
</body>
</html>

<%
DB01.close();
%>

