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
// TODO: 
// 1.新增公司內部紀錄:BKA008901-BKA008905
//   依照傳遞過來的FTYPE值判斷新增/更新
//   更新的話，BKA008902要取BKA008904的值


Database DB01 = new Database("BK");
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01="";
String table="BKA008";


String SENDURL = "../web_page/BKB060100.jsp";
String FTYPE = SQLIJ(request.getParameter("FTYPE"));
String BKA008001 = SQLIJ(request.getParameter("BKA008001"));// 大類
String BKA008002 = SQLIJ(request.getParameter("BKA008002"));// 大類
BKA008002 = TAB01.getCol("UBZ002", "UBZ002008", "UBZ002001+UBZ002002+UBZ002003+UBZ002004", "'"+BKA008002+"'");
// SELECT UBZ002008 FROM UBZ002 WHERE UBZ002001+UBZ002002+UBZ002003+UBZ002004='BKB0101002'


String BKA008003 = SQLIJ(request.getParameter("BKA008003"));// 小類
String BKA008004 = SQLIJ(request.getParameter("BKA008004"));// 名稱
String BKA008005 = SQLIJ(request.getParameter("BKA008005"));// 型號
String BKA008006 = SQLIJ(request.getParameter("BKA008006"));// 數量
String BKA008007 = SQLIJ(request.getParameter("BKA008007"));// 單位
String BKA008008 = SQLIJ(request.getParameter("BKA008008"));// 描述
String BKA008009 = SQLIJ(request.getParameter("BKA008009"));// 有效時間
String URA004_MSG ="";

// 新增公司內部紀錄
String BKA008901 = SQLIJ(request.getParameter("BKA008901"));// 
String BKA008902 = SQLIJ(request.getParameter("BKA008902"));// 
String BKA008903 = SQLIJ(request.getParameter("BKA008903"));//
String BKA008904 = SQLIJ(request.getParameter("BKA008904"));// 
String BKA008905 = SQLIJ(request.getParameter("BKA008905"));// 內部其他資訊備註




SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
Date currentDate = new Date();
if(FTYPE.equals("A")){
  out.print("A");
  BKA008001=UUID.randomUUID().toString();
  // BKA008009 = dateFormat.format(currentDate).substring(0, 8); // 提取年份、月份和日期
  BKA008009=BKA008904.substring(0, 8);
  URA004_MSG = URA004_Log(USERID,SC01,BKA008001,BKA008002,"新增庫存維護",URA004006);
}
else if(FTYPE.equals("U")){
  out.print("U");
  SQL01="SELECT * FROM "+table+" WHERE BKA008001 = '"+BKA008001+"'";
  RS01 = TAB01.buildMaps(SQL01);
	BKA008901=RS01[0].get("BKA008901").toString();
  BKA008902=RS01[0].get("BKA008904").toString();
	BKA008903=RS01[0].get("BKA008903").toString();
	BKA008904=dateFormat.format(currentDate);
	BKA008905=RS01[0].get("BKA008905").toString();

  URA004_MSG = URA004_Log(USERID,SC01,BKA008001,BKA008002,"修改庫存維護",URA004006);
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
<!-- 隱藏表單-->
<form id="FM01" name="FM01" method="post" action="">
  <input name="BKA008001" type="hidden" id="BKA008001" value="<%=BKA008001%>" />
  <input name="BKA008002" type="hidden" id="BKA008002" value="<%=BKA008002%>" />
  <input name="BKA008003" type="hidden" id="BKA009003" value="<%=BKA008003%>" />
  <input name="BKA008004" type="hidden" id="BKA008004" value="<%=BKA008004%>" /> 
  <input name="BKA008005" type="hidden" id="BKA008005" value="<%=BKA008005%>" />
  <input name="BKA008006" type="hidden" id="BKA008006" value="<%=BKA008006%>" />
  <input name="BKA008007" type="hidden" id="BKA008007" value="<%=BKA008007%>" />
  <input name="BKA008008" type="hidden" id="BKA008008" value="<%=BKA008008%>" />
  <input name="BKA008009" type="hidden" id="BKA008009" value="<%=BKA008009%>" />

  <input name="BKA008901" type="hidden" id="BKA008901" value="<%=BKA008901%>" />
  <input name="BKA008902" type="hidden" id="BKA008902" value="<%=BKA008902%>" />
  <input name="BKA008903" type="hidden" id="BKA008903" value="<%=BKA008903%>" />
  <input name="BKA008904" type="hidden" id="BKA008904" value="<%=BKA008904%>" />
  <input name="BKA008905" type="hidden" id="BKA008905" value="<%=BKA008905%>" />
  <input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" />
  <input name="indkey" type="hidden" id="indkey" value="2" />
  <input name="tabname" type="hidden" id="tabname" value="BKA008" />
  <input name="sendmsg" type="hidden" id="sendmsg" value="<%= FTYPE.equals("A") ? "新增成功" : "修改成功" %>" />
  <input name="sendurl" type="hidden" id="sendurl" value="../web_page/BKB060100.jsp" />
</form>

  <script type="text/javascript">
  FM01.target = "_self";
  FM01.action="<%= FTYPE.equals("A") ? "../web_script/KDY010100.jsp" : "../web_script/KDY010200.jsp"%>";
  FM01.submit();
</script>

</body>
</html>

<%
DB01.close();
%>

