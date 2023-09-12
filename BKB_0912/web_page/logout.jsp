<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %> 
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
String USERID = (String)session.getValue("USERID");
String URA004_MSG = URA004_Log(USERID,SC01,"","","登出",URA004006);
session.invalidate();
%>
<!DOCTYPE html>
<html lang="zh">

<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body>
    <form action="" method="post" name="FM01" id="FM01">
    <input name="PK01" type="hidden" id="PK01" value="" />
    <input name="PK02" type="hidden" id="PK02" value="" />
    </form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>

<script type="text/javascript">
Swal.fire({
  icon: 'success',
  title: '系統訊息',
  text: '已登出系統',
  confirmButtonText:'回登入頁',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	top.window.location = "login.jsp";
  } else if (result.isDenied) {
	top.window.location = "login.jsp";
  }
});
</script>
</body>
</html>

