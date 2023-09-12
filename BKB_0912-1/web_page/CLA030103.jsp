<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
//取得日期
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
Map[] RS03 = null;
String SQL02 = "";
%>
<%
String BKA007002 = SQLIJ(request.getParameter("BKA007002"));  //行政區
String BKA007003 = SQLIJ(request.getParameter("BKA007003"));  //院所名稱
String TOrder = SQLIJ(request.getParameter("TOrder"));  //排序用
if(TOrder.equals(""))TOrder=" BKA007001";

if(!BKA007002.equals("")){
  SQL01 += " AND BKA007002 = N'" + BKA007002 + "' ";
}
if(!BKA007003.equals("")){
  SQL01 += " AND BKA007003 LIKE N'%" + BKA007003 + "%'";
}

if(SQL01.equals("")){
    SQL01 = "SELECT * FROM BKA007 WHERE BKA007001 <> '' ORDER BY " + TOrder;  //無查詢條件全列
}else{
    SQL01 = "SELECT * FROM BKA007 WHERE BKA007001 <> '' " + SQL01 + " ORDER BY " + TOrder;
}
//out.print(SQL01);  //印出訊息
//if(true)return;   //終止程式
RS01 = TAB01.buildMaps(SQL01);
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
<html lang="zh"> 
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
<style>

</style>
</head>
<body>

<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="form1" name="form1" method="post" action="" class="mb-0">
<input type="hidden" name ="BKA007001" value="" >
<input name="PNO01" type="hidden" id="PNO01" value="" />
<div class="container my-5">

	<div class="card shadow">
	<div class="card-body">
		<div class="d-flex justify-content-between">
			<h4 class="text-green fw-bold">院所資料</h4>
		</div>
		<div class="border p-4 mt-2">
			<div class="row">
				<div class="col-lg">
					<label for="" class="col-form-label">名稱</label>
					<input class="form-control" name="BKA007003" type="text" id="BKA007003" maxlength="50" value="<%=BKA007003%>" placeholder="例如：鴻維診所">
				</div>
				<div class="col-lg">
					<label for="" class="col-form-label">行政區</label>
					<div class="input-group">
						<select class="form-select" name="BKA007002" id="BKA007002">
							<option value="">&ndash;請選擇&ndash;</option>
							<%
							SQL01="SELECT DIST_NAME FROM DIST ORDER BY DIST_ID"; 
							RS02 = TAB01.buildMaps(SQL01);
							for(int A=0;A<RS02.length;A++){
							%>
							<option value="<%=RS02[A].get("DIST_NAME").toString()%>" <%=BKA007002.equals(RS02[A].get("DIST_NAME").toString())?"selected":""%>><%=RS02[A].get("DIST_NAME").toString()%></option>
							<%
							}
							%>
						</select>
						<a href="javascript:SF01()" type="button" class="btn btn-green border-secondary text-white"><i class="fas fa-search me-2"></i>查詢</a>
					</div>
				</div>
			</div>
			<div class="row mt-5">
				<div class="col-lg" align="right">
					<button type="button" class="btn btn-light border-secondary" onclick="SF02('CLA030100','_self','')"><i class="fas fa-plus me-2"></i>新增</button>
				</div>
			</div>
			<table class="table table-bordered mt-1">
				<thead class="tr-only-hide bg-dark text-white">
					<tr align="center" valign="middle">
						<td width="">院所編號</td>
						<td width="">行政區</td>	
						<td width="">名稱</td>					
						<td width="">地址</td>					
						<td width="">電話</td>					
						<td width="5%">修改</td>
						<td width="5%">刪除</td>
					</tr>
				</thead>
				<tbody>
					<%
					//for(int A=0;A<RS01.length;A++){
					for (int A=SNUM01;A<ENUM01;A++){
					%>
					<tr align="center" valign="middle">
						<td><%=RS01[A].get("BKA007001").toString()%></td>
						<td><%=RS01[A].get("BKA007002").toString()%></td>
						<td><%=RS01[A].get("BKA007003").toString()%></td>
						<td><%=RS01[A].get("BKA007004").toString()%></td>
						<td><%=RS01[A].get("BKA007010").toString()%></td>					
						<td>
							<button type="button" class="btn btn-warning btn-sm" onclick="SF02('CLA030100','_self','<%=RS01[A].get("BKA007001").toString()%>')"><i class="fas fa-pencil-alt"></i></button>
						</td>
						<td align="center">
							<button type="button" class="btn btn-danger btn-sm" onclick="SF02('CLA030102','_self','<%=RS01[A].get("BKA007001").toString()%>')"><i class="fa fa-minus"></i></button>
						</td>
					</tr>
					<%}%>
				</tbody>
			</table>
			
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
<input type="hidden" name ="SENDURL" value="CLA030103" >
</form>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>


<script type="text/javascript">
function SF01(){
	form1.action = "CLA030103.jsp";
	form1.submit();
}
function SF02(A, B, C){
	form1.BKA007001.value=C;
	form1.target = B;
	form1.action = A + ".jsp";
	form1.submit();
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
<%
DB01.close();
%>