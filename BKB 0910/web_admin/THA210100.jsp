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
<%@ include file="../web_script/WSA010700.jsp"%>
<% 
String PK01 = SQLIJ(request.getParameter("PK01"));
String PK02 = SQLIJ(request.getParameter("PK02"));
String URA001008 = SQLIJ(request.getParameter("URA001008"));
String URA001010 = SQLIJ(request.getParameter("URA001010"));
String URA001011 = SQLIJ(request.getParameter("URA001011"));
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

SQL01 = "SELECT * FROM URA001 WHERE URA001001 IS NOT NULL"; //宣告SQL語法

if (!URA001008.equals("")){
SQL01 = SQL01+" AND URA001008 LIKE '%"+URA001008+"%'"; //宣告SQL語法
}

if (!URA001010.equals("")){
SQL01 = SQL01+" AND URA001010 LIKE '%"+URA001010+"%'"; //宣告SQL語法
}

if (!URA001011.equals("")){
SQL01 = SQL01+" AND URA001011 LIKE '%"+URA001011+"%'"; //宣告SQL語法
}

if (!KW01S.equals("") && !KW01S.equals("請輸入帳號或名稱關鍵字")){
SQL01 = SQL01+" AND (URA001001 LIKE '%"+KW01S+"%' OR URA001002 LIKE '%"+KW01S+"%')"; //宣告SQL語法
}

SQL01 = SQL01+" ORDER BY URA001015 DESC,URA001001"; //宣告SQL語法
RS01 = TAB01.buildMaps(SQL01); //將篩選出來的資料放到陣列中
%>
<%
//資料總筆數(必須轉換為數值)
int DTNUM01 = RS01.length;

//每頁顯示筆數
int PNUM01 = 20;

//總頁數(取整數部份)
int TPAGE01 = ((DTNUM01-1)/PNUM01)+1;

//頁碼
int PNO01 = 1;
if (request.getParameter("PNO01") != null && request.getParameter("PNO01") != ""){
PNO01 = Integer.parseInt(request.getParameter("PNO01"));
}

//起始筆數
int SNUM01 = (PNUM01*PNO01)-PNUM01;

