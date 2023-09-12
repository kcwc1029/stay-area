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
String CRA006001 = SQLIJ(request.getParameter("CRA006001"));  //帳號
String CRA006002 = "";
String CRA006003 = "";
String CRA006901 = USERID;
String CRA006902 = SC01;
String CRA006903 = USERID;
String CRA006904 = SC01;
String CRA006905 = "";
String FTYPE = "A"; //這裡的A是新增的代號
%>
<% 
//修改用
SQL01 = "SELECT * FROM CRA006 WHERE CRA006001 = '" + CRA006001 + "'";
RS01 = TAB01.buildMaps(SQL01);  //如果是新增，RS01長度0
if(RS01.length==1){
	CRA006002 = RS01[0].get("CRA006002").toString();
	CRA006003 = RS01[0].get("CRA006003").toString();
	CRA006901 = RS01[0].get("CRA006901").toString();
	CRA006902 = RS01[0].get("CRA006902").toString();
	CRA006903 = USERID;
	CRA006904 = SC01;
	CRA006905 = RS01[0].get("CRA006905").toString();
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
<input name="CRA006001" type="hidden" id="CRA006001" value="<%=CRA006001%>">
<input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>">
<input type="hidden" name ="CRA006901" value="<%=CRA006901%>" >
<input type="hidden" name ="CRA006902" value="<%=CRA006902%>" >
<input type="hidden" name ="CRA006903" value="<%=CRA006903%>" >
<input type="hidden" name ="CRA006904" value="<%=CRA006904%>" >
<input type="hidden" name ="CRA006905" value="<%=CRA006905%>" >
<div class="container">
	</br></br>
	<div class="card shadow">
		<div class="card-body pb-0">
			<div class="d-flex justify-content-between">
				<div><h4 class="text-red2 font-weight-bold">代理人管理</h4></div>
			</div>
			<ol class="breadcrumb">
				<li class="breadcrumb-item">首頁</li>
				<li class="breadcrumb-item">資料維護</li>
				<li class="breadcrumb-item">代理人管理</li>
			</ol>	
		</div>
		<div class="container pb-3">
		  <div class="text-danger font-weight-bold" align="right">（★為必填欄位）</div>
			<div class="border p-3">
				<div class="alert alert-success" role="alert"><strong>管理人設定資料變更</strong></div>
				<div class="row">
					<div class="col-sm">
						<label for="CRA006002" class="col-form-label"><span class="text-danger font-weight-bold">★</span>設定管理人</label>
						<select name="CRA006002" class="custom-select" id="CRA006002">
							<option value="">-請選擇-</option>
							<%
							SQL02 = "SELECT URA001001,URA001002 FROM URA001 WHERE URA001003 = '承辦人' AND URA001001 <> '"+CRA006001+"' AND URA001016 = '1' ORDER BY URA001001";
							RS02 = TAB01.buildMaps(SQL02);
							for(int A=0; A<RS02.length; A++){
							%>
							<option value="<%=RS02[A].get("URA001001").toString()%>" <%=CRA006002.equals(RS02[A].get("URA001001").toString())?"selected":""%>><%=RS02[A].get("URA001002").toString()%></option>
							<%}%>
						</select>
					</div>				
				</div>
				<div class="row p-3" align="center">
					<div class="col-sm">
						<button type="button" class="btn btn-info" onClick="SF01('THA300202','_self')">儲存</button>
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