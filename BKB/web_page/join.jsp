<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
String cip = request.getRemoteAddr();  //210.63.215.41 
//中山 140.117.248.3
if(!cip.equals("127.0.0.1") && !cip.equals("210.63.215.41") && !cip.equals("192.168.1.20") && !cip.equals("192.168.1.13") && !cip.equals("140.117.248.3") && !cip.equals("128.5.246.4")){
	//out.println(cip+",code=000004,msg=IP無法識別");
	//return;
}
%>
<!DOCTYPE html>
<html lang="zh">

<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body>
<form id="form1" name="form1" method="post" action="">
<div class="container">
  <center><h2 class="mt-5 fw-bold text-green">疫苗接種預約後台管理系統2.0</h2></center>
  <div class="row mt-5 mb-5">
    <div class="col-lg-3"></div>
    <div class="col-lg-6">
		<div class="card border-1 shadow">
		  <div class="card-body bg-white rounded-lg">
		  
			<h4 class="text-green fw-bold" align="center">申請帳號</h4>
			<div class="form-group text-green fw-bold">
				<i class="fas fa-user-alt pe-2"></i><label for="URA001002" class="form-label">姓名</label>
				<input type="text" class="form-control validate[required]" name="URA001002" id="URA001002" placeholder="請輸入您的帳號">
			</div>
			
			<div class="form-group text-green fw-bold mt-3">
				<i class="far fa-address-card pe-2"></i><label for="URA001001" class="form-label">身分證號</label>
				<input type="text" class="form-control validate[required]" name="URA001001" id="URA001001" placeholder="請輸入您的身分證號">
			</div>
			<div class="form-group text-green fw-bold mt-3">
				<i class="fas fa-h-square pe-2"></i><label for="URA001011" class="form-label">院所十碼章</label>
				<input type="text" class="form-control validate[required,minSize[10],maxSize[10],custom[onlyNumberSp]]" name="URA001011" id="URA001011" maxlength="10" placeholder="請輸入院所十碼章">
			</div>
			<div class="form-group text-green fw-bold mt-3">
				<i class="fas far fa-id-card pe-2"></i><label for="URA001008" class="form-label">健保卡號</label>
				<input type="text" class="form-control validate[required,minSize[12],maxSize[12],custom[onlyNumberSp]]" name="URA001008" id="URA001008" maxlength="12" placeholder="請輸入您的健保卡號">
			</div>
			<div class="form-group text-green fw-bold mt-3">
				<i class="fas fa-fax pe-2"></i><label for="URA001007" class="form-label">連絡電話</label>
				<input type="text" class="form-control" name="URA001007" id="URA001007" placeholder="請輸入您的連絡電話">
			</div>
			<div class="form-group text-green fw-bold mt-3">
				<i class="fas fa-phone pe-2"></i><label for="URA001009" class="form-label">連絡手機</label>
				<input type="text" class="form-control validate[minSize[10],maxSize[10],custom[onlyNumberSp]]" name="URA001009" id="URA001009" maxlength="10" placeholder="請輸入您的連絡手機">
			</div>
			<div class="form-group text-green fw-bold mt-3">
				<i class="fas fa-mail-bulk pe-2"></i><label for="URA001005" class="form-label">信箱</label>
				<input type="text" class="form-control" name="URA001005" id="URA001005" placeholder="請輸入您的信箱">
			</div>
			<div class="form-group text-green fw-bold mt-3">
				<i class="fas fa-laptop-code pe-2"></i><label for="verimg" class="form-label">驗證碼，英文字母有區分大小寫</label>
				<div class="input-group">
				<input type="text" class="form-control validate[required]" name="verimg" id="verimg" placeholder="請輸入驗證碼，英文字母有區分大小寫">
				  <div class="input-group-prepend">
					<img src="ver_img.jsp?CHK01=A" class="CHKIMG" width="80" height="38" alt="" />
				  </div>
				  <div class="input-group-prepend">
					<button type="button" class="btn btn-outline-secondary A01" onclick="javascript:;"><i class="fas fa-redo-alt"></i></button>
				  </div>
				</div>
			</div>
			<div class="alert alert-warning" role="alert">
				註冊會員後請通知轄區衛生所開通您的帳號。
			</div>
			
			<div class="row mt-3">
				<div class="col-lg-12" align="center">
					<button type="button" class="btn btn-green border-secondary" onclick="SF01('join_CHK','_self')">送出</button>
				</div>
			</div>
		  </div>
		</div>
			
		<div class="row mt-3">
			<div class="col-lg-12" align="center">
				<button type="button" class="btn btn-outline-green border-secondary" onclick="SF02('login','_self')">登入系統</button>
			</div>
		</div>
	</div>
    <div class="col-lg-3"></div>
  </div>
</div>
</form>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
<script type="text/javascript">
function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  $("#form1").submit();
}
function SF02(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}

var PA01=new Number(0);
$().ready(function(){
$(".A01").click(function(){
PA01=PA01+1;
//alert("");
$(".CHKIMG").attr("src","ver_img.jsp?CHK01=A"+PA01);
});
});
</script>
</body>
</html>