//迄止筆數
int ENUM01;
if (PNO01 != TPAGE01){
ENUM01 = PNUM01*PNO01;
} else {
ENUM01 = DTNUM01;
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
<input name="PK01" type="hidden" id="PK01" value="<%=PK01%>" />
<input name="PK02" type="hidden" id="PK02" value="<%=PK02%>" />
<input name="PNO01" type="hidden" id="PNO01" value="" />
<br><br>
<div class="container-fluid">
	<div class="card shadow">
		<div class="card-body pb-0">
			<div class="d-flex justify-content-between">
				<div><h4 class="text-red2 font-weight-bold">使用者權限管理</h4></div>
			</div>
			<ol class="breadcrumb">
				<li class="breadcrumb-item">首頁</li>
				<li class="breadcrumb-item">資料維護</li>
				<li class="breadcrumb-item active">使用者權限管理</li>
			</ol>
		</div>
		<div class="container-fluid">
			<div class="border p-3">
				<!-- 查詢列表 -->
				<div class="row">
					<div class="col-sm-3">
						<label for="URA001013S" class="col-form-label">單位</label>
						<input class="form-control" name="URA001011" type="text" id="URA001011" value="<%=URA001011%>" placeholder="請輸入單位關鍵字"/>
					</div>
					<div class="col-sm-3">
						<label for="URA001013S" class="col-form-label">轄區</label>
						<input class="form-control" name="URA001010" type="text" id="URA001010" value="<%=URA001010%>" placeholder="請輸入轄區關鍵字"/>
					</div>
					<div class="col-sm-3">
						<label for="URA001013S" class="col-form-label">健保卡號</label>
						<input class="form-control" name="URA001008" type="text" id="URA001008" value="<%=URA001008%>" placeholder="請輸入健保卡號"/>
					</div>
					<div class="col-sm">
						<label for="KW01S" class="col-form-label">關鍵字</label>
						<div class="input-group">
							<input class="form-control" name="KW01S" type="text" id="KW01S" onclick="PF01(this.value)" value="<%=((!KW01S.equals(""))?KW01S:"")%>" placeholder="請輸入帳號或名稱關鍵字"/>
							<div class="input-group-append">
								<button type="button" class="btn btn-light border-secondary" onclick="javascript:SF01('THA210100','jsp','_self','','');"><i class="fa fa-search pr-2"></i>查詢</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 查詢結束 -->
			<!-- 按鈕 -->
			<div class="row mt-4 mb-3">
				<div class="col-sm" align="right">
					<button type="button" class="btn btn-outline-secondary" name="BTN01" id="BTN01" onclick="SF01('THA210200','jsp','_self','','');"><i class="fa fa-user-plus pr-2"></i>新增使用帳號</button>
					<button type="button" class="btn btn-outline-secondary" name="BTN02" id="BTN02" onclick="SF01('THA210400','jsp','_self','','');"><i class="fa fa-users pr-2"></i>群組權限管理</button>
				</div>
			</div>
			<!-- 查詢結果列表 -->
			<div class="table-responsive mt-2">
				<table class="table table-striped">
					<thead>
						<tr align="center">
							<th>名稱 / 帳號</th>
							<th>健保卡號</th>
							<th>轄區</th>
							<th>單位</th>
							<th>電子信箱</th>
							<th>狀態</th>
							<th>修改</th>
							<th>權限設定</th>
					</thead>
					<tbody>
					<%
					for (int A=SNUM01;A<ENUM01;A++){
					%>
					<tr align="center">
					<%
					ST01 = RS01[A].get("URA001002").toString()+"/"+RS01[A].get("URA001001").toString();
					%>
					   <td nowrap="nowrap" class="<%=TD01%>"><%=ST01%></td>
					<%
					ST01 = RS01[A].get("URA001008").toString();					
					%>
					  <td width="20%" class="<%=TD01%>"><%=ST01%></td>
					  <td nowrap="nowrap" class="<%=TD01%>"><%=RS01[A].get("URA001010").toString()%></td>
					  <td nowrap="nowrap" class="<%=TD01%>"><%=RS01[A].get("URA001011").toString()%></td>
					<%
					ST01 = RS01[A].get("URA001005").toString();
					%>
					  <td class="<%=TD01%>"><%=ST01%></td>
					<%
					ST01 = RS01[A].get("URA001016").toString();
					if (ST01.equals("2")){
					ST01 = "待開通";
					}
					if (ST01.equals("1")){
					ST01 = "啟用中";
					}
					if (ST01.equals("0")){
					ST01 = "已停權";
					}
					%>
					  <td nowrap="nowrap" class="<%=TD01%>"><%=ST01%></td>
					<%
					ST01 = RS01[A].get("URA001001").toString();
					%>
					  <td class="<%=TD01%>"><button type="button" class="btn btn-sm btn-success" onclick="SF01('THA210201','jsp','_self','<%=ST01%>','')"><i class="fas fa-edit"></i></button></td>
					  <td class="<%=TD01%>"><button type="button" class="btn btn-sm btn-success" onclick="SF01('THA210300','jsp','_self','<%=ST01%>','')"><i class="fas fa-user-secret"></i></button></td>
					</tr>
					<%
					}
					%>
					</tbody>
				</table>
			</div>
			
			<!-- 切換頁數 -->
			<div class="d-flex justify-content-center input-group">
			  <div class="input-group-prepend">
				<span class="input-group-text">共<%=RS01.length%>筆，目前頁數</span>
			  </div>
			  <select name="PGA01" id="PGA01" class="txt_data_left" onChange="PG01(this.value,'<%=request.getRequestURI()%>')">
				<%
				for(int i=1; i<TPAGE01+1; i++){
				%>
				<option value="<%=i%>" <%=((i == PNO01)?"selected=\"selected\"":"")%>>第<%=i%>頁</option>
				<%
				}
				%>
			  </select>

				<a class="btn btn-sm btn-outline-dark input-group-append" href="javascript:PG01('1','<%=request.getRequestURI()%>');">
				  <i class="fa fa-fast-backward" style="font-size: 16px; line-height: inherit;"></i>
				</a>
				<%
				if(SNUM01 != 0){
				%>
				<a class="btn btn-sm btn-outline-dark input-group-append" href="javascript:PG01('<%=PNO01-1%>','<%=request.getRequestURI()%>');">
				  <i class="fa fa-caret-left" style="font-size: 24px;"></i>
				</a>
				<%
				}else{
				%>
				<a class="btn btn-sm btn-outline-dark input-group-append" href="javascript:PG01('<%=PNO01%>','<%=request.getRequestURI()%>');">
				  <i class="fa fa-caret-left" style="font-size: 24px;"></i>
				</a>
				<%
				}
				%>
				<%
				if(ENUM01 != DTNUM01){
				%>
				<a class="btn btn-sm btn-outline-dark input-group-append" href="javascript:PG01('<%=PNO01+1%>','<%=request.getRequestURI()%>');">
				  <i class="fa fa-caret-right" style="font-size: 24px;"></i>
				</a>
				<%
				}else{
				%>
				<a class="btn btn-sm btn-outline-dark input-group-append" href="javascript:PG01('<%=PNO01%>','<%=request.getRequestURI()%>');">
				  <i class="fa fa-caret-right" style="font-size: 24px;"></i>
				</a>
				<%
				}
				%>
				<a class="btn btn-sm btn-outline-dark input-group-append" href="javascript:PG01('<%=TPAGE01%>','<%=request.getRequestURI()%>');">
				  <i class="fa fa-fast-forward" style="font-size: 16px; line-height: inherit;"></i>
				</a>
			</div>
			<!--切換頁數-->
			<br><br>
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
function PF01(A){
if (A == "請輸入帳號或名稱關鍵字"){
$("#KW01S").val("");
}
}
function PG01(A,B){
	FM01.PNO01.value=A;
	FM01.target="_self";
	FM01.action=B;
	//alert(B);
	//alert(A);
	FM01.submit();
}
</script>
</html>
<%
DB01.close();
%>