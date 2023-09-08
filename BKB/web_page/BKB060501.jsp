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
			<h3 class="mt-4">醫療院所發放數量管理</h3>
			<ol class="breadcrumb mb-4">
				<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
				<li class="breadcrumb-item" aria-current="page">醫療院所發放數量管理</li>
				<li class="breadcrumb-item active" aria-current="page">新增發放數量</li>
			</ol>
		  </div>
		  <div class="mt-5">
			<button type="button" class="btn btn-sm btn-light border-secondary" onClick="javascript:document.location.href='BKB060500.jsp'"><i class="fas fa-reply me-2"></i>回查詢頁</button>
		  </div>
		</div>
		
		<div class="row">
			<div class="col-xl-12">
				<div class="card shadow mb-4">
					<div class="card-header bg-green text-white fw-bold">
						<i class="fas fa-file-import me-1"></i>
						發放數量維護管理
					</div>
					<div class="card-body">
						<div class="row mt-2">
							<div class="col-xl-3">
								<label for="BKA002002" class="form-label text-green fw-bold">發放日期<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control datepicker1" id="BKA002009" name="BKA002009" value="" placeholder="例如：1111114">
							</div>
							<div class="col-xl-3">
								<label for="BKA002002" class="form-label text-green fw-bold">行政區<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇行政區</option>
								  <option value="">三民區</option>
								  <option value="">左營區</option>
								</select>
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">合約醫療所代碼(10碼)<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA002003" name="BKA002003" value="" placeholder="例如：3351234567">
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">醫療院所<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA002003" name="BKA002003" value="" placeholder="">
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-xl-3">
								<label for="BKA002002" class="form-label text-green fw-bold">品項類別<span class="text-danger ms-1">*</span></label>
								<select class="form-select" aria-label="Default select" id="BKA002001" name="BKA002001">
								  <option value="">請選擇類別</option>
								  <option value="">宣導品</option>
								  <option value="">衛教品</option>
								</select>
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">品項名稱<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA002003" name="BKA002003" value="" placeholder="例如：酒精噴瓶">
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">品項數量<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA002003" name="BKA002003" value="" placeholder="例如：60">
							</div>
							<div class="col-xl-3">
								<label for="BKA002003" class="form-label text-green fw-bold">單位<span class="text-danger ms-1">*</span></label>
								<input type="text" class="form-control validate[required]" id="BKA002003" name="BKA002003" value="" placeholder="例如：">
							</div>
						</div>
						
						<div class="row mt-4">
							<div class="col-xl-12" align="center">
								<button type="button" class="btn btn-green border-secondary" onClick="SF01('BKB060500','_self')"><i class="far fa-check-circle me-2"></i>儲存</button>
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
