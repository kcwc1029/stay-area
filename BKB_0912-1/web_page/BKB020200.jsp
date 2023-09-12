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
String BKA005010S = SQLIJ(request.getParameter("BKA005010S"));
String BKA005010E = SQLIJ(request.getParameter("BKA005010E"));
String BKA005009 = SQLIJ(request.getParameter("BKA005009"));

String TOrder = SQLIJ(request.getParameter("TOrder"));  //排序用
if(TOrder.equals(""))TOrder=" BKA005010,BKA005008";

if(!BKA002001.equals("")){
  SQL01 += " AND BKA003002 IN (SELECT BKA002001 FROM BKA002 WHERE BKA002001 = '"+BKA002001+"') ";
}
if(!BKA005010S.equals("")){
  BKA005010S = BKA005010S.replace("/","");
  SQL01 += " AND BKA005010 >= '" + BKA005010S + "' ";
}
if(!BKA005010E.equals("")){
  BKA005010E = BKA005010E.replace("/","");
  SQL01 += " AND BKA005010 <= '" + BKA005010E + "' ";
}
if(!BKA005009.equals("")){
  SQL01 += " AND BKA005009 = '"+BKA005009+"' ";
}
if(!USERKIND.equals("府關懷中心")){
  BKA007001 = URA001011C;
  SQL01 += " AND BKA005008 = '"+URA001011C+"'";  //不是府關懷中心，鎖診所
}else{
	if(!BKA007001.equals("")){
	  SQL01 += " AND BKA005008 = '"+BKA007001+"' ";
	}
}
if(SQL01.equals("")){
    SQL01 = "SELECT * FROM BKA005 INNER JOIN BKA002inBKA003 ON BKA005002 = BKA003001 WHERE 1<>1 ORDER BY "+TOrder;  //無查詢條件全列
}else{
    SQL01 = "SELECT * FROM BKA005 INNER JOIN BKA002inBKA003 ON BKA005002 = BKA003001 WHERE BKA005001 <> '' AND BKA005905 = '1' " + SQL01 + " ORDER BY "+TOrder;
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
String TT[][]  = new String[RS01.length+1][13];
String FNAME = "疫苗預約清冊";
TT[0][0]= "期別";
TT[0][1]= "場次名稱";
TT[0][2]= "預約院所";
TT[0][3]= "預約接種日期";
TT[0][4]= "預約接種時段";
TT[0][5]= "預約疫苗類別(組別)";
TT[0][6]= "姓名";
TT[0][7]= "身分證號/護照號碼";
TT[0][8]= "生日";
TT[0][9]= "電話";
TT[0][10]= "前一劑次";
TT[0][11]= "前一次疫苗類型";
TT[0][12]= "前一劑施打時間";
for(int A=SNUM01; A<ENUM01; A++){
	TT[A+1][0]= RS01[A].get("BKA002002").toString();
	TT[A+1][1]= RS01[A].get("BKA002003").toString();
	TT[A+1][2]= TAB01.getCol("BKA007", "BKA007003", "BKA007001", "'" + RS01[A].get("BKA005008").toString() + "'");
	TT[A+1][3]= RS01[A].get("BKA005010").toString().length() >= 8 ? EYC2(RS01[A].get("BKA005010").toString()):RS01[A].get("BKA005010").toString();
	TT[A+1][4]= RS01[A].get("BKA005011").toString();
	TT[A+1][5]= RS01[A].get("BKA005009").toString();
	TT[A+1][6]= RS01[A].get("BKA005003").toString();
	TT[A+1][7]= RS01[A].get("BKA005004").toString();
	TT[A+1][8]= RS01[A].get("BKA005005").toString().length() >= 8 ? EYC2(RS01[A].get("BKA005005").toString()):RS01[A].get("BKA005005").toString();
	TT[A+1][9]= RS01[A].get("BKA005006").toString();
	TT[A+1][10]= RS01[A].get("BKA005012").toString();
	TT[A+1][11]= RS01[A].get("BKA005013").toString();
	TT[A+1][12]= RS01[A].get("BKA005014").toString().length() >= 8 ? EYC2(RS01[A].get("BKA005014").toString()):RS01[A].get("BKA005014").toString();
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
	<div class="container-fuild px-4">
		<h3 class="mt-4">預約查詢</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item" aria-current="page">量能管理</li>
			<li class="breadcrumb-item active" aria-current="page">預約查詢</li>
		</ol>
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						預約查詢
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
									<input type="text" class="form-control datepicker1" id="BKA005010S" name="BKA005010S" value="<%=BKA005010S%>" placeholder="例如：1111114">
									<span class="input-group-text" id="input-group-left-example">-</span>
									<input type="text" class="form-control datepicker" id="BKA005010E" name="BKA005010E" value="<%=BKA005010E%>" placeholder="例如：1111120">
								</div>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">預約疫苗類別</label>
								<div class="input-group">
									<select class="form-select" aria-label="Default select" id="BKA005009" name="BKA005009">
									  <option value="">請選擇</option>
									  <%
									  SQL01 = "SELECT BKA001003 FROM BKA001 GROUP BY BKA001003"; //宣告SQL語法
									  RS02 = TAB01.buildMaps(SQL01);
									  for(int A=0;A<RS02.length;A++){
									  %>
									  <option value="<%=RS02[A].get("BKA001003").toString()%>" <%=BKA005009.equals(RS02[A].get("BKA001003").toString())?"selected":""%>><%=RS02[A].get("BKA001003").toString()%></option>
									  <%}%>
									</select>
									<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB020200','_self')"><i class="fas fa-search me-2"></i>查詢</button>
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
								  <th scope="col">預約院所</th>
								  <th scope="col">預約接種日期</th>
								  <th scope="col">預約接種時段</th>
								  <th scope="col">預約疫苗類別(組別)</th>
								  <th scope="col">姓名</th>
								  <th scope="col">身分證號/護照號碼</th>
								  <th scope="col">生日</th>
								  <th scope="col">電話</th>
								  <th scope="col">前一劑次</th>
								  <th scope="col">前一次疫苗類型</th>
								  <th scope="col">前一劑施打時間</th>
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
								  <td><%=TT[A][7]%></td>
								  <td><%=TT[A][8]%></td>
								  <td><%=TT[A][9]%></td>
								  <td><%=TT[A][10]%></td>
								  <td><%=TT[A][11]%></td>
								  <td><%=TT[A][12]%></td>
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
