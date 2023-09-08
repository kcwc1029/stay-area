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
//out.print(BKA002001);  //印出訊息
//if(true)return;
String MSG01="";
try{
	PreparedStatement preSMT01 = null;
	SQL01 = "DELETE FROM BKA002 WHERE BKA002001 = ? ";
	preSMT01 =  CONN01.prepareStatement(SQL01);
	preSMT01.setString(1, BKA002001);
	preSMT01.executeUpdate();
	preSMT01.close();
	String URA004_MSG = URA004_Log(USERID,SC01,BKA002001,"","刪除場次維護",URA004006);
	MSG01="場次刪除成功";
}catch(Exception e){
	e.printStackTrace();
	MSG01=e.toString()+"<br>場次刪除錯誤，請洽系統管理人員";
}
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body>
<form id="FM01" name="FM01" method="post" action="">
<%//=MSG01%>
</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
<script type="text/javascript">
<% if (MSG01.equals("場次刪除成功") && SENDURL!=null && SENDURL!=""){ %>
Swal.fire({
  icon: 'success',
  title: '系統訊息',
  text: '<%=MSG01%>',
  confirmButtonText:'回編輯頁',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	window.top.location.href="<%=SENDURL%>.jsp";
  } else if (result.isDenied) {
	window.top.location.href="<%=SENDURL%>.jsp";
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
	window.top.location.href="<%=SENDURL%>.jsp";
  } else if (result.isDenied) {
	window.top.location.href="<%=SENDURL%>.jsp";
  }
});
<%}%>
</script>
</body>
</html>
<%
DB01.close();
%>