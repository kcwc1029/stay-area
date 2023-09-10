<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
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

String PK01 = SQLIJ(request.getParameter("PK01"));
String PK02 = SQLIJ(request.getParameter("PK02"));
String UID = SQLIJ((String)session.getValue("USERID"));
String URA001001 = SQLIJ(request.getParameter("URA001001"));
String URA001002 = SQLIJ(request.getParameter("URA001002"));
String URA001003 = SQLIJ(request.getParameter("URA001003"));
String URA001004 = request.getParameter("URA001004");
String URA001005 = SQLIJ(request.getParameter("URA001005"));
//String URA001006 = SQLIJ(request.getParameter("URA001006"));
String URA001006 = SHA512(URA001004);  //將URA001004進行加密編碼
String URA001007 = request.getParameter("URA001007");
String URA001008 = SQLIJ(request.getParameter("URA001008"));
String URA001009 = SQLIJ(request.getParameter("URA001009"));
String URA001010 = SQLIJ(request.getParameter("URA001010"));
String URA001011 = SQLIJ(request.getParameter("URA001011"));
String URA001012 = SQLIJ(request.getParameter("URA001012"));
String URA001013 = SQLIJ(request.getParameter("URA001013"));
String URA001013O = SQLIJ(request.getParameter("URA001013O"));
String URA001014 = UID;
String URA001015 = SC01;
String URA001016 = SQLIJ(request.getParameter("URA001016"));
String ST01 = ""; //宣告SQL語法
String ST02 = ""; //宣告SQL語法
String TYP01 = ""; //宣告SQL語法
String MSG01 = "";
String SQL01 = ""; //宣告SQL語法
String SQLC01 = ""; //宣告SQL語法
String SQLV01 = ""; //宣告SQL語法
String[] AS01 = null;
Map[] RS01 = null; //將篩選出來的資料放到陣列中
Map[] RS02 = null; //將篩選出來的資料放到陣列中
//out.print(PK01+"<br>");
%>
<%
//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table
Statement SMT01 = CONN01.createStatement(); //使用新增、修改、刪除語法的宣告

SQL01 = "SELECT * FROM URA001 WHERE URA001001 = '"+URA001001+"'";
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

