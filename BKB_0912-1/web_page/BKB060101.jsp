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
Map[] RS02 = null;
String SQL02 = "";
String table="BKA008"; //要連接的資料表
String FTYPE=SQLIJ(request.getParameter("FTYPE"));


// 接值
String BKA008001 = SQLIJ(request.getParameter("BKA008001"));// UUID
String BKA008002 = SQLIJ(request.getParameter("BKA008002"));// 大類
String BKA008003 = SQLIJ(request.getParameter("BKA008003"));// 小類
String BKA008004 = SQLIJ(request.getParameter("BKA008004"));// 名稱
String BKA008005 = SQLIJ(request.getParameter("BKA008005"));// 型號
String BKA008006 = SQLIJ(request.getParameter("BKA008006"));// 數量
String BKA008007 = SQLIJ(request.getParameter("BKA008007"));// 單位
String BKA008008 = SQLIJ(request.getParameter("BKA008008"));// 描述
String BKA008009 = SQLIJ(request.getParameter("BKA008009"));// 有效時間
String BKA008901 = USERID;
String BKA008902 = SC01;
String BKA008903 = USERID;
String BKA008904 = SC01;
String BKA008905 = "0912test";

// 判斷是新增資料還是更新資料
if(BKA008001.equals("")){
	FTYPE="A";
}else{
	FTYPE="U";
	SQL01="SELECT * FROM BKA008 where BKA008001 = '"+BKA008001+"'";

	RS01 = TAB01.buildMaps(SQL01);
	BKA008002=RS01[0].get("BKA008002").toString();
	BKA008002=TAB01.getCol("UBZ002", "UBZ002001+UBZ002002+UBZ002003+UBZ002004", "UBZ002008", "'"+BKA008002+"'");
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
<input name="BKA008901" type="hidden" id="BKA008901" value="<%=BKA008901%>" />
<input name="BKA008902" type="hidden" id="BKA008902" value="<%=BKA008902%>" />
<input name="BKA008903" type="hidden" id="BKA008903" value="<%=BKA008903%>" />
<input name="BKA008904" type="hidden" id="BKA008904" value="<%=BKA008904%>" />
<input name="BKA008905" type="hidden" id="BKA008905" value="<%=BKA008905%>" />
<input type="hidden" name="selkind" id="selkind">
<input type="hidden" name="selvalue1" id="selvalue1">
<input type="hidden" name="selvalue2" id="selvalue2">
<input type="hidden" name="selvalue3" id="selvalue3">
<input type="hidden" name="outobj" id="outobj">
<input type="hidden" name="TN" id="TN">

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
							<%-- NOTE:處裡動態標籤頁 --%>
							<div class="col-xl-3">
								<label for="BKA002002" class="form-label text-green fw-bold">品項大類<span class="text-danger ms-1">*</span></label>
								<%-- <input type="hidden" id="TUA001022O" name ="TUA001022O" value="<%=BKA008002%>"> --%>
								<select class="form-select validate[required]" aria-label="Default select" id="BKA008002" name="BKA008002" onChange="getCode('getSelect',this.value,'','form1.BKA008003','UBZ002')" >
								  	<option value="">請選擇類別</option>
									<%
										SQL02="SELECT UBZ002001,UBZ002002,UBZ002003,UBZ002004,UBZ002008 FROM UBZ002 WHERE UBZ002002+UBZ002003 = '0101' AND UBZ002004 <> '000' AND UBZ002015 = '1' ORDER BY UBZ002010";													
										RS02 = TAB01.buildMaps(SQL02);
										for(int i=0;i<RS02.length;i++){
									%>
									<%-- 大類裡面的option --%>
			
										<option value="<%= RS02[i].get("UBZ002001").toString()+RS02[i].get("UBZ002002").toString()+RS02[i].get("UBZ002003").toString()+RS02[i].get("UBZ002004").toString() %>" <%=(RS02[i].get("UBZ002001").toString()+RS02[i].get("UBZ002002").toString()+RS02[i].get("UBZ002003").toString()+RS02[i].get("UBZ002004").toString()).equals(BKA008002) ? "selected" : ""%>><%=RS02[i].get("UBZ002008").toString()%></option>
									
									<% } %>
								</select>
							</div>
							<div class="col-xl-3">
							<%-- 處裡小標籤 --%>
								<label for="BKA002003" class="form-label text-green fw-bold">品項小類<span class="text-danger ms-1">*</span></label>
								<select class="form-select validate[required]" aria-label="Default select" id="BKA008003" name="BKA008003">
									<option value="">請選擇類別</option>
									<%
                              		SQL02 = "SELECT UBZ002008,UBZ002010 FROM UBZ002 WHERE UBZ002011 = '"+ BKA008002 +"' AND UBZ002010 <> '0'  GROUP BY UBZ002008,UBZ002010 ORDER BY UBZ002010"; //宣告SQL語法
                              		RS02 = TAB01.buildMaps(SQL02); //將篩選出來的資料放到陣列中
									 out.print("page 100,品項小類SQL");
									out.print(SQL02);
									// if(true)return;
                              for (int A=0;A<RS02.length;A++){
                              %>
                                 <option value="<%=RS02[A].get("UBZ002008").toString()%>" <%=RS02[A].get("UBZ002008").toString().equals(BKA008003) ? "selected" : ""%> ><%=RS02[A].get("UBZ002008").toString()%></option>
                              <%
                              }
                              %>
								</select>
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">品項名稱<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA008004" name="BKA008004" value="<%=BKA008004%>" placeholder="例如：酒精噴瓶">
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold ">批號或型號</label>
								<input type="text" class="form-control " id="BKA008005" name="BKA008005" value="<%=BKA008005%>" placeholder="例如：">
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
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">有效時間<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required] datepicker" id="BKA008009" name="BKA008009" value="<%=BKA008009%>" placeholder="日期：2022/11/01">
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
<%-- NOTE: 因動態標籤而使用 --%>
<iframe name="IFM01" src="" style="display:none" ></iframe>
	<!-- indexJS -->
	<%@ include file="indexJS.jsp"%>
	
<script type="text/javascript">
function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  $("#form1").submit();
}

// 處裡動態標籤選擇
function getCode(A,B,C,D,E,F){
	console.log("hihi");
	form1.selkind.value = A;
	form1.selvalue1.value = B;
	form1.selvalue2.value = C;
	form1.outobj.value = D;
	form1.TN.value = E;
	form1.target="IFM01";
	form1.action="../web_script/getCode.jsp";
	form1.submit();
}

</script>

</body>
</html>
