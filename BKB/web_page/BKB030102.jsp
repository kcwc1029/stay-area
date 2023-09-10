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
String FTYPE = SQLIJ(request.getParameter("FTYPE"));
String SENDURL = SQLIJ(request.getParameter("SENDURL"));
String BKA002001 = SQLIJ(request.getParameter("BKA002001"));
String BKA002002 = SQLIJ(request.getParameter("BKA002002"));
SQL01 = "SELECT * FROM BKA002 WHERE BKA002001 <> '"+BKA002001+"' AND BKA002002 = '"+BKA002002+"'";
RS01 = TAB01.buildMaps(SQL01);
if(RS01.length!=0){
%>
	<script>
	alert("期別重複，請重新輸入");
	history.back(-1);
	</script>
<%
	return;
}

//計算流水號
if(FTYPE.equals("A") && BKA002001.equals("")){   //判斷是否新增取編號
	BKA002001 = UUID.randomUUID().toString();
}
String BKA002003 = SQLIJ(request.getParameter("BKA002003"));
String BKA002004 = SQLIJ(request.getParameter("BKA002004"));
String BKA002005 = SQLIJ(request.getParameter("BKA002005"));
String BKA002005Y = SQLIJ(request.getParameter("BKA002005Y"));
String BKA002005H = SQLIJ(request.getParameter("BKA002005H"));
BKA002005 = BKA002005Y.replace("/","")+BKA002005H;
String BKA002006 = SQLIJ(request.getParameter("BKA002006"));
String BKA002006Y = SQLIJ(request.getParameter("BKA002006Y"));
String BKA002006H = SQLIJ(request.getParameter("BKA002006H"));
BKA002006 = BKA002006Y.replace("/","")+BKA002006H;
String BKA002007 = SQLIJ(request.getParameter("BKA002007"));
String BKA002007Y = SQLIJ(request.getParameter("BKA002007Y"));
String BKA002007H = SQLIJ(request.getParameter("BKA002007H"));
BKA002007 = BKA002007Y.replace("/","")+BKA002007H;
String BKA002008 = SQLIJ(request.getParameter("BKA002008"));
String BKA002009 = SQLIJ(request.getParameter("BKA002009"));
BKA002009 = BKA002009.replace("/","");
String BKA002010 = SQLIJ(request.getParameter("BKA002010"));
BKA002010 = BKA002010.replace("/","");
String BKA002901 = SQLIJ(request.getParameter("BKA002901"));
String BKA002902 = SQLIJ(request.getParameter("BKA002902"));
String BKA002903 = SQLIJ(request.getParameter("BKA002903"));
String BKA002904 = SQLIJ(request.getParameter("BKA002904"));
String BKA002905 = SQLIJ(request.getParameter("BKA002905"));

if(FTYPE.equals("A")){
	String URA004_MSG = URA004_Log(USERID,SC01,BKA002001,BKA002002,"新增場次維護",URA004006);
}else if(FTYPE.equals("U")){
	String URA004_MSG = URA004_Log(USERID,SC01,BKA002001,BKA002002,"修改場次維護",URA004006);
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
  <input name="BKA002003" type="hidden" id="BKA002003" value="<%=BKA002003%>" />
  <input name="BKA002004" type="hidden" id="BKA002004" value="<%=BKA002004%>" /> 
  <input name="BKA002005" type="hidden" id="BKA002005" value="<%=BKA002005%>" />
  <input name="BKA002006" type="hidden" id="BKA002006" value="<%=BKA002006%>" />
  <input name="BKA002007" type="hidden" id="BKA002007" value="<%=BKA002007%>" />
  <input name="BKA002008" type="hidden" id="BKA002008" value="<%=BKA002008%>" />
  <input name="BKA002009" type="hidden" id="BKA002009" value="<%=BKA002009%>" />
  <input name="BKA002010" type="hidden" id="BKA002010" value="<%=BKA002010%>" />
  <input name="BKA002901" type="hidden" id="BKA002901" value="<%=BKA002901%>" />
  <input name="BKA002902" type="hidden" id="BKA002902" value="<%=BKA002902%>" />
  <input name="BKA002903" type="hidden" id="BKA002903" value="<%=BKA002903%>" />
  <input name="BKA002904" type="hidden" id="BKA002904" value="<%=BKA002904%>" />
  <input name="BKA002905" type="hidden" id="BKA002905" value="<%=BKA002905%>" />
  <input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" />
  <input name="tabname" type="hidden" id="tabname" value="BKA002" />
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

