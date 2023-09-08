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

// NOTE: 接值&v宣告
String table="BKA008"; //要連接的資料表
//先設定啥都沒有，如果下面的SQL查詢為空，在下面input的value也會為空
String BKA008002=""; // 大類
String BKA008003=""; // 小類
String BKA008004=""; // 名稱
String BKA008005=""; // 型號
String BKA008006=""; // 數量
String BKA008007=""; // 單位
String BKA008008=""; // 描述
String FTYPE="A"; 

// 處裡如果是按新增，會回傳"BKB060101";如果是修改，會回傳uuid
String BKA008001 = SQLIJ(request.getParameter("BKB060101")); // UUID(變數由網頁編號改成資料庫編號)




out.print(BKA008001);


// 透過BKA008001查詢資料
if(BKA008001.equals("BKB060101")==false){
	FTYPE="U";
	SQL01+="SELECT * FROM BKA008 where BKA008001 = '"+BKA008001+"'";
	out.print(SQL01);
	RS01 = TAB01.buildMaps(SQL01);
	// 更新欄位值
	for(int i=0;i<RS01.length;i++){
		BKA008002=RS01[i].get("BKA008002").toString();
		BKA008003=RS01[i].get("BKA008003").toString();
		BKA008004=RS01[i].get("BKA008004").toString();
		BKA008005=RS01[i].get("BKA008005").toString();
		BKA008006=RS01[i].get("BKA008006").toString();
		BKA008007=RS01[i].get("BKA008007").toString();
		BKA008008=RS01[i].get("BKA008008").toString();
	}

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
<input name="FTYPE" type="hidden" id="FTYPE" value="A" /> 
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
								  <option value="衛教品">衛教品</option>
								  <option value="宣導品">宣導品</option>
								</select>
							</div>
							<div class="col-xl-3">
								<label for="BKA002002" class="form-label text-green fw-bold">品項小類<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="BKA008003" name="BKA008003">
								  <option value="酒精">酒精</option>
								  <option value="原子筆">原子筆</option>
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
