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
// 頁面:新增庫存管理
// 1.新增資料:
// 	表BKA008
// 	接收值BKA008001:若為空值，FTYPE為"A"，帶當前頁面至BKB006103新增資料
// 2.資料編輯:BKA008002-BKA008004若有放資料->有條件查詢
// 	表BKA008
// 	接收值BKA008001:若有值，FTYPE為"U"，SQL查詢依BKA008001查詢原資料，帶至BKA008002-BKA008009資料 當前頁面至BKB006103新增資料
// 3.表單傳遞:
// 	FTYPE:新增->"A"，編輯->"U"
// 	FIXME:新增完成了，但更新抱錯(這邊我的邏輯是BKB006103會依照UUID值去做更新)
// 	BKA008001:帶值到BKB006103新增/更新資料，
// 	BKA008002-BKA008009:帶值到BKB006103新增/更新資料，


// 連線資料庫
Database DB01 = new Database("BK");
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
String table="BKA008"; //要連接的資料表
String FTYPE=SQLIJ(request.getParameter("FTYPE"));


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

// 判斷是新增資料還是更新資料
if(BKA008001.equals("")){
	FTYPE="A";
}else{
	FTYPE="U";
	SQL01="SELECT * FROM BKA008 where BKA008001 = '"+BKA008001+"'";
	RS01 = TAB01.buildMaps(SQL01);
	BKA008002=RS01[0].get("BKA008002").toString();
	BKA008003=RS01[0].get("BKA008003").toString();
	BKA008004=RS01[0].get("BKA008004").toString();
	BKA008005=RS01[0].get("BKA008005").toString();
	BKA008006=RS01[0].get("BKA008006").toString();
	BKA008007=RS01[0].get("BKA008007").toString();
	BKA008008=RS01[0].get("BKA008008").toString();
	BKA008009=RS01[0].get("BKA008009").toString();
}

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
<%-- NOTE: 隱藏表單--%>
<input name="BKA008001" type="hidden" id="BKA008001" value="<%=BKA008001%>" /> 
<input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" /> 
	<div class="container px-4">
		<div class="d-flex justify-content-between">
		  <div>
			<h3 class="mt-4">庫存維護管理</h3>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
				<li class="breadcrumb-item" aria-current="page">庫存維護管理</li>
				<li class="breadcrumb-item active" aria-current="page">庫存維護</li>
			</ol>
		  </div>
		  <div class="mt-5">
			<button type="button" class="btn btn-sm btn-light border-secondary" onClick="javascript:document.location.href='BKB060100.jsp'"><i class="fas fa-reply me-2"></i>回查詢頁</button>
		  </div>
		</div>
		
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						庫存管理
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl-3">
								<label for="BKA002002" class="form-label text-green fw-bold">品項大類<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="BKA008002" name="BKA008002">
								  	<option value="">請選擇類別</option>
									<option value="大類1">大類1</option>
								 	<option value="大類2">大類2</option>
									<option value="大類3">大類3</option> 
								</select>
							</div>
							<div class="col-xl-3">
								<label for="BKA002002" class="form-label text-green fw-bold">品項小類<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="BKA008003" name="BKA008003">
								    <option value="">請選擇類別</option>
									<option value="小類1">小類1</option>
								 	<option value="小類2">小類2</option>
									<option value="小類3">小類3</option>
									<option value="小類4">小類4</option>
									<option value="小類5">小類5</option>
								</select>
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">品項名稱<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA008004" name="BKA008004" value="<%=BKA008004%>" placeholder="例如：酒精噴瓶">
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">批號或型號</label>
								<input type="text" class="form-control" id="BKA008005" name="BKA008005" value="<%=BKA008005%>" placeholder="例如：">
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">數量<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA008006" name="BKA008006" value="<%=BKA008006%>" placeholder="例如：50">
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">單位<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA008007" name="BKA008007" value="<%=BKA008007%>" placeholder="例如：瓶">
							</div>
							<div class="col-xl-6">
								<label for="BKA002003" class="form-label text-green fw-bold">描述說明</label>
								<input type="text" class="form-control" id="BKA008008" name="BKA008008" value="<%=BKA008008%>" placeholder="請輸入描述說明">
							</div>
						</div>
						
						<div class="row mt-4">
							<div class="col-xl-12" align="center">
								<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB060103','_self')"><i class="far fa-check-circle me-2"></i>儲存</button>
							</div>
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
  $("#form1").submit();
}

</script>

</body>
</html>
