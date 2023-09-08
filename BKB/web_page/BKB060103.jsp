<%-- TODO: 處李新增資料  --%>

<%-- NOTE: 引入資料 --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
// NOTE:連線資料庫
Database DB01 = new Database("BK");
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";

// TODO: 檢查資料庫連接狀況
if (CONN01 != null) {
    out.println("成功建立数据库连接");
	// if(true)return;   //終止程式
} else {
    out.println("无法建立数据库连接");
	// if(true)return;   //終止程式
}


// NOTE:取值並進行新增資料
String FTYPE = SQLIJ(request.getParameter("FTYPE"));
String BKA008001 =UUID.randomUUID().toString();
// String BKA008001 = (request.getParameter("BKA008001") != null) ? request.getParameter("BKA008001") : UUID.randomUUID().toString();
String BKA008002 = SQLIJ(request.getParameter("BKA008002"));// 大類
String BKA008003 = SQLIJ(request.getParameter("BKA008003"));// 小類
String BKA008004 = SQLIJ(request.getParameter("BKA008004"));// 名稱
String BKA008005 = SQLIJ(request.getParameter("BKA008005"));// 型號
String BKA008006 = SQLIJ(request.getParameter("BKA008006")); // 數量
String BKA008007 = SQLIJ(request.getParameter("BKA008007"));// 單位
String BKA008008 = SQLIJ(request.getParameter("BKA008008"));// 描述
// NOTE: 增加 BKA008009 為時間
Date currentDate = new Date();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
String BKA008009 = dateFormat.format(currentDate); //20230908
out.print(BKA008001);
out.print(BKA008008);
out.print(BKA008009);






// NOTE: SQL處理結果
if (FTYPE.equals("A")) {
    // SQL 目標
    SQL01 += "INSERT INTO BKA008 (BKA008001, BKA008002, BKA008003, BKA008004, BKA008005, BKA008006, BKA008007, BKA008008, BKA008009) ";
    SQL01 += "VALUES ('" + BKA008001 + "', '" + BKA008002 + "', '" + BKA008003 + "', '" + BKA008004 + "', '" + BKA008005 + "', '" + BKA008006 + "', '" + BKA008007 + "', '" + BKA008008 + "', '" + BKA008009 + "')";
    out.print(SQL01);
    Statement stmt = CONN01.createStatement();
    int rowsAffected = stmt.executeUpdate(SQL01);
    // 处理执行结果
    out.println("SQL 语句执行成功，影响了 " + rowsAffected + " 行数据。");


    // 不要在这里关闭连接
} else if (FTYPE.equals("U")) {
    // 这里可能有其他操作
} else {
    out.print("嚴重錯誤，請洽系統管理員");
}

// 在所有数据库操作完成后关闭连接
try {
    if (CONN01 != null) {
        CONN01.close();
        out.println("成功关闭数据库连接");
    }
} catch (SQLException e) {
    e.printStackTrace();
    out.println("关闭数据库连接时发生错误: " + e.getMessage());
}


%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Covid-19疫苗施打量能調查平台</title>
</head>
<body>



<%-- 處裡回傳部分  --%>
<script type="text/javascript">
  FM01.target = "_self";
  FM01.action="<%= FTYPE.equals("A") ? "../web_script/KDY010100.jsp" : "../web_script/KDY010200.jsp"%>";
  FM01.submit();
</script>
</body>





















