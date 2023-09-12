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
Database DB01 = new Database("CR");//連資料庫
Connection CONN01 = DB01.getConn();
String SQL01 = "";
%>
<%
String FTYPE = SQLIJ(request.getParameter("FTYPE"));
String CRA004001 = SQLIJ(request.getParameter("CRA004001"));
String CRA004002 = SQLIJ(request.getParameter("CRA004002"));
String CRA004003 = SQLIJ(request.getParameter("CRA004003"));
String CRA004004 = SQLIJ(request.getParameter("CRA004004"));
String CRA004901 = SQLIJ(request.getParameter("CRA004901"));
String CRA004902 = SQLIJ(request.getParameter("CRA004902"));
String CRA004903 = SQLIJ(request.getParameter("CRA004903"));
String CRA004904 = SQLIJ(request.getParameter("CRA004904"));
String CRA004905 = SQLIJ(request.getParameter("CRA004905"));
String MSG01="";
String chk = "error";
try{
	PreparedStatement preSMT01 = null;
	if(FTYPE.equals("A")){
		SQL01 = "INSERT INTO CRA004 VALUES(?,?,?,?,?,?,?,?,?) ";
		preSMT01 =  CONN01.prepareStatement(SQL01);
		preSMT01.setString(1, CRA004001);
		preSMT01.setString(2, CRA004002);
		preSMT01.setString(3, CRA004003);
		preSMT01.setString(4, CRA004004);
		preSMT01.setString(5, CRA004901);
		preSMT01.setString(6, CRA004902);
		preSMT01.setString(7, CRA004903);
		preSMT01.setString(8, CRA004904);
		preSMT01.setString(9, CRA004905);
		preSMT01.executeUpdate();
		preSMT01.close();
		String URA004_MSG = URA004_Log(USERID,SC01,"","","儲存陳核長官資料",URA004006);
		MSG01="陳核長官資料儲存成功";
		chk = "success";
	}else if(FTYPE.equals("U")){
		SQL01 = "UPDATE CRA004 SET CRA004002 = ?,CRA004003=?,CRA004004=?,CRA004903=?,CRA004904=?,CRA004905=? WHERE CRA004001 = ?";
		preSMT01 =  CONN01.prepareStatement(SQL01);
		preSMT01.setString(1, CRA004002);
		preSMT01.setString(2, CRA004003);
		preSMT01.setString(3, CRA004004);
		preSMT01.setString(4, CRA004903);
		preSMT01.setString(5, CRA004904);
		preSMT01.setString(6, CRA004905);
		preSMT01.setString(7, CRA004001);
		preSMT01.executeUpdate();
		preSMT01.close();
		String URA004_MSG = URA004_Log(USERID,SC01,"","","修改陳核長官資料",URA004006);
		MSG01="陳核長官資料修改成功";
		chk = "success";
	}else{
		MSG01 = "嚴重錯誤，請洽系統管理人員";
	}
}catch(Exception e){
	e.printStackTrace();
	MSG01=e.toString()+"<br>陳核長官資料維護錯誤，請洽系統管理人員";
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

</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
<script type="text/javascript">
Swal.fire({
  icon: '<%=chk%>',
  title: '系統訊息',
  text: '<%=MSG01%>',
  confirmButtonText:'回查詢頁',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	form1.target="_self";
	form1.action="THA300100.jsp";
	form1.submit();
  } else if (result.isDenied) {
	form1.target="_self";
	form1.action="THA300100.jsp";
	form1.submit();
  }
});
</script>
</body>
</html>
<%
DB01.close();
%>