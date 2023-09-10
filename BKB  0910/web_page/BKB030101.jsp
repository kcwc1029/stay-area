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
String BKA002002 = "";
String BKA002003 = "";
String BKA002004 = "";
String BKA002005 = "";
String BKA002005Y = "";  //日期
String BKA002005H = "";  //時間
String BKA002006 = "";
String BKA002006Y = "";  //日期
String BKA002006H = "";  //時間
String BKA002007 = "";
String BKA002007Y = "";  //日期
String BKA002007H = "";  //時間
String BKA002008 = "";
String BKA002009 = "";
String BKA002010 = "";
String BKA002901 = USERID;
String BKA002902 = SC01;
String BKA002903 = USERID;
String BKA002904 = SC01;
String BKA002905 = "";
String FTYPE = "A"; //這裡的A是新增的代號
SQL01 = "SELECT * FROM BKA002 WHERE BKA002001 = '"+BKA002001+"'";

RS01 = TAB01.buildMaps(SQL01);
//out.print(SQL01);  //印出訊息



if(RS01.length==1){
	BKA002002 = RS01[0].get("BKA002002").toString();
	BKA002003 = RS01[0].get("BKA002003").toString();
	BKA002004 = RS01[0].get("BKA002004").toString();
	BKA002005 = RS01[0].get("BKA002005").toString();
	if(!BKA002005.equals("") && BKA002005.length() >= 12){
		BKA002005Y = EYC2(BKA002005.substring(0,8));
		BKA002005H = BKA002005.substring(8);
	}
	BKA002006 = RS01[0].get("BKA002006").toString();
	if(!BKA002006.equals("") && BKA002006.length() >= 12){
		BKA002006Y = EYC2(BKA002006.substring(0,8));
		BKA002006H = BKA002006.substring(8);
	}
	BKA002007 = RS01[0].get("BKA002007").toString();
	if(!BKA002007.equals("") && BKA002007.length() >= 12){
		BKA002007Y = EYC2(BKA002007.substring(0,8));
		BKA002007H = BKA002007.substring(8);
	}
	BKA002008 = RS01[0].get("BKA002008").toString();  //空白
	BKA002009 = EYC2(RS01[0].get("BKA002009").toString());
	BKA002010 = EYC2(RS01[0].get("BKA002010").toString());
	BKA002901 = RS01[0].get("BKA002901").toString();
	BKA002902 = RS01[0].get("BKA002902").toString();
	BKA002903 = USERID;
	BKA002904 = SC01;
	BKA002905 = RS01[0].get("BKA002905").toString();
	FTYPE = "U"; //這裡的U是修改的代號
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
<input name="FTYPE" type="hidden" id="FTYPE" value="<%=FTYPE%>" />
<input type="hidden" name="SENDURL" value="BKB030100" >
<input name="BKA002001" type="hidden" id="BKA002001" value="<%=BKA002001%>" />
<input name="BKA002008" type="hidden" id="BKA002008" value="<%=BKA002008%>" />
<input name="BKA002901" type="hidden" id="BKA002901" value="<%=BKA002901%>" />
<input name="BKA002902" type="hidden" id="BKA002902" value="<%=BKA002902%>" />
<input name="BKA002903" type="hidden" id="BKA002903" value="<%=BKA002903%>" />
<input name="BKA002904" type="hidden" id="BKA002904" value="<%=BKA002904%>" />
<input name="BKA002905" type="hidden" id="BKA002905" value="<%=BKA002905%>" />
	<div class="container px-4">
		<div class="d-flex justify-content-between">
		  <div>
			<h3 class="mt-4">場次維護</h3>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
				<li class="breadcrumb-item" aria-current="page">場次管理</li>
				<li class="breadcrumb-item active" aria-current="page">場次維護</li>
			</ol>
		  </div>
		  <div class="mt-5">
			<button type="button" class="btn btn-sm btn-light border-secondary" onClick="javascript:document.location.href='BKB030100.jsp'"><i class="fas fa-reply me-2"></i>回查詢頁</button>
		  </div>
		</div>
		
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						場次維護
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl-3">
								<label for="BKA002002" class="form-label text-green fw-bold">期別<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA002002" name="BKA002002" value="<%=BKA002002%>" placeholder="例如：10-1">
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">場次名稱<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA002003" name="BKA002003" value="<%=BKA002003%>" placeholder="例如：第十期加開場次">
							</div>
							<div class="col-xl">
								<label for="BKA002004" class="form-label text-green fw-bold">場次狀態<span class="text-danger ms-1">*</span></label>
								<div class="input-group">
									<select class="form-select validate[required]" aria-label="Default select" id="BKA002004" name="BKA002004">
									  <option value="1" <%=BKA002004.equals("1")?"selected":""%>>開放</option>
									  <option value="0" <%=BKA002004.equals("0")?"selected":""%>>關閉</option>
									</select>
									<span class="input-group-text" id="input-group-right-example">於開放匯入期間，關閉場次會使院所不可維護量能</span>
								</div>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-green fw-bold">開放匯入日期<span class="text-danger ms-1">*</span></label>
								<div class="input-group">
									<input type="text" class="form-control validate[required] datepicker" id="BKA002005Y" name="BKA002005Y" value="<%=BKA002005Y%>" placeholder="日期：2022/11/01">
									<input type="text" class="form-control validate[required]" id="BKA002005H" name="BKA002005H" value="<%=BKA002005H%>" placeholder="時間：1000">
									<span class="input-group-text" id="input-group-left-example">-</span>
									<input type="text" class="form-control validate[required] datepicker" id="BKA002006Y" name="BKA002006Y" value="<%=BKA002006Y%>" placeholder="日期：2022/11/01">
									<input type="text" class="form-control validate[required]" id="BKA002006H" name="BKA002006H" value="<%=BKA002006H%>" placeholder="時間：1500">
								</div>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-danger fw-bold">開放預約日期<span class="text-danger ms-1">*</span></label>
								<div class="input-group">
									<input type="text" class="form-control validate[required] datepicker" id="BKA002007Y" name="BKA002007Y" value="<%=BKA002007Y%>" placeholder="日期：2022/11/01">
									<input type="text" class="form-control validate[required]" id="BKA002007H" name="BKA002007H" value="<%=BKA002007H%>" placeholder="時間：1000">
								</div>
							</div>
							<div class="col-xl">
								<label for="formControlInput" class="form-label text-primary fw-bold">開放接種日期<span class="text-danger ms-1">*</span></label>
								<div class="input-group">
									<input type="text" class="form-control validate[required] datepicker" id="BKA002009" name="BKA002009" value="<%=BKA002009%>" placeholder="例如：2022/11/01">
									<span class="input-group-text" id="input-group-left-example">-</span>
									<input type="text" class="form-control validate[required] datepicker" id="BKA002010" name="BKA002010" value="<%=BKA002010%>" placeholder="例如：2022/11/01">
								</div>
							</div>
						</div>
						<div class="row mt-4">
							<div class="col-xl-12" align="center">
								<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB030102','_self')"><i class="far fa-check-circle me-2"></i>儲存</button>
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

</script>

</body>
</html>
