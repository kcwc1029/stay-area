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
String URA003001 = "";
String URA003002 = "";
String URA003003 = "";
String URA003004 = "";
String URA003005 = "";
String URA003006 = "";
String URA003009 = "";
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
SQL01 = "SELECT * FROM URA003 WHERE URA003001 = '"+PK01+"' AND URA003002 = '000000000'";
//out.print(SQL01+"<br>");
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中

if (RS01.length != 0){
URA003001 = RS01[0].get("URA003001").toString();
URA003002 = RS01[0].get("URA003002").toString();
URA003003 = RS01[0].get("URA003003").toString();
URA003004 = RS01[0].get("URA003004").toString();
URA003005 = RS01[0].get("URA003005").toString();
URA003006 = RS01[0].get("URA003006").toString();
URA003009 = RS01[0].get("URA003009").toString();
PK02 = "C";
} else {
PK02 = "B";
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
				<li class="breadcrumb-item">群組權限管理</li>
				<li class="breadcrumb-item active">編輯群組</li>
			</ol>
		</div>		
		<div class="container-fluid mt-2">
			<div class="text-danger font-weight-bold" align="right">（★為必填欄位）</div>
			<div class="border p-3 mt-2">
				<div class="alert alert-success" role="alert"><strong>編輯群組</strong></div>
				<div class="row">
					<div class="col-sm">
						<label for="URA003003" class="col-form-label"><span class="text-danger font-weight-bold">★</span>群組名稱</label>
						<input name="URA003003" type="text" id="URA003003" size="15" class="form-control" value="<%=URA003003%>" />
						<input name="URA003001" type="hidden" id="URA003001" value="<%=URA003001%>" />
						<input type="hidden" name="URA003002" id="URA003002" value="<%=URA003002%>" />
						<input type="hidden" name="URA003004" id="URA003004" value="<%=URA003004%>" />
						<input type="hidden" name="URA003005" id="URA003005" value="<%=URA003005%>" />
					</div>
					<div class="col-sm">
						<label for="URA003009" class="col-form-label"><span class="text-danger font-weight-bold">★</span>顯示狀態</label>
						<select name="URA003009" class="form-select" id="URA003009">
						  <option value="">請選擇</option>
						  <option value="1" <%=((URA003009.equals("1"))?"selected=\"selected\"":"")%>>顯示</option>
						  <option value="0" <%=((URA003009.equals("0"))?"selected=\"selected\"":"")%>>隱藏</option>
						</select>
					</div>
					<div class="w-100"></div>
					<div class="col-sm">
						<label for="URA003006" class="col-form-label">備註</label>
						<textarea name="URA003006" rows="2" id="URA003006" class="form-control"><%=URA003006%></textarea>
					</div>
				</div>
			</div>
			<!-- 按鈕 -->
			<div class="row mt-4 mb-3">
				<div class="col-sm" align="center">
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:SF01('THA210400','jsp','_self','<%=PK01%>','');">回上一頁</button>
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:PF01('THA210402','jsp','_self','','<%=PK02%>');">儲存</button>
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
function SF01(A,B,C,D,E){
	FM01.PK01.value=D;
	FM01.PK02.value=E;
	FM01.target=C;
	FM01.action=A+"."+B;
	FM01.submit();
}
var MSG01;

function PF01(A,B,C,D,E){
//alert(A);
MSG01 = "";

if (FM01.URA003003.value == ""){
MSG01 = MSG01+"群組名稱不可空白!!\r\n";
}

if (FM01.URA003009.value == ""){
MSG01 = MSG01+"顯示狀態必須選取!!\r\n";
}

if (MSG01 != ""){
alert(MSG01);
} else {
SF01(A,B,C,D,E);
}

}
</script>
</html>
<%
DB01.close();
%>
