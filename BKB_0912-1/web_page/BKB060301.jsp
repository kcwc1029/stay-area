<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>

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
	<div class="container px-4">
		<div class="d-flex justify-content-between">
		  <div>
			<h3 class="mt-4">物資撥出維護</h3>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
				<li class="breadcrumb-item" aria-current="page">物資撥出管理</li>
				<li class="breadcrumb-item active" aria-current="page">物資撥出維護</li>
			</ol>
		  </div>
		  <div class="mt-5">
			<button type="button" class="btn btn-sm btn-light border-secondary" onClick="javascript:document.location.href='BKB060300.jsp'"><i class="fas fa-reply me-2"></i>回查詢頁</button>
		  </div>
		</div>
		
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						物資撥出維護
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl">
								<label for="BKA002002" class="form-label text-green fw-bold">撥出日期<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control datepicker1" id="BKA002009" name="BKA002009" value="" placeholder="例如：2023/09/07">
							</div>
							<div class="col-xl">
								<label for="BKA002002" class="form-label text-green fw-bold">撥出單位行政區<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇行政區</option>
								  <option value="">三民區</option>
								  <option value="">左營區</option>
								</select>
							</div>
							<div class="col-xl">
								<label for="BKA002002" class="form-label text-green fw-bold">撥出單位(包含衛生所及醫療院所)<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇</option>
								  <option value="">2302020017-高雄市鼓山區衛生所</option>
								  <option value="">0102020011-高雄市立聯合醫院</option>
								</select>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl-4">
								<label for="BKA002002" class="form-label text-green fw-bold">撥出品項<span class="text-danger ms-1">*</span></label></label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇類別</option>
								  <option value="">卡通酒精(剩餘：30瓶)</option>
								  <option value="">素色酒精(剩餘：30瓶)</option>
								  <option value="">貼紙(剩餘：50張)</option>
								</select>
							</div>
							<div class="col-xl-4">
								<label for="BKA002003" class="form-label text-green fw-bold">撥出數量<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA002003" name="BKA002003" value="" placeholder="例如：60">
							</div>
						</div>
						<div class="row mt-4">
							<div class="col-xl-12" align="center">
								<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB060300','_self')"><i class="far fa-check-circle me-2"></i>儲存</button>
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
