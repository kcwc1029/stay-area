<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
Map[] RS03 = null;
String SQL03 = "";
%>
<%
String MSG01 = "批次更新失敗";
String SENDURL = SQLIJ(request.getParameter("SENDURL"));
String BKA002001 = SQLIJ(request.getParameter("BKA002001"));
String BKA002002 = SQLIJ(request.getParameter("BKA002002"));

String[] BKA003001S = request.getParameterValues("BKA003001S");  //UUID
String BKA003001 = "";
String BKA003012 = "";  //狀態
if(null != BKA003001S){
	for(int A=0; A<BKA003001S.length; A++){
		BKA003001 = BKA003001S[A];
		BKA003012 = SQLIJ(request.getParameter(BKA003001));
		if(BKA003012.equals("")){
			BKA003012 = "0";
		}
		//out.print(BKA003001+" "+BKA003012+"<br>");
		
		SQL01 = "SELECT * FROM BKA003 WHERE BKA003001 = '"+BKA003001+"'";
		RS01 = TAB01.buildMaps(SQL01);
		try{
			if(RS01.length != 0){
				if(!BKA003012.equals("")){
					PreparedStatement preSMT01 = null;
					SQL01 = "UPDATE BKA003 SET BKA003012 = ?,BKA003903 = ?,BKA003904 = ? WHERE BKA003001 = ?";
					preSMT01 =  CONN01.prepareStatement(SQL01);
					preSMT01.setString(1, BKA003012);
					preSMT01.setString(2, USERID);
					preSMT01.setString(3, SC01);
					preSMT01.setString(4, BKA003001);
					preSMT01.executeUpdate();
					preSMT01.close();
					String URA004_MSG = URA004_Log(USERID,SC01,BKA003001,"","批次接種量能狀態",URA004006);
				}
				out.print(BKA003001+"批次更新結果"+BKA003012+"更新成功<br>");
				MSG01="批次更新成功";
			}
		}catch(Exception e){
			e.printStackTrace();
			MSG01=e.toString()+"<br>批次更新失敗，請洽系統管理人員";
			out.print(MSG01+"<br>");
		}
	}
}else{
	MSG01="編號空白，批次更新失敗";
}
//if(true)return;	
%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8" />
<script type="text/javascript">

</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="">
<input name="BKA002001" type="hidden" id="BKA002001" value="<%=BKA002001%>" />
<input name="BKA002002" type="hidden" id="BKA002002" value="<%=BKA002002%>" />

</form>

<%@ include file="indexJS.jsp"%>
</body>
</html>
<script language="javascript">
<% if (MSG01.equals("批次更新成功")){ %>
Swal.fire({
  position: 'center',
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
  position: 'center',
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
<%
DB01.close();
%>