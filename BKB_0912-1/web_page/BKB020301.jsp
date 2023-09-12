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
String BKA004001 = SQLIJ(request.getParameter("BKA004001"));
String BKA004002 = SQLIJ(request.getParameter("BKA004002"));
String BKA004003 = SQLIJ(request.getParameter("BKA004003"));
String BKA004004 = SQLIJ(request.getParameter("BKA004004"));
String BKA004005 = SQLIJ(request.getParameter("BKA004005"));
String BKA004901 = SQLIJ(request.getParameter("BKA004901"));
String BKA004902 = SQLIJ(request.getParameter("BKA004902"));
String BKA004903 = SQLIJ(request.getParameter("BKA004903"));
String BKA004904 = SQLIJ(request.getParameter("BKA004904"));
String BKA004905 = SQLIJ(request.getParameter("BKA004905"));

if(FTYPE.equals("A")){
	String URA004_MSG = URA004_Log(USERID,SC01,BKA004001,"","新增量能預約方式維護",URA004006);
}else if(FTYPE.equals("U")){
	String URA004_MSG = URA004_Log(USERID,SC01,BKA004001,"","修改量能預約方式維護",URA004006);
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
  <input name="BKA004001" type="hidden" id="BKA004001" value="<%=BKA004001%>" />
  <input name="BKA004002" type="hidden" id="BKA004002" value="<%=BKA004002%>" />
  <input name="BKA004003" type="hidden" id="BKA004003" value="<%=BKA004003%>" />
  <input name="BKA004004" type="hidden" id="BKA004004" value="<%=BKA004004%>" /> 
  <input name="BKA004005" type="hidden" id="BKA004005" value="<%=BKA004005%>" />
  <input name="BKA004901" type="hidden" id="BKA004901" value="<%=BKA004901%>" />
  <input name="BKA004902" type="hidden" id="BKA004902" value="<%=BKA004902%>" />
  <input name="BKA004903" type="hidden" id="BKA004903" value="<%=BKA004903%>" />
  <input name="BKA004904" type="hidden" id="BKA004904" value="<%=BKA004904%>" />
  <input name="BKA004905" type="hidden" id="BKA004905" value="<%=BKA004905%>" />
  <input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" />
  <input name="tabname" type="hidden" id="tabname" value="BKA004" />
  <input name="indkey" type="hidden" id="indkey" value="2" />
  <input name="sendmsg" type="hidden" id="sendmsg" value="<%= FTYPE.equals("A") ? "新增成功" : "修改成功" %>" />
  <input name="sendurl" type="hidden" id="sendurl" value="../web_page/<%=SENDURL%>.jsp" />
</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
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

