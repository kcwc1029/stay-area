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
Map[] RS03 = null;
String SQL03 = "";
%>
<%
String BKA002001 = SQLIJ(request.getParameter("BKA002001"));
String BKA002002 = SQLIJ(request.getParameter("BKA002002"));
String BKA003001 = SQLIJ(request.getParameter("BKA003001"));
String BKA003002 = BKA002001;  //場次UUID
String BKA003003 = URA001011C;  //操作人的十碼章
String BKA003004 = "";
String BKA003005 = "";
String BKA003006 = "";
String BKA003007 = "";
String BKA003008 = "";
String BKA003009 = "";
String BKA003010 = "";
String BKA003011 = "";
String BKA003012 = "";
String BKA003901 = USERID;
String BKA003902 = SC01;
String BKA003903 = USERID;
String BKA003904 = SC01;
String BKA003905 = "";
String FTYPE = "A"; //這裡的A是新增的代號
SQL01 = "SELECT * FROM BKA003 WHERE BKA003001 = '"+BKA003001+"'";
RS01 = TAB01.buildMaps(SQL01);
//out.print(SQL01);  //印出訊息
if(RS01.length==1){
	BKA003002 = RS01[0].get("BKA003002").toString();
	BKA003003 = RS01[0].get("BKA003003").toString();
	BKA003004 = RS01[0].get("BKA003004").toString();
	if(!BKA003004.equals("") && BKA003004.length() >= 8){
		BKA003004 = EYC2(BKA003004);
	}
	BKA003005 = RS01[0].get("BKA003005").toString();
	BKA003006 = RS01[0].get("BKA003006").toString();
	BKA003007 = RS01[0].get("BKA003007").toString();
	BKA003008 = RS01[0].get("BKA003008").toString();
	BKA003009 = RS01[0].get("BKA003009").toString();
	BKA003010 = RS01[0].get("BKA003010").toString();
	BKA003011 = RS01[0].get("BKA003011").toString();
	BKA003012 = RS01[0].get("BKA003012").toString();
	BKA003901 = RS01[0].get("BKA003901").toString();
	BKA003902 = RS01[0].get("BKA003902").toString();
	BKA003903 = USERID;
	BKA003904 = SC01;
	BKA003905 = RS01[0].get("BKA003905").toString();
	FTYPE = "U"; //這裡的U是修改的代號
}

