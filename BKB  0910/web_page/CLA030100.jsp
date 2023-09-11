<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
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
//新增用,預設
String BKA007001 = SQLIJ(request.getParameter("BKA007001"));  //院所編號
String BKA007002 = "";
String BKA007003 = "";
String BKA007004 = "";
String BKA007005 = "";
String BKA007006 = "";
String BKA007007 = "";
String BKA007008 = "";
String BKA007009 = "";
String BKA007010 = "";
String BKA007011 = "";
String BKA007012 = "";
String BKA007013 = "";
String BKA007014 = "";
String BKA007015 = "";
String BKA007901 = USERID;
String BKA007902 = SC01;
String BKA007903 = USERID;
String BKA007904 = SC01;
String BKA007905 = "";
String FTYPE = "A"; //這裡的A是新增的代號
%>
<% 
//修改用
SQL01 = "SELECT * FROM BKA007 WHERE BKA007001 = '"+BKA007001+"'";
RS01 = TAB01.buildMaps(SQL01);
//out.print(SQL01);  //印出訊息
if(RS01.length==1){
	BKA007002 = RS01[0].get("BKA007002").toString();
	BKA007003 = RS01[0].get("BKA007003").toString();
	BKA007004 = RS01[0].get("BKA007004").toString();
	BKA007005 = RS01[0].get("BKA007005").toString();
	BKA007006 = RS01[0].get("BKA007006").toString();
	BKA007007 = RS01[0].get("BKA007007").toString();
	BKA007008 = RS01[0].get("BKA007008").toString();
	BKA007009 = RS01[0].get("BKA007009").toString();
	BKA007010 = RS01[0].get("BKA007010").toString();
	BKA007011 = RS01[0].get("BKA007011").toString();
	BKA007012 = RS01[0].get("BKA007012").toString();
	BKA007013 = RS01[0].get("BKA007013").toString();
	BKA007014 = RS01[0].get("BKA007014").toString();
	BKA007015 = RS01[0].get("BKA007015").toString();
	BKA007901 = RS01[0].get("BKA007901").toString();
	BKA007902 = RS01[0].get("BKA007902").toString();
	BKA007903 = USERID;
	BKA007904 = SC01;
	BKA007905 = RS01[0].get("BKA007905").toString();
	FTYPE = "U"; //這裡的U是修改的代號
}
//out.print(SQL01);  //印出訊息
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
<input type="hidden" name ="FTYPE" value="<%=FTYPE%>" >
<input type="hidden" name="SENDURL" value="CLA030103" >
<input type="hidden" name ="BKA007901" value="<%=BKA007901%>">
<input type="hidden" name ="BKA007902" value="<%=BKA007902%>">
<input type="hidden" name ="BKA007903" value="<%=BKA007903%>">
<input type="hidden" name ="BKA007904" value="<%=BKA007904%>">
<input type="hidden" name ="BKA007905" value="<%=BKA007905%>">
<div class="container my-5">
	<div class="card shadow">
	<div class="card-body">
		<div class="d-flex justify-content-between">
			<h4 class="text-green fw-bold">院所資料</h4>
		</div>
		<hr class="mt-0">
		
		<div class="border p-4 mt-2">
			<div class="row">
				<div class="col-lg">
					<label for="" class="col-form-label"><span class="text-danger me-2">*</span>醫療機構代碼(必須是唯一值！)</label>
					<input type="text" class="form-control validate[required,minSize[10],maxSize[10],custom[onlyNumberSp]]" name="BKA007001" id="BKA007001" maxlength="10" value="<%=BKA007001%>" placeholder="">
				</div>
				<div class="col-lg-4">
					<label for="" class="col-form-label"><span class="text-danger me-2">*</span>行政區</label>
					<select class="form-select validate[required]" name="BKA007002" id="BKA007002">
						<option value="">&ndash;請選擇&ndash;</option>
						<%
						SQL01 = "SELECT DIST_NAME FROM DIST ORDER BY DIST_ID"; //宣告SQL語法
						RS02 = TAB01.buildMaps(SQL01);
						for(int A=0;A<RS02.length;A++){
						%>
						<option value="<%=RS02[A].get("DIST_NAME").toString()%>" <%=BKA007002.equals(RS02[A].get("DIST_NAME").toString())?"selected":""%>><%=RS02[A].get("DIST_NAME").toString()%></option>
						<%
						}
						%>
					</select>
				</div>
				<div class="col-lg">
					<label for="" class="col-form-label"><span class="text-danger me-2">*</span>名稱</label>
					<input class="form-control validate[required]" name="BKA007003" type="text" id="BKA007003" maxlength="50" value="<%=BKA007003%>" placeholder="例如：鴻維診所">
				</div>
			</div>
			<div class="row">
				<div class="col-lg">
					<label for="" class="col-form-label"><span class="text-danger me-2">*</span>電話</label>
					<input class="form-control validate[required,custom[onlyNumberSp]]" name="BKA007010" type="text" id="BKA007010" maxlength="20" value="<%=BKA007010%>" placeholder="例如：079538758">
				</div>
				<div class="col-lg-8">
					<label for="" class="col-form-label"><span class="text-danger me-2">*</span>醫療機構地址</label>
					<input class="form-control validate[required]" name="BKA007004" type="text" id="BKA007004" maxlength="150" value="<%=BKA007004%>" placeholder="例如：文信路333號4樓">
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4">
					<label for="" class="col-form-label"><span class="text-danger me-2">*</span>X座標</label>
					<input class="form-control validate[required,custom[number]]" name="BKA007008" type="text" id="BKA007008" maxlength="15" value="<%=BKA007008%>" placeholder="例如：120.0101">
				</div>
				<div class="col-lg-4">
					<label for="" class="col-form-label"><span class="text-danger me-2">*</span>Y座標</label>
					<input class="form-control validate[required,custom[number]]" name="BKA007009" type="text" id="BKA007009" maxlength="15" value="<%=BKA007009%>" placeholder="例如：22.0101">
				</div>
			</div>
			<div class="row">
				<div class="col-lg">
					<label for="" class="col-form-label">手機1</label>
					<input class="form-control validate[custom[onlyNumberSp],minSize[10]]" name="BKA007005" type="text" id="BKA007005" maxlength="10" value="<%=BKA007005%>" placeholder="例如：0910123456">
				</div>
				<div class="col-lg">
					<label for="" class="col-form-label">手機2</label>
					<input class="form-control validate[custom[onlyNumberSp],minSize[10]]" name="BKA007006" type="text" id="BKA007006" maxlength="10" value="<%=BKA007006%>" placeholder="例如：0910123456">
				</div>
				<div class="col-lg">
					<label for="" class="col-form-label">醫療機構層級</label>
					<select class="form-select" name="BKA007007" id="BKA007007">
						<option value="0" <%=BKA007007.equals("0") ?"selected":""%> >診所</option>
						<option value="1" <%=BKA007007.equals("1") ?"selected":""%> >地區醫院</option>
						<option value="2" <%=BKA007007.equals("2") ?"selected":""%> >區域醫院</option>
						<option value="3" <%=BKA007007.equals("3") ?"selected":""%> >醫學中心</option>
					</select>
				</div>
			</div>
			<div class="row" style="display:none">
				<div class="col-lg">
					<label for="" class="col-form-label">提供兒科服務-週六</label>
					<select class="form-select" name="BKA007011" id="BKA007011">
						<option value="0" <%=BKA007011.equals("0") ?"selected":""%> >否</option>
						<option value="1" <%=BKA007011.equals("1") ?"selected":""%> >是</option>
					</select>
				</div>
				<div class="col-lg">
					<label for="" class="col-form-label">提供兒科服務-週日</label>
					<select class="form-select" name="BKA007012" id="BKA007012">
						<option value="0" <%=BKA007012.equals("0") ?"selected":""%> >否</option>
						<option value="1" <%=BKA007012.equals("1") ?"selected":""%> >是</option>
					</select>
				</div>
			</div>
			<div class="row" style="display:none">
				<div class="col-lg">
					<label for="" class="col-form-label">平日收案量上限</label>
					<input class="form-control validate[required,custom[integer]" name="BKA007013" type="text" id="BKA007013" maxlength="5" value="<%=BKA007013%>" placeholder="例如：10">
				</div>
				<div class="col-lg">
					<label for="" class="col-form-label">週六收案量上限</label>
					<input class="form-control validate[required,custom[integer]" name="BKA007014" type="text" id="BKA007014" maxlength="5" value="<%=BKA007014%>" placeholder="例如：30">
				</div>
				<div class="col-lg">
					<label for="" class="col-form-label">週日收案量上限</label>
					<input class="form-control validate[required,custom[integer]" name="BKA007015" type="text" id="BKA007015" maxlength="5" value="<%=BKA007015%>" placeholder="例如：100">
				</div>
			</div>
			<div class="row pt-3">
				<div class="col-lg-12" align="center">
					<a href="javascript:SF01()" type="button" class="btn btn-green text-light">儲存</a>
				</div>
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


<script type="text/javascript">
function SF01(){
	form1.action = "CLA030101.jsp";
	$("#form1").submit();
}
function SF02(A, B, C){
	form1.BKA007001.value=C;
	form1.target = B;
	form1.action = A + ".jsp";
	form1.submit();
}

</script>
</body>
</html>
<%
DB01.close();
%>