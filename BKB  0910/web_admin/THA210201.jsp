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
String URA001001 = "";
String URA001002 = "";
String URA001003 = "";
String URA001004 = "";
String URA001005 = "";
String URA001006 = "";
String URA001007 = "";
String URA001008 = "";
String URA001009 = "";
String URA001010 = "";
String URA001011 = "";
String URA001012 = "";
String URA001013 = "";
String URA001016 = "";
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
SQL01 = "SELECT * FROM URA001 WHERE URA001001 = '"+PK01+"'";
//out.print(SQL01+"<br>");
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

if (RS01.length != 0){
	URA001001 = RS01[0].get("URA001001").toString();
	URA001002 = RS01[0].get("URA001002").toString();
	URA001003 = RS01[0].get("URA001003").toString();
	URA001004 = RS01[0].get("URA001004").toString();
	URA001005 = RS01[0].get("URA001005").toString();
	URA001006 = RS01[0].get("URA001006").toString();
	URA001007 = RS01[0].get("URA001007").toString();
	URA001008 = RS01[0].get("URA001008").toString();
	URA001009 = RS01[0].get("URA001009").toString();
	URA001010 = RS01[0].get("URA001010").toString();
	URA001011 = RS01[0].get("URA001011").toString();
	URA001012 = RS01[0].get("URA001012").toString();
	URA001013 = RS01[0].get("URA001013").toString();
	URA001016 = RS01[0].get("URA001016").toString();
}
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
<input name="URA001006" type="hidden" id="URA001006" value="<%=URA001006%>" />
<input name="URA001013O" type="hidden" id="URA001013O" value="<%=URA001013%>" />
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
				<li class="breadcrumb-item active">使用者帳號資料變更</li>
			</ol>
		</div>
		<div class="container-fluid">
			<div class="text-danger font-weight-bold" align="right">（★為必填欄位）</div>
			<div class="border p-3">
				<div class="alert alert-success" role="alert"><strong>使用者帳號資料變更</strong></div>
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
							<option value="<%=RS02[A].get("URA003001").toString()%>" <%=((URA001013.equals(RS02[A].get("URA003001").toString()))?"selected=\"selected\"":"")%>><%=RS02[A].get("URA003003").toString()%></option>
							<%}%>
						</select>
					</div>
					<div class="col-sm">
						<label for="" class="col-form-label"><span class="text-danger font-weight-bold">★</span>使用者帳號</label>
						<input type="text" name="URA001001" id="URA001001" class="form-control" value="<%=URA001001%>" readonly />
					</div>
					<div class="col-sm" style="display:none">
						<label for="URA001004" class="col-form-label"><span class="text-danger font-weight-bold">★</span>密碼</label>
						<input name="URA001004" type="password" id="URA001004" class="form-control" maxlength="30" value="<%=URA001004%>" />
					</div>
					<div class="col-sm" style="display:none">
						<label for="URA001004CK" class="col-form-label"><span class="text-danger font-weight-bold">★</span>確認密碼</label>
						<input name="URA001004CK" type="password" id="URA001004CK" class="form-control" maxlength="30" value="<%=URA001004%>" />
					</div>
				</div>
				<div class="row">
					<div class="col-sm">
						<label for="URA001002" class="col-form-label"><span class="text-danger font-weight-bold">★</span>使用者名稱</label>
						<input name="URA001002" type="text" id="URA001002" size="15" class="form-control" value="<%=URA001002%>"/>
					</div>
					<div class="col-sm">
						<label for="URA001003" class="col-form-label"><span class="text-danger font-weight-bold">★</span>使用者角色</label>
						<select name="URA001003" class="form-select" id="URA001003">
							<option value="府關懷中心" <%=((URA001003.equals("府關懷中心"))?"selected=\"selected\"":"")%>>府關懷中心</option>
							<option value="區關懷中心" <%=((URA001003.equals("區關懷中心"))?"selected=\"selected\"":"")%>>區關懷中心</option>
							<option value="里幹事" <%=((URA001003.equals("里幹事"))?"selected=\"selected\"":"")%>>里幹事</option>
							<option value="衛生所人員" <%=((URA001003.equals("衛生所人員"))?"selected=\"selected\"":"")%>>衛生所人員</option>
							<option value="醫事人員" <%=((URA001003.equals("醫事人員"))?"selected=\"selected\"":"")%>>醫事人員</option>
						</select>
					</div>
					<div class="col-sm">
						<label for="URA001007" class="col-form-label">連絡電話</label>
						<input name="URA001007" type="text" id="URA001007" size="15" class="form-control" value="<%=URA001007%>" placeholder="例:071234567,1234"/>
					</div>
					<div class="col-sm">
						<label for="URA001009" class="col-form-label">連絡手機</label>
						<input name="URA001009" type="text" id="URA001009" size="15" class="form-control" value="<%=URA001009%>" placeholder="例:0910110110"/>
					</div>
				</div>
				<div class="row">
					<div class="col-sm">
						<label for="URA001012" class="col-form-label">轄區</label>
						<select name="URA001010" class="form-select" id="URA001010">
							<%
							SQL01 = "SELECT DIST_NAME FROM DIST ORDER BY DIST_ID"; //宣告SQL語法
							RS02 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中
							for (int A=0;A<RS02.length;A++){
							%>
							<option value="<%=RS02[A].get("DIST_NAME").toString()%>" <%=((URA001010.equals(RS02[A].get("DIST_NAME").toString()))?"selected=\"selected\"":"")%>><%=RS02[A].get("DIST_NAME").toString()%></option>
							<%}%>
						</select>
					</div>
					<div class="col-sm">
						<label for="URA001012" class="col-form-label">職稱</label>
						<input name="URA001012" type="text" id="URA001012" size="30" class="form-control" value="<%=URA001012%>" placeholder="例:里幹事"/>
					</div>
					<div class="col-sm">
						<label for="URA001005" class="col-form-label"><span class="text-danger font-weight-bold">★</span>電子信箱</label>
						<input type="text" name="URA001005" id="URA001005" class="form-control" value="<%=URA001005%>"/>
					</div>
					<div class="col-sm">
						<label for="URA001016" class="col-form-label"><span class="text-danger font-weight-bold">★</span>帳號狀態</label>
						<select name="URA001016" class="form-select" id="URA001016">
						  <option value="">請選擇</option>
						  <option value="1" <%=((URA001016.equals("1"))?"selected=\"selected\"":"")%>>啟用</option>
						  <option value="2" <%=((URA001016.equals("2"))?"selected=\"selected\"":"")%>>待開通</option>
						  <option value="0" <%=((URA001016.equals("0"))?"selected=\"selected\"":"")%>>停權</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-sm">
						<label for="URA001011" class="col-form-label">單位</label>
						<input name="URA001011" type="text" id="URA001011" maxlength="100" class="form-control" value="<%=URA001011%>" placeholder="例:衛生局"/>
					</div>
					<div class="col-sm">
						<label for="URA001008" class="col-form-label">健保卡號</label>
						<input type="text" name="URA001008" id="URA001008" class="form-control" value="<%=URA001008%>"/>
					</div>
				</div>
			</div>
			<!-- 按鈕 -->
			<div class="row mt-4 mb-3">
				<div class="col-sm" align="center">
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:SF01('THA210100','jsp','_self','','');">回上一頁</button>
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:PF01('THA210202','jsp','_self','','C');">儲存</button>
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
//alert(A);
MSG01 = "";

if (E == "C"){

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

if (FM01.URA001011.value == ""){
MSG01 = MSG01+"服務單位不可空白!!\r\n";
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