//院所行政區
String BKA007002 = "";
BKA007002 = TAB01.getCol("BKA007", "BKA007002", "BKA007001", "'"+URA001011C+"'");
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
<input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" />
<input type="hidden" name="SENDURL" value="BKB020100" >
<input name="BKA002001" type="hidden" id="BKA002001" value="<%=BKA002001%>" />
<input name="BKA002002" type="hidden" id="BKA002002" value="<%=BKA002002%>" />
<input name="BKA003001" type="hidden" id="BKA003001" value="<%=BKA003001%>" />
<input name="BKA003002" type="hidden" id="BKA003002" value="<%=BKA003002%>" />
<input name="BKA003901" type="hidden" id="BKA003901" value="<%=BKA003901%>" />
<input name="BKA003902" type="hidden" id="BKA003902" value="<%=BKA003902%>" />
<input name="BKA003903" type="hidden" id="BKA003903" value="<%=BKA003903%>" />
<input name="BKA003904" type="hidden" id="BKA003904" value="<%=BKA003904%>" />
<input name="BKA003905" type="hidden" id="BKA003905" value="<%=BKA003905%>" />
	<div class="container px-4">
		<div class="d-flex justify-content-between">
		  <div>
			<h3 class="mt-4">單筆維護接種數量</h3>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
				<li class="breadcrumb-item" aria-current="page">選擇匯入場次</li>
				<li class="breadcrumb-item active" aria-current="page">單筆維護接種數量</li>
			</ol>
		  </div>
		  <div class="mt-5">
			<button type="button" class="btn btn-sm btn-light border-secondary" onClick="SF02('BKB020100','_self')"><i class="fas fa-reply me-2"></i>回上頁</button>
		  </div>
		</div>
		
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						場次：<%=TAB01.getCol("BKA002", "BKA002003", "BKA002001", "'"+BKA002001+"'")%>
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">行政區<span class="text-danger ms-1">*</span></label>
								<select class="form-select validate[required]" aria-label="Default select" id="BKA007002" name="BKA007002">
								  <%
								  SQL01 = "SELECT DIST_NAME FROM DIST ORDER BY DIST_ID"; //宣告SQL語法
								  RS02 = TAB01.buildMaps(SQL01);
								  for(int A=0;A<RS02.length;A++){
								  %>
								  <option value="<%=RS02[A].get("DIST_NAME").toString()%>" <%=BKA007002.equals(RS02[A].get("DIST_NAME").toString())?"selected":""%>><%=RS02[A].get("DIST_NAME").toString()%></option>
								  <%}%>
								</select>
							</div>
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">醫療院所<span class="text-danger ms-1">*</span></label>
								<select class="form-select validate[required]" aria-label="Default select" id="BKA003003" name="BKA003003">
								  <%
								  SQL01 = "SELECT * FROM BKA007 ORDER BY BKA007001"; //宣告SQL語法
								  RS02 = TAB01.buildMaps(SQL01);
								  for(int A=0;A<RS02.length;A++){
								  %>
								  <option value="<%=RS02[A].get("BKA007001").toString()%>" <%=BKA003003.equals(RS02[A].get("BKA007001").toString())?"selected":""%>><%=RS02[A].get("BKA007003").toString()%></option>
								  <%}%>
								</select>
							</div>
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">接種日期<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required] datepicker" id="BKA003004" name="BKA003004" value="<%=BKA003004%>" placeholder="例如：2022/11/11">
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">接種時段<span class="text-danger ms-1">*</span></label>
								<div class="input-group">
									<select class="form-select validate[required,custom[onlyNumberSp]]" aria-label="Default select" id="BKA003005" name="BKA003005">
									  <option value="08" <%=BKA003005.equals("08")?"selected":""%>>08</option>
									  <option value="09" <%=BKA003005.equals("09")?"selected":""%>>09</option>
									  <option value="10" <%=BKA003005.equals("10")?"selected":""%>>10</option>
									  <option value="11" <%=BKA003005.equals("11")?"selected":""%>>11</option>
									  <option value="12" <%=BKA003005.equals("12")?"selected":""%>>12</option>
									  <option value="13" <%=BKA003005.equals("13")?"selected":""%>>13</option>
									  <option value="14" <%=BKA003005.equals("14")?"selected":""%>>14</option>
									  <option value="15" <%=BKA003005.equals("15")?"selected":""%>>15</option>
									  <option value="16" <%=BKA003005.equals("16")?"selected":""%>>16</option>
									  <option value="17" <%=BKA003005.equals("17")?"selected":""%>>17</option>
									  <option value="18" <%=BKA003005.equals("18")?"selected":""%>>18</option>
									  <option value="19" <%=BKA003005.equals("19")?"selected":""%>>19</option>
									  <option value="20" <%=BKA003005.equals("20")?"selected":""%>>20</option>
									  <option value="21" <%=BKA003005.equals("21")?"selected":""%>>21</option>
									  <option value="22" <%=BKA003005.equals("22")?"selected":""%>>22</option>
									</select>
									<span class="input-group-text" id="input-group-left-example">：</span>
									<select class="form-select validate[required,custom[onlyNumberSp]]" aria-label="Default select" id="BKA003006" name="BKA003006">
									  <option value="00" <%=BKA003006.equals("00")?"selected":""%>>00</option>
									  <option value="10" <%=BKA003006.equals("10")?"selected":""%>>10</option>
									  <option value="20" <%=BKA003006.equals("20")?"selected":""%>>20</option>
									  <option value="30" <%=BKA003006.equals("30")?"selected":""%>>30</option>
									  <option value="40" <%=BKA003006.equals("40")?"selected":""%>>40</option>
									  <option value="50" <%=BKA003006.equals("50")?"selected":""%>>50</option>
									</select>
									<span class="input-group-text" id="input-group-left-example">-</span>
									<select class="form-select validate[required,custom[onlyNumberSp]]" aria-label="Default select" id="BKA003007" name="BKA003007">
									  <option value="08" <%=BKA003007.equals("08")?"selected":""%>>08</option>
									  <option value="09" <%=BKA003007.equals("09")?"selected":""%>>09</option>
									  <option value="10" <%=BKA003007.equals("10")?"selected":""%>>10</option>
									  <option value="11" <%=BKA003007.equals("11")?"selected":""%>>11</option>
									  <option value="12" <%=BKA003007.equals("12")?"selected":""%>>12</option>
									  <option value="13" <%=BKA003007.equals("13")?"selected":""%>>13</option>
									  <option value="14" <%=BKA003007.equals("14")?"selected":""%>>14</option>
									  <option value="15" <%=BKA003007.equals("15")?"selected":""%>>15</option>
									  <option value="16" <%=BKA003007.equals("16")?"selected":""%>>16</option>
									  <option value="17" <%=BKA003007.equals("17")?"selected":""%>>17</option>
									  <option value="18" <%=BKA003007.equals("18")?"selected":""%>>18</option>
									  <option value="19" <%=BKA003007.equals("19")?"selected":""%>>19</option>
									  <option value="20" <%=BKA003007.equals("20")?"selected":""%>>20</option>
									  <option value="21" <%=BKA003007.equals("21")?"selected":""%>>21</option>
									  <option value="22" <%=BKA003007.equals("22")?"selected":""%>>22</option>
									</select>
									<span class="input-group-text" id="input-group-left-example">：</span>
									<select class="form-select validate[required,custom[onlyNumberSp]]" aria-label="Default select" id="BKA003008" name="BKA003008">
									  <option value="00" <%=BKA003008.equals("00")?"selected":""%>>00</option>
									  <option value="10" <%=BKA003008.equals("10")?"selected":""%>>10</option>
									  <option value="20" <%=BKA003008.equals("20")?"selected":""%>>20</option>
									  <option value="30" <%=BKA003008.equals("30")?"selected":""%>>30</option>
									  <option value="40" <%=BKA003008.equals("40")?"selected":""%>>40</option>
									  <option value="50" <%=BKA003008.equals("50")?"selected":""%>>50</option>
									</select>
								</div>
							</div>
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">接種疫苗類別<span class="text-danger ms-1">*</span></label>
								<select class="form-select validate[required]" aria-label="Default select" id="BKA003009" name="BKA003009">
								  <option value="COVID-19" <%=BKA003009.equals("COVID-19")?"selected":""%>>COVID-19</option>
								  <option value="流感" <%=BKA003009.equals("流感")?"selected":""%>>流感</option>
								</select>
							</div>
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">疫苗種類及年齡組別<span class="text-danger ms-1">*</span></label>
								<select class="form-select validate[required]" aria-label="Default select" id="BKA003010" name="BKA003010">
								  <%
								  SQL01 = "SELECT BKA001003 FROM BKA001 GROUP BY BKA001003"; //宣告SQL語法
								  RS02 = TAB01.buildMaps(SQL01);
								  for(int A=0;A<RS02.length;A++){
								  %>
								  <option value="<%=RS02[A].get("BKA001003").toString()%>" <%=BKA003010.equals(RS02[A].get("BKA001003").toString())?"selected":""%>><%=RS02[A].get("BKA001003").toString()%></option>
								  <%}%>
								</select>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">數量<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required,custom[onlyNumberSp]]" id="BKA003011" name="BKA003011" value="<%=BKA003011%>" placeholder="例如：100">
							</div>
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-deepgreen fw-bold">是否開放預約<span class="text-danger ms-1">*</span></label>
								<select class="form-select validate[required]" aria-label="Default select" id="BKA003012" name="BKA003012">
								  <option value="0" <%=BKA003012.equals("0")?"selected":""%>>否</option>
								  <option value="1" <%=BKA003012.equals("1")?"selected":""%>>是</option>
								</select>
							</div>
						</div>
						<div class="row mt-4">
							<div class="col-xl-12" align="center">
								<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB020103','_self')"><i class="far fa-check-circle me-2"></i>儲存</button>
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
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
	
<script type="text/javascript">
function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  $("#form1").submit();
  //form1.submit();
}

function SF02(A, B){
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
