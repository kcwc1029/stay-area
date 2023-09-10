<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
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
String URA002001 = SQLIJ(request.getParameter("URA002001"));
String URA002002 = "";
String URA002003 = "";
String URA002004 = "";
String URA002005 = SQLIJ((String)session.getValue("USERID"));
String URA002006 = SC01;
String URA002007 = SQLIJ(request.getParameter("URA002007"));
String ST01 = ""; //宣告SQL語法
String ST02 = ""; //宣告SQL語法
String MSG01 = "";
String SQL01 = ""; //宣告SQL語法
String[] AS01 = null; //宣告SQL語法
Map[] RS01 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table

Statement SMT01 = CONN01.createStatement(); //使用新增、修改、刪除語法的宣告

SQL01 = "DELETE FROM URA002 WHERE URA002001 = '"+URA002001+"'"; //新增
SMT01.executeUpdate(SQL01);//執行新增、修改、刪除

SQL01 = "SELECT * FROM WSA001 WHERE WSA001016 <> '0'";
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

if(RS01.length != 0){
for(int A=0;A<RS01.length;A++){

URA002002 = RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString();
URA002003 = SQLIJ(request.getParameter(RS01[A].get("WSA001001").toString()+RS01[A].get("WSA001002").toString()+RS01[A].get("WSA001003").toString()+RS01[A].get("WSA001004").toString()));
  if (URA002003.equals("")){
  URA002003 = "0";
  }

//out.print(A+"."+URA002001+"_"+URA002002+"_"+URA002003+"<br>");

SQL01 = "INSERT INTO URA002(URA002001,URA002002,URA002003,URA002004,URA002005,URA002006,URA002007) VALUES('"+URA002001+"','"+URA002002+"','"+URA002003+"','"+URA002004+"','"+URA002005+"','"+URA002006+"','"+URA002007+"')"; //新增
SMT01.executeUpdate(SQL01);//執行新增、修改、刪除

}

MSG01 = "使用者權限已儲存!!";
} else {

MSG01 = "目前無任何權限項目可供設定!!";
}
%>
<!doctype html>
<html>
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- indexS -->
<%@ include file="../web_page/indexS.jsp"%>
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
SF01("THA210100","jsp","_self","","");
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