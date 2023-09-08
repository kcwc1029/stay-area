<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8" />
<title>批次更新使用者權限</title>
</head>
<%
//寫入門牌資料用
Database db = new Database("BK"); //宣告資料庫連線
Connection conn = db.getConn();  //宣告連線(可宣告或不宣告)
PreparedStatement preSMT01 = null;
Table TAB01 =new Table(conn); //宣告對應的table
String SQL01 = "";
Map[] RS01 = null;
boolean success = true;
String URA001001 = "H221850920";   //參考用帳號
String URA001003 = "衛生所人員";   //指定角色
String sendmsg="更新成功";
SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHHmmss");
String SC01 = date.format(new Date());
int count = 0;
int colnum = 0;
try{
	SQL01 = "TRUNCATE TABLE URA002BAT";    //清空資料表
	preSMT01 = conn.prepareStatement(SQL01);
	preSMT01.executeUpdate();
	SQL01 = "INSERT INTO URA002BAT SELECT * FROM URA002 WHERE URA002001 = '"+URA001001+"'";  //將指定帳號之權限轉進來做為基準
	preSMT01 = conn.prepareStatement(SQL01);
	preSMT01.executeUpdate();
	//if(true)return;
	SQL01 = "DELETE FROM URA002 WHERE URA002001 IN (SELECT URA001001 FROM URA001 WHERE URA001003 = '" + URA001003 + "')";  //將指定角色帳號之權限刪除
	preSMT01 = conn.prepareStatement(SQL01);
	preSMT01.executeUpdate();
	//if(true)return;
	SQL01 = "SELECT * FROM URA001 WHERE URA001003 = '" + URA001003 + "'";  //用角色挑選要更新的帳號
	RS01 = TAB01.buildMaps(SQL01);
	for(int A=0;A<RS01.length;A++){  //一筆一筆處理
		SQL01 = "UPDATE URA002BAT SET URA002001 = '"+RS01[A].get("URA001001").toString()+"'";    //先換掉帳號
		preSMT01 = conn.prepareStatement(SQL01);
		preSMT01.executeUpdate();
		SQL01 = "INSERT INTO URA002 SELECT * FROM URA002BAT";    //新增至URA002
		preSMT01 = conn.prepareStatement(SQL01);
		preSMT01.executeUpdate();
		count++;
	}
	//out.print(SQL01+"<br>");
}catch(SQLException e){
	e.printStackTrace();
	out.println("第"+count+"筆資料匯入錯誤:" + e);
}

db.close();

%>
<body>
<%=sendmsg%>
</body>
<script>
</script>
</html>