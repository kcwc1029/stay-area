<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
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
String SENDURL = SQLIJ(request.getParameter("SENDURL"));
String BKA002001 = SQLIJ(request.getParameter("BKA002001"));
String BKA002002 = SQLIJ(request.getParameter("BKA002002"));
String BKA003001 = SQLIJ(request.getParameter("BKA003001"));
//out.print(BKA002001);  //印出訊息
//if(true)return;
String MSG01="";
try{
	PreparedStatement preSMT01 = null;
	SQL01 = "DELETE FROM BKA003 WHERE BKA003001 = ? ";
	preSMT01 =  CONN01.prepareStatement(SQL01);
	preSMT01.setString(1, BKA003001);
	preSMT01.executeUpdate();
	preSMT01.close();
	String URA004_MSG = URA004_Log(USERID,SC01,BKA003001,"","刪除接種量能維護",URA004006);
	MSG01="接種量能刪除成功";
}catch(Exception e){
	e.printStackTrace();
	MSG01=e.toString()+"<br>接種量能刪除錯誤，請洽系統管理人員";
}
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body>
<form id="form1" name="form1" method="post" action="">
<input name="BKA002001" type="hidden" id="BKA002001" value="<%=BKA002001%>" />
<input name="BKA002002" type="hidden" id="BKA002002" value="<%=BKA002002%>" />
<%//=MSG01%>
</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
<script type="text/javascript">
<% if (MSG01.equals("接種量能刪除成功") && SENDURL!=null && SENDURL!=""){ %>
Swal.fire({
  icon: 'success',
  title: '系統訊息',
  text: '<%=MSG01%>',
  confirmButtonText:'回編輯頁',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	form1.action="<%=SENDURL%>.jsp";
	form1.target="_self";
	form1.submit();
  } else if (result.isDenied) {
	form1.action="<%=SENDURL%>.jsp";
	form1.target="_self";
	form1.submit();
  }
});
<%}else{%>
Swal.fire({
  icon: 'error',
  title: '系統訊息',
  text: '<%=MSG01%>',
  confirmButtonText:'回編輯頁',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	form1.action="<%=SENDURL%>.jsp";
	form1.target="_self";
	form1.submit();
  } else if (result.isDenied) {
	form1.action="<%=SENDURL%>.jsp";
	form1.target="_self";
	form1.submit();
  }
});
<%}%>
</script>
</body>
</html>
<%
DB01.close();
%>