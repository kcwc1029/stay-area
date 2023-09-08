<%-- NOTE:引入 --%>
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
%>

<%
// NOTE: 接值
String BKA002002 = SQLIJ(request.getParameter("BKA002002"));
String BKA002003 = SQLIJ(request.getParameter("BKA002003"));
String BKA002005 = SQLIJ(request.getParameter("BKA002005"));
String BKA002006 = SQLIJ(request.getParameter("BKA002006"));
String BKA002009 = SQLIJ(request.getParameter("BKA002009"));
String BKA002010 = SQLIJ(request.getParameter("BKA002010"));


// NOTE: 處裡SQL語句
String TOrder = SQLIJ(request.getParameter("TOrder"));  //排序用
if(TOrder.equals(""))TOrder=" BKA002002 DESC";

if(!BKA002002.equals("")){
  SQL01 += " AND BKA002002 = '" + BKA002002 + "'";
}
if(!BKA002003.equals("")){
  SQL01 += " AND BKA002003 = '" + BKA002003 + "'";
}
if(!BKA002005.equals("")){
  BKA002005 = BKA002005.replace("/","");
  SQL01 += " AND SUBSTRING(BKA002005,1,8) >= '" + BKA002005 + "' ";
}
if(!BKA002006.equals("")){
  BKA002006 = BKA002006.replace("/","");
  SQL01 += " AND SUBSTRING(BKA002006,1,8) <= '" + BKA002006 + "' ";
}
if(!BKA002009.equals("")){
  BKA002009 = BKA002009.replace("/","");
  SQL01 += " AND BKA002009 >= '" + BKA002009 + "' ";
}
if(!BKA002010.equals("")){
  BKA002010 = BKA002010.replace("/","");
  SQL01 += " AND BKA002010 <= '" + BKA002010 + "' ";
}
if(SQL01.equals("")){
    SQL01 = "SELECT * FROM BKA002 WHERE BKA002001 <> '' ORDER BY "+TOrder;  //無查詢條件全列
}else{
    SQL01 = "SELECT * FROM BKA002 WHERE BKA002001 <> '' " + SQL01 + " ORDER BY "+TOrder;
}
RS01 = TAB01.buildMaps(SQL01);


%>

<%
// NOTE: 處理分頁
//資料總筆數(必須轉換為數值)
int DTNUM01 = RS01.length;
//每頁顯示筆數
int PNUM01 = 30;
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
<input name="BKA002001" type="hidden" id="BKA002001" value="" />
<input name="SENDURL" type="hidden" id="SENDURL" value="BKB030100" >
<input name="PNO01" type="hidden" id="PNO01" value="" />
	<div class="container px-4">
		<h3 class="mt-4">場次管理</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">場次管理</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						場次維護
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">期別</label>
								<input type="text" class="form-control" id="BKA002002" name="BKA002002" value="<%=BKA002002%>" placeholder="例如：10-1">
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">場次名稱</label>
								<input type="text" class="form-control" id="BKA002003" name="BKA002003" value="<%=BKA002003%>" placeholder="例如：第十期BNT加開場次">
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">開放接種日期</label>
								<div class="input-group">
									<input type="text" class="form-control datepicker1" id="BKA002009" name="BKA002009" value="<%=BKA002009%>" placeholder="例如：1111114">
									<span class="input-group-text" id="input-group-left-example">-</span>
									<input type="text" class="form-control datepicker" id="BKA002010" name="BKA002010" value="<%=BKA002010%>" placeholder="例如：1111120">
								</div>
							</div>
							<div class="col-xl-4 mt-2">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">開放匯入日期</label>
								<div class="input-group">
									<input type="text" class="form-control datepicker1" id="BKA002005" name="BKA002005" value="<%=BKA002005%>" placeholder="例如：1111110">
									<span class="input-group-text" id="input-group-left-example">-</span>
									<input type="text" class="form-control datepicker" id="BKA002006" name="BKA002006" value="<%=BKA002006%>" placeholder="例如：1111111">
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB030100','_self')"><i class="fas fa-search me-2"></i>查詢</button>
								</div>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-xl-12 mt-3" align="right">
								<button type="button" class="btn btn-light border-secondary" onClick="SF01('BKB030101','_self')"><i class="fas fa-plus me-2"></i>新增場次</button>
							</div>
						</div>
						
						<div class="table-responsive mt-1">
							<table class="table table-striped table-bordered">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">期別</th>
								  <th scope="col">場次名稱</th>
								  <th scope="col">場次狀態</th>
								  <th scope="col">開放匯入起始日</th>
								  <th scope="col">開放匯入截止日</th>
								  <th scope="col">開放預約時間</th>
								  <th scope="col">開放接種起始日</th>
								  <th scope="col">開放接種截止日</th>
								  <th scope="col">修改</th>
								  <th scope="col">刪除</th>
								</tr>
							  </thead>
							  <tbody align="center">
								<%
								String BKA002005Y = "";
								String BKA002006Y = "";
								String BKA002007Y = "";
								for(int A=SNUM01;A<ENUM01;A++){
									BKA002005Y = RS01[A].get("BKA002005").toString();
									if(BKA002005Y.length() >= 12){
										BKA002005Y = EYC2(BKA002005Y.substring(0,8))+" "+BKA002005Y.substring(8,10)+":"+BKA002005Y.substring(10);
									}
									BKA002006Y = RS01[A].get("BKA002006").toString();
									if(BKA002006Y.length() >= 12){
										BKA002006Y = EYC2(BKA002006Y.substring(0,8))+" "+BKA002006Y.substring(8,10)+":"+BKA002006Y.substring(10);
									}
									BKA002007Y = RS01[A].get("BKA002007").toString();
									if(BKA002007Y.length() >= 12){
										BKA002007Y = EYC2(BKA002007Y.substring(0,8))+" "+BKA002007Y.substring(8,10)+":"+BKA002007Y.substring(10);
									}
								%>
								<tr>
								  <th scope="row"><%=RS01[A].get("BKA002002").toString()%></th>
								  <td><%=RS01[A].get("BKA002003").toString()%></td>
								  <td><%=RS01[A].get("BKA002004").toString().equals("1")?"開放":"關閉"%></td>
								  <td class="text-green fw-bold"><%=BKA002005Y%></td>
								  <td class="text-green fw-bold"><%=BKA002006Y%></td>
								  <td class="text-danger fw-bold"><%=BKA002007Y%></td>
								  <td class="text-primary fw-bold"><%=EYC2(RS01[A].get("BKA002009").toString())%></td>
								  <td class="text-primary fw-bold"><%=EYC2(RS01[A].get("BKA002010").toString())%></td>
								  <td><button type="button" class="btn btn-warning btn-sm" onclick="SF02('BKB030101','_self','<%=RS01[A].get("BKA002001").toString()%>')"><i class="fas fa-pen"></i></button></td>
								  <td><button type="button" class="btn btn-danger btn-sm" onclick="SF03('BKB030103','_self','<%=RS01[A].get("BKA002001").toString()%>')"><i class="fas fa-minus"></i></button></td>
								</tr>
								<%}%>
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
  form1.BKA002001.value = C;
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
			form1.BKA002001.value = C;
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
