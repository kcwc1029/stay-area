<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html lang="zh">
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>
<body class="sb-nav-fixed bg-white">
<form id="form1" name="form1" method="post" action="">
		<div class="row mt-3 p-3">
			<div class="col-xl-12">
				<label for="floatingSelect" class="text-green fw-bold">行政區</label>
				<select class="form-select" aria-label="Default select">
				  <option value="">請選擇</option>
				  <option value="2">鼓山區</option>
				  <option value="3">左營區</option>
				</select>
			</div>
			<div class="col-xl-12 mt-2">
				<label for="floatingSelect" class="text-green fw-bold">醫療院所</label>
				<select class="form-select" aria-label="Default select">
				  <option value="">請選擇</option>
				  <option value="2">鴻維科技醫學中心</option>
				</select>
			</div>
			<div class="col-xl-12 mt-2">
				<label for="floatingSelect" class="text-green fw-bold">民眾預約日期</label>
				<input type="text" class="form-control" id="" name="" value="" placeholder="例如：1111014">
			</div>
		</div>	
		<div class="row mt-3">
			<div class="col-xl-12" align="center">
				<button type="button" class="btn btn-green border-secondary" onClick="SF01('#','_self')">產製報表</button>
			</div>
		</div>
	<br><br><br>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
</form>

<script type="text/javascript">
function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}
</script>
</body>
</html>
