<%-- NOTE: 引入資料 --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
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
<%@ include file="../web_script/WSA010700.jsp"%>


<%
// TODO: 
// 頁面:匯入物資存量
// 1.呈現資料:
// 	表BKA008拉資料BKA008002-BKA008009->無條件查詢


// 連線資料庫
Database DB01 = new Database("BK");
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
String FTYPE="";
String table="BKA008"; //要連接的資料表

// 接值
String BKA008001 = SQLIJ(request.getParameter("BKA008001"));// 大類
String BKA008002 = SQLIJ(request.getParameter("BKA008002"));// 大類
String BKA008003 = SQLIJ(request.getParameter("BKA008003"));// 小類
String BKA008004 = SQLIJ(request.getParameter("BKA008004"));// 名稱
String BKA008005 = SQLIJ(request.getParameter("BKA008005"));// 型號
String BKA008006 = SQLIJ(request.getParameter("BKA008006"));// 數量
String BKA008007 = SQLIJ(request.getParameter("BKA008007"));// 單位
String BKA008008 = SQLIJ(request.getParameter("BKA008008"));// 描述
String BKA008009 = SQLIJ(request.getParameter("BKA008009"));// 時間


out.print( BKA008001);
out.print( BKA008002);
out.print( BKA008003);
out.print( BKA008004);
out.print( BKA008005);
out.print( BKA008006);
out.print( BKA008007);
out.print( BKA008008);
out.print( BKA008009);
if(true)return;

SQL01 = "SELECT * FROM " + table + " WHERE BKA008001 <> '' ORDER BY BKA008009";
// out.print(SQL01);
RS01 = TAB01.buildMaps(SQL01);

%>



<!DOCTYPE html>
<html lang="zh">
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>
<body class="sb-nav-fixed">
<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="form1" name="form1" method="post" action="">
	<div class="container px-4">
		<h3 class="mt-4">匯入物資存量</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">匯入物資存量</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						匯入物資存量
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl">
								<div class="input-group">
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('','_self')"><i class="fas fa-file-download me-2"></i>範例下載</button>
									<input type="file" accept=".xls,.xlsx" class="form-control" value="" id="customFile" name="customFile">
									<button type="button" class="btn btn-outline-secondary" id="input-group-button-right" onclick="uploadFile()">匯入</button>
								</div>
							</div>
						</div>
						<div class="table-responsive mt-5">
							<table class="table table-striped table-bordered">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">品項大類</th>
								  <th scope="col">品項小類</th>
								  <th scope="col">品項名稱</th>
								  <th scope="col">批號或型號</th>
								  <th scope="col">品項數量</th>
								  <th scope="col">描述說明</th>
								  <th scope="col">更新日期</th>
								</tr>
							  </thead>
							  <tbody align="center">
							  	<%
									// 處裡迴圈，特殊字串部分
									for(int i=0;i<RS01.length;i++){
										String num=RS01[i].get("BKA008006").toString()+RS01[i].get("BKA008007").toString();
								%>
									<tr>
									<td><%= RS01[i].get("BKA008002").toString()%></td>
									<td><%= RS01[i].get("BKA008003").toString()%></td>
									<td><%= RS01[i].get("BKA008004").toString()%></td>
									<td><%= RS01[i].get("BKA008005").toString()%></td>
									<td><%=num %></td>
									<td><%= RS01[i].get("BKA008008").toString()%></td>
									<td class="fw-bold"><%= RS01[i].get("BKA008009").toString()%></td>
									</tr>
								<%}%>
							  </tbody>
							</table>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
</form>
	<!-- indexJS -->
	<%@ include file="indexJS.jsp"%>
	
<script type="text/javascript">
function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}
</script>

</body>
</html>
