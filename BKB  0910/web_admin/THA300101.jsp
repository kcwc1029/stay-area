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
//新增用,預設
String CRA004001 = SQLIJ(request.getParameter("CRA004001"));  //帳號
String CRA004002 = "";
String CRA004003 = "";
String CRA004004 = "";
String CRA004901 = USERID;
String CRA004902 = SC01;
String CRA004903 = USERID;
String CRA004904 = SC01;
String CRA004905 = "";
String FTYPE = "A"; //這裡的A是新增的代號
%>
<% 
//修改用
SQL01 = "SELECT * FROM CRA004 WHERE CRA004001 = '" + CRA004001 + "'";
RS01 = TAB01.buildMaps(SQL01);  //如果是新增，RS01長度0
if(RS01.length==1){
	CRA004002 = RS01[0].get("CRA004002").toString();
	CRA004003 = RS01[0].get("CRA004003").toString();
	CRA004004 = RS01[0].get("CRA004004").toString();
	CRA004901 = RS01[0].get("CRA004901").toString();
	CRA004902 = RS01[0].get("CRA004902").toString();
	CRA004903 = USERID;
	CRA004904 = SC01;
	CRA004905 = RS01[0].get("CRA004905").toString();
	FTYPE = "U"; //這裡的U是修改的代號
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
<input name="CRA004001" type="hidden" id="CRA004001" value="<%=CRA004001%>">
<input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>">
<input type="hidden" name ="CRA004901" value="<%=CRA004901%>" >
<input type="hidden" name ="CRA004902" value="<%=CRA004902%>" >
<input type="hidden" name ="CRA004903" value="<%=CRA004903%>" >
<input type="hidden" name ="CRA004904" value="<%=CRA004904%>" >
<input type="hidden" name ="CRA004905" value="<%=CRA004905%>" >
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
		  <div class="text-danger font-weight-bold" align="right">（★為必填欄位）</div>
			<div class="border p-3">
				<div class="alert alert-success" role="alert"><strong>陳核設定資料變更</strong></div>
				<div class="row">
					<div class="col-sm">
						<label for="CRA004002" class="col-form-label"><span class="text-danger font-weight-bold">★</span>第一級審核長官</label>
						<select name="CRA004002" class="custom-select validate[required]" id="CRA004002">
							<option value="">-請選擇-</option>
							<%
							SQL02 = "SELECT URA001001,URA001002 FROM URA001 WHERE URA001003 = '第一層決行' AND URA001016 = '1' ORDER BY URA001001";
							RS02 = TAB01.buildMaps(SQL02);
							for(int A=0; A<RS02.length; A++){
							%>
							<option value="<%=RS02[A].get("URA001002").toString()%>" <%=CRA004002.equals(RS02[A].get("URA001002").toString())?"selected":""%>><%=RS02[A].get("URA001002").toString()%></option>
							<%}%>
						</select>
					</div>
					<div class="col-sm">
						<label for="CRA004003" class="col-form-label"><span class="text-danger font-weight-bold">★</span>第二級審核長官</label>
						<select name="CRA004003" class="custom-select validate[required]" id="CRA004003">
							<option value="">-請選擇-</option>
							<%
							SQL02 = "SELECT URA001001,URA001002 FROM URA001 WHERE URA001003 = '第二層決行' AND URA001016 = '1' ORDER BY URA001001";
							RS02 = TAB01.buildMaps(SQL02);
							for(int A=0; A<RS02.length; A++){
							%>
							<option value="<%=RS02[A].get("URA001002").toString()%>" <%=CRA004003.equals(RS02[A].get("URA001002").toString())?"selected":""%>><%=RS02[A].get("URA001002").toString()%></option>
							<%}%>  
						</select>
					</div>
					<div class="col-sm">
						<label for="CRA004004" class="col-form-label"><span class="text-danger font-weight-bold">★</span>第二級審核長官</label>
						<select name="CRA004004" class="custom-select validate[required]" id="CRA004004">
							<option value="">-請選擇-</option>
							<%
							SQL02 = "SELECT URA001001,URA001002 FROM URA001 WHERE URA001003 = '第三層決行' AND URA001016 = '1' ORDER BY URA001001";
							RS02 = TAB01.buildMaps(SQL02);
							for(int A=0; A<RS02.length; A++){
							%>
							<option value="<%=RS02[A].get("URA001002").toString()%>" <%=CRA004004.equals(RS02[A].get("URA001002").toString())?"selected":""%>><%=RS02[A].get("URA001002").toString()%></option>
							<%}%>  
						</select>
					</div>
				</div>
				<div class="row p-3" align="center">
					<div class="col-sm">
						<button type="button" class="btn btn-info" onClick="SF01('THA300102','_self')">儲存</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
</body>
</html>
<script type="text/javascript">
function SF01(A ,B){
	form1.target = B;
	form1.action = A + ".jsp";
	form1.submit();
}
</script>