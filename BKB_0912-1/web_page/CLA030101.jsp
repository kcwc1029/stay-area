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
Map[] RS03 = null;
String SQL02 = "";
%>
<%
String BKA007001 = SQLIJ(request.getParameter("BKA007001"));
String FTYPE = SQLIJ(request.getParameter("FTYPE"));
String SENDURL = SQLIJ(request.getParameter("SENDURL"));
//計算流水號
if(FTYPE.equals("A") && BKA007001.equals("")){   //判斷是否新增取編號
	out.print("嚴重錯誤，請洽系統管理員");
	return;
}	
String BKA007002 = SQLIJ(request.getParameter("BKA007002"));
String BKA007003 = SQLIJ(request.getParameter("BKA007003"));
String BKA007004 = SQLIJ(request.getParameter("BKA007004"));
String BKA007005 = SQLIJ(request.getParameter("BKA007005"));
String BKA007006 = SQLIJ(request.getParameter("BKA007006"));
String BKA007007 = SQLIJ(request.getParameter("BKA007007"));
String BKA007008 = SQLIJ(request.getParameter("BKA007008"));
String BKA007009 = SQLIJ(request.getParameter("BKA007009"));
String BKA007010 = SQLIJ(request.getParameter("BKA007010"));
String BKA007011 = SQLIJ(request.getParameter("BKA007011"));
String BKA007012 = SQLIJ(request.getParameter("BKA007012"));
String BKA007013 = SQLIJ(request.getParameter("BKA007013"));
String BKA007014 = SQLIJ(request.getParameter("BKA007014"));
String BKA007015 = SQLIJ(request.getParameter("BKA007015"));
String BKA007901 = SQLIJ(request.getParameter("BKA007901"));
String BKA007902 = SQLIJ(request.getParameter("BKA007902"));
String BKA007903 = SQLIJ(request.getParameter("BKA007903"));
String BKA007904 = SQLIJ(request.getParameter("BKA007904"));
String BKA007905 = SQLIJ(request.getParameter("BKA007905"));

if(FTYPE.equals("A")){
	String URA004_MSG = URA004_Log(USERID,SC01,BKA007001,BKA007002+BKA007003,"新增院所資料",URA004006);
}else if(FTYPE.equals("U")){
	String URA004_MSG = URA004_Log(USERID,SC01,BKA007001,BKA007002+BKA007003,"修改院所資料",URA004006);
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
  <input name="BKA007001" type="hidden" id="BKA007001" value="<%=BKA007001%>" />
  <input name="BKA007002" type="hidden" id="BKA007002" value="<%=BKA007002%>" />
  <input name="BKA007003" type="hidden" id="BKA007003" value="<%=BKA007003%>" />
  <input name="BKA007004" type="hidden" id="BKA007004" value="<%=BKA007004%>" /> 
  <input name="BKA007005" type="hidden" id="BKA007005" value="<%=BKA007005%>" />
  <input name="BKA007006" type="hidden" id="BKA007006" value="<%=BKA007006%>" />
  <input name="BKA007007" type="hidden" id="BKA007007" value="<%=BKA007007%>" />
  <input name="BKA007008" type="hidden" id="BKA007008" value="<%=BKA007008%>" />
  <input name="BKA007009" type="hidden" id="BKA007009" value="<%=BKA007009%>" />
  <input name="BKA007010" type="hidden" id="BKA007010" value="<%=BKA007010%>" />
  <input name="BKA007011" type="hidden" id="BKA007011" value="<%=BKA007011%>" />
  <input name="BKA007012" type="hidden" id="BKA007012" value="<%=BKA007012%>" />
  <input name="BKA007013" type="hidden" id="BKA007013" value="<%=BKA007013%>" />
  <input name="BKA007014" type="hidden" id="BKA007014" value="<%=BKA007014%>" />
  <input name="BKA007015" type="hidden" id="BKA007015" value="<%=BKA007015%>" />
  <input name="BKA007901" type="hidden" id="BKA007901" value="<%=BKA007901%>" />
  <input name="BKA007902" type="hidden" id="BKA007902" value="<%=BKA007902%>" />
  <input name="BKA007903" type="hidden" id="BKA007903" value="<%=BKA007903%>" />
  <input name="BKA007904" type="hidden" id="BKA007904" value="<%=BKA007904%>" />
  <input name="BKA007905" type="hidden" id="BKA007905" value="<%=BKA007905%>" />
  <input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" />
  <input name="tabname" type="hidden" id="tabname" value="BKA007" />
  <input name="indkey" type="hidden" id="indkey" value="2" />
  <input name="sendmsg" type="hidden" id="sendmsg" value="<%= FTYPE.equals("A") ? "新增成功" : "修改成功" %>" />
  <input name="sendurl" type="hidden" id="sendurl" value="../web_page/<%=SENDURL%>.jsp" />
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

