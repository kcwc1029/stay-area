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
		  
			<h4 class="text-green fw-bold" align="center">登入系統</h4>
			<div class="form-group text-green fw-bold">
				<i class="fas fa-user-alt pe-2"></i><label for="USERID" class="form-label">帳號</label>
				<input type="text" class="form-control validate[required]" name="USERID" id="USERID" placeholder="請輸入您的帳號">
			</div>
			
			<div class="form-group text-green fw-bold mt-3">
				<i class="fas fa-unlock-alt pe-2"></i><label for="UPWD" class="form-label">密碼</label>
				<input type="password" class="form-control validate[required]" name="UPWD" id="UPWD" placeholder="請輸入您的密碼">
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
			
			<div class="row mt-3">
				<div class="col-lg-12" align="center">
					<button type="button" class="btn btn-green border-secondary" onclick="SF01('login_CHK','_self')">登入</button>
					<button type="button" class="btn btn-outline-green border-secondary" onclick="SF02('join','_self')">申請帳號</button>
				</div>
			</div>
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