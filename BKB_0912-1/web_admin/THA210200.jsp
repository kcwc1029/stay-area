<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<% 
String PK01 = SQLIJ(request.getParameter("PK01"));
String PK02 = SQLIJ(request.getParameter("PK02"));
String URA001013S = SQLIJ(request.getParameter("URA001013S"));
String URA001016S = SQLIJ(request.getParameter("URA001016S"));
String KW01S = SQLIJ(request.getParameter("KW01S"));
String TD01 = ""; //宣告SQL語法
String ST01 = ""; //宣告SQL語法
String ST02 = ""; //宣告SQL語法
String SQL01 = ""; //宣告SQL語法
String[] AS01 = null;
Map[] RS01 = null; //將篩選出來的資料放到陣列中
Map[] RS02 = null; //將篩選出來的資料放到陣列中
%>
<%
//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>
<body>
<!-- indexS -->
<%@ include file="../web_page/indexS.jsp"%>
<form id="FM01" name="FM01" method="post" action="">
<input name="PK01" type="hidden" id="PK01" value="" />
<input name="PK02" type="hidden" id="PK02" value="" />
<iframe name="IFM01" style="display:none"></iframe>
<input name="URA001006" type="hidden" id="URA001006" value="" />
<br><br>
<div class="container">
	<div class="card shadow">
		<div class="card-body pb-0">
			<div class="d-flex justify-content-between">
				<div><h4 class="text-red2 font-weight-bold">使用者權限管理</h4></div>
			</div>
			<ol class="breadcrumb">
				<li class="breadcrumb-item">首頁</li>
				<li class="breadcrumb-item">資料維護</li>
				<li class="breadcrumb-item">使用者帳號權限管理</li>
				<li class="breadcrumb-item active">新增使用者帳號</li>
			</ol>
		</div>
		<div class="container-fluid">
			<div class="text-danger font-weight-bold" align="right">（★為必填欄位）</div>
			<div class="border p-3 mt-2">
				<div class="alert alert-success" role="alert"><strong>新增使用者帳號</strong></div>
				<div class="row">
					<div class="col-sm">
						<label for="URA001013" class="col-form-label"><span class="text-danger font-weight-bold">★</span>群組類別</label>
						<select name="URA001013" class="form-select" id="URA001013">
							<option value="">請選擇</option>
							<%
							SQL01 = "SELECT URA003001,URA003003 FROM URA003 WHERE URA003009 = '1' AND URA003002 = '000000000' ORDER BY URA003001"; //宣告SQL語法
							RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

							for (int A=0;A<RS02.length;A++){
							%>
								  <option value="<%=RS02[A].get("URA003001").toString()%>" ><%=RS02[A].get("URA003003").toString()%></option>
								  <%
							}
							%>
						</select>
					</div>
					<div class="col-sm">
						<label for="URA001001" class="col-form-label"><span class="text-danger font-weight-bold">★</span>使用者帳號</label>
						<div class="input-group">
							<input name="URA001001" type="text" id="URA001001" size="15" class="form-control" maxlength="30"/>
							<div class="input-group-append">
								<button type="button" class="btn btn-info" name="BTN01" id="BTN01" onclick="PF01('THA210202','jsp','IFM01','','A');" >帳號查詢</button>
							</div>
						</div>
					</div>
					<div class="col-sm" style="display:none">
						<label for="URA001004" class="col-form-label"><span class="text-danger font-weight-bold">★</span>密碼</label>
						<input name="URA001004" type="password" id="URA001004" class="form-control" maxlength="30" value ="CCC)(*098"/>
					</div>
					<div class="col-sm" style="display:none">
						<label for="URA001004CK" class="col-form-label"><span class="text-danger font-weight-bold">★</span>確認密碼</label>
						<input name="URA001004CK" type="password" id="URA001004CK" class="form-control" maxlength="30" value="CCC)(*098" />
					</div>
					<div class="w-100"></div>
					<div class="col-sm">
						<label for="URA001002" class="col-form-label"><span class="text-danger font-weight-bold">★</span>使用者名稱</label>
						<input name="URA001002" type="text" id="URA001002" size="15" class="form-control" maxlength="30" />
					</div>
					<div class="col-sm">
						<label for="URA001003" class="col-form-label"><span class="text-danger font-weight-bold">★</span>使用者角色</label>
						<select name="URA001003" class="form-select" id="URA001003">
							<option value="府關懷中心">府關懷中心</option>
							<option value="區關懷中心">區關懷中心</option>
							<option value="里幹事">里幹事</option>
							<option value="衛生所人員">衛生所人員</option>
							<option value="醫事人員">醫事人員</option>
						</select>
					</div>
					<div class="col-sm">
						<label for="URA001007" class="col-form-label">連絡電話</label>
						<input name="URA001007" type="text" id="URA001007" size="15" class="form-control" placeholder="例:071234567,1234">
					</div>
					<div class="col-sm">
						<label for="URA001009" class="col-form-label">連絡手機</label>
						<input name="URA001009" type="text" id="URA001009" size="15" class="form-control" placeholder="例:0910110110">
					</div>
					<div class="w-100"></div>
					<div class="col-sm">
						<label for="URA001012" class="col-form-label">轄區</label>
						<select name="URA001010" class="form-select" id="URA001010">
							<%
							SQL01 = "SELECT DIST_NAME FROM DIST ORDER BY DIST_ID"; //宣告SQL語法
							RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中
							for (int A=0;A<RS02.length;A++){
							%>
							<option value="<%=RS02[A].get("DIST_NAME").toString()%>"><%=RS02[A].get("DIST_NAME").toString()%></option>
							<%}%>
						</select>
					</div>
					
					<div class="col-sm">
						<label for="URA001012" class="col-form-label">職稱</label>
						<select name="URA001012" class="form-select" id="URA001012">
						    <option value="局承辦人">局承辦人</option>
							<option value="區承辦人">區承辦人</option>
							<option value="衛生所承辦人">衛生所承辦人</option>
							<option value="里幹事">里幹事</option>
							<option value="醫事人員">醫事人員</option>
							<option value="其他">其他</option>
						</select>
					</div>
					<div class="col-sm">
						<label for="URA001005" class="col-form-label"><span class="text-danger font-weight-bold">★</span>電子信箱</label>
						<input type="text" name="URA001005" id="URA001005" class="form-control" placeholder="例:OOO@gmail.com">
					</div>
					<div class="col-sm">
						<label for="URA001016" class="col-form-label"><span class="text-danger font-weight-bold">★</span>帳號狀態</label>
						<select name="URA001016" class="form-select" id="URA001016">
							<option value="">請選擇</option>
							<option value="1" selected="selected">啟用</option>
							<option value="2" >待開通</option>
							<option value="0" >停權</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-sm">
						<label for="URA001011" class="col-form-label"><span class="text-danger font-weight-bold">★</span>單位</label>
						<input name="URA001011" type="text" id="URA001011" maxlength="100" class="form-control" value="" placeholder="例:衛生局"/>
					</div>
					<div class="col-sm">
						<label for="URA001008" class="col-form-label">里別</label>
						<input type="text" name="URA001008" id="URA001008" class="form-control" value=""/>
					</div>
				</div>
			</div>
			<!-- 按鈕 -->
			<div class="row mt-4 mb-3">
				<div class="col-sm" align="center">
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:SF01('THA210100','jsp','_self','','');">回上一頁</button>
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:PF01('THA210202','jsp','_self','','B');">新增</button>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
<!-- indexF -->
<%@ include file="../web_page/indexF.jsp"%>
<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
</body>
<script type="text/javascript">
var MSG01;

