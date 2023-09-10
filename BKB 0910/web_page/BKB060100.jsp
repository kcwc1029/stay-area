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
// NOTE:連線資料庫
Database DB01 = new Database("BK");
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
String FTYPE="";



// NOTE: 接值
String table="BKA008"; //要連接的資料表
String BKA008001 = SQLIJ(request.getParameter("BKA008001"));// 大類
String BKA008002 = SQLIJ(request.getParameter("BKA008002"));// 大類
String BKA008003 = SQLIJ(request.getParameter("BKA008003"));// 小類
String BKA008004 = SQLIJ(request.getParameter("BKA008004"));// 名稱
String BKA008005 = SQLIJ(request.getParameter("BKA008005"));// 型號
String BKA008006 = SQLIJ(request.getParameter("BKA008006"));// 數量
String BKA008007 = SQLIJ(request.getParameter("BKA008007"));// 單位
String BKA008008 = SQLIJ(request.getParameter("BKA008008"));// 描述
String BKA008009 = SQLIJ(request.getParameter("BKA008009"));// 時間

// 無條件查詢
if(BKA008002.equals("") && BKA008003.equals("") && BKA008004.equals("")){
	SQL01 = "SELECT * FROM " + table + " WHERE BKA008001 <> '' ORDER BY BKA008009";
}else{
	// 有條件查詢
	SQL01 = "SELECT * FROM " + table + " WHERE BKA008001 <> '' ";
    if (!BKA008002.equals("")) SQL01 += " AND BKA008002 = '" + BKA008002 + "'";
    if (!BKA008003.equals("")) SQL01 += " AND BKA008003 = '" + BKA008003 + "'";
    if (!BKA008004.equals("")) SQL01 += " AND BKA008004 LIKE '%" + BKA008004 + "%'";
    // SQL01 +=" ORDER BY BKA008009";
}
out.print(SQL01);
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
	<%-- 隱藏表單 --%>
	<input name="BKA008001" type="hidden" id="BKA008001" value="<%=BKA008001 %>" />

	<div class="container px-4">
		<h3 class="mt-4">庫存管理</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">庫存維護管理</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						庫存維護管理
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">品項大類</label>
								<select class="form-select" aria-label="Default select" id="BKA008002" name="BKA008002">
									<option value="">請選擇類別</option>
									<option value="大類1">大類1</option>
								 	<option value="大類2">大類2</option>
									<option value="大類3">大類3</option> 
								</select>
							</div>
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">品項小類</label>
								<select class="form-select" aria-label="Default select" id="BKA008003" name="BKA008003">
								  	<option value="">請選擇類別</option>
									<option value="小類1">小類1</option>
								 	<option value="小類2">小類2</option>
									<option value="小類3">小類3</option>
									<option value="小類4">小類4</option>
									<option value="小類5">小類5</option>
								</select>
							</div>
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">品項名稱</label>
								<div class="input-group">
									<input type="text" class="form-control validate[required]" id="BKA008004" name="BKA008004" value="<%=BKA008004%>" placeholder="例如：酒精噴瓶">

									<!--
									<select class="form-select" aria-label="Default select" id="BKA008004" name="BKA008004">
									  <option value="">請選擇類別</option>
									  <option value="卡通酒精">卡通酒精</option>
									  <option value="素色酒精">素色酒精</option>
									</select>
									-->
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB060100','_self')"><i class="fas fa-search me-2"></i>查詢</button>
								</div>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-xl-12 mt-3" align="right">
							
								<button type="button" class="btn btn-light border-secondary" onClick="SF01('BKB060101','_self')"><i class="fas fa-plus me-2"></i>新增庫存</button>
							</div>
						</div>
						
						<div class="table-responsive mt-1">
							<table class="table table-striped table-bordered">
								<thead>
									<tr align="center" class="bg-lightgreen">
									<th scope="col">品項大類</th>
									<th scope="col">品項小類</th>
									<th scope="col">品項名稱</th>
									<th scope="col">批號或型號</th>
									<th scope="col">品項數量</th>
									<th scope="col">更新日期</th>
									<th scope="col">修改</th>
									<th scope="col">刪除</th>
									</tr>
								</thead>
								<tbody align="center">
									<%
										// TODO: 處裡迴圈，特殊字串部分
										for(int i=0;i<RS01.length;i++){
											String num=RS01[i].get("BKA008006").toString()+RS01[i].get("BKA008007").toString();
									%>
										<tr>
										<td><%= RS01[i].get("BKA008002").toString()%></td>
										<td><%= RS01[i].get("BKA008003").toString()%></td>
										<td><%= RS01[i].get("BKA008004").toString()%></td>
										<td class="text-green"><%= RS01[i].get("BKA008005").toString()%></td>

										<td class=""><%=num %></td>
										<td class=""><%= EYC2(RS01[i].get("BKA008009").toString())%></td>
										<td><button type="button" class="btn btn-warning btn-sm" onclick="SF02('BKB060101','_self','<%=RS01[i].get("BKA008001").toString()%>')"><i class="fas fa-pen"></i></button></td>
										<td><button type="button" class="btn btn-danger btn-sm" onclick="SF03('BKB060104','_self','<%=RS01[i].get("BKA008001").toString()%>')"><i class="fas fa-minus"></i></button></td>
										
										</tr>
									<%
										}
									%>
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
function SF02(A, B, C){

  form1.BKA008001.value = C;
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}
function SF03(A, B, C){
  Swal.fire({
		position: 'bottom',
		title: '您確定要刪除嗎？',
		showDenyButton: true,
		//showCancelButton: true,
		denyButtonText:'取消',
		confirmButtonText:'確定',
		allowEscapeKey: false,
		allowOutsideClick: false
	}).then((result) => {
		if (result.isConfirmed) {
			form1.BKA008001.value = C;
		    form1.target = B;
		    form1.action = A + ".jsp";
		    form1.submit();
		} else if (result.isDenied) {
			return;
		}
	});
}

function PG01(A,B){
	form1.PNO01.value=A;
	form1.target="_self";
	form1.action=B;
	form1.submit();
}


</script>

</body>
</html>
