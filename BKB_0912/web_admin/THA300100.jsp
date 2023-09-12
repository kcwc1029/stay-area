<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
//取得日期
Database DB01 = new Database("CR");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
%>
<%
String URA001002 = SQLIJ(request.getParameter("URA001002"));  //帳號

String TOrder = SQLIJ(request.getParameter("TOrder"));  //排序用
if(TOrder.equals(""))TOrder=" URA001002 ";

if(!URA001002.equals("")){
  SQL01 += " AND URA001002 LIKE '%" + URA001002 + "%'";
}


if(SQL01.equals("")){
    SQL01 = "SELECT * FROM URA001 LEFT JOIN CRA004 ON URA001001 = CRA004001 WHERE URA001003 = '承辦人'  ORDER BY "+TOrder;  //無查詢條件，僅列辦理中案件
}else{
    SQL01 = "SELECT * FROM URA001 LEFT JOIN CRA004 ON URA001001 = CRA004001 WHERE URA001003 = '承辦人'  " + SQL01 + " ORDER BY "+TOrder;
}
//out.print(SQL01);  //印出訊息
//if(true)return;   //終止程式
RS01 = TAB01.buildMaps(SQL01);

%>
<%
//資料總筆數(必須轉換為數值)
int DTNUM01 = RS01.length;

//每頁顯示筆數
int PNUM01 = 10;

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

<body>
<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="form1" name="form1" method="post" action="">
<input name="PNO01" type="hidden" id="PNO01" value="">
<input name="CRA004001" type="hidden" id="CRA004001" value="">
<div class="container">
	</br></br>	
	<div class="card shadow">
		<div class="card-body pb-0">
			<div class="d-flex justify-content-between">
				<div><h4 class="text-red2 font-weight-bold">陳核設定</h4></div>
			</div>
			<ol class="breadcrumb">
				<li class="breadcrumb-item">首頁</li>
				<li class="breadcrumb-item">資料維護</li>
				<li class="breadcrumb-item">陳核設定</li>
			</ol>	
		</div>
		<div class="container pb-3">
		  <div class="row">
			<div class="col-sm">
				<label for="URA001002" class="col-form-label">姓名關鍵字</label>
				<div class="input-group">
					<input class="form-control" name="URA001002" type="text" id="URA001002" value="<%=URA001002%>" placeholder="請輸入姓名關鍵字"/>
					<div class="input-group-append">
						<button type="button" class="btn btn-info" onclick="SF02('THA300100','_self')"><i class="fa fa-search pr-2"></i>查詢</button>
					</div>
				</div>
			</div>
		  </div>
		</div>
		<div class="table-responsive mt-2">
			<table class="table table-striped">
				<thead>
					<tr align="center">
						<th>名稱 / 帳號</th>
						<th>預設一</th>
						<th>預設二</th>
						<th>預設三</th>
						<th>設定</th>
					</tr>
				</thead>
				<tbody>
					<%
					for(int A=SNUM01;A<ENUM01;A++){
					%>
					<tr align="center">
						<td><%=RS01[A].get("URA001002").toString()%>/<%=RS01[A].get("URA001001").toString()%></td>
						<td><%=RS01[A].get("CRA004002").toString()%></td>
						<td><%=RS01[A].get("CRA004003").toString()%></td>
						<td><%=RS01[A].get("CRA004004").toString()%></td>
						<td><button type="button" class="btn btn-sm btn-success" onclick="SF01('THA300101','_self','<%=RS01[A].get("URA001001").toString()%>');"><i class="fa fa-pencil"></i></button></td>
					</tr>
					<%}%>
				</tbody>
			</table>
		</div>
	</div>
	<!--切換頁數-->
	<div class="mt-1">
	  <div>
		<div class="input-group">
		  <div class="input-group-prepend">
			<span class="input-group-text">共<%=RS01.length%>筆，目前頁數</span>
		  </div>
			<select name="PGA01" id="PGA01" class="txt_data_left" onChange="PG01(this.value,'<%=request.getRequestURI()%>')">
				<%
				for (int i=1;i<TPAGE01+1;i++){
				%>
				<option value="<%=i%>" <%=((i == PNO01)?"selected=\"selected\"":"")%>>第<%=i%>頁</option>
				<%
				}
				%>
			</select>
		  <div class="input-group-append">
			<a class="btn btn-sm btn-outline-info" href="javascript:PG01('1','<%=request.getRequestURI()%>');"><i class="fa fa-fast-backward pt-1" style="font-size:16px"></i></a>
			<% if (SNUM01 != 0){ %><a class="btn btn-sm btn-outline-info" href="javascript:PG01('<%=PNO01-1%>','<%=request.getRequestURI()%>');"><i class="fa fa-caret-left" style="font-size:24px"></i></a><% } else { %><a class="btn btn-sm btn-outline-info" href="javascript:PG01('<%=PNO01%>','<%=request.getRequestURI()%>');"><i class="fa fa-caret-left" style="font-size:24px"></i></a><% } %>
			<% if (ENUM01 != DTNUM01){ %><a class="btn btn-sm btn-outline-info" href="javascript:PG01('<%=PNO01+1%>','<%=request.getRequestURI()%>');"><i class="fa fa-caret-right" style="font-size:24px"></i></a><% } else { %><a class="btn btn-sm btn-outline-info" href="javascript:PG01('<%=PNO01%>','<%=request.getRequestURI()%>');"><i class="fa fa-caret-right" style="font-size:24px"></i></a><% } %>
			<a class="btn btn-sm btn-outline-info" href="javascript:PG01('<%=TPAGE01%>','<%=request.getRequestURI()%>');"><i class="fa fa-fast-forward pt-1" style="font-size:16px"></i></a>  
		  </div>
		</div>
	  </div>
	</div>
	<!--切換頁數-->
</div>
</form>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
</body>
</html>
<script type="text/javascript">
function SF01(A ,B ,C){
	form1.CRA004001.value = C;
	form1.target = B;
	form1.action = A + ".jsp";
	form1.submit();
}
function SF02(A ,B){
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