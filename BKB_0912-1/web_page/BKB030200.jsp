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
//取得日期
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
%>
<%
String BKA002001 = SQLIJ(request.getParameter("BKA002001"));
String BKA007001 = SQLIJ(request.getParameter("BKA007001"));
String BKA002009 = SQLIJ(request.getParameter("BKA002009"));
String BKA002010 = SQLIJ(request.getParameter("BKA002010"));
String BKA003010 = SQLIJ(request.getParameter("BKA003010"));
String BKA003011C = SQLIJ(request.getParameter("BKA003011C"));
String BKA003011 = SQLIJ(request.getParameter("BKA003011"));

String TOrder = SQLIJ(request.getParameter("TOrder"));  //排序用
if(TOrder.equals(""))TOrder=" BKA002002 DESC,BKA003004 DESC";

if(!BKA002001.equals("")){
  SQL01 += " AND BKA002001 = '" + BKA002001 + "'";
}
if(!BKA002009.equals("")){
  BKA002009 = BKA002009.replace("/","");
  SQL01 += " AND BKA002009 >= '" + BKA002009 + "' ";
}
if(!BKA002010.equals("")){
  BKA002010 = BKA002010.replace("/","");
  SQL01 += " AND BKA002010 <= '" + BKA002010 + "' ";
}
if(!BKA003010.equals("")){
  SQL01 += " AND BKA003010 = '" + BKA003010 + "'";
}
if(!BKA003011.equals("")){
  if(!BKA003011C.equals("")){
	if(BKA003011C.equals("1"))BKA003011C = "<";
	if(BKA003011C.equals("2"))BKA003011C = ">";
	SQL01 += " AND BKA003011 "+BKA003011C+" '" + BKA003011 + "'";  
  }else{
	SQL01 += " AND BKA003011 = '" + BKA003011 + "'";
  }
}
if(!USERKIND.equals("府關懷中心")){
  BKA007001 = URA001011C;
  SQL01 += " AND BKA003003 = '"+URA001011C+"'";  //不是府關懷中心，鎖診所
}else{
  if(!BKA007001.equals("")){
	SQL01 += " AND BKA003003 = '"+BKA007001+"' ";
  }
}
if(SQL01.equals("")){
    SQL01 = "SELECT * FROM BKA002inBKA003 WHERE 1<>1 ORDER BY "+TOrder;  //無查詢條件全列
}else{
    SQL01 = "SELECT * FROM BKA002inBKA003 WHERE BKA002001 <> '' " + SQL01 + " ORDER BY "+TOrder;
}
//out.print(SQL01);  //印出訊息
//if(true)return;   //終止程式
RS01 = TAB01.buildMaps(SQL01);
%>
<%
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
<%
String TT[][]  = new String[RS01.length+1][7];
String FNAME = "場次量能清冊";
TT[0][0]= "期別";
TT[0][1]= "場次名稱";
TT[0][2]= "醫療院所";
TT[0][3]= "接種日期";
TT[0][4]= "接種時段";
TT[0][5]= "疫苗類別(組別)";
TT[0][6]= "數量";
for(int A=SNUM01; A<ENUM01; A++){
	TT[A+1][0]= RS01[A].get("BKA002002").toString();
	TT[A+1][1]= RS01[A].get("BKA002003").toString();
	TT[A+1][2]= TAB01.getCol("BKA007", "BKA007003", "BKA007001", "'" + RS01[A].get("BKA003003").toString() + "'");
	TT[A+1][3]= RS01[A].get("BKA003004").toString().length() >= 8 ? EYC2(RS01[A].get("BKA003004").toString()):RS01[A].get("BKA003004").toString();
	TT[A+1][4]= RS01[A].get("BKA003005").toString()+":"+RS01[A].get("BKA003006").toString()+"-"+RS01[A].get("BKA003007").toString()+":"+RS01[A].get("BKA003008").toString();
	TT[A+1][5]= RS01[A].get("BKA003010").toString();
	TT[A+1][6]= RS01[A].get("BKA003011").toString();
}
session.setAttribute("TT_A", TT);
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
<input type="hidden" name="FNAME" id="FNAME" value="<%=FNAME%>">
<input type="hidden" name="T1" id="T1" value="<%=TT.length%>">
<input type="hidden" name="T2" id="T2" value="<%=TT[0].length%>">
<input type="hidden" name="T3" id="T3" value="TT_A">
<input name="PNO01" type="hidden" id="PNO01" value="" />
	<div class="container px-4">
		<h3 class="mt-4">場次量能查詢</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item" aria-current="page">場次管理</li>
			<li class="breadcrumb-item active" aria-current="page">場次量能查詢</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						場次量能查詢
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">場次名稱</label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇</option>
								  <%
								  SQL01="SELECT BKA002001,BKA002002,BKA002003 FROM BKA002 WHERE BKA002004 = '1' GROUP BY BKA002001,BKA002002,BKA002003 ORDER BY BKA002002"; 
								  RS02 = TAB01.buildMaps(SQL01);
								  for(int A=0;A<RS02.length;A++){
								  %>
								  <option value="<%=RS02[A].get("BKA002001").toString()%>" <%=BKA002001.equals(RS02[A].get("BKA002001").toString())?"selected":""%>><%=RS02[A].get("BKA002003").toString()%></option>
								  <%
								  }
								  %>
								</select>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">醫療院所</label>
								<select class="form-select" aria-label="Default select" id="BKA007001" name="BKA007001" <%=!USERKIND.equals("府關懷中心")?"disabled":""%>>
								  <option value="">請選擇</option>
								  <%
								  SQL01="SELECT BKA007001,BKA007003 FROM BKA007 GROUP BY BKA007001,BKA007003 ORDER BY BKA007001"; 
								  RS02 = TAB01.buildMaps(SQL01);
								  for(int A=0;A<RS02.length;A++){
								  %>
								  <option value="<%=RS02[A].get("BKA007001").toString()%>" <%=BKA007001.equals(RS02[A].get("BKA007001").toString())?"selected":""%>><%=RS02[A].get("BKA007003").toString()%></option>
								  <%
								  }
								  %>
								</select>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">接種日期</label>
								<div class="input-group">
									<input type="text" class="form-control datepicker1" id="BKA002009" name="BKA002009" value="<%=BKA002009%>" placeholder="例如：1111114">
									<span class="input-group-text" id="input-group-left-example">-</span>
									<input type="text" class="form-control datepicker" id="BKA002010" name="BKA002010" value="<%=BKA002010%>" placeholder="例如：1111120">
								</div>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">疫苗類別</label>
								<select class="form-select" aria-label="Default select" id="BKA003010" name="BKA003010">
								  <option value="">請選擇</option>
								  <%
								  SQL01 = "SELECT BKA001003 FROM BKA001 GROUP BY BKA001003"; //宣告SQL語法
								  RS02 = TAB01.buildMaps(SQL01);
								  for(int A=0;A<RS02.length;A++){
								  %>
								  <option value="<%=RS02[A].get("BKA001003").toString()%>" <%=BKA003010.equals(RS02[A].get("BKA001003").toString())?"selected":""%>><%=RS02[A].get("BKA001003").toString()%></option>
								  <%}%>
								</select>
							</div>
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">疫苗數量</label>
								<div class="input-group">
									<select class="form-select" aria-label="Default select" id="BKA003011C" name="BKA003011C">
									  <option value="">請選擇</option>
									  <option value="1" <%=BKA003011C.equals("<")?"selected":""%> ><</option>
									  <option value="2" <%=BKA003011C.equals(">")?"selected":""%> >></option>
									  <option value="=" <%=BKA003011C.equals("=")?"selected":""%> >=</option>
									</select>
									<input type="text" class="form-control" id="BKA003011" name="BKA003011" value="<%=BKA003011%>" placeholder="例如：200">
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB030200','_self')"><i class="fas fa-search me-2"></i>查詢</button>
								</div>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-xl-12 mt-3" align="right">
								<button type="button" class="btn btn-light border-secondary" onClick="outQfile()"><i class="far fa-arrow-alt-circle-down me-2"></i>匯出表單</button>
							</div>
						</div>
						
						<div class="table-responsive mt-1">
							<table class="table table-striped table-bordered">
							  <thead>
								<tr align="center" class="bg-lightgreen">
								  <th scope="col">期別</th>
								  <th scope="col">場次名稱</th>
								  <th scope="col">醫療院所</th>
								  <th scope="col">接種日期</th>
								  <th scope="col">接種時段</th>
								  <th scope="col">疫苗類別(組別)</th>
								  <th scope="col">數量</th>
								</tr>
							  </thead>
							  <tbody align="center">
							    <%for(int A=1;A<TT.length;A++){%>
								<tr>
								  <th scope="row"><%=TT[A][0]%></th>
								  <td><%=TT[A][1]%></td>
								  <td><%=TT[A][2]%></td>
								  <td><%=TT[A][3]%></td>
								  <td><%=TT[A][4]%></td>
								  <td><%=TT[A][5]%></td>
								  <td><%=TT[A][6]%></td>
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

function outQfile(){
    form1.target = "_new";
    form1.action = "../web_script/outExcel.jsp";
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
