<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %> 
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<% 
SimpleDateFormat date=new SimpleDateFormat("yyyyMMddHHmmss");  
String SC01 = date.format(new Date()); //C表示日期時間值
%>
<%
String PK01 = SQLIJ(request.getParameter("PK01")); //目前都計區代碼
String PK02 = SQLIJ(request.getParameter("PK02"));
String URA003001 = SQLIJ(request.getParameter("URA003001"));
String URA003002 = SQLIJ(request.getParameter("URA003002"));
String URA003003 = SQLIJ(request.getParameter("URA003003"));
String URA003004 = SQLIJ(request.getParameter("URA003004"));
String URA003005 = SQLIJ(request.getParameter("URA003005"));
String URA003006 = SQLIJ(request.getParameter("URA003006"));
String URA003007 = SQLIJ((String)session.getValue("USERID"));
String URA003008 = SC01;
String URA003009 = SQLIJ(request.getParameter("URA003009"));
String ST01 = ""; //宣告SQL語法
String ST02 = ""; //宣告SQL語法
String MSG01 = "";
String SQL01 = ""; //宣告SQL語法
String[] AS01 = null; //宣告SQL語法
Map[] RS01 = null; //將篩選出來的資料放到陣列中
Map[] RS02 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table

Statement SMT01 = CONN01.createStatement(); //使用新增、修改、刪除語法的宣告

if (PK02.equals("A")){

SQL01 = "DELETE FROM URA003 WHERE URA003001 = '"+URA003001+"' AND URA003002 <> '000000000'"; //新增
SMT01.executeUpdate(SQL01);//執行新增、修改、刪除

SQL01 = "SELECT * FROM URA003 WHERE URA003001 = '"+URA003001+"' AND URA003002 = '000000000'";
//out.print(SQL01+"<br>");
RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

  if (RS02.length != 0){
  URA003003 = RS02[0].get("URA003003").toString();
  URA003005 = RS02[0].get("URA003005").toString();
  URA003006 = RS02[0].get("URA003006").toString();
  URA003009 = RS02[0].get("URA003009").toString();
  }

SQL01 = "SELECT * FROM WSA001 WHERE WSA001016 <> '0'";
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

  if(RS01.length != 0){
  for(int A=0;A<RS01.length;A++){

  URA003002 = RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString();
  URA003004 = SQLIJ(request.getParameter(RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString()));
    if (URA003004.equals("")){
    URA003004 = "0";
    }

//out.print(A+"."+URA003001+"_"+URA003002+"_"+URA003003+"<br>");

  SQL01 = "INSERT INTO URA003(URA003001,URA003002,URA003003,URA003004,URA003005,URA003006,URA003007,URA003008,URA003009) VALUES('"+URA003001+"','"+URA003002+"','"+URA003003+"','"+URA003004+"','"+URA003005+"','"+URA003006+"','"+URA003007+"','"+URA003008+"','"+URA003009+"')"; //新增
  SMT01.executeUpdate(SQL01);//執行新增、修改、刪除

  }

  MSG01 = "群組權限已儲存!!";
  } else {

  MSG01 = "目前無任何權限項目可供設定!!";
  }
} else if (PK02.equals("B")){

URA003001 = SC01;
URA003002 = "000000000";

SQL01 = "INSERT INTO URA003(URA003001,URA003002,URA003003,URA003004,URA003005,URA003006,URA003007,URA003008,URA003009) VALUES('"+URA003001+"','"+URA003002+"','"+URA003003+"','"+URA003004+"','"+URA003005+"','"+URA003006+"','"+URA003007+"','"+URA003008+"','"+URA003009+"')"; //新增
SMT01.executeUpdate(SQL01);//執行新增、修改、刪除

MSG01 = "群組資訊新增成功!!";

} else if (PK02.equals("C")){

SQL01 = "UPDATE URA003 SET URA003003='"+URA003003+"',URA003006='"+URA003006+"',URA003007='"+URA003007+"',URA003008='"+URA003008+"',URA003009='"+URA003009+"' WHERE URA003001='"+URA003001+"'"; //新增
SMT01.executeUpdate(SQL01);//執行新增、修改、刪除

MSG01 = "群組資訊已變更!!";

}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form id="FM01" name="FM01" method="post" action="">
<input name="PK01" type="hidden" id="PK01" value="">
<input name="PK02" type="hidden" id="PK02" value="">
</form>
<!-- indexF -->
<%@ include file="../web_page/indexF.jsp"%>
<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
</body>
<script type="text/JavaScript">
alert("<%=MSG01%>");
SF01("THA210400","jsp","_self","<%=URA003001%>","");
function SF01(A,B,C,D,E){
	FM01.PK01.value=D;
	FM01.PK02.value=E;
	FM01.target=C;
	FM01.action=A+"."+B;
	FM01.submit();
}
</script>
</html>
<%
DB01.close();
%>