function PF01(A,B,C,D,E){
//alert(E);
//FM01.URA001004.value = FM01.URA001001.value;
//FM01.URA001004CK.value = FM01.URA001001.value;
MSG01 = "";
if (E == "A"){

if (FM01.URA001001.value == ""){
MSG01 = MSG01+"使用者帳號不可空白!!\r\n";
}

}

if (E == "B"){
	
if(FM01.URA001001.value == FM01.URA001004.value){
MSG01 = MSG01+"帳號密碼不可以相同!!\r\n";
}

if (FM01.URA001013.value == ""){
MSG01 = MSG01+"群組類別必須選取!!\r\n";
}

if (FM01.URA001001.value == ""){
MSG01 = MSG01+"使用者帳號不可空白!!\r\n";
}

if (FM01.URA001004.value == ""){
MSG01 = MSG01+"使用者密碼不可空白!!\r\n";
}

if (FM01.URA001004CK.value == ""){
MSG01 = MSG01+"確認密碼不可空白!!\r\n";
}

if (FM01.URA001004.value != FM01.URA001004CK.value){
MSG01 = MSG01+"二次輸入密碼不同,請重新輸入!!\r\n";
FM01.URA001004CK.value == "";
}

if (FM01.URA001002.value == ""){
MSG01 = MSG01+"使用者名稱不可空白!!\r\n";
}

if (FM01.URA001003.value == ""){
MSG01 = MSG01+"使用者角色必須選取!!\r\n";
}

if (FM01.URA001016.value == ""){
MSG01 = MSG01+"帳號狀態必須選取!!\r\n";
}

}

if (MSG01 != ""){
alert(MSG01);
} else {
SF01(A,B,C,D,E);
}

}
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
