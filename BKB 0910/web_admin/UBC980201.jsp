﻿<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%
String PK01 = SQLIJ(request.getParameter("PK01"));
String ST01 = ""; //暫存用變數
String ST02 = ""; //暫存用變數
String ST03 = ""; //暫存用變數
String SQL01 = ""; //宣告SQL語法
Map[] RS01 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("TU"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table
%>
<!doctype html>
<html>
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form id="form1" name="form1" method="post" action="">
<input name="PK01" type="hidden" id="PK01" value="">
<input name="PK02" type="hidden" id="PK02" value="">
<!-- indexS -->
<%@ include file="../web_page/indexS.jsp"%>
<div id="layoutSidenav">
<!-- indexS -->
<%@ include file="../web_page/indexS1.jsp"%>
	<div id="layoutSidenav_content">
	<main>
		<div class="container">
			<div class="row">	
				<div class="text-dark fw-bold col-sm" align="left"><!--%=USERNAME%--> 您好</div>			    
			</div>	
			<div class="card shadow">
				<div class="card-body pb-0">
					<div class="d-flex justify-content-between">
						<div><h4 class="text-red2 fw-bold">系統代碼管理</h4></div>
					</div>
					<ol class="breadcrumb">
						<li class="breadcrumb-item">首頁</li>
						<li class="breadcrumb-item">資料維護</li>
						<li class="breadcrumb-item">系統代碼維護</li>
						<li class="breadcrumb-item active">代碼資訊設定</li>
					</ol>
				</div>
				<div class="container">
					<table class="table table-bordered">
						<thead class="bg-deepgreen text-light" align="center">
							<tr>
								<td colspan="2" align="center">代碼資訊設定</td>
							</tr>
						</thead>
					  <tr>
						<td width="20%" align="right">代碼類別：　</td>
						<td width="883" valign="top"><%=TAB01.getCol("UBZ002","UBZ002007","UBZ002001+UBZ002002+UBZ002003","'"+PK01+"'")%>
							<input name="UBZ002011" type="hidden" id="UBZ002011" value="<%=TAB01.getCol("UBZ002","UBZ002011","UBZ002001+UBZ002002+UBZ002003","'"+PK01+"'")%>">
						</td>
					  </tr>
					  <tr>
						<td align="right">代碼名稱：　      </td>
						<td valign="top"><input name="UBZ002008" type="text" class="form-control" id="UBZ002008" style="width:519px"></td>
					  </tr>
					  <tr>
						<td align="right">識&nbsp;&nbsp;別&nbsp;&nbsp;碼：　      </td>
						<td valign="top"><input name="UBZ002009" type="text" class="form-control" id="UBZ002009" style="width:50px" maxlength="3"></td>
					  </tr>
					  <tr>
						<td align="right">序&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;位：　     </td>
						<td valign="top"><input name="UBZ002010" type="text" class="form-control" id="UBZ002010" style="width:50px" maxlength="11"></td>
					  </tr>
					  <tr>
						<td align="right">顯示狀態：　      </td>
						<td valign="top">
							<input type="radio" name="UBZ002015" class="form-check-input" id="UBZ" value="1">&nbsp;&nbsp;顯示
							<input type="radio" name="UBZ002015" class="form-check-input" id="UBZ002015" value="0">&nbsp;&nbsp;隱藏
					    </td>
					  </tr>
					 </table>
					<div class="row mb-3">
						<div class="col-sm" align="center">
							<button type="button" class="btn btn-light border-secondary" onClick="SF01('UBC980200','jsp','_parent','<%=PK01%>','')"><i class="fas fa-reply-all mr-2"></i>回上一頁</button>
						</div>
						<div class="col-sm" align="center">
							<button type="button" class="btn btn-light border-secondary" onClick="SF01('UBC980203','jsp','_parent','<%=PK01%>','A')"><i class="fa fa-edit pr-2"></i>儲存</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- indexF -->
	<%@ include file="../web_page/indexF.jsp"%>
	</div>
</div>
</form>
<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
<script type="text/JavaScript">
function SF01(A,B,C,D,E){
	form1.PK01.value=D;
	form1.PK02.value=E;
	form1.target=C;
	form1.action=A+"."+B;
	form1.submit();
}
</script>
</body>
</html>
<%
DB01.close();
%>