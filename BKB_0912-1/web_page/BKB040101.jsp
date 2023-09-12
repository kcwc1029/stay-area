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
				<label for="floatingSelect" class="text-green fw-bold">場次</label>
				<select class="form-select" aria-label="Default select">
				  <option value="">請選擇</option>
				  <option value="2">第100期BNT</option>
				  <option value="3">第100期BNT加開場次	</option>
				</select>
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
