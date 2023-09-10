<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8" %>
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
String rand = (String)session.getAttribute("rand");
String verimg = SQLIJ(request.getParameter("verimg"));
%>
<% 
String URA001001 = SQLIJ(request.getParameter("URA001001"));
String URA001002 = SQLIJ(request.getParameter("URA001002"));
String URA001003 = "Member";  //成員
String URA001004 = "1";  //密碼預設1
String URA001004CK = request.getParameter("URA001004CK");
String URA001005 = SQLIJ(request.getParameter("URA001005"));
String URA001006 = SQLIJ(request.getParameter("URA001006"));
String URA001007 = SQLIJ(request.getParameter("URA001007"));
String URA001008 = SQLIJ(request.getParameter("URA001008"));
String URA001009 = SQLIJ(request.getParameter("URA001009"));
String URA001010 = SQLIJ(request.getParameter("URA001010"));
String URA001011 = SQLIJ(request.getParameter("URA001011"));
String URA001012 = SQLIJ(request.getParameter("URA001012"));
String URA001013 = "20211224131528";  //群組暫時
String URA001014 = "";
String URA001015 = SC01;
String URA001016 = "2";  //待開通
String MSG01 = "";
String TYP01 = "";
String chkstatus = "error";
String SQL01 = ""; //宣告SQL語法
String[] AS01 = null;
Map[] RS01 = null; //將篩選出來的資料放到陣列中
Map[] RS02 = null; //將篩選出來的資料放到陣列中

//out.print(URA001001);
//if(true)return;
%>
<%
//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table
PreparedStatement preSMT01 = null;

SQL01 = "SELECT * FROM URA001 WHERE URA001001 = '"+URA001001+"'";
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

if(rand.equals(verimg)){
	if (RS01.length != 0){
		MSG01 = "此帳號("+RS01[0].get("URA001001").toString()+")已由有人使用!!";
		chkstatus = "error";
	}else{
		SQL01 = "INSERT INTO URA001 VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		//out.print(SQL01+"<br>");
		preSMT01 = CONN01.prepareStatement(SQL01);
		preSMT01.setString(1, URA001001);
		preSMT01.setString(2, URA001002);
		preSMT01.setString(3, URA001003);
		preSMT01.setString(4, URA001004);
		preSMT01.setString(5, URA001005);
		preSMT01.setString(6, URA001006);
		preSMT01.setString(7, URA001007);
		preSMT01.setString(8, URA001008);
		preSMT01.setString(9, URA001009);
		preSMT01.setString(10, URA001010);
		preSMT01.setString(11, URA001011);
		preSMT01.setString(12, URA001012);
		preSMT01.setString(13, URA001013);
		preSMT01.setString(14, URA001014);
		preSMT01.setString(15, URA001015);
		preSMT01.setString(16, URA001016);
		preSMT01.executeUpdate();

		MSG01 = "會員申請成功，請等候承辦人員開通後電話通知";
		chkstatus = "success";
	}
}else{
	MSG01="密碼確認錯誤";
	chkstatus = "error";
}
%>
<!doctype html>
<html>
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body>
<form id="form1" name="form1" method="post" action="">
</form>

<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
</body>
<script type="text/javascript">
Swal.fire({
  icon: '<%=chkstatus%>',
  title: '系統訊息',
  text: '<%=MSG01%>',
  confirmButtonText:'返回',
  allowEscapeKey: false,
  allowOutsideClick: false
}).then((result) => {
  if (result.isConfirmed) {
	parent.location.href="join.jsp";
  } else if (result.isDenied) {
	parent.location.href="join.jsp";
  }
});
</script>
</html>
<%
DB01.close();
%>
