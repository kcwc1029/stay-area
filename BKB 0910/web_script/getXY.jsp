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
<%
String TTB013007 = SQLIJ(request.getParameter("TTB013007")); // 代碼類別
Database DB01 = new Database("TT");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "SELECT * FROM TTB009 WHERE TTB009001 = '"+TTB013007+"'";
RS01 = TAB01.buildMaps(SQL01);
String X = "121";
String Y = "22";
if(RS01.length==1){
X = RS01[0].get("TTB009013").toString();
Y = RS01[0].get("TTB009014").toString();
}
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8" />
<script language="javascript">
function returnValue()
{
    parent.form1.TTB013010.value=<%=X%>;
	parent.form1.TTB013011.value=<%=Y%>;
}
</script>
<title></title>
</head>
<body onLoad="returnValue()">
<%=SQL01%>
</body>
</html>
<%DB01.close();%>