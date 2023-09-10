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
String UBZ002001 = "";
String UBZ002002 = "";
String UBZ002003 = "";
String UBZ002004 = "";
String UBZ002005 = "";
String UBZ002006 = "";
String UBZ002007 = "";
String UBZ002008 = SQLIJ(request.getParameter("UBZ002008"));
String UBZ002009 = SQLIJ(request.getParameter("UBZ002009"));
String UBZ002010 = SQLIJ(request.getParameter("UBZ002010"));
String UBZ002011 = SQLIJ(request.getParameter("UBZ002011"));
String UBZ002012 = SQLIJ(request.getParameter("UBZ002012"));
String UBZ002013 = SQLIJ((String)session.getValue("USERID"));
String UBZ002014 = SC01;
String UBZ002015 = SQLIJ(request.getParameter("UBZ002015"));
String ST01 = ""; //宣告SQL語法
String ST02 = ""; //宣告SQL語法
String SQL01 = ""; //宣告SQL語法
Map[] RS01 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("CC"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table

Statement SMT01 = CONN01.createStatement(); //使用新增、修改、刪除語法的宣告

if (PK02.equals("A")){

SQL01 = "SELECT * FROM UBZ002 WHERE UBZ002001+UBZ002002+UBZ002003 = '"+PK01+"' ORDER BY UBZ002004 DESC";
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

UBZ002001 = RS01[0].get("UBZ002001").toString();
UBZ002002 = RS01[0].get("UBZ002002").toString();
UBZ002003 = RS01[0].get("UBZ002003").toString();
UBZ002004 = RS01[0].get("UBZ002004").toString();
UBZ002004 = String.valueOf(Integer.parseInt(UBZ002004)+1);
  if (UBZ002004.length() == 1){
  UBZ002004 = "0"+UBZ002004;
  }
UBZ002005 = RS01[0].get("UBZ002005").toString();
UBZ002006 = RS01[0].get("UBZ002006").toString();
UBZ002007 = RS01[0].get("UBZ002007").toString();

  if (UBZ002010.equals("")){
  UBZ002010 = "99";
  }

SQL01 = "INSERT INTO UBZ002(UBZ002001,UBZ002002,UBZ002003,UBZ002004,UBZ002005,UBZ002006,UBZ002007,UBZ002008,UBZ002009,UBZ002010,UBZ002011,UBZ002012,UBZ002013,UBZ002014,UBZ002015) VALUES('"+UBZ002001+"','"+UBZ002002+"','"+UBZ002003+"','"+UBZ002004+"','"+UBZ002005+"','"+UBZ002006+"','"+UBZ002007+"','"+UBZ002008+"','"+UBZ002009+"',"+UBZ002010+",'"+UBZ002011+"','"+UBZ002012+"','"+UBZ002013+"','"+UBZ002014+"','"+UBZ002015+"')"; //新增

SMT01.executeUpdate(SQL01);//執行新增、修改、刪除

} else if (PK02.equals("B")){

SQL01 = "SELECT * FROM UBZ002 WHERE UBZ002001+UBZ002002+UBZ002003+UBZ002004 = '"+PK01+"'";
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

UBZ002001 = RS01[0].get("UBZ002001").toString();
UBZ002002 = RS01[0].get("UBZ002002").toString();
UBZ002003 = RS01[0].get("UBZ002003").toString();
UBZ002004 = RS01[0].get("UBZ002004").toString();
UBZ002005 = RS01[0].get("UBZ002005").toString();
UBZ002006 = RS01[0].get("UBZ002006").toString();
UBZ002007 = RS01[0].get("UBZ002007").toString();

  if (UBZ002010.equals("")){
  UBZ002010 = "99";
  }

SQL01 = "UPDATE UBZ002 SET UBZ002008='"+UBZ002008+"',UBZ002009='"+UBZ002009+"',UBZ002010="+UBZ002010+",UBZ002011='"+UBZ002011+"',UBZ002012='"+UBZ002012+"',UBZ002013='"+UBZ002013+"',UBZ002014='"+UBZ002014+"',UBZ002015='"+UBZ002015+"' WHERE UBZ002001='"+UBZ002001+"' AND UBZ002002='"+UBZ002002+"' AND UBZ002003='"+UBZ002003+"' AND UBZ002004='"+UBZ002004+"'"; //新增
SMT01.executeUpdate(SQL01);//執行新增、修改、刪除
}
%>
<!doctype html>
<html>
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="FM01" name="FM01" method="post" action="">
<input name="PK01" type="hidden" id="PK01" value="">
<input name="PK02" type="hidden" id="PK02" value="">
</form>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
</body>
<script type="text/JavaScript">
alert("代 碼 資 訊 已 儲 存 !!");
SF01("UBC980200","jsp","_self","<%=UBZ002001+UBZ002002+UBZ002003%>","");
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