if (PK02.equals("A")){

TYP01 = "A";
  if (RS01.length != 0){
  MSG01 = "此帳號("+RS01[0].get("URA001001").toString()+")已由"+RS01[0].get("URA001002").toString()+"所使用!!";
  } else {
  MSG01 = "此帳號("+URA001001+")可使用!!";
  }
  
} else if (PK02.equals("B")){

  if (RS01.length != 0){
  MSG01 = "此帳號("+RS01[0].get("URA001001").toString()+")已由"+RS01[0].get("URA001002").toString()+"所使用!!";
  TYP01 = "A";
  } else {
  SQLC01 = "URA001001,URA001002,URA001003,URA001004,URA001005,URA001006,URA001007,URA001008,URA001009,URA001010,URA001011,URA001012,URA001013,URA001014,URA001015,URA001016"; //宣告SQL語法
  SQLV01 = "'"+URA001001+"',N'"+URA001002+"',N'"+URA001003+"',N'"+URA001004+"',N'"+URA001005+"',N'"+URA001006+"',N'"+URA001007+"',N'"+URA001008+"',N'"+URA001009+"',N'"+URA001010+"',N'"+URA001011+"',N'"+URA001012+"',N'"+URA001013+"',N'"+URA001014+"',N'"+URA001015+"',N'"+URA001016+"'"; //宣告SQL語法

  SQL01 = "INSERT INTO URA001("+SQLC01+") VALUES("+SQLV01+")";
  //out.print("1."+SQL01+"<br>");
  SMT01.executeUpdate(SQL01);//執行新增、修改、刪除

  MSG01 = "使用者資訊新增成功";

  SQL01 = "SELECT * FROM URA003 WHERE URA003001 = '"+URA001013+"' AND URA003002 <> '000000000' AND URA003009 = '1'";
  RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

    if (RS02.length != 0){
    SQL01 = "DELETE FROM URA002 WHERE URA002001 = '"+URA001001+"'"; //新增
    SMT01.executeUpdate(SQL01);//執行新增、修改、刪除
  
    for (int A=0;A<RS02.length;A++){
    SQLC01 = "URA002001,URA002002,URA002003,URA002004,URA002005,URA002006,URA002007"; //宣告SQL語法
    SQLV01 = "'"+URA001001+"','"+RS02[A].get("URA003002").toString()+"','"+RS02[A].get("URA003004").toString()+"','"+RS02[A].get("URA003005").toString()+"','"+URA001014+"','"+URA001015+"','"+RS02[A].get("URA003009").toString()+"'"; //宣告SQL語法

    SQL01 = "INSERT INTO URA002("+SQLC01+") VALUES("+SQLV01+")";
    //out.print("1."+SQL01+"<br>");
    SMT01.executeUpdate(SQL01);//執行新增、修改、刪除
    }

    MSG01 = MSG01+"，並完成所屬群組權限套用";
    }

  MSG01 = MSG01+"!!";
  TYP01 = "B";

  }

} else if (PK02.equals("C")){

  SQL01 = "UPDATE URA001 SET URA001002 = N'"+URA001002+"',URA001003 = N'"+URA001003+"',URA001004 = N'"+URA001004+"',URA001005 = N'"+URA001005+"',URA001006 = N'"+URA001006+"',URA001007 = N'"+URA001007+"',URA001008 = N'"+URA001008+"',URA001009 = N'"+URA001009+"',URA001010 = N'"+URA001010+"',URA001011 = N'"+URA001011+"',URA001012 = N'"+URA001012+"',URA001013 = N'"+URA001013+"',URA001014 = N'"+URA001014+"',URA001015 = N'"+URA001015+"',URA001016 = N'"+URA001016+"' WHERE URA001001 = '"+URA001001+"'";
  //out.print(SQL01+"<br>");
  //if(true)return;
  SMT01.executeUpdate(SQL01);//執行新增、修改、刪除
  
  MSG01 = "使用者資訊已變更";

  if (!URA001013.equals(URA001013O)){

  SQL01 = "SELECT * FROM URA003 WHERE URA003001 = '"+URA001013+"' AND URA003002 <> '000000000' AND URA003009 = '1'";
  RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

  SQL01 = "DELETE FROM URA002 WHERE URA002001 = '"+URA001001+"'"; //新增
  SMT01.executeUpdate(SQL01);//執行新增、修改、刪除
  
    if (RS02.length != 0){

    for (int A=0;A<RS02.length;A++){
    SQLC01 = "URA002001,URA002002,URA002003,URA002004,URA002005,URA002006,URA002007"; //宣告SQL語法
    SQLV01 = "'"+URA001001+"','"+RS02[A].get("URA003002").toString()+"','"+RS02[A].get("URA003004").toString()+"','"+RS02[A].get("URA003005").toString()+"','"+URA001014+"','"+URA001015+"','"+RS02[A].get("URA003009").toString()+"'"; //宣告SQL語法

    SQL01 = "INSERT INTO URA002("+SQLC01+") VALUES("+SQLV01+")";
    //out.print("1."+SQL01+"<br>");
    SMT01.executeUpdate(SQL01);//執行新增、修改、刪除
    }

    }

    MSG01 = MSG01+"，並完成所屬群組權限變更";
  }
  MSG01 = MSG01+"!!";
  TYP01 = "B";

}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>

<body>
    <form action="" method="post" name="FM01" id="FM01">
    <input name="PK01" type="hidden" id="PK01" value="" />
    <input name="PK02" type="hidden" id="PK02" value="" />
    </form>
<!-- indexF -->
<%@ include file="../web_page/indexF.jsp"%>	
<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
</body>
<script type="text/javascript">
alert("<%=MSG01%>");
<%
if (TYP01.equals("A")){
  if (!PK02.equals("A")){
%>
history.back();
<%
  }
} else {
%>
SF01('THA210100','jsp','_self','','');
<%
}
%>